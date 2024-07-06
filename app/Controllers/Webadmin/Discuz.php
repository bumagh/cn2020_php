<?php
namespace App\Controllers\Webadmin;
use App\Controllers\AdminController;

class Discuz extends AdminController{

	protected static $model;
	
	public function __construct(){
		self::$model = model('App\Models\DiscuzModel');
	}

	public function index(){	
		if ($this->request->getPost()){
			// 基本表查询字段
			$ret = parent::getSearchData(self::$model);
			if (!empty($ret['data'])){
				$mModel = model('App\Models\MemberModel');
				$ret['member'] = array_column($mModel->getMemberByUids(array_column($ret['data'],'uid')),NULL,'uid');
			}
			
			return retJson($ret);
		}
		$data['init'] = parent::setIndexInitData(self::$model);
		return view($this->_tpl.'index', $data);
	}
	
	public function delm(){
		if ($this->request->getPost()){
			$ids  = $this->request->getPost('ids', FILTER_SANITIZE_NUMBER_INT);
			if (!empty($ids)){
				self::$model->whereIn('id',$ids)->delete();
				$ret['code'] = 1;
				$ret['data'] = $ids;
				return retJson($ret);
			}
		}
		$ret['code'] = 0;
		$ret['msg'] = 'error';
		return retJson($ret);
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
