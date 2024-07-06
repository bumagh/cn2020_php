<?php

namespace App\Controllers\Webadmin;
use App\Controllers\AdminController;

class Member extends AdminController{

	protected static $model;
	protected static $extbase;
	
	public function __construct(){
		self::$model = model('App\Models\MemberModel');
		self::$extbase = new \App\Entities\Extbase;
	}

	public function index(){
		
		if ($this->request->getPost()){
			// 基本表查询字段
			$ret = parent::getSearchData(self::$model, self::$extbase);
			return retJson($ret);
		}		

		$lvlModel = model('App\Models\LevelModel');
		$_lvl = $lvlModel->asArray()->where('status',1)->findAll();
		self::$model->searchFields['lvl']['setting'] = array_column($_lvl,'name','id');		
	
		$data['init'] = parent::setIndexInitData(self::$model, self::$extbase);		
		return  view($this->_tpl . 'index', $data);
	}
	
	private function setFilterData($type){	
		if ($type == 'add'){
			$adata['username']	= $this->request->getPost('username', FILTER_SANITIZE_STRING);
		}
		$_avatar			= $this->request->getPost('avatar', FILTER_SANITIZE_URL);
		$adata['avatar'] 	= (empty($_avatar)) ? '/images/default.png' : $_avatar;
		$adata['name']		= $this->request->getPost('name', FILTER_SANITIZE_STRING);
		$adata['passwd']	= $this->request->getPost('passwd', FILTER_SANITIZE_STRING);
		$adata['repasswd']	= $this->request->getPost('repasswd', FILTER_SANITIZE_STRING);
		//$adata['email']		= $this->request->getPost('email', FILTER_SANITIZE_EMAIL);
		//$adata['phone']		= $this->request->getPost('phone', FILTER_SANITIZE_NUMBER_INT);
		$adata['sign']		= $this->request->getPost('sign', FILTER_SANITIZE_STRING);
		$adata['status']	= empty($this->request->getPost('status')) ? 0 : 1;
		return $adata;
	}

	/**
	* 添加
	*/
	public function add(){	
		if ($this->request->getPost()){
			$adata = $this->setFilterData('add');
			$adata['adduid'] = self::getAuth()['uid'];
			
			//	扩展验证规则,如果有扩展表的话 begin:
			$_res = !empty(self::$extbase) ? self::$extbase->setRulesExt(self::$model, $this->request->getPost('ext')) : [];			
			if (!empty($_res['rules'])){
				self::$model->setValidationRules($_res['rules']);
				$adata = array_merge($adata, empty($_res['post']) ? [] : $_res['post']);
			}
			// end;
		
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
		return view($this->_tpl . 'detail', $data);
	}
	
	public function edit($id){
		$uid = intval($id);
		if ($this->request->getPost()){
			$adata = $this->setFilterData('edit');
			$adata['edituid'] = self::getAuth()['uid'];
			//	修改验证规则 
			$validrules = self::$model->getValidationRules();
			$validrules['username'] = 'required|string|is_unique[sys_user.username,username,{username}]|min_length[3]';
			$validrules['passwd'] = 'permit_empty|min_length[6]';
			self::$model->setValidationRules($validrules);
			
			$_res = !empty(self::$extbase) ? self::$extbase->setRulesExt(self::$model, $this->request->getPost('ext')) : [];			
			if (!empty($_res['rules'])){
				self::$model->setValidationRules($_res['rules']);
				$adata = array_merge($adata, empty($_res['post']) ? [] : $_res['post']);
			}
									
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
		return view($this->_tpl . 'detail', $data);
	}
	
	public function del(){
		if ($this->request->getPost()){
			$uid  = $this->request->getPost('id', FILTER_SANITIZE_NUMBER_INT);
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

/*
	public function view($id){
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
*/
}
