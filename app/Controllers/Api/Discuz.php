<?php

namespace App\Controllers\Api;
use App\Controllers\ApiController;

// 讨论
class Discuz extends ApiController
{

	protected static $dModel;	
	public function __construct(){
		self::$dModel = model('App\Models\DiscuzModel');
	}
	
	private function getJoin($ids=[]){
		if (!empty($ids)){
			$result = [];
			$total = self::$jModel->whereIn('vid', $ids)->groupBy('vid,value')->select("vid,value as opt,count(value) as numb")->get()->getResultArray();
			$ext = $this->getExtData(self::$vModel, $ids);
			if (!empty($ext)){
				$_fields = $this->getExtFields(self::$vModel->__get("table"));
				$options = json_decode($_fields['voteitem']['setting'],true);
				foreach ($ext as $k => $v){
					$_t = explode(',',$v['voteitem']['value']);
					$result[$k]['options'] = array_intersect($options, $_t);
					$result[$k]['total'] = 0;
					$result[$k]['items'] = array_fill_keys(array_keys($result[$k]['options']),0);
					foreach ($total as $k2 => $v2){
						if ($v2['vid'] == $k){
							$result[$k]['items'][$v2['opt']] = $v2['numb'];
							$result[$k]['total'] += $v2['numb'];
						}
					}
				}
			}			 
			return $result;
		}
		return false;
	}
	
	// 参与投票
	public function join(){
		$pdata = $this->request->getJSON(true);	
		if (!empty($pdata['id']) && !empty($pdata['vote'])){
			$this->checkLogin();
			$uid = $this->loginfo['uid'];
			$id = intval($pdata['id']);
			$vote = intval($pdata['vote']);
			$tag = $pdata['tag'];
			
			// 判断当前标的的有效性
			$pinfo = self::$vModel->where('id', $id)->get()->getRowArray();
			if (!empty($pinfo['etime'])) {
				$_t = strtotime($pinfo['etime']);
				if ($_t < time()){
					$ret['msg'] = "该标的已过期。";
					$ret['code'] = 0;
					return retJson($ret);				
				}
			}			
			if ($pinfo['status'] != 0){
				$ret['msg'] = '该投票已经结束';
				$ret['code'] = 0;
				return retJson($ret);
			}
			
			$_voted = self::$jModel->where('vid',$id)->where('uid', $uid)->get()->getRowArray();
			if (!empty($_voted)){
				$ret['msg'] = '不能重复投票';
				$ret['code'] = 0;
				return retJson($ret);			
			}			

			$data['vid'] = $id;
			$data['uid'] = $uid;
			$data['value'] = $vote;
			$data['id'] = self::$jModel->insert($data);
			if ($data['id']){
				$ret['data'] = $this->getJoin([$id]);
				$ret['code'] = 1;
				return retJson($ret);			
			}
		}
		$ret['msg'] = '请求异常';
		$ret['code'] = 0;
		return retJson($ret);
	
	}
	
	public function test(){
		//print_r($this->getJoin([8,9,7]));
		$dis = new \App\Entities\Discuz;
		echo "<PRE>";
		print_r($dis->getNewoneByModule('vote',[8,9]));
	}
	
	public function getData(){
		$pdata = $this->request->getJSON(true);		
		
		if (!empty($pdata['module'])){
			$sdata['module'] = $pdata['module'];		
		}

		if (isset($pdata['tag'])){		
			$sdata['tag'] = intval($pdata['tag']);
		}
				
		if (!empty($pdata['id'])){		
			$sdata['relid'] =  intval($pdata['id']);
		}
		
		
		$sdata['status'] = 1;

		$page = max(1, empty($pdata['page']) ? 0 : intval($pdata['page']));
		$limit = empty($pdata['limit']) ? 15 : intval($pdata['limit']);
		$ret['count'] = empty($pdata['count']) ? 0 : intval($pdata['count']);
		
		if ($ret['count'] == 0){
			$ret['count'] = self::$dModel->count($sdata)['id'];
		}
		
		$ret['data'] = self::$dModel->getData($sdata, $limit, ($page-1) * $limit);
		if (!empty($ret['data'])){
			$mModel = model('App\Models\MemberModel');
			$ids = array_column($ret['data'],'uid');
			$ret['member'] = array_column($mModel->getMemberByUids($ids),NULL,'uid');
		}
		
		$ret['page'] = $page;
		$ret['limit'] = $limit;
		$ret['code'] = 1;
		return retJson($ret);
	}
	
	public function setData(){
		$pdata = $this->request->getJSON(true);	
		if (empty($pdata['module'])){
			$ret['msg'] = '请求异常';
			$ret['code'] = 0;
			return retJson($ret);				
		}
		
		$allowModule = array_keys(self::$dModel->__GET("searchFields")['module']['setting']);
		if (!in_array($pdata['module'], $allowModule)){
			$ret['msg'] = '请求异常';
			$ret['code'] = 0;
			return retJson($ret);		
		}
		
		if ($pdata['module'] == 'vote'){
			if (empty($pdata['id']) || empty($pdata['content']) || !isset($pdata['tag'])){
				$ret['msg'] = '请求异常';
				$ret['code'] = 0;
				return retJson($ret);		
			}
			$adata['relid'] = intval($pdata['id']);
			$adata['tag'] = intval($pdata['tag']);
		}
		
		
		$this->checkLogin();		
		$adata['uid'] = $this->loginfo['uid'];
		$adata['status'] = 1;
		$adata['module'] = filter_var($pdata['module'],FILTER_SANITIZE_STRING);
		$adata['content'] = filter_var($pdata['content'],FILTER_SANITIZE_STRING);
		if (self::$dModel->insert($adata)){
			$ret['code'] = 1;
			return retJson($ret);					
		}

//		$ret['msg'] = self::$dModel->errors();
		$ret['msg'] = '出错了';
		$ret['code'] = 0;
		return retJson($ret);
		
	}
}
