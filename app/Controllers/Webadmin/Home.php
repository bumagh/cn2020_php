<?php
namespace App\Controllers\Webadmin;
use App\Controllers\AdminController;

class Home extends AdminController
{
	public function index(){
//		$config = config('App');
//		print_r($config->sessionCookieName);
		$mModel = model('App\Models\SysModuleModel');
		$d['login'] = parent::getAuth();		
		if (empty($d['login'])){
			return redirect()->to('webadmin/sysuser/login');
		}
		
		$module = $mModel->where('status',1)->orderBy('pmid','asc')->orderBy('sort','asc')->findAll();		
		$menu = [];	
		if (!empty($module)){
			foreach ($module as $k => $v){
				if (!empty($v['actions'])){
					$_menu = ['name'=>$v['name'],'code'=>$v['code'],'icon'=>$v['icon'],'actions'=> explode(',',$v['actions'])];
				}else{
					$_menu = ['name'=>$v['name'],'code'=>$v['code'],'icon'=>$v['icon']];				
				}
					
				if ($v['pmid'] == 0){
					$menu[$v['mid']] = $_menu;
				}else{
					$menu[$v['pmid']]['submenu'][] = $_menu;
				}
			}
						
			if ($d['login']['rid'] != 1){
				$_menu = [];
				foreach ($menu as $k => $v){
					if (!empty($v['submenu'])){
						foreach ($v['submenu'] as $_k => $_v){
							if (isset($d['login']['act'][$_v['code']]['index'])) {
								$_menu[$k]['submenu'][] = $_v;
							}
						}
					}else{
						if (!empty($v['code'])  && isset($d['login']['act'][$v['code']]['index'])) {
							$_menu[$k] = $v;
						}
					}
				}
				$__menu = [];
				foreach($_menu as $k => $v){
					if (isset($v['submenu'])){
						if (count($v['submenu']) == 1){
							$__menu[$k]['name'] = $v['submenu'][0]['name'];
							$__menu[$k]['code'] = $v['submenu'][0]['code'];
							$__menu[$k]['icon'] = $menu[$k]['icon'];
						}else{
							$__menu[$k]['name'] = $menu[$k]['name'];
							$__menu[$k]['code'] = $menu[$k]['code'];
							$__menu[$k]['icon'] = $menu[$k]['icon'];
							$__menu[$k]['submenu'] = $v['submenu'];
						}
					}else{
						$__menu[$k]['name'] = $menu[$k]['name'];
						$__menu[$k]['code'] = $menu[$k]['code'];
						$__menu[$k]['icon'] = $menu[$k]['icon'];
					}

				}
				$menu = $__menu;
			}
		}
		$d['menu'] = $menu;
		
//		print_r($d);
//		exit;
		
		// 加载语言包
		$d['lang'] = $this->lang;
		
		//$stModel = model('App\Models\SysTipsModel');		
		//$d['tipsnumb'] = $stModel->getNewTips(parent::getAuth()['uid']);
		
		return view($this->_tpl . 'frame', $d);
	}
	
	public function center(){
		$d = [];
		return view($this->_tpl . 'center', $d);
	}
}
