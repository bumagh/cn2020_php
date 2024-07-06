<?php

namespace App\Controllers\Api;
use App\Controllers\ApiController;

// 签到
class Signin extends ApiController
{

	protected static $model;
	
	public function __construct(){
		self::$model = model('App\Models\SignInModel');
	}
	
	public function index(){
		$this->checkLogin();
		//$uinfo = $this->loginfo;
		$uid = $this->loginfo['uid'];
		
		// 判断是否已经签到
		//$row = self::$model->where('uid', $uid)->where('substring(created_at,1,7)','CURRENT_DATE',false)->get()->getRowArray();		
		$row = self::$model->where('uid', $uid)->get()->getRowArray();		
		if (!empty($row)){		
			// 已经签到
			if (substr($row['updated_at'],0,10) == date('Y-m-d')){
				$ret['code'] = 1;
				return retJson($ret);
			}
		
			// 如果是新月，则重置curmonth值从1开始		
			if (substr($row['updated_at'],0,7) == date('Y-m')){
				self::$model->where('uid',$uid)->set('total','total+1',FALSE)->set('curmonth','curmonth+1',FALSE)->update();
			}else{
				self::$model->where('uid',$uid)->set('total','total+1',FALSE)->set('curmonth',1)->update();			
			}

		}else{
			self::$model->insert(['uid'=>$uid]);
		}
			
		// 更新金币日志
		$mModel 	= model('App\Models\MemberModel');	
		$logCoin 	= model('App\Models\PocketLogCoinModel');
		
		$minfo = $mModel->getMemberByUids([$uid],'lvl')[0];
		
		$numb 		= intval($minfo['lvl']) * 20;		
		$numbres	= intval($minfo['lvl']) * 10000;		
		$logid = $logCoin->setLog('qiandao',$uid,$numb);
				
		if ($logid){
			$pModel = model('App\Models\PocketModel');
			// 更新钱包-金币
			$curcoin = $pModel->updateCoin($uid, $numb);
			// 更新钱包-资源
			$curres = $pModel->updateRes($uid, $numbres);
			$ret['code'] = 1;
			$ret['coin'] = $curcoin;
			return retJson($ret);			
		}
		
		$ret['code'] = 0;
		$ret['msg'] = '签到异常。';
		return retJson($ret);		
	}
	
	public function getData(){
    	$pdata = $this->request->getJSON(true); 
    	
    	$db = db_connect();
		$_tbl = self::$model->__get('table');

    	
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
		$_res = self::$model->select("uid,total,curmonth")->orderby('curmonth','DESC')->get($limit, ($page-1) * $limit)->getResultArray();	
		
		if (!empty($_res)){
			$mModel = model('App\Models\MemberModel');
			$_member = array_column($mModel->getMemberByUids(array_column($_res,'uid'),'uid,name,avatar,sign'),NULL,'uid');
			foreach ($_res as $k => $v){
				$ret['data'][$k] = empty($_member[$v['uid']]) ? $v : array_merge($v,$_member[$v['uid']]);
			}
		}
		*/

		$offset = ($page-1) * $limit;
		$sql = "select a.uid,a.name,a.avatar,a.sign,b.total,b.curmonth from member as a 
				left join {$_tbl} as b 
				on a.uid = b.uid
				order by b.curmonth desc
				limit {$offset}, {$limit}";
		$rs = $db->query($sql);
		$ret['data'] = $rs->getResultArray();
		
		$ret['page'] = $page;
		$ret['limit'] = $limit;
		$ret['code'] = 1;
		return retJson($ret);
	}
	
}
