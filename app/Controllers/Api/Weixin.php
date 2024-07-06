<?php
namespace App\Controllers\Api;
use App\Controllers\ApiController;

class Weixin extends ApiController{

	protected static $cfgModel;
	protected static $memModel;
	
	public function __construct(){
		self::$cfgModel = model('App\Models\SysConfigModel');
		self::$memModel = model('App\Models\MemberModel');
		include_once APPPATH."ThirdParty/wechatdeveloper/include.php";		
	}
	
	// 微信网页授权
	public function oauth(){
		$this->checkLogin();
		$config = self::$cfgModel->getConfig('wxpay');
		try {
			$oauth = new \WeChat\Oauth($config);
			$ret['data'] = $oauth->getOauthRedirect(site_url('api/weixin/bindOpenid'),$this->loginfo['uid']);
			$ret['code'] = 1;
			return retJson($ret);
		}catch (Exception $e) {
			$ret['msg'] = $e->getMessage();
		}		
		$ret['code'] = 0;
		return retJson($ret);		
	}
	
	// 回调绑定OPENID至用户
	public function bindOpenid(){
		$get = $this->request->getGet();
		if (!empty($get['code']) && !empty($get['state'])){
			$uid = intval($get['state']);
			$config = self::$cfgModel->getConfig('wxpay');
			try {
				$oauth = new \WeChat\Oauth($config);
				$res = $oauth->getOauthAccessToken($get['code']);
				if (!empty($res['openid'])){
					$this->setExtItem(self::$memModel,$uid,['openid'=>$res['openid']]);
					exit('<script>alert("授权完成");window.history.go();</script>');
				}
				exit('<script>console.log("绑定异常");</script>');
			} catch (Exception $e) {
				// 出错啦，处理下吧
				echo $e->getMessage() . PHP_EOL;
			}
		}
	}
	

	// 微信支付,服务号类型
	public function pay(){
		$this->checkLogin();
		$openid = $this->getExtItem(self::$memModel,$this->loginfo['uid'])['openid'];
		if (empty($openid)) return redirect()->to('api/weixin/oauth');		
		$pdata = $this->request->getJSON(true);
		if (!empty($pdata['cash'])){				
			$config = self::$cfgModel->getConfig('wxpay');
			try {
				$wechat = new \WeChat\Pay($config);
				$options = [
					'body'             => '在线充值',
					'out_trade_no'     => time(),
					'total_fee'        => $pdata['cash'] * 100,
					'openid'           => $openid,	// 此处需要微信授权登录才可以获得，服务号内的openid
					'trade_type'       => 'JSAPI',
					'notify_url'       => site_url('api/weixin/paynotice'),
					'spbill_create_ip' => $this->request->getIPAddress(),
					'attach'			=> $this->loginfo['uid'].'|'.$this->loginfo['lvl'],
				];
				// 生成预支付码
				$result = $wechat->createOrder($options);
				$ret['data'] = $wechat->createParamsForJsApi($result['prepay_id']);
				$ret['code'] = 1;
				return retJson($ret);
			} catch (Exception $e) {
				$ret['msg'] = $e->getMessage();
			}
		}
		
		$ret['code'] = 0;
		return retJson($ret);		
	}
	
	// 微信内支付的异步通知
	public function paynotice(){
		try {
			$config = self::$cfgModel->getConfig('wxpay');
			// 3. 创建接口实例
			$wechat = new \WeChat\Pay($config);
			// 4. 获取通知参数
			$data = $wechat->getNotify();
			if ($data['return_code'] === 'SUCCESS' && $data['result_code'] === 'SUCCESS') {
				$pocket = new \App\Entities\Pocket;
				$pocket->setWxPay($data);
				ob_clean();
				echo $wechat->getNotifySuccessReply();
			}

		} catch (Exception $e) {
			// 出错啦，处理下吧
			echo $e->getMessage() . PHP_EOL;
		}
	}
	
	public function test(){
		$pdata = array (
		  'appid' => 'wxf9cfef5166d06286',
		  'attach' => '95|1',
		  'bank_type' => 'OTHERS',
		  'cash_fee' => '100',
		  'fee_type' => 'CNY',
		  'is_subscribe' => 'Y',
		  'mch_id' => '1351973601',
		  'nonce_str' => 'ci5pxcbpnpymzpxzg6xcwxtxb3ocoljw',
		  'openid' => 'oJXGJwEVaad2NhHUu1tDz_fEPEyI',
		  'out_trade_no' => '1668988814',
		  'result_code' => 'SUCCESS',
		  'return_code' => 'SUCCESS',
		  'sign' => '3078AEE8F37AEAD18D9856A09D9EACDB',
		  'time_end' => '20221121080019',
		  'total_fee' => '10',
		  'trade_type' => 'JSAPI',
		  'transaction_id' => '4200001621202211216674897892',
		);		
		$pocket = new \App\Entities\Pocket;
		var_dump($pocket->setWxPay($pdata));
	}
}
