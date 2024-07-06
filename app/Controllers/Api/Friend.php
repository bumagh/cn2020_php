<?php

namespace App\Controllers\Api;
use App\Controllers\ApiController;

// 
class Friend extends ApiController
{

	protected static $model;
	
	public function __construct(){
		self::$model = model('App\Models\FriendModel');
	}
	
	public function test(){
		$myid = 80;
		$uid = 60;
		$mModel = model('App\Models\MemberModel');
		$data = $mModel->where('uid', $myid)->findColumn('name');
		//$data = self::$model->where("(uid='".$myid ."' and fid='".$uid."' or uid='".$uid ."' and fid='".$myid."')")->orderby('status','desc')->get()->getRowArray();
		echo "<PRE>";
		print_r($data);
	}
	
	public function agree(){
		$pdata = $this->request->getJSON(true);	
		if (!empty($pdata['uid'])){
			$this->checkLogin();
			$myid = $this->loginfo['uid'];
			$uid = intval($pdata['uid']);
			if (self::$model->where('fid', $myid)->where('uid',$uid)->set('status',1)->update()) {
				$ret['code'] = 1;
				$ret['msg']  = '操作成功';
				return retJson($ret);			
			}
		}

		$ret['code'] = 0;
		$ret['msg']  = '操作异常';
		return retJson($ret);
	}
	
	public function refuse(){
		$pdata = $this->request->getJSON(true);	
		if (!empty($pdata['uid'])){
			$this->checkLogin();
			$myid = $this->loginfo['uid'];
			$uid = intval($pdata['uid']);
			if (self::$model->where('fid', $myid)->where('uid',$uid)->set('status',1)->delete()) {
				$ret['code'] = 1;
				$ret['msg']  = '操作成功';
				return retJson($ret);			
			}
		}

		$ret['code'] = 0;
		$ret['msg']  = '操作异常';
		return retJson($ret);
	}
	
	// 添加到我的好友
	public function add(){
		$pdata = $this->request->getJSON(true);	
		if (!empty($pdata['uid'])){
			$this->checkLogin();
			$myid = $this->loginfo['uid'];
			$uid = intval($pdata['uid']);
			$mModel = model('App\Models\MemberModel');
			$myinfo = $mModel->where('uid', $myid)->select('name')->get()->getRowArray();
			$data = self::$model->where("(uid='".$myid ."' and fid='".$uid."' or uid='".$uid ."' and fid='".$myid."')")->orderby('status','desc')->get()->getRowArray();
			if (empty($data)){
				$adata['uid'] = $myid;
				$adata['fid'] = $uid;
				$adata['status'] = 0;
				if (self::$model->insert($adata)){
					// 发送加好友信息
					$content = '用户['.$myinfo['name'].']向您发起好友申请';
					$this->sendMessage($uid,'friendadd','',$content);				
				}
				$ret['step'] = 0;	
				$ret['msg'] = '好友申请中';			
			}else if ($data['status'] == '1'){
				$ret['step'] = 1;				
				$ret['msg'] = '已经是好友了';
			}else if ($data['status']=='0'){
				if ($data['uid'] == $myid){	// 由『我』发起过加好友请求，尚未被对方通过时的处理
					$ret['step'] = 0;	
					$ret['msg'] = '好友申请中';							
				}else if($data['fid'] == $myid){	// 对方已经发起过加『我』为好友的请求时的处理
					if (self::$model->where('fid', $myid)->where('uid',$uid)->set('status',1)->update()) {
						// 确认加好友信息
						$content = '您和用户['.$myinfo['name'].']成为了好友';
						$this->sendMessage($uid,'friendadd','',$content);
						$ret['step'] = 1;
						$ret['msg'] = '恭喜！有新的好友了';					
						
					}
				}
			}
			
			$ret['code'] = 1;
			return retJson($ret);			
		}
		$ret['code'] = 0;
		$ret['msg']  = '添加好友异常';
		return retJson($ret);			
	}
	
	// 删除好友
	public function del(){
		$pdata = $this->request->getJSON(true);	
		if (!empty($pdata['uid'])){
			$this->checkLogin();
			$myid = $this->loginfo['uid'];
			$uid = intval($pdata['uid']);
			if (self::$model->where("(uid='".$myid ."' and fid='".$uid."' or uid='".$uid ."' and fid='".$myid."')")->delete()){
				$ret['code'] = 1;
				$ret['data'] = $uid;
				$ret['msg']  = '删除成功';
				return retJson($ret);			
			}
		}
		
		$ret['code'] = 0;
		$ret['msg']  = '删除好友异常';
		return retJson($ret);			

	}
	
	// 搜索要添加的好友
	public function search(){
		$pdata = $this->request->getJSON(true);	
		if (!empty($pdata['name'])){
			$this->checkLogin();
			$mModel = model('App\Models\MemberModel');
			$ret['data'] = $mModel->where('name', filter_var($pdata['name'], FILTER_SANITIZE_STRING))->select('uid,name,avatar,sign')->get()->getResultArray();
			$ret['code'] = 1;
			return retJson($ret);				
		}
		
		$ret['code'] = 0;
		$ret['msg']  = '参数异常';
		return retJson($ret);			
	}
	
	// 读取好友
	public function getData(){
		$this->checkLogin();
		//$this->loginfo['uid'] = 80;		
		$uid = $this->loginfo['uid'];
		$ret['data'] = self::$model->where("(uid='".$uid ."' OR fid='".$uid."') or (fid='".$uid."' and status=0)")->select('uid,fid,status')->paginate(100);
		if (!empty($ret['data'])){
			$uids = [];
			foreach ($ret['data'] as $k => $v) array_push($uids,$v['uid'],$v['fid']);
			$uids = array_unique($uids);
			if (!empty($uids)){				
				$_k = array_search($uid, $uids);
				if ($_k !== false) unset($uids[$_k]);
				if ($uids){				
					$mModel = model('App\Models\MemberModel');
					$ret['uinfo']= $mModel->getMemberByUids($uids,'uid,name,avatar,sign');
				}
			}
		}
		$ret['code'] = 1;
//		$ret['data'] = empty($ret['data']) ? [] : $ret['data'];
		return retJson($ret);
	}
}
