<?php

namespace App\Controllers\Api;
use App\Controllers\ApiController;

class Member extends ApiController
{

	protected static $model;
	protected static $ext;
	
	public function __construct(){
		self::$model = model('App\Models\MemberModel');	
		self::$ext = new \App\Entities\Extbase;
	}
		
	/*
	private static function setLogin($data){
		$_SESSION['memberlogin'] = $data;
	}
	*/
	
	// 注册信息过滤处理
	private function setFilterData($pdata, $act='reg'){	
		if ($act == 'reg'){
			$adata['username']	= filter_var($pdata['username'], FILTER_SANITIZE_NUMBER_INT);
			//$adata['phone']		= filter_var($pdata['phone'], FILTER_SANITIZE_NUMBER_INT);
			//$adata['name']		= '会员'.$adata['username'];
			$adata['phone']		= $adata['username'];
			$adata['name']		= '会员'.rand(100000,999999);
			$adata['avatar'] 	= (empty($pdata['avatar'])) ? '/images/default.png' : filter_var($pdata['avatar'], FILTER_SANITIZE_URL);

			$adata['invitcode']	= filter_var($pdata['invite'], FILTER_SANITIZE_NUMBER_INT);
			$adata['passwd']	= filter_var($pdata['password'], FILTER_SANITIZE_STRING);
			$adata['repasswd']	= $adata['passwd'];
			$adata['status']	= 1;
			$adata['lvl'] 		= 1;		
		}else if ($act = 'login'){
			$adata['username']	= filter_var($pdata['username'], FILTER_SANITIZE_NUMBER_INT);
			$adata['passwd']	= filter_var($pdata['password'], FILTER_SANITIZE_STRING);		
		}
		
		return $adata;
	}
	
	// 重置对我的绑定
	public function setMyInvited(){
		$pdata = $this->request->getJSON(true);		
		if (!empty($pdata['newcode'])){
			$this->checkLogin();
			$code = intval($pdata['newcode']);
			$res = self::$model->where('username', $code)->where('status',1)->select('username')->get()->getRowArray();
			if (empty($res['username'])){
				$ret['code'] = 0;
				$ret['msg'] = '不存在该邀请码';
				return retJson($ret);
			}
			
			if (self::$model->where('uid', $this->loginfo['uid'])->set('invitcode', $res['username'])->update()){
				$ret['code'] = 1;
				return retJson($ret);			
			}
			
		}
		
		$ret['code'] = 0;
		$ret['msg'] = '重置异常。';
		return retJson($ret);
	}
		
	
	// 获取我的绑定
	public function getMyInvited(){
		$this->checkLogin();
		$res = self::$model->where('uid', $this->loginfo['uid'])->select('invitcode')->get()->getRowArray();
		$ret['code'] = 1;
		$ret['data'] = $res;
		return retJson($ret);
	}
	
	// 强制解除我的绑定
	public function forceCancel(){
		$pdata = $this->request->getJSON(true);		
		if (!empty($pdata['invitcode'])){
			$this->checkLogin();
			$uid = $this->loginfo['uid'];
			// 获取贡献值
			$pocket = model('App\Models\PocketModel');
			$mine = $pocket->getPocket($uid);
			
			
			if ($mine['point']<500){
				$ret['code'] = 0;
				$ret['msg'] = '您的贡献值不足。';
				return retJson($ret);		
			}
			
			// 记录积分扣除日志
			$logPoint = model('App\Models\PocketLogPointModel');
			$logPoint->setLog('uninvited',$uid,-500);
			
			// 更新积分
			$pocket->updatePoint($uid, -500);
			
			// 解除绑定
			
			if (self::$model->where('uid',$uid)->set('invitcode','')->update()){
				$ret['code'] = 1;
				return retJson($ret);								
			}
			
		}
		
		$ret['code'] = 0;
		$ret['msg'] = '操作异常';
		return retJson($ret);					
	}
	
	// 获取个人信息，包括扩展信息
	public function getProfile(){
		$this->checkLogin();
		$res = self::$model->where('uid', $this->loginfo['uid'])->select('uid,name,phone,avatar,sign')->get()->getRowArray();
		$res = empty($res) ? [] : array_merge($res,$this->getExtItem(self::$model,$res['uid']));
		$ret['code'] = 1;
		$ret['data'] = $res;
		return retJson($ret);		
	}
	
	public function test(){
	
//		$time = Time::createFromFormat('j-M-Y', '15-Feb-2009', 'America/Chicago');
//		var_dump(app_timezone());
		$smsModel = model('App\Models\SmslogModel');
		$_res = $smsModel->where('created_at>', date("Y-m-d H:i:s",time()-60))->get()->getRowArray();
		echo '<PRE>';
		print_r($_res);
	
	}
	
	
	public function setPwdByPhone(){
		$pdata = $this->request->getJSON(true);

		if (empty($pdata['phone']) || empty($pdata['code']) || empty($pdata['password'])){
			$ret['code'] = 0;
			$ret['msg'] = '参数不全';
			return retJson($ret);				
		}
		
		/*
		$session = \Config\Services::session();
		if ($session->getFlashdata('mvcode') != $pdata['code']){
			$ret['code'] = 0;
			$ret['msg'] = '手机验证码出错';
			return retJson($ret);						
		}
		*/
		
		
		$_SER = $this->request->getServer();
		$smsModel = model('App\Models\SmslogModel');
		$_res = $smsModel->where('deviceid',$_SER['HTTP_ACCESS_TAG'])->where('created_at>', date("Y-m-d H:i:s",time()-60))->select('mvcode')->get()->getRowArray();
		
		if (empty($_res) || ($_res['mvcode'] != $pdata['code'])) {
			$ret['code'] = 0;
			$ret['msg'] = '手机验证码出错';
			return retJson($ret);
		}
		
		$row = self::$model->getLogin(intval($pdata['phone']),'phone');
		if (empty($row)){
			$ret['code'] = 0;
			$ret['msg'] = '该手机号尚未绑定帐号';
			return retJson($ret);
		}
		
		$adata['passwd'] = filter_var($pdata['password'], FILTER_SANITIZE_STRING);			
		if (self::$model->where('uid', $row['uid'])->set($adata)->update()){
			$ret['code'] = 1;
			return retJson($ret);								
		}
		
		$ret['code'] = 0;
		$ret['msg'] = '重置异常，请与管理员联系。';
		return retJson($ret);
	}
	
	public function setProfile(){
		$this->checkLogin();
		$pdata = $this->request->getJSON(true);
				
		if (!empty($pdata)){
			$uid = $this->loginfo['uid'];
			$adata['phone']	= filter_var($pdata['phone'], FILTER_SANITIZE_NUMBER_INT);			
			$adata['name']	= filter_var($pdata['name'], FILTER_SANITIZE_STRING);
			$adata['avatar']	= filter_var($pdata['avatar'], FILTER_SANITIZE_URL);
			$adata['sign']	= filter_var($pdata['sign'], FILTER_SANITIZE_STRING);
			$extdata = [];

			//	修改验证规则 begin :
			$validrules = self::$model->getValidationRules();
			$newRules['name'] = $validrules['name'];
			$newRules['phone'] = $validrules['phone'];
			//$newRules['uid'] = 'required|max_length[1]';

			$kModel = model('App\Models\SysDictkeyModel');
			$_rules = $kModel->where('tname', self::$model->__get('table'))
						->select('name,type,force,code,rule')
						->get()->getResultArray();
			if (!empty($_rules)){
				foreach ($_rules as $k => $v){
					// 迭加验证规则
					if (!empty($v['rule'])) $newRules[$v['code']] = $v['rule'];
					
					// 处理写入扩展表的字段
					$extdata[$v['type']][$v['code']] = empty($pdata[$v['code']]) ? '' : $pdata[$v['code']];
				}
			}
			
			if (!$this->validate($newRules)){
				$_errors = $this->validator->getErrors();
				$msg = '';
				foreach ($_errors as $k => $v){
					$msg .= $v . "\r\n";
				}
				$ret['msg'] = $msg;
				$ret['code'] = 0;
				return retJson($ret);
			}
			
			$st = self::$model->update($uid,$adata);
			
			if ($st){
				// 写入扩展字段值
				if ($extdata){				
					self::$ext::setExtValue(self::$model->__get('table'), $uid, $extdata, $uid);
				}				
				
				$ret['code'] = 1;
				return retJson($ret);
			}
			$ret['msg'] = '更新异常';
			$ret['code'] = 0;
			return retJson($ret);

		}
	}
	
	public function reg(){
		$pdata = $this->request->getJSON(true);
		if (!empty($pdata)){
			$adata = $this->setFilterData($pdata);
			
			// 验证邀请码
			if (!empty($adata['invitcode'])){
				$_row = self::$model->where('username',$adata['invitcode'])->select("username")->get()->getRowArray();
				$adata['invitcode'] = (!empty($_row['username'])) ? $_row['username'] : '';
			}
									
			$uid = self::$model->insert($adata);
			if ($uid){
				$ret['data']['username'] = $adata['username'];
				$ret['code'] = 1;
				return retJson($ret);
			}
			//$_err = self::$model->errors();
			// $ret['msg'] = $_err;
			//if (!empty($_err['username'])) $ret['msg'] = $_err['username'];
			//if (!empty($_err['phone'])) $ret['msg'] = $_err['phone'];

			$ret['code'] = 0;
			$ret['msg'] = self::$model->errors();
			return retJson($ret);
			
		}
		
		$ret['code'] = 0;
		$ret['msg'] = '注册异常，请重试';
		return retJson($ret);
	}
    
    // 用户升级
    public function setLevelup(){
		$this->checkLogin();
		$uid = $this->loginfo['uid'];
		$lvl = intval($this->loginfo['lvl']);
		$costcoin = $lvl * $lvl * 100;
		
		$pModel = model('App\Models\PocketModel');
		$pocket = $pModel->getPocket($uid);
		if ($pocket['coin'] < $costcoin){
			$ret['code'] = 0;
			$ret['msg'] = '金币不足,无法升级';
			return retJson($ret);
		}

		$coinLog = model('App\Models\PocketLogCoinModel');
		$coinLog->setLog('levelup',$uid, 0-$costcoin);

		if ($pModel->updateCoin($uid, 0-$costcoin)){
			// 会员等级提升
			$lvl = $lvl + 1;
			self::$model->where('uid', $uid)->set('lvl', $lvl)->update();
			if (self::$model->affectedRows()){
				// 发送系统消息告之会员等级提升了。
				$this->sendMessage($uid,'levelup');
				$ret['code'] = 1;		
				return retJson($ret);							
			}
		}
		
		$ret['code'] = 0;
		$ret['msg'] = '升级异常';
		return retJson($ret);
    }
    
    public function login(){
    
    	$pdata = $this->request->getJSON(true);
		if (!empty($pdata)){
			$pdata = $this->setFilterData($pdata, 'login');
			//$session = \Config\Services::session();
			/*
			$vercode = $this->request->getPost('vercode', FILTER_SANITIZE_STRING);
			if ($_SESSION['vcode'] != $vercode){
				$ret['code'] = 0;
				$ret['msg'] = '验证码出错';
				return retJson($ret);
			}
	
			$username = $this->request->getPost('username', FILTER_SANITIZE_STRING);
			$pwd = $this->request->getPost('passwd', FILTER_SANITIZE_STRING);
			*/
			
			if (strlen($pdata['username']) == 11){	// 是手机号码登录
				$res = self::$model->getLogin($pdata['username'],'phone');
			}else{
				$res = self::$model->getLogin($pdata['username']);
			}
			
			if ($res){
				if (!password_verify($pdata['passwd'], $res['passwd'])){
					$ret['code'] = 0;
					$ret['msg'] = '帐号登录失败';
					return retJson($ret);
				}
				
				unset($res['passwd']);
				//$res['username'] = $pdata['username'];				
				$res['v'] = $this->setLoginVerify($res['uid'],$res['lvl'],$res['username']);
				
				//self::setLogin($res);	
				
				$ret['code'] = 1;
				$ret['data'] = $res;
				return retJson($ret);
			}
			
			$ret['code'] = 0;
			$ret['msg'] = '帐号登录失败';
			return retJson($ret);			
		}

		$ret['code'] = 0;
		$ret['msg'] = '登录异常，请重试';
		return retJson($ret);
	}
	
	// 获取我推广的用户，以及当天获取的金币
	public function getinvited(){	
		$this->checkLogin();
		$res = self::$model->where('invitcode', $this->loginfo['username'])->select('uid,username,name,lvl,avatar')->orderBy('lvl','desc')->get()->getResultArray();
		$ret['code'] = 1;
		$ret['data'] = $res;
		$logCoin = model('App\Models\PocketLogCoinModel');	
		$gets = $logCoin->where('uid', $this->loginfo['uid'])
						->where('substring(created_at,1,10)','CURRENT_DATE',false)
						->where('tag','invited')
						->findColumn('relid');
		
		$ret['getcoin'] = empty($gets) ? [] : $gets;
		
		$pocket = model('App\Models\PocketModel');			
		$ret['coin'] = $pocket->where('uid', $this->loginfo['uid'])->findColumn('coin')[0];
		return retJson($ret);
	
	}
	
	// 解绑推广用户
	public function cancelinvited(){
		$this->checkLogin();	
		$pdata = $this->request->getJSON(true);		
		if (!empty($pdata['uid'])){
			$uid = intval($pdata['uid']);
			self::$model->where('uid', $uid)->where('invitcode', $this->loginfo['username'])->set('invitcode','')->update();
			$ret['code'] = 1;
			$ret['data'] = $uid;
			return retJson($ret);
		}
	}
}
