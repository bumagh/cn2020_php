<?php

namespace App\Controllers\Api;
use App\Controllers\ApiController;

class Message extends ApiController
{

	protected static $model;
	
	public function __construct(){
		self::$model = model('App\Models\MessageModel');
	}
	
	// 提醒解绑
	public function unMyInvited(){
		$pdata = $this->request->getJSON(true);
		if (!empty($pdata['invitcode'])){
			$this->checkLogin();
			$code = intval($pdata['invitcode']);

			if ($this->loginfo['username'] == $code){
				$ret['code'] = 0;
				$ret['msg'] = '不需要提醒自己';
				return retJson($ret);				
			}
	
			$mModel = model('App\Models\MemberModel');
			$res = $mModel->where('username', $code)->where('status',1)->select('uid')->get()->getRowArray();
			if (empty($res['uid'])){
				$ret['code'] = 0;
				$ret['msg'] = '不存在该用户';
				return retJson($ret);
			}
						
			$adata['tag'] = 'uninvit';
			$adata['content'] = "会员[".$this->loginfo['username']."]向您发起了请求对TA的绑定解除。";
			$adata['fromuid'] = $this->loginfo['uid'];
			$adata['touid'] = $res['uid'];
			if (self::$model->insert($adata)){
				$ret['code'] = 1;
				return retJson($ret);
			}
		}
		
		$ret['code'] = 0;
		$ret['msg'] = '操作异常';
		return retJson($ret);						
	}
	
	public function getnew(){
		$this->checkLogin();
		$ret['data'] = self::$model->getNewMessage($this->loginfo['uid']);
		$ret['code'] = 1;
		return retJson($ret);
	}
	
	public function getmine(){
		$this->checkLogin();
		$pdata = $this->request->getJSON(true);
		$uid = $this->loginfo['uid'];
		$sdata['touid'] = $uid; 
	
		//$pdata = $this->request->getJSON(true);
		//$sdata['touid'] = 60;
				
		$page = max(1, empty($pdata['page']) ? 0 : intval($pdata['page']));
		$limit = empty($pdata['limit']) ? 15 : intval($pdata['limit']);
		$count = empty($pdata['count']) ? 0 : intval($pdata['count']);
		$ret['count'] = empty($count) ? self::$model->count($sdata)['id'] : $count;
		$ret['data'] = self::$model->getData($sdata,$limit, ($page - 1) * $limit);
		if (!empty($ret['data'])){
			$lang = lang('Sysfields.message');
			foreach ($ret['data'] as $k => $v){
				$ret['data'][$k]['tag'] = $lang[$v['tag']];
			}
		}
		$ret['page'] = $page;
		$ret['limit'] = $limit;
		$ret['code'] = 1;
		return retJson($ret);
	}
	
	public function setread(){
		$pdata = $this->request->getJSON(true);
		if (!empty($pdata['id'])){
			$this->checkLogin();
			$uid = $this->loginfo['uid'];
			$id = intval($pdata['id']);
			self::$model->where('touid', $uid)->where('id',$id)->set(['status'=>0])->update();
			$ret['code'] = 1;	
			return retJson($ret);		
		}
		$ret['code'] = 0;
		$ret['msg'] = '请求异常';
		return retJson($ret);				
	}
	public function del(){
		$pdata = $this->request->getJSON(true);
		if (!empty($pdata['id'])){
			$this->checkLogin();
			$uid = $this->loginfo['uid'];
			$id = intval($pdata['id']);
			self::$model->where('touid', $uid)->where('id',$id)->delete();
			$ret['code'] = 1;	
			return retJson($ret);		
		}
		$ret['code'] = 0;
		$ret['msg'] = '请求异常';
		return retJson($ret);
	}
}
