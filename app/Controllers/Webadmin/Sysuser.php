<?php

namespace App\Controllers\Webadmin;
use App\Controllers\AdminController;

class Sysuser extends AdminController{

	protected static $model;
	protected static $extbase;
	
	public function __construct(){
		self::$model = model('App\Models\SysUserModel');
		self::$extbase = new \App\Entities\Extbase;
	}
	
	private static function setLogin($data){
		$_SESSION['login'] = $data;
	}

	public function logout(){
		unset($_SESSION['login']);
		session_destroy();
		return redirect()->to('home');
	}
	
	public function login(){
		if ($this->request->getPost()){		
			$session = \Config\Services::session();
			$vercode = $this->request->getPost('vercode', FILTER_SANITIZE_STRING);
			if ($_SESSION['vcode'] != $vercode){
				$ret['code'] = 0;
				$ret['msg'] = '验证码出错';
				return retJson($ret);
			}
	
			$username = $this->request->getPost('username', FILTER_SANITIZE_STRING);
			$pwd = $this->request->getPost('passwd', FILTER_SANITIZE_STRING);
			$res = self::$model->getLogin($username);
			if ($res){
				if (!password_verify($pwd, $res['passwd'])){
					$ret['code'] = 0;
					$ret['msg'] = '帐号登录失败';
					return retJson($ret);
				}
			
				$curtime = $this->request->getServer('REQUEST_TIME');
				if (!empty($res['overtime']) && ($res['overtime']< $curtime)){
					$ret['code'] = 0;
					$ret['msg'] = '帐号过期';
					return retJson($ret);
				}
				
				// 读取登录信息
				$loginfo = ['uid'=>$res['uid'],'name'=>$res['name'],'avatar'=>(empty($res['avatar']) ? '/images/default.png' : $res['avatar']),'rid'=>$res['rid']];
				// 读取角色信息
				if ($loginfo['rid'] == 1){
					$loginfo['rolename'] = '系统管理员';	
				}else{
					$rModel = model('App\Models\SysRoleModel');
					$_roleinfo = $rModel->where('rid', $loginfo['rid'])->first();
					$loginfo['rolename'] = '';
					$loginfo['act'] = [];
					if (!empty($_roleinfo)){
						$loginfo['rolename'] =  $_roleinfo['name'];
						$loginfo['act'] = json_decode($_roleinfo['modulelist'],true);
					}				
				}

				
				self::setLogin($loginfo);
				$ret['code'] = 1;
				$ret['url'] = site_url('webadmin');
				$ret['msg'] = '验证成功！正在登陆...';
				return retJson($ret);
			}
			
			$ret['code'] = 0;
			$ret['msg'] = '帐号登录失败';
			return retJson($ret);
		}
		
		return view($this->_tpl . 'login');
	}
	
	
	public function index(){
		
		if ($this->request->getPost()){
			// 基本表查询字段
			//$searchfields = self::$model::$searchFields;
			$ret = parent::getSearchData(self::$model, self::$extbase);
			return retJson($ret);
		}		

		// 将角色信息赋值到账号模型中 begin:
		$rModel = model('App\Models\SysRoleModel');
		$sdata = [];
		if (self::getAuth()['rid'] != 1) $sdata['rid<>'] = 1;
		$_role = $rModel->getData($sdata);
		self::$model->searchFields['rid']['setting'] = array_column($_role,'name','rid');
		// end;

		$data['init'] = parent::setIndexInitData(self::$model, self::$extbase);				
		return  view($this->_tpl . 'index', $data);
	}
	
	private function setFilterData(){	
		$adata['username']	= $this->request->getPost('username', FILTER_SANITIZE_STRING);
		$adata['name']		= $this->request->getPost('name', FILTER_SANITIZE_STRING);
		$adata['passwd']	= $this->request->getPost('passwd', FILTER_SANITIZE_STRING);
		$adata['repasswd']	= $this->request->getPost('repasswd', FILTER_SANITIZE_STRING);
		$_avatar			= $this->request->getPost('avatar', FILTER_SANITIZE_URL);
		$adata['avatar'] 	= (empty($_avatar)) ? '/images/default.png' : $_avatar;
		$adata['rid']		= intval($this->request->getPost('rid'));
		$adata['email']		= $this->request->getPost('email', FILTER_SANITIZE_EMAIL);
		$adata['phone']		= $this->request->getPost('phone', FILTER_SANITIZE_NUMBER_INT);
		$adata['status']	= empty($this->request->getPost('status')) ? 0 : 1;
		return $adata;
	}
	
	public function setmine(){
		$uinfo = self::getAuth();
		$uid = $uinfo['uid'];
		
		$init = parent::setDetailInitData(self::$model, $uid);
		
		$rModel = model('App\Models\SysRoleModel');
		$_role = ($uinfo['rid'] != 1) ? $rModel->asArray()->where('rid!=',1)->findAll() : $rModel->asArray()->findAll();
		$init['role'] = array_column($_role,'name','rid');	
		
		if ($this->request->getPost()){
			$adata = $this->setFilterData();
			$adata['edituid'] = $uinfo['uid'];
			$adata['status'] = 1;
			//	修改验证规则 
			$validrules = self::$model->getValidationRules();
			$validrules['username'] = 'required|string|is_unique[sys_user.username,username,{username}]|min_length[3]';
			$validrules['passwd'] = 'permit_empty|min_length[6]';
			$validrules['email'] =  'permit_empty|valid_email';
			$validrules['phone'] = 'permit_empty|numeric|min_length[11]|max_length[11]';

			self::$model->setValidationRules($validrules);
			$st = self::$model->update($uid,$adata);
			if ($st){
				parent::setDetailPostExt(self::$model, self::$extbase, $uid);
				$init['data']['row']['uid'] = $uid;
				$ret['data'] = $init['data']['row'];
				$ret['code'] = 1;
				return retJson($ret);
			}
			$ret['msg'] = self::$model->errors();
			$ret['code'] = 0;
			return retJson($ret);
		}
		
		$data['init'] = $init;
		return view($this->_tpl . 'mine', $data);
	}
	
	
	/**
	* 添加
	*/
	public function add(){	
		if ($this->request->getPost()){
			$adata = $this->setFilterData();
			$adata['adduid'] = self::getAuth()['uid'];
			$uid = self::$model->insert($adata);
			if ($uid){
				parent::setDetailPostExt(self::$model, self::$extbase, $uid);
				$adata['id'] = $uid;
				$adata['uid'] = $uid;
				$ret['data'] = $adata;
				$ret['code'] = 1;
				return retJson($ret);
			}

			$ret['msg'] = self::$model->errors();
			$ret['code'] = 0;
			return retJson($ret);
		}
		
		$data['init'] = parent::setDetailInitData(self::$model);
		$rModel = model('App\Models\SysRoleModel');
		$_role = $rModel->asArray()->where('rid<>',1)->findAll();
		$data['init']['role'] = array_column($_role,'name','rid');
		return view($this->_tpl . 'detail', $data);
	}
	
	public function edit($id){
		$uid = intval($id);
		if ($uid <= 1) return "不能编辑该账号"; 		
		if ($this->request->getPost()){
			$adata = $this->setFilterData();
			$adata['edituid'] = self::getAuth()['uid'];
			//	修改验证规则 
			$validrules = self::$model->getValidationRules();
			$validrules['username'] = 'required|string|is_unique[sys_user.username,username,{username}]|min_length[3]';
			$validrules['passwd'] = 'permit_empty|min_length[6]';
			//$validrules['email'] =  'permit_empty|valid_email';

			self::$model->setValidationRules($validrules);
			$st = self::$model->update($uid,$adata);
			if ($st){
				parent::setDetailPostExt(self::$model, self::$extbase, $uid);
			//	$ret['data'] = $data['row'];
				$ret['code'] = 1;
				return retJson($ret);
			}
			$ret['msg'] = self::$model->errors();
			$ret['code'] = 0;
			return retJson($ret);
		}

		$data['init'] = parent::setDetailInitData(self::$model, $id);
		$rModel = model('App\Models\SysRoleModel');
		$_role = $rModel->asArray()->where('rid!=',1)->findAll();
		$data['init']['role'] = array_column($_role,'name','rid');
		return view($this->_tpl . 'detail', $data);
	}
	
	public function del(){
		if ($this->request->getPost()){
			$uid  = $this->request->getPost('id', FILTER_SANITIZE_NUMBER_INT);
			if ($uid <= 1){
				$ret['msg'] = '不能删除该账号';
				$ret['code'] = 0;
				return retJson($ret);			
			}
			
			if (self::$model->delete($uid)){
				self::$extbase::delExtValue(self::$model->__get('table'), $uid);
				
				$ret['code'] = 1;
				$ret['data'] = $uid;
				return retJson($ret);
			}
		}
		
		$ret['code'] = 0;
		return retJson($ret);
	}

	private function view($id){
		$id = intval($id);
		if (empty($id)){
			$ret['code'] = 0;
			$ret['msg'] = '参数丢失';
			$ret['btnhide'] = true;
			return  view('home/tips', $ret);
		}
		$tag = parent::getTag($this->request->getPath());
		return self::getStat($id, $tag);
	}
	
	public static function getStat($id, $tag){
		$report = new \App\Entities\Report;
		$data = $report::getUserStatByUid($id);
		$data = array_merge($data, $report::getRoleByUid($id));
		$data['tag'] = $tag;
		return  view('user/view', $data);
	}
}
