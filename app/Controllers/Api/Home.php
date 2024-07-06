<?php

namespace App\Controllers\Api;
use App\Controllers\ApiController;

class Home extends ApiController
{

	//protected static $model;
	//protected static $extbase;
	
	protected static $client;
	
	public function __construct(){
	
		self::$client = \Config\Services::curlrequest([
			'base_uri' => site_url(),
		]);		
	}
	
	public function test(){
	/*
			$response = self::$client->request('POST','/api/discuz/getData',['json' => ['limit'=>2]]);
			$body = json_decode($response->getBody(),true);
			$_discuz = $body['data'];
			if (!empty($_discuz)){
				$_member = $body['member'];
				foreach ($_discuz as $k => $v){
					$ret['data']['discuz'][$k] = array_merge($v,$_member[$v['uid']]);
				}
			}
	*/
			$response = self::$client->request('POST','/api/paimai/getData',['json' => ['tag' => '0','limit'=>3]]);
			$body = json_decode($response->getBody(),true);
			$ret['data']['cash'] = $body['data'];

			echo "<PRE>";
			print_r($ret);	
	}
	
	public function index(){
		$response = self::$client->request('POST','/api/paimai/getData',['json' => ['tag' => '0','limit'=>3]]);
		$body = json_decode($response->getBody(),true);
			echo '<PRE>';
			print_r($body);
//			print_r($body['data']);
	}
		
	public function getSections(){
		$pdata = $this->request->getJSON(true);
		
		// 版块广告
		if (!empty($pdata['banner'])){
			$secModel = model('App\Models\SectionModel');
			$ret['data']['banner'] = $secModel->where('status',1)->orderby('sort','ASC')->limit(intval($pdata['banner']))->select('tourl,image as url,desc as content')->get()->getResultArray();

		}
		// 获取拍卖信息
		if (!empty($pdata['cash'])){
			$response = self::$client->request('POST','/api/paimai/getData',['json' => ['tag' => '0','limit'=>3]]);
			$body = json_decode($response->getBody(),true);
			$ret['data']['cash'] = $body['data'];
		}
		
		if (!empty($pdata['coin'])){
			$ret['data']['coin'] = [];
		}
		if (!empty($pdata['resource'])){
			$ret['data']['resource'] = [];
		}
		
		// 签到排行
		if (!empty($pdata['signin'])){
			/*
			$siModel = model('App\Models\SignInModel');
			$_sign = $siModel->select("total,curmonth,uid")->orderby('curmonth','DESC')->get(3)->getResultArray();
			if (!empty($_sign)){
				$membModel = model('App\Models\MemberModel');
				$_member = array_column($membModel->getMemberByUids(array_column($_sign,'uid'),'uid,name,avatar,sign'),NULL,'uid');
				foreach ($_sign as $k => $v){
					$ret['data']['signin'][$k] = empty($_member[$v['uid']]) ? $v : array_merge($v,$_member[$v['uid']]);
				}
			}
			*/
			$response = self::$client->request('POST','/api/signin/getData',['json' => ['tag' => '0','limit'=>3]]);
			$body = json_decode($response->getBody(),true);
			$ret['data']['signin'] = $body['data'];
		}		
		
		// 贡献值排行
		if (!empty($pdata['ranking'])){
			/*
			$pockModel = model('App\Models\PocketModel');
			$_ranking = $pockModel->select("point,uid")->orderby('point','DESC')->get(3)->getResultArray();
			if (!empty($_ranking)){
				$membModel = model('App\Models\MemberModel');
				$_member = array_column($membModel->getMemberByUids(array_column($_ranking,'uid'),'uid,name,avatar,sign'),NULL,'uid');
				foreach ($_ranking as $k => $v){
					$ret['data']['ranking'][$k] = empty($_member[$v['uid']]) ? $v : array_merge($v,$_member[$v['uid']]);
				}
			}
			*/
			$response = self::$client->request('POST','/api/pocket/getRanking',['json' => ['type' => 'point','limit'=>3]]);
			$body = json_decode($response->getBody(),true);
			$ret['data']['ranking'] = $body['data'];
		}
		// 讨论最新两条
		if (!empty($pdata['discuz'])){
			$response = self::$client->request('POST','/api/discuz/getData',['json' => ['module'=>'discuz','limit'=>2]]);
			$body = json_decode($response->getBody(),true);
			$_discuz = $body['data'];
			if (!empty($_discuz)){
				$_member = $body['member'];
				foreach ($_discuz as $k => $v){
					$ret['data']['discuz'][$k] = empty($_member[$v['uid']]) ? $v : array_merge($v,$_member[$v['uid']]);
				}
			}
		}
		$ret['code'] = 1;
		return retJson($ret);
	}

}
