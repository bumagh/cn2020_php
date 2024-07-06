<?php
namespace App\Controllers\Webadmin;
use App\Controllers\AdminController;

class Paimai extends AdminController{

	protected static $model;
	
	public function __construct(){
		self::$model = model('App\Models\PaimaiModel');
	}

	private function setFilterData($type){
		$adata['tag']		= $this->request->getPost('tag', FILTER_SANITIZE_NUMBER_INT);	
		$adata['name']		= $this->request->getPost('name', FILTER_SANITIZE_STRING);
		$adata['numbmin']	= $this->request->getPost('numbmin', FILTER_SANITIZE_NUMBER_INT);	
		$adata['numbmax']	= $this->request->getPost('numbmax', FILTER_SANITIZE_NUMBER_INT);	
		$adata['content']	= $this->request->getPost('content', FILTER_SANITIZE_STRING);
		$adata['btime']		= empty($this->request->getPost('btime')) ? NULL :  $this->request->getPost('btime',FILTER_SANITIZE_STRING);	
		$adata['etime']		= empty($this->request->getPost('etime')) ? NULL :  $this->request->getPost('etime',FILTER_SANITIZE_STRING);	
		$_status			= $this->request->getPost('status', FILTER_SANITIZE_STRING);
		$adata['status']	= (!empty($_status)) ? 1 : 0;
		return $adata;
	}
	
	public function index(){	
		if ($this->request->getPost()){
			// 基本表查询字段
			$ret = parent::getSearchData(self::$model);
			return retJson($ret);
		}
		$data['init'] = parent::setIndexInitData(self::$model);
		return view($this->_tpl.'index', $data);
	}
	
	public function add(){		
		if ($this->request->getPost()){
			$adata = $this->setFilterData('add');
			$adata['adduid'] = self::getAuth()['uid'];			
			$id = self::$model->insert($adata);
			if ($id){
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
			$st = self::$model->update($id,$adata);
			if ($st){
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


	public function view($id){
			
		$id = intval($id);
		if (empty($id)) return "参数丢失"; 

		$jModel = model('App\Models\PaimaiJoinModel');

		$pdata = $this->request->getPost();
		if (!empty($pdata)){
			$sdata['pid'] = $id; 
			$page = max(1, empty($pdata['page']) ? 0 : intval($pdata['page']));
			$limit = empty($pdata['limit']) ? 15 : intval($pdata['limit']);
			$count = empty($pdata['count']) ? 0 : intval($pdata['count']);
			$ret['count'] = empty($count) ? $jModel->count($sdata)['id'] : $count;
			$ret['data'] = $jModel->getData($sdata,$limit, ($page - 1) * $limit);			
			
			if (!empty($ret['data'])){
				$mModel = model('App\Models\MemberModel');
				$ret['member'] = array_column($mModel->getMemberByUids(array_column($ret['data'],'uid')),NULL,'uid');
			}

			$ret['page'] = $page;
			$ret['limit'] = $limit;
			$ret['code'] = 1;
			return retJson($ret);
		}

		$data['init']['tag'] = 'paimai_view_' . $id;		
		$data['init']['module'] = 'paimai_view';

		return view($this->_tpl.'view', $data);		
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
