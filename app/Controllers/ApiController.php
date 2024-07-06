<?php

namespace App\Controllers;

use CodeIgniter\Controller;
use CodeIgniter\HTTP\CLIRequest;
use CodeIgniter\HTTP\IncomingRequest;
use CodeIgniter\HTTP\RequestInterface;
use CodeIgniter\HTTP\ResponseInterface;
use Psr\Log\LoggerInterface;

/**
 * Class BaseController
 *
 * BaseController provides a convenient place for loading components
 * and performing functions that are needed by all your controllers.
 * Extend this class in any new controllers:
 *     class Home extends BaseController
 *
 * For security be sure to declare any new methods as protected or private.
 */
abstract class ApiController extends Controller
{
    /**
     * Instance of the main Request object.
     *
     * @var CLIRequest|IncomingRequest
     */
    protected $request;

    /**
     * An array of helpers to be loaded automatically upon
     * class instantiation. These helpers will be available
     * to all other controllers that extend BaseController.
     *
     * @var array
     */
    protected $helpers = [];


	protected $loginfo = [];


	private function authFail(){
//		file_put_contents(APPPATH . '/logs/checkLogin.txt', var_export($_SER,true));
		$ret['code'] = -1;
		$ret['msg'] = '帐号校验失败,请重新登录。';
		exit(json_encode($ret));
	}

    /**
     * Constructor.
     */
    public function initController(RequestInterface $request, ResponseInterface $response, LoggerInterface $logger)
    {
        // Do Not Edit This Line
        parent::initController($request, $response, $logger);

        // Preload any models, libraries, etc, here.
        // E.g.: $this->session = \Config\Services::session();             
    }
    
	// 生成用户请求时的验证码，防止授权信息被篡改
	public function setLoginVerify($uid,$lvl,$username){
		return md5('ey56'.$uid.$lvl.$username);
	}
	
	// 校验请求用户是否已授权
	public function checkLogin(){
		$_SER = $this->request->getServer();
		
		if (!empty($_SER['HTTP_ACCESS_TOKEN']) && (strpos($_SER['HTTP_ACCESS_TOKEN'],'|') != false)){
			list($this->loginfo['uid'],$this->loginfo['username'],$_v,$this->loginfo['lvl']) = explode('|', $_SER['HTTP_ACCESS_TOKEN']);
			if ($_v !== self::setLoginVerify($this->loginfo['uid'],$this->loginfo['lvl'],$this->loginfo['username'])) {
				self::authFail();
			}
			return true;
		}else{
			self::authFail();
		}
	}
	
	public function getExtFields($tname){
		$ext = new \App\Entities\Extbase;
		return $ext->getExtFields($tname);
	}
	
	// 获取扩展数据集
	public function getExtData($m, $relids){
		$ext = new \App\Entities\Extbase;
		return $ext->getExtValue($m->__get('table'), $relids);
	}
	
	// 获取扩展表字段及值
	public function getExtItem($m, $id){
		$ext = new \App\Entities\Extbase;
		$_ext = $ext->getExtValue($m->__get('table'), $id)[$id];
		$res = [];
		if (!empty($_ext)){
			foreach ($_ext as $k => $v){
				$res[$k] = empty($v['value']) ? '' : $v['value'];
			}
		}
		return $res;
	}
	
	// 写入扩展表字段值
	public function setExtItem($m, $id, $data){
		if (empty($m) || empty($id) || empty($data)) return false;
		$ext = new \App\Entities\Extbase;	
		$fields = $ext->getExtFields($m->__get('table'));
		if (empty($fields)) return false;
		
		$vModel = model('App\Models\SysDictvalModel');
		$vModel->setTname($m->__get('table'));
		$ret = 0;
		foreach ($data as $k => $v){
			if (!empty($fields[$k])){
				$_m = $vModel->where('fid', $fields[$k]['fid'])->where('relid', $id)->get()->getRowArray();
				if (!empty($_m)){
					$vModel->where('fid', $fields[$k]['fid'])->where('relid', $id)->set('val', $v)->update();
				}else{
					$vModel->set('fid', $fields[$k]['fid'])->set('relid', $id)->set('val',$v)->insert();
				}
				//var_dump($vModel->where('fid', $fields[$k]['fid'])->where('relid', $id)->set('val', $v)->update());
				//echo $vModel->__get('db')->getLastQuery();
				$ret++;
			}
		}
		return $ret;
	}
	

	// 系统给当前用户发系统消息
	public function sendMessage($uid, $tag,$title='',$content=''){
		if (empty($tag) || empty($uid)) return false;
		$model = model('App\Models\MessageModel');		
		$model->sendSysMessage($uid, $tag,$title,$content);
	}
}
