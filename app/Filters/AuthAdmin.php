<?php namespace App\Filters;

use CodeIgniter\HTTP\RequestInterface;
use CodeIgniter\HTTP\ResponseInterface;
use CodeIgniter\Filters\FilterInterface;
//use Config\Services;

class AuthAdmin implements FilterInterface
{

	public function before(RequestInterface $request, $arguments = null)
	{
	
		$session =  \Config\Services::session();
		//$session = service("session");
		$login = self::hasLogin();


 		if (!$login){
			if ($request->isAjax() && ($request->getMethod() == 'get')){
				echo "<script>document.location.href='".site_url('webadmin/sysuser/login')."'</script>";
				exit;
			}else if ($request->isAjax() && ($request->getMethod() == 'post')){
				$ret['code'] = 0;
				$ret['msg'] = '请重新登录';
				exit(retJson($ret));
				//exit(retJson(['code'=>-1]));
			}else{
				return redirect()->to('webadmin/sysuser/login');
			}
		}else{
			if ($login['rid'] != 1){
				$tip = '无权限访问';
				$act = $request->uri->getSegments();				
				$act[1] = empty($act[1]) ? 'home' : $act[1];
				$act[2] = empty($act[2]) ? 'index' : $act[2];
				if (!isset($login['act'][$act[1]]) ||  !isset($login['act'][$act[1]][$act[2]])) {
					if ($request->isAjax() && ($request->getMethod() == 'get')){
						exit(view('webadmin/home/tips', ['msg'=>$tip,'btnhide'=>true]));
					}else if ($request->isAjax() && ($request->getMethod() == 'post')){
						exit(retJson(['code'=>0,'msg'=>$tip]));
					}else if ($act[1] != 'home'){
						exit(retJson(['code'=>0,'msg'=>$tip]));
					}
				}
			}
		}
	}

	public function after(RequestInterface $request, ResponseInterface $response, $arguments = null){	
		$req = $request->uri->getSegments();
		if ($req[0] != 'webadmin') return;
		$allow = ['login','add','edit','del','setmine'];	// 允许记录日志的操作动作
		if (($request->getMethod() == 'post') && (!empty($req[2])) && (in_array($req[2], $allow))) {
			$ret = json_decode($response->getBody(),true);
			if ($ret['code'] != "1") return;
			$login = self::hasLogin();
			if  ($login) {
				$logModel = model('App\Models\SysLogModel');
				$adata['module']	= $req[1];
				$adata['actions']	= $req[2];
				$adata['route']		= $request->uri->getPath();
				$adata['relid']		= empty($req[3]) ? $request->getPost('id',FILTER_SANITIZE_NUMBER_INT) : intval($req[3]);
				$title 				= $request->getPost('name',FILTER_SANITIZE_STRING);
				$adata['title']		= empty($title) ? $request->getPost('title',FILTER_SANITIZE_STRING) : $title;
				//$adata['response'] 	= ($req[1] != 'index') ? $response->getBody() : '';
				$adata['adduid']	= $login['uid'];
				$adata['name']		= $login['name'];
				$logModel->insert($adata);
			}
		}
	}
	
	
	private static function hasLogin(){
		return (!empty($_SESSION['login'])) ? $_SESSION['login'] : false;
	}
}