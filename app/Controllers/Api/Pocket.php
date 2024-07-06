<?php

namespace App\Controllers\Api;
use App\Controllers\ApiController;

class Pocket extends ApiController
{

	protected static $model;
	protected static $mModel;
	
	public function __construct(){
		self::$model = model('App\Models\PocketModel');	
		self::$mModel = model('App\Models\MemberModel');		
	}
	
	private function checkLevelup($curlvl, $curcoin){
		$lModel = model('App\Models\LevelModel');
		$lvlinfo = $lModel->where('status',1)->where('numbmin<', $curcoin)->where('numbmax>', $curcoin)->get()->getRowArray();
		
		if ((!empty($lvlinfo)) && ($curlvl < $lvlinfo['id'])) {
			// 会员等级提升
			self::$mModel->where('uid', $this->loginfo['uid'])->set('lvl', $lvlinfo['id'])->update();
			if (self::$mModel->affectedRows()){
				// 发送系统消息告之会员等级提升了。
				$this->sendMessage($this->loginfo['uid'],'levelup');						
			}
		}
	}
	
	// 
	public function getPocket(){
		$this->checkLogin();
		$ret['data'] = self::$model->getPocket($this->loginfo['uid']);
		$ret['code'] = 1;
		return retJson($ret);		
	}
	
	// 初始化前台钱包界面，包括返回需要微信充值时的openID
	public function setInitPocket(){
		$this->checkLogin();
		$ext = $this->getExtItem(self::$mModel, $this->loginfo['uid']);
		$ret['data'] = self::$model->getPocket($this->loginfo['uid']);
		$ret['data']['openid'] = $ext['openid'];
		$ret['code'] = 1;
		return retJson($ret);		
	}

	/*
	// 签到事件已经转移至signin接口
	// 签到获得金币
	public function setQiandao(){
		$this->checkLogin();
		$logCoin = model('App\Models\PocketLogCoinModel');		
		// 获取当天的签到状态
		$gets = $logCoin->where('uid', $this->loginfo['uid'])
						->where('substring(created_at,1,10)','CURRENT_DATE',false)
						->where('tag','qiandao')
						->select("count(*) as c")->get()->getRowArray();
		if ($gets['c'] >= 1){
			$ret['code'] = 1;
			return retJson($ret);					
		}				

		// 更新金币日志
		$minfo = self::$mModel->getMemberByUids([$this->loginfo['uid']],'lvl')[0];
		
		$uid = $this->loginfo['uid'];
		$numb 		= intval($minfo['lvl']) * 20;		
		$numbres	= intval($minfo['lvl']) * 10000;		
		$logid = $logCoin->setLog('qiandao',$uid,$numb);
				
		if ($logid){
			// 更新钱包-金币
			$curcoin = self::$model->updateCoin($uid, $numb);
			
			// 验证是否升级等级 begin:
			//$this->checkLevelup($minfo['lvl'], $curcoin);
			// end;	
			
			// 更新钱包-资源
			$curres = self::$model->updateRes($uid, $numbres);		
			
			$ret['code'] = 1;
			$ret['coin'] = $curcoin;
			return retJson($ret);			
		}
		$ret['code'] = 0;
		$ret['msg'] = '签到异常。';
		return retJson($ret);		
	}
	*/
	
	// 向绑定者收取金币,不消耗绑定金币
	public function getCoin(){	
		$this->checkLogin();
    	$pdata = $this->request->getJSON(true);
    	if (!empty($pdata['uid']) && !empty($pdata['lvl'])) {    	
    	
    		$logCoin = model('App\Models\PocketLogCoinModel');
    		$uid = $this->loginfo['uid'];
    		$relid = intval($pdata['uid']);
    		//$numb = $this->loginfo['lvl'] * 8;
    		$numb = intval($pdata['lvl']) * 8;
    		$logid = $logCoin->setLog('invited',$uid,$numb,'',$relid);
			if ($logid){
				// 更新钱包-金币
				$curcoin = self::$model->updateCoin($uid,$numb);
				// 验证是否升级等级
				//$this->checkLevelup($pdata['lvl'], $curcoin);
				
				// 返回当天的收取次数
				$gets = $logCoin->where('uid', $uid)
								->where('substring(created_at,1,10)','CURRENT_DATE',false)
								->where('tag','invited')
								->findColumn('relid');
				$ret['code'] = 1;
				$ret['coin'] = $curcoin;
				$ret['data'] = $gets;
				return retJson($ret);
			}
    	}
    	
		$ret['code'] = 0;
		$ret['msg'] = '金币收取异常。';
		return retJson($ret);
	}
	
	// 获取积分排行
	public function getRanking(){	
    	$pdata = $this->request->getJSON(true);
    	if (empty($pdata['type']) && ($pdata['type'] != 'point')){
			$ret['code'] = 0;
			$ret['msg'] = '数据读取失败。';
			return retJson($ret);
    	}
    	
		$db = db_connect();
		$_tbl = self::$model->__get('table');
		
    	$type = $pdata['type'];
        	
    	$page = max(1, empty($pdata['page']) ? 0 : intval($pdata['page']));
		$limit = empty($pdata['limit']) ? 15 : intval($pdata['limit']);
		$ret['count'] = empty($pdata['count']) ? 0 : intval($pdata['count']);
		
		if ($ret['count'] == 0){
			//$ret['count'] = self::$model->count([])['id'];
			$sql = "select count(*) as c from member as a 
					left join {$_tbl} as b 
					on a.uid = b.uid";
			$row = $db->query($sql);
			$ret['count'] = $row->getRowArray()['c'];
		}
		
		
		/*
		$_res = self::$model->select("uid,".$type)->orderby($type,'DESC')->get($limit, ($page-1) * $limit)->getResultArray();	
		
		if (!empty($_res)){
			$_member = array_column(self::$mModel->getMemberByUids(array_column($_res,'uid'),'uid,name,avatar,sign'),NULL,'uid');
			foreach ($_res as $k => $v){
				$ret['data'][$k] = empty($_member[$v['uid']]) ? $v : array_merge($v,$_member[$v['uid']]);
			}
		}
		*/

		
		$offset = ($page-1) * $limit;
		$sql = "select a.uid,a.name,a.avatar,a.sign,b.{$type} from member as a 
				left join {$_tbl} as b 
				on a.uid = b.uid
				order by b.{$type} desc
				limit {$offset}, {$limit}";
		$rs = $db->query($sql);
		$ret['data'] = $rs->getResultArray();
		$ret['page'] = $page;
		$ret['limit'] = $limit;
		$ret['code'] = 1;
		return retJson($ret);
    }
	
}
