<?php
namespace App\Controllers\Api;
use App\Controllers\ApiController;

class Tools extends ApiController{
	
	public function __construct(){
	}
	
	private function juhecurl($url,$params=false,$ispost=0){
		$httpInfo = array();
		$ch = curl_init();
	 
		curl_setopt( $ch, CURLOPT_HTTP_VERSION , CURL_HTTP_VERSION_1_1 );
		curl_setopt( $ch, CURLOPT_USERAGENT , 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.22 (KHTML, like Gecko) Chrome/25.0.1364.172 Safari/537.22' );
		curl_setopt( $ch, CURLOPT_CONNECTTIMEOUT , 30 );
		curl_setopt( $ch, CURLOPT_TIMEOUT , 30);
		curl_setopt( $ch, CURLOPT_RETURNTRANSFER , true );
		if( $ispost )
		{
			curl_setopt( $ch , CURLOPT_POST , true );
			curl_setopt( $ch , CURLOPT_POSTFIELDS , $params );
			curl_setopt( $ch , CURLOPT_URL , $url );
		}
		else
		{
			if($params){
				curl_setopt( $ch , CURLOPT_URL , $url.'?'.$params );
			}else{
				curl_setopt( $ch , CURLOPT_URL , $url);
			}
		}
		$response = curl_exec( $ch );
		if ($response === FALSE) {
			//echo "cURL Error: " . curl_error($ch);
			return false;
		}
		$httpCode = curl_getinfo( $ch , CURLINFO_HTTP_CODE );
		$httpInfo = array_merge( $httpInfo , curl_getinfo( $ch ) );
		curl_close( $ch );
		return $response;
	}
	
	
	private function sendsms($phone,$param){
		$ret['code'] = 0;
		$ret['msg'] = '';
		$sendUrl = 'http://sms.yuyaoit.cn/index.php/api'; //短信接口的URL
		$smsConf = array(
			'appkey'   => $param['key'], //您申请的APPKEY
			'phone'    => $phone, //接受短信的用户手机号码
			'tplType'    => $param['tplType'],
			'code' =>$param['code']
		);
		//生成签名
		$sign = '';
		ksort($smsConf);
		foreach ($smsConf as $key => $val) if ($key != '' && $val != '') $sign .= $key.$val;
		$sign.=$param['secret'];// 您申请的SECRET
		$smsConf['sign'] = strtoupper(md5($sign));		
		$content = $this->juhecurl($sendUrl,$smsConf,1); //请求发送短信
		if($content){
			$result = json_decode($content,true);
			$error_code = $result['code'];
			if($error_code == 1){	//状态为1，说明短信发送成功
				// 记录到数据库
				//$this->db->insert($this->tbl,array('org'=>'ey','phone'=>$phone,'mvcode'=>$param['code']));
				$ret['code'] = 1;
			}else{
				//状态为0，说明失败
				$ret['code'] = 0;
			}
		}else{
			//返回内容异常，以下可根据业务逻辑自行修改
			$ret['code'] = 0;
		}
		return $ret;
	}	
	
	
	public function getPhoneCode(){
		$pdata = $this->request->getJSON(true);
		if (!empty($pdata['phone'])){
		
			/*
			$session = \Config\Services::session();
			$session->setFlashdata('mvcode', $_code);
			*/			
			$_code = rand(1000, 9999);
			// 发送短信 begin:
			$phone = intval($pdata['phone']);
			$param['key'] = 'eysms19';
			$param['secret'] = '13ba960ed770dca56c63';
			$param['tplType'] = 'reg';
			$param['code'] = $_code;
			$_res = $this->sendsms($phone, $param);
			// end;
			
			if (!empty($_res['code'])){			
				$_SER = $this->request->getServer();
				$model = model('App\Models\SmslogModel');
				$adata['deviceid'] = $_SER['HTTP_ACCESS_TAG'];
				$adata['tag'] = 'ey';
				$adata['phone'] = $phone;
				$adata['mvcode'] = $_code;
				$model->insert($adata);
				$ret['code'] = 1;
				return retJson($ret);		
			}
				
		}
		
		$ret['code'] = 0;
		$ret['msg'] = '获取验证码异常';
		return retJson($ret);
	}
}
