<?php

namespace App\Controllers\Api;
use App\Controllers\ApiController;

// 投票
class Vote extends ApiController
{

	protected static $vModel;
	protected static $jModel;
	
	public function __construct(){
		self::$vModel = model('App\Models\VoteModel');
		self::$jModel = model('App\Models\VoteJoinModel');
	}
	
	private function getJoin($ids=[]){
		if (!empty($ids)){
			$result = [];
			$total = self::$jModel->whereIn('vid', $ids)->groupBy('vid,value')->select("vid,value as opt,count(value) as numb")->get()->getResultArray();
//			if (empty($total)) return $result;
			$ext = $this->getExtData(self::$vModel, $ids);			
			if (!empty($ext)){
				$_fields = $this->getExtFields(self::$vModel->__get("table"));
								
				$options = json_decode($_fields['voteitem']['setting'],true);
				foreach ($ext as $k => $v){
					$_t = explode(',',$v['voteitem']['value']);
					$result[$k]['options'] = array_intersect($options, $_t);
					$result[$k]['total'] = 0;
					$result[$k]['items'] = array_fill_keys(array_keys($result[$k]['options']),0);
					if (empty($total)){					
						continue;
					}
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
			if ($pinfo['status'] == 2){
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
		print_r($this->getJoin([8,9,7]));
		
	}
	
	public function getData(){
		$pdata = $this->request->getJSON(true);		
		if (!isset($pdata['tag'])){
			$ret['msg'] = '请求异常';
			$ret['code'] = 0;
			return retJson($ret);
		}	
		$tag = intval($pdata['tag']);			
//		$db = db_connect();
		
		$sdata['tag'] = ($tag <=1) ? 1 : $tag;
//		$sdata['status'] = ($tag < 2) ? $tag : 1;
		if ($sdata['tag'] == 1){
			if (isset($pdata['status'])) $sdata['status'] = intval($pdata['status']);		
		}else if ($sdata['tag'] > 1){
			$sdata['status>'] = 0;	
		}

		$page = max(1, empty($pdata['page']) ? 0 : intval($pdata['page']));
		$limit = empty($pdata['limit']) ? 15 : intval($pdata['limit']);
		$ret['count'] = empty($pdata['count']) ? 0 : intval($pdata['count']);
		
		if ($ret['count'] == 0){
			$ret['count'] = self::$vModel->count($sdata)['id'];
		}
		
		$ret['data'] = self::$vModel->getData($sdata, $limit, ($page-1) * $limit);
		//echo self::$vModel->__get("db")->getLastQuery();
		if (!empty($ret['data'])){
			$ids = array_column($ret['data'],'id');
			$ret['result'] = $this->getJoin($ids);
			$dis = new \App\Entities\Discuz;
			$ret['discuz'] = array_column($dis->getNewoneByModule('vote',$ids, $sdata['tag']),NULL,'relid');
		}
		
		$ret['page'] = $page;
		$ret['limit'] = $limit;
		$ret['code'] = 1;
		return retJson($ret);
	}
	
	// 
	public function getOptions(){
		$this->checkLogin();
		$extbase = new \App\Entities\Extbase;
		$opt = $extbase->getExtFields(self::$vModel->__get("table"))['voteitem']['setting'];
		if (!empty($opt)){
			$t = json_decode($opt, true);
			$data = [];
			$i = 0;
			foreach ($t as $k => $v){
				$data[$i]['text']	= $v;
				$data[$i]['value']	= $k;
				$i++;
			}
			$ret['data'] = $data;
			$ret['code'] = 1;
			return retJson($ret);			
		}
		
		$ret['msg'] = '请求异常';
		$ret['code'] = 0;
		return retJson($ret);
	}
	
	// 用户发表议题
	public function setTopic(){
		$pdata = $this->request->getJSON(true);	
		if (!empty($pdata['tag'])){
			$this->checkLogin();
			$adata['tag'] 	= intval($pdata['tag']);
			$adata['title'] = filter_var($pdata['title'], FILTER_SANITIZE_STRING);
			$adata['intro'] = filter_var($pdata['intro'], FILTER_SANITIZE_STRING);
			$adata['etime'] = empty($pdata['etime']) ? NULL : $pdata['etime'];
			$adata['status'] = 1;	// 用户发布后即为进行中
			$adata['uid'] = $this->loginfo['uid'];
			$id = self::$vModel->insert($adata);
			if (!empty($id)){
				$extbase = new \App\Entities\Extbase;
				$extdata['checkbox']['voteitem'] = $pdata['options'];
				$extbase->setExtValue(self::$vModel->__get("table"), $id, $extdata, $adata['uid']);
				$ret['code'] = 1;
				return retJson($ret);
			}			
		}
		
		$ret['code'] = 0;
		$ret['msg']  = '发布异常';
		return retJson($ret);	
	}
	
}
