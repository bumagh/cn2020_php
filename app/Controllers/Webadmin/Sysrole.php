<?php
// 角色管理
namespace App\Controllers\Webadmin;
use App\Controllers\AdminController;

class Sysrole extends AdminController
{

	protected static $model;
	
	public function __construct(){
		self::$model = model('App\Models\SysRoleModel');
	}
		
		
	private function setRoleAtions(){
		$adata['name'] = $this->request->getPost('name', FILTER_SANITIZE_STRING);
		$adata['memo'] = $this->request->getPost('memo', FILTER_SANITIZE_STRING);			
		
		// 处理已选模块
		$_selectModule = $this->request->getPost('modulelist', FILTER_SANITIZE_STRING);
		$selectModule = [];
		if (!empty($_selectModule)) $selectModule = array_column($_selectModule, 'actions','value');

		if (!empty($selectModule)){
			$selectActions = [];
//			$_validactions = array_keys($data['actionsall']);
			foreach ($selectModule as $k => $v){
				//$_validactions = explode(',',$v);
				$_selectActions = $this->request->getPost($k, FILTER_SANITIZE_STRING);
				if (!empty($_selectActions)){
					$selectActions[$k] = array_fill_keys(array_keys($_selectActions), 1);
				}
			}
			
			$adata['modulelist'] = json_encode($selectActions);
		}
		
		return $adata;
	}
	
	public function index(){
	
		if ($this->request->getPost()){
			$ret = parent::getSearchData(self::$model);
			return retJson($ret);
		}

		$data['init'] = parent::setIndexInitData(self::$model);				
		$mModel = model('App\Models\SysModuleModel');		
		$_mdata = $mModel->getBase(['code','name']);
		$data['mdata'] = array_column($_mdata,'name','code');
		return view($this->_tpl.'index', $data);
	}
		
	public function add(){		
		if ($this->request->getPost()){
			$adata = $this->setRoleAtions();
			$adata['adduid'] = self::getAuth()['uid'];
			$id = self::$model->insert($adata);
			if ($id){
				$ret['code'] = 1;
				return retJson($ret);						
			}

			$ret['msg'] = self::$model->errors();
			$ret['code'] = 0;
			return retJson($ret);			
		}


		$data['init'] = parent::setDetailInitData(self::$model);
		
		// 读取模块数据 		
		$mModel = model('App\Models\SysModuleModel');		
		$data['mdata'] = $mModel->getBase(['mid','code as value','name as title','actions']);
		$data['actionsall'] = lang('Sysfields.actions');
		$data['modulelist'] = [];	// 已选操作项
		return view($this->_tpl.'detail', $data);
	}

	public function edit($id=0){	// 默认测试『经理』角色		
		$id = intval($id);	
		if ($id <= 1) return "不能编辑该角色"; 		
		if ($this->request->getPost()){
			$adata = $this->setRoleAtions();
			$adata['edituid'] = self::getAuth()['uid'];
			$adata['rid'] = $id;
			if (self::$model->update($adata['rid'],$adata)){
				$ret['code'] = 1;
				return retJson($ret);						
			}
			
			$ret['msg'] = self::$model->errors();
			$ret['code'] = 0;
			return retJson($ret);
		}

		$data['init'] = parent::setDetailInitData(self::$model, $id);
		$mModel = model('App\Models\SysModuleModel');			
		$data['mdata'] = $mModel->getBase(['mid','code as value','name as title','actions']);		// 读取模块数据 
		$data['actionsall'] = lang('Sysfields.actions');
		$data['modulelist'] = json_decode($data['init']['row']['modulelist'],true);	// 已选操作项
		return view($this->_tpl.'detail', $data);	
	}
	
	public function del(){
		if ($this->request->getPost()){
			$rid = $this->request->getPOST('id', FILTER_SANITIZE_NUMBER_INT);
			if ($rid == 1){
				$ret['msg'] = '不能删除该角色';
				$ret['code'] = 0;
				return retJson($ret);			
			}
			if ($rid){
				$model = model('App\Models\SysRoleModel');
				if ($model->delete($rid)){
					$ret['code'] = 1;
					return retJson($ret);										
				}
			}
		}
		$ret['code'] = 0;
		return retJson($ret);								
	}
}
