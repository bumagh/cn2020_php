<?php

namespace App\Controllers\Api;
use App\Controllers\ApiController;

// 
class Share extends ApiController
{

	protected static $model;
	
	public function __construct(){
		self::$model = model('App\Models\ShareModel');
	}
	

	
	public function getData(){
		$pdata = $this->request->getJSON(true);		
		if (!isset($pdata['uid'])){
			$ret['msg'] = '请求异常';
			$ret['code'] = 0;
			return retJson($ret);
		}
		
		$ret['data'] = self::$model->where('uid', intval($pdata['uid']))->get()->getRowArray();		
		$ret['code'] = 1;
		return retJson($ret);
	}
	

	// 登记用户的分享编辑内容
	public function setData(){
		$pdata = $this->request->getJSON(true);	
		if (!empty($pdata['title'])){
			$this->checkLogin();
			
			$adata['title'] = filter_var($pdata['title'], FILTER_SANITIZE_STRING);
			$adata['content'] = filter_var($pdata['content'], FILTER_SANITIZE_STRING);
			$adata['url'] = filter_var($pdata['url'], FILTER_SANITIZE_URL);
			
			$row = self::$model->where('uid',  $this->loginfo['uid'])->get()->getRowArray();
			if (!empty($row)){
				self::$model->where('uid',  $this->loginfo['uid'])->set($adata)->update();
					$ret['code'] = 1;
					return retJson($ret);				
			}else{
				$adata['uid'] = $this->loginfo['uid'];
				$adata['status'] = 1;
				$id = self::$model->insert($adata);				
				if (!empty($id)){
					$ret['code'] = 1;
					return retJson($ret);
				}			
			}
		}
		
		$ret['code'] = 0;
		$ret['msg']  = '发布异常';
		return retJson($ret);	
	}
	
}
