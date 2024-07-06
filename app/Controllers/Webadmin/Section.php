<?php
namespace App\Controllers\Webadmin;
use App\Controllers\AdminController;

class Section extends AdminController{

	protected static $model;
	protected static $extbase;
	
	public function __construct(){
		self::$model = model('App\Models\SectionModel');
		self::$extbase = new \App\Entities\Extbase;		
	}

	private function setFilterData($type){
		$adata['name']		= $this->request->getPost('name', FILTER_SANITIZE_STRING);	
		$adata['desc']		= $this->request->getPost('desc', FILTER_SANITIZE_STRING);	
		$adata['bdate']		= $this->request->getPost('bdate', FILTER_SANITIZE_STRING);		
		$adata['edate']		= $this->request->getPost('edate', FILTER_SANITIZE_STRING);	
		$adata['sort']		= $this->request->getPost('sort', FILTER_SANITIZE_NUMBER_INT);	
		$adata['tourl']		= $this->request->getPost('tourl', FILTER_SANITIZE_URL);	
		$adata['thumb']		= $this->request->getPost('thumb', FILTER_SANITIZE_URL);	
		$adata['image']		= $this->request->getPost('image', FILTER_SANITIZE_URL);	
		$adata['imagew']	= $this->request->getPost('imagew', FILTER_SANITIZE_NUMBER_INT);	
		$adata['imageh']	= $this->request->getPost('imageh', FILTER_SANITIZE_NUMBER_INT);	
		$_status			= $this->request->getPost('status', FILTER_SANITIZE_STRING);
		$adata['status']	= (!empty($_status)) ? 1 : 0;
		return $adata;
	}

	public function index(){	
		if ($this->request->getPost()){
			$ret = parent::getSearchData(self::$model, self::$extbase);
			return retJson($ret);
		}
		
		$data['init'] = parent::setIndexInitData(self::$model, self::$extbase);
		return view($this->_tpl.'index', $data);
	}
	
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
					
			$id = self::$model->insert($adata);
			if ($id){
				parent::setDetailPostExt(self::$model, self::$extbase, $id);
				$ret['id'] = $id;
				$ret['code'] = 1;
				return retJson($ret);
			}

			$ret['msg'] = self::$model->errors();
			$ret['code'] = 0;
			return retJson($ret);
		}
		
		$data['init'] = parent::setDetailInitData(self::$model);
		return view($this->_tpl.'detail', $data);
	}
	public function edit($id){
		$id = intval($id);
		if (empty($id)) return "参数丢失"; 
		
		if ($this->request->getPost()){
			$adata = $this->setFilterData('edit');
			$adata['edituid'] = self::getAuth()['uid'];
			//	扩展验证规则,如果有扩展表的话 begin:
			$_res = !empty(self::$extbase) ? self::$extbase->setRulesExt(self::$model, $this->request->getPost('ext')) : [];			
			if (!empty($_res['rules'])){
				self::$model->setValidationRules($_res['rules']);
				$adata = array_merge($adata, empty($_res['post']) ? [] : $_res['post']);
			}
			// end;
			$st = self::$model->update($id,$adata);
			if ($st){
				parent::setDetailPostExt(self::$model, self::$extbase, $id);
				$ret['data'] = $adata;
				$ret['code'] = 1;
				return retJson($ret);
			}
			$ret['msg'] = self::$model->errors();
			$ret['code'] = 0;
			return retJson($ret);
		}
	
		$data['init'] = parent::setDetailInitData(self::$model, $id);
		return view($this->_tpl.'detail', $data);
	}
	
	public function del(){
		if ($this->request->getPost()){
			$id  = $this->request->getPost('id', FILTER_SANITIZE_NUMBER_INT);
			if (self::$model->delete($id)){
				$ret['code'] = 1;
				$ret['data'] = $id;
				return retJson($ret);
			}
		}
		
		$ret['code'] = 0;
		return retJson($ret);
	}
}
