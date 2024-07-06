<?php

namespace App\Controllers\Api;
use App\Controllers\ApiController;

// 聊天室
class Chat extends ApiController
{
	public function __construct(){

	}
	
	public function test(){
		$pdata['rid'] = 1;
		$ret = $this->getGroupChat($pdata);

		echo "<PRE>";
		print_r($ret);
		
	}
	private function getGroupMember($pdata){	
		$chat = model('App\Models\ChatGroupModel');
		$ids = $chat->where('rid',intval($pdata['rid']))->groupBy('uid')->findColumn('uid');
		if (!empty($ids)){
			$mModel = model('App\Models\MemberModel');
			$ret['data'] = $mModel->getMemberByUids($ids);		
		}
		$ret['code'] = 1;
		return $ret;
	}

	private function getFriendMember($pdata){	
		$ids[] = intval($pdata['rid']);
		if (!empty($ids)){
			$mModel = model('App\Models\MemberModel');
			$ret['data'] = $mModel->getMemberByUids($ids);		
		}
		$ret['code'] = 1;
		return $ret;
	}
	
	private function getGroupChat($pdata){	
		$chat = model('App\Models\ChatGroupModel');
		$page = max(1, empty($pdata['page']) ? 0 : intval($pdata['page']));
		$limit = empty($pdata['limit']) ? 15 : intval($pdata['limit']);			
		//$_data = $chat->getData($sdata, $limit, ($page-1) * $limit,'','','id','desc');			
		
		if (!empty($pdata['id'])){
			$_data = $chat->where('rid',intval($pdata['rid']))->where('id<'.intval($pdata['id']))->select('id,rid,uid,content,tag,status,created_at')->orderBy('id','desc')->get($limit)->getResultArray();
		}else{
			$_data = $chat->where('rid',intval($pdata['rid']))->select('id,rid,uid,content,tag,status,created_at')->orderBy('id','desc')->get($limit)->getResultArray();
		}
		
		if (!empty($_data)){
			$mModel = model('App\Models\MemberModel');
			$ids = array_column($_data,'uid');
			$ret['member'] = array_column($mModel->getMemberByUids($ids),NULL,'uid');
		}
	//	$ret['data'] = array_reverse($_data);
		$ret['data'] = $_data;
		$ret['code'] = 1;
		$ret['date'] = date('Y-m-d H:i:s');
		return $ret;
	}
	
	private function getFriendChat($pdata){
		$chat = model('App\Models\ChatFriendModel');
		$db = db_connect();
		$uid = intval($pdata['uid']);
		$fid = intval($pdata['rid']);
		$c = " where ((uid='{$uid}' and fid='{$fid}') or (uid='{$fid}' and fid='{$uid}')) ";		
		$c .= empty($pdata['id']) ? '' : ' and id <'.intval($pdata['id']);		
		//$_data = $chat->Where("uid", $pdata['uid'])->orWhere("fid", $pdata['fid'])->select('id,uid,fid,tag,content,created_at')->orderby('id','desc')->paginate(15);
		$page = max(1, empty($pdata['page']) ? 0 : intval($pdata['page']));
		$limit = empty($pdata['limit']) ? 15 : intval($pdata['limit']);			
		$sql = "select id,uid,fid,tag,content,created_at 
				from ". $chat->__get('table') . $c . " 
				order by id desc
				limit " . (($page - 1) * $limit) . "," . $limit;
		$query = $db->query($sql);
		$_data = $query->getResultArray();
		
		if (!empty($_data)){
			$mModel = model('App\Models\MemberModel');
			$ids = array_column($_data,'uid');
			$ret['member'] = array_column($mModel->getMemberByUids($ids),NULL,'uid');
		}

//		$ret['data'] = array_reverse($_data);
		$ret['data'] = $_data;
		$ret['code'] = 1;
		$ret['date'] = date('Y-m-d H:i:s');
		return $ret;
	}
		
	public function getRoom(){
		$this->checkLogin();
		//$this->loginfo['uid'] = 60;
		$pdata = $this->request->getJSON(true);		
		$db = db_connect();			
		// 读取聊天群信息 begin:
		$rModel = model('App\Models\ChatModel');
		//$ret['group']['room'] = $rModel->getData(['status'=>1],'id as rid, title,avatar',100);
		
		$ret['group']['room'] = $rModel->where('status',1)->select('id as rid, title,avatar')->get(100)->getResultArray();
		
		if (!empty($ret['group']['room'])){
			//$ids = array_column($ret['group'],'rid');
//			$c = 'where (uid<>'. $this->loginfo['uid'] .') and ';
			$c = 'where ';
			$_t = '';
			foreach ($ret['group']['room'] as $k => $v){
				$_t .= ' rid='.$v['rid']." or ";
			}			
			$c .= '('.rtrim($_t,' or ') . ')';

			$gChat = model('App\Models\ChatGroupModel');				
			$sql = 'SELECT	max.* FROM (SELECT DISTINCT (a.id),tag,content,uid,rid,created_at FROM ' . $gChat->__GET("table") . ' a ' . $c . ' ORDER BY a.created_at DESC) max GROUP BY rid';
			$query = $db->query($sql);
			$ret['group']['news'] = $query->getResultArray();						
			$uids =  array_unique(array_column($ret['group']['news'],'uid'));
			$ret['group']['news'] = array_column($ret['group']['news'],NULL,'rid');
			if (!empty($uids)){
				$mModel = model('App\Models\MemberModel');
				$ret['group']['uinfo'] = array_column($mModel->getMemberByUids($uids),NULL,'uid');
			}
		}
		// end;
		
		// 读取联系人聊天信息 begin:
		$c = 'where (uid='. $this->loginfo['uid'] .' or fid='. $this->loginfo['uid'] .') ';
		$fChat = model('App\Models\ChatFriendModel');			
		$_tbl = $fChat->__GET("table");	
		//$sql = 'SELECT	max.* FROM (SELECT DISTINCT (a.id),content,uid,fid,created_at FROM ' . $fChat->__GET("table") . ' a ' . $c . ' ORDER BY a.created_at DESC) max GROUP BY fid';
		
		$sql = 'SELECT uid,fid,tag,content,created_at 
				FROM
				(SELECT uid,fid,tag,content,created_at 
				FROM '.$_tbl. ' m 
				WHERE 
				(m.uid IN(SELECT uid as chat_id FROM '. $_tbl. ' e WHERE e.fid = '.$this->loginfo['uid'].' UNION SELECT fid as chat_id FROM '.$_tbl.' e WHERE e.uid = '.$this->loginfo['uid'].') AND m.fid = '.$this->loginfo['uid'].')
				OR
				(m.uid='.$this->loginfo['uid'].' AND m.fid IN(SELECT uid as chat_id FROM '.$_tbl.' e WHERE e.fid = '.$this->loginfo['uid'].' UNION SELECT fid as chat_id FROM '.$_tbl.' e WHERE e.uid = '.$this->loginfo['uid'].'))
				ORDER BY created_at DESC LIMIT 99999) msg 
				GROUP BY msg.uid+msg.fid,ABS(msg.uid-msg.fid)';
				
		$query = $db->query($sql);
		
		$_friendnews = $query->getResultArray();
		if (!empty($_friendnews)){
			$uids = [];
			foreach ($_friendnews as $k => $v){
				$uid = ($v['uid'] == $this->loginfo['uid']) ? $v['fid'] : $v['uid'];
				$ret['friend']['news'][$uid] = $v;
				array_push($uids,$v['fid'],$v['uid']);
			}
			$uids = array_unique($uids);
			if (!empty($uids)){
				$mModel = model('App\Models\MemberModel');
				$ret['friend']['uinfo'] = array_column($mModel->getMemberByUids($uids),NULL,'uid');
			}
		}
		// end;		
		$ret['code'] = 1;
		/*
		echo "<PRE>";
		print_r($ret['friend']['news']);
		exit;
		*/
		return retJson($ret);
	}
	
	public function setData(){
		$this->checkLogin();
		$pdata = $this->request->getJSON(true);		
		if (!empty($pdata['type']) && !empty($pdata['tag']) && !empty($pdata['rid'])){
			$rid = intval($pdata['rid']);
			if ($pdata['type'] == 'group'){
				$chat = model('App\Models\ChatGroupModel');			
				$fields = 'id,uid,rid,tag,content,created_at';	
				$adata['rid'] = $rid;
			}else if ($pdata['type'] == 'friend'){
				$chat = model('App\Models\ChatFriendModel');
				$fields = 'id,uid,fid,tag,content,created_at';
				$adata['fid'] = $rid;
			}
			
			$adata['uid'] = $this->loginfo['uid'];
			$adata['type'] = $pdata['type'];
			$adata['tag'] = $pdata['tag'];
			$adata['content'] = $pdata['content'];
			$adata['created_at'] =  date('Y-m-d H:i:s');
			$adata['id'] = $chat->insert($adata);
			if (!empty($adata['id'])){
				$ret['code'] = 1;
				$ret['data'] = $adata;
	//			$ret['date'] = date('Y-m-d H:i:s');
				return retJson($ret);	
			}
		}
		$ret['code'] = 0;
		return retJson($ret);	
	}
	
	public function getData(){
		$this->checkLogin();
		$pdata = $this->request->getJSON(true);
		if (!empty($pdata['type']) && !empty($pdata['rid'])){
			if ($pdata['type'] == 'group'){
				return retJson($this->getGroupChat($pdata));
			}else if ($pdata['type'] == 'friend'){
				$pdata['uid'] = $this->loginfo['uid'];
				return retJson($this->getFriendChat($pdata));			
			}		
		}
		$ret['code'] = 0;
		$ret['msg'] = '参数丢失';
		return retJson($ret);
	}
	
	public function getMember(){
		$this->checkLogin();
		$pdata = $this->request->getJSON(true);
		if (!empty($pdata['type']) && !empty($pdata['rid'])){
			if ($pdata['type'] == 'group'){
				return retJson($this->getGroupMember($pdata));
			}else if ($pdata['type'] == 'friend'){
				$pdata['uid'] = $this->loginfo['uid'];
				return retJson($this->getFriendMember($pdata));			
			}		
		}
		$ret['code'] = 0;
		$ret['msg'] = '参数丢失';
		return retJson($ret);
	}
}
