<?php
namespace App\Controllers\Bash;
use App\Controllers\BashController;

class Paimai extends BashController{

	protected static $pModel;
	protected static $jModel;
	protected static $pockModel;
	protected static $coinModel;
	protected static $msgModel;
		
	public function __construct(){
		self::$pModel 		= model('App\Models\PaimaiModel');
		self::$jModel 		= model('App\Models\PaimaiJoinModel');
		self::$pockModel 	= model('App\Models\PocketModel');
		self::$coinModel 	= model('App\Models\PocketLogCoinModel');
		self::$msgModel 	= model('App\Models\MessageModel');
	}

	public function test($p='default'){

		var_dump(self::$pockModel->cancelCoinFix(60, 100));

		return self::$msgModel->sendSysMessage(60,'cashjoin', '哈哈哈');		
		//$t = self::$msgModel->getData(['touid'=>60],15,1);
//		print_r($t);
		
	}
	
	// 定时截止拍卖，并处理拍卖完结任务
	public function procOver($tag=0){
		$pdata = self::$pModel->where('tag',$tag)->where('status',0)->orderBy('id','asc')->get()->getResultArray();
		if (empty($pdata)) return;
		foreach ($pdata as $k => $v){
			// 先置该标的为完成；
			echo "process 『" . $v['id'] . "』...\r\n";
			$jdata = $curitem = [];
			if (self::$pModel->where('id',$v['id'])->set('status',1)->update()){
				// 开始处理参与者的金币解冻，及扣除获胜者的冻结金币
				$jdata = self::$jModel->where('pid', $v['id'])->orderBy('numb','desc')->get()->getResultArray();
				if (empty($jdata)) continue;
				// 开始扣除获胜者的冻结金币，并发送内容消息至该帐号
				$curitem = array_shift($jdata);
				// 扣除冻结金币
				self::$coinModel->setLog('cashjoin',$curitem['uid'],0-$curitem['numb']);
				self::$pockModel->updateCoinFix($curitem['uid'], 0-$curitem['numb']);
				// 标识获胜状态
				self::$jModel->where('id',$curitem['id'])->set('status',1)->update();
				// 发送消息
				self::$msgModel->sendSysMessage($curitem['uid'],'cashjoin:ok',$v['name'], $v['content']);
				
				if (empty($jdata)) continue;				
				// 如果存在其他参与者
				foreach ($jdata as $k2 => $v2){
					// 解冻金币
					self::$pockModel->cancelCoinFix($v2['uid'], $v2['numb']);
					// 发送消息
					self::$msgModel->sendSysMessage($v2['uid'],'cashjoin:fail', $v['name']);
				}
			}
		}
	}
}
