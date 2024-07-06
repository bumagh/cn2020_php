<?php
namespace App\Controllers\Webadmin;
use App\Controllers\AdminController;

class Syslog extends AdminController{

	protected static $model;
	
	public function __construct(){
		self::$model = model('App\Models\SysLogModel');
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
	
	public function clear(){
		if (self::$model->setEmpty()){
			$ret['code'] = 1;
		}else{
			$ret['code'] = 0;
		}
		return retJson($ret);		
	}
}
