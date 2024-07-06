<?php

namespace App\Controllers;

class Sysmessage extends BaseController
{

	protected static $model;
	
	public function __construct(){
		self::$model = model('App\Models\SysMessageModel');
	}
		
	public function index(){
		if ($this->request->getPost()){
			$sdata['touid'] = self::getAuth()['uid']; 
			$page = max(1, $this->request->getPost('page', FILTER_SANITIZE_NUMBER_INT));
			$limit = empty($this->request->getPost('limit')) ? 15 : $this->request->getPost('limit', FILTER_SANITIZE_NUMBER_INT);
			$count = ($this->request->getPost('count', FILTER_SANITIZE_NUMBER_INT));
			$ret['count'] = empty($count) ? self::$model->count($sdata)['id'] : $count;
			$ret['data'] = self::$model->getData($sdata,$limit, ($page - 1) * $limit);
			$ret['code'] = 1;
			return retJson($ret);
		}
		
		$data['init'] = parent::setIndexInitData(self::$model);		
		return  view('systips/index', $data);
	}
	
	public function setread(){
		if ($this->request->getPost('ids[]')){
			$ids = $this->request->getPost('ids[]',FILTER_SANITIZE_NUMBER_INT);
			self::$model->where('touid', self::getAuth()['uid'])->whereIn('id',$ids)->set(['status'=>0])->update();
			$ret['code'] = 1;
			$ret['data'] = $ids;
			$ret['new'] = self::$model->getNewTips(self::getAuth()['uid']);
			return retJson($ret);
		}
		$ret['code'] = 0;
		$ret['msg'] = '请求异常';
		return retJson($ret);				
	}
	public function del(){
		if ($this->request->getPost('ids[]')){
			$ids = $this->request->getPost('ids[]',FILTER_SANITIZE_NUMBER_INT);
			self::$model->where('touid', self::getAuth()['uid'])->whereIn('id',$ids)->delete();
			$ret['code'] = 1;
			$ret['data'] = $ids;
			$ret['new'] = self::$model->getNewTips(self::getAuth()['uid']);
			return retJson($ret);
		}
		$ret['code'] = 0;
		$ret['msg'] = '请求异常';
		return retJson($ret);
	}
}
