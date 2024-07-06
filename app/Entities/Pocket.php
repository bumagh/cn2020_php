<?php namespace App\Entities;

use CodeIgniter\Entity;

class Pocket extends Entity{

	// 变更用户钱包
	public static function setChange($data){
	
		if (empty($data['tag']) || empty($data['adduid']) || empty($data['act']) || empty($data['numb'])) return false;
		$data['numb'] = ($data['act'] == 'sub') ? (0-intval($data['numb'])) : intval($data['numb']);
		$data['memo'] = empty($data['memo']) ? '' : filter_var($data['memo'],FILTER_SANITIZE_STRING);
		if ($data['type'] == 'coin'){
			$log = model('App\Models\PocketLogCoinModel');
			$numb['coin'] = $data['numb'];
		}else if ($data['type'] == 'coinfix'){
			$log = model('App\Models\PocketLogCoinModel');		
			$numb['coinfix'] = $data['numb'];
		}else if ($data['type'] == 'point'){
			$log = model('App\Models\PocketLogPointModel');				
			$numb['point'] = $data['numb'];
		}else if ($data['type'] == 'res'){ 		// 2023.3.28 新增资源
			$log = model('App\Models\PocketLogResModel');				
			$numb['res'] = $data['numb'];
		}
		
		$log->setLog($data['tag'],$data['uid'], $data['numb'], $data['memo'],'', $data['adduid']);	
		
		$pocketModel = model('App\Models\PocketModel');
		return $pocketModel->updatePocket($data['uid'], $numb);				
	}

	// 在线充值业务
	public static function setWxPay($data){	
		if (strpos($data['attach'],'|') !== false){
			list($uid, $lvl) = explode('|', $data['attach']);
		}else{
			$uid = intval($data['attach']);
		}
		
		$numbcash = intval($data['cash_fee'])/100;	
		$numbcoin = intval($numbcash * 10);
		$numbpoint = intval($numbcash * 10);
		
		// 写入现金日志
		$cashLog = model('App\Models\PocketLogCashModel');
		$cashLog->setLog('recharge',$uid, $numbcash, $data['out_trade_no'],1,$data['transaction_id']);
		
		// 写入金币日志
		$coinLog = model('App\Models\PocketLogCoinModel');
		$coinLog->setLog('recharge',$uid, $numbcoin);
		
		// 写入积分日志
		$pointLog = model('App\Models\PocketLogPointModel');
		$pointLog->setLog('recharge',$uid, $numbpoint);
		
		// 更新钱包
		$pocketModel = model('App\Models\PocketModel');
		$numb['cash'] = $numbcash;
		$numb['coin'] = $numbcoin;
		$numb['point'] = $numbpoint;
		return $pocketModel->updatePocket($uid, $numb);		
	}
	
	/*
	// 根据会员所有的金币，判断是否升级
	public static function setLevelupByCoin($uid, $curlvl, $curcoin){
		$lModel = model('App\Models\LevelModel');
		$lvlinfo = $lModel->where('status',1)->where('numbmin<', $curcoin)->where('numbmax>', $curcoin)->get()->getRowArray();
		if ((!empty($lvlinfo)) && ($curlvl < $lvlinfo['id'])) {
			// 会员等级提升
			$mModel = model('App\Models\MemberModel');
			$mModel->where('uid', $uid)->set('lvl', $lvlinfo['id'])->update();
		}
	}
	*/
}