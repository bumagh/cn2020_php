<?php

namespace App\Controllers\Api;
use App\Controllers\ApiController;

class Paimai extends ApiController
{

	protected static $pModel;
	protected static $jModel;
	
	public function __construct(){
		self::$pModel = model('App\Models\PaimaiModel');
		self::$jModel = model('App\Models\PaimaiJoinModel');
	}
	
	public function test(){
		$tag = 0;
		$db = db_connect();
		$mModel = model('App\Models\MemberModel');
		$page = max(1, empty($pdata['page']) ? 0 : intval($pdata['page']));
		$limit = empty($pdata['limit']) ? 15 : intval($pdata['limit']);
		$ret['count'] = empty($pdata['count']) ? 0 : intval($pdata['count']);
		
		if ($ret['count'] == 0){
			$ret['count'] = self::$pModel->count(['tag'=>$tag])['id'];
		}
				
		$sql = "select a.id,a.tag,a.name as title,a.numbmin,substring(a.etime,6,10) as etime,a.status,b.pid,b.uid,b.numb,c.name,c.avatar,c.sign
				from " . self::$pModel->__get('table') . " as a 
				left join (SELECT max.* FROM (SELECT DISTINCT (a.id), a.pid,uid,numb FROM " . self::$jModel->__get('table'). " a ORDER BY a.numb DESC) max GROUP BY	pid) as b 
				on a.id = b.pid 
				left join " . $mModel->__get('table') . " as c
				on b.uid = c.uid
				where  a.tag=" . $tag . "
				order by a.status asc,a.id desc
				limit " . (($page - 1) * $limit) . "," . $limit;				
		$query = $db->query($sql);
		$ret['data'] = $query->getResultArray();			
		$ret['page'] = $page;
		$ret['limit'] = $limit;
		$ret['tag'] = $tag;
		$ret['code'] = 1;
		return retJson($ret);
	}
	
	// 参与竞拍
	public function join(){
		$pdata = $this->request->getJSON(true);	
		if (!empty($pdata['id']) && !empty($pdata['numb'])){
			$this->checkLogin();
			$uid = $this->loginfo['uid'];
			$pid = intval($pdata['id']);
			$numb = intval($pdata['numb']);
			
			// 判断当前标的的有效性
			$pinfo = self::$pModel->where('id', $pid)->get()->getRowArray();
			if ($pinfo['numbmin'] > $numb){
				$ret['msg'] = '竞价过低';
				$ret['code'] = 0;
				return retJson($ret);			
			}
			if (!empty($pinfo['numbmax']) && ($pinfo['numbmax'] < $numb)){
				$ret['msg'] = "竞价过高,\n\r不得超过".$pinfo['numbmax'];
				$ret['code'] = 0;
				return retJson($ret);			
			}
			if (!empty($pinfo['etime'])) {
				$_t = strtotime($pinfo['etime']);
				if ($_t < time()){
					$ret['msg'] = "该标的已过期。";
					$ret['code'] = 0;
					return retJson($ret);				
				}
			}			
			if ($pinfo['status'] != 0){
				$ret['msg'] = '该竞价标的已经结束';
				$ret['code'] = 0;
				return retJson($ret);
			}
			
			
			$pocketModel = model('App\Models\PocketModel');
			$pocket = $pocketModel->getPocket($uid);

			if ($pocket['coin'] < $numb){
				$ret['msg'] = '金币不足';
				$ret['code'] = 0;
				return retJson($ret);			
			}
			
			$data['coin'] = 0 - $numb;
			$data['coinfix'] = $numb;
			if ($pocketModel->updatePocket($uid, $data)) {				
				$data = [];
				$data['pid'] = $pid;
				$data['uid'] = $uid;
				$data['numb'] = $numb;
				$data['id'] = self::$jModel->insert($data);
				if ($data['id']){
					// 直接退还小于当前出价的金币
					$jdata = self::$jModel->where('pid', $pid)->where('numb<'.$numb)->orderBy('numb','desc')->get()->getResultArray();
					if (!empty($jdata)){
						foreach ($jdata as $k2 => $v2){
							// 解冻金币
							$pocketModel->cancelCoinFix($v2['uid'], $v2['numb']);
							// 发送消息
							$this->sendMessage($v2['uid'],'cashjoin:fail', $pinfo['name']);
						}
					}
				
				
					$member = model('App\Models\MemberModel');
					$_minfo = $member->where('uid', $uid)->select('name,avatar,sign')->get()->getRowArray();
					$ret['data'] = array_merge($data,$_minfo);
				}
				$ret['code'] = 1;
				return retJson($ret);			
			}			
		}
		$ret['msg'] = '请求异常';
		$ret['code'] = 0;
		return retJson($ret);
	
	}
	
	public function getData(){
		$pdata = $this->request->getJSON(true);		
		if (!isset($pdata['tag'])){
			$ret['msg'] = '请求异常';
			$ret['code'] = 0;
			return retJson($ret);
		}
		$tag = intval($pdata['tag']);			
		$db = db_connect();
		$mModel = model('App\Models\MemberModel');
		$page = max(1, empty($pdata['page']) ? 0 : intval($pdata['page']));
		$limit = empty($pdata['limit']) ? 15 : intval($pdata['limit']);
		$ret['count'] = empty($pdata['count']) ? 0 : intval($pdata['count']);
		
		if ($ret['count'] == 0){
			$ret['count'] = self::$pModel->count(['tag'=>$tag])['id'];
		}
				
		$sql = "select a.id,a.tag,a.name as title,a.numbmin,substring(a.etime,6,10) as etime,a.status,b.pid,b.uid,b.numb,c.name,c.avatar,c.sign
				from " . self::$pModel->__get('table') . " as a 
				left join (SELECT max.* FROM (SELECT DISTINCT (a.id), a.pid,uid,numb FROM " . self::$jModel->__get('table'). " a ORDER BY a.numb DESC) max GROUP BY	pid) as b 
				on a.id = b.pid 
				left join " . $mModel->__get('table') . " as c
				on b.uid = c.uid
				where  a.tag=" . $tag . "
				order by a.status asc,a.id desc
				limit " . (($page - 1) * $limit) . "," . $limit;				
		$query = $db->query($sql);
		$ret['data'] = $query->getResultArray();			
		$ret['page'] = $page;
		$ret['limit'] = $limit;
		$ret['tag'] = $tag;
		$ret['code'] = 1;
		return retJson($ret);
	}
}
