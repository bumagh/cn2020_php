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
abstract class AdminController extends Controller
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

	protected $lang = [];
	protected $actions = [];
	
	protected $_tpl = '';	// 模版路径

    /**
     * Constructor.
     */
    public function initController(RequestInterface $request, ResponseInterface $response, LoggerInterface $logger)
    {
        // Do Not Edit This Line
        parent::initController($request, $response, $logger);

        // Preload any models, libraries, etc, here.
        // E.g.: $this->session = \Config\Services::session();
		$this->session = \Config\Services::session();
		$this->lang = lang('Sysfields.fields');
		$this->actions = lang('Sysfields.actions');
		$_path = $request->uri->getSegments();
		$_path[1] = empty($_path[1]) ? 'home' : $_path[1];
		$this->_tpl = strtolower($_path[0].'/' . $_path[1] . '/');
    }
    
	public function getAuth(){
		return (!empty($_SESSION['login'])) ? $_SESSION['login'] : false;
	}
	
	public function setAuth($fields, $value){
		$_SESSION['login'][$fields] = $value;
	}
	
	// 处理局限操作权限的条件
	public function act2Cond($login){
		if ($login['rid'] == '1') return [];
		$module = $this->request->uri->getSegments()[1];			
		return (isset($login['act'][$module]) && isset($login['act'][$module]['priv'])) ? ['adduid'=>$login['uid']] : [];
	}
	
	public function getTag($route){
		$_t = explode("/", $route);
		array_shift($_t);
		return implode("_", $_t);
	}
	public function getRoute($tag){
		return '/'.str_replace('_', '/', $tag);
	}
	
	public function setDetailPostExt($model, $extbase, $id){
		if ($this->request->getPost('ext')){
			$extdata = [];
			foreach ($this->request->getPost('ext',FILTER_SANITIZE_STRING) as $k => $v){
				if (!empty($v)) $extdata[$k] = $v;
			}
						
			if ($extdata){
				$relid = $extbase::setExtValue($model->__get('table'), $id, $extdata, $this->getAuth()['uid']);
				return $relid;
			}
		}
		return [];	
	}
	
	// 初始化详细页数据
	public function setDetailInitData($m, $id=''){
		$init = [];
		$init['login'] 	= $this->getAuth();
		$init['module'] = $this->request->uri->getSegments()[1];
		$init['action'] = $this->request->uri->getSegments()[2];
		$init['tag'] = $this->getTag($this->request->getPath());
		$init['table']	= $m->__get('table');
		$init['searchFields'] = isset($m->searchFields) ? $m->searchFields : [];
		if (!empty($id)){
			$init['row'] = ($init['action'] == 'setmine') ? $m->find($id) : $m->where($this->act2Cond($init['login']))->find($id);
		}
		return $init;
	}
	// 统一渲染数据表格左上角可操作铵钮
	public function getRenderTopAct($login, $module){
		$act['delm']	= '<button class="layui-btn layui-btn-danger layui-btn-sm" lay-event="delbatch" title="批量删除" route="/'.$module.'/delm"> <i class="layui-icon layui-icon-delete" style="font-size: 22px;"></i> </button>';
		$act['add']		= '<button class="layui-btn layui-btn-primary layui-btn-sm" ey-event="openRightView" title="添加" route="/'.$module.'/add"> <i class="layui-icon layui-icon-add-1"></i> 添加</button>';
		$ret = '';
		if ($login['rid'] == '1'){
			$ret .= method_exists($this,'delm') ? $act['delm'] : '';
			$ret .= method_exists($this,'add') ? $act['add'] : '';
		}else{
			$ret .= isset($login['act'][$module]['delm']) ? $act['delm'] : '';
			$ret .= isset($login['act'][$module]['add']) ? $act['add'] : '';
		}
		
		
		return empty($ret) ? '' : ('<div class="layui-btn-group">'.$ret.'</div>');	
	}
	
	
	// 渲染"搜索"操作的DOM
	public static function getRenderSearch($login, $module, $fullfields=[]){
		if (empty($fullfields)) return '';
//		if (($login['rid'] == '1') || (isset($login['act'][$module]['index']) && isset($login['act'][$module]['pub']))) {
		if (($login['rid'] == '1') || (isset($login['act'][$module]['index']))) {
			$_opt = '';
			
			foreach ($fullfields as $k => $v){
				 $_opt .= '<option value="'.$k.'" lay-fid="'.(empty($v['fid']) ? '' : intval($v['fid'])).'" lay-type="'.$v['type'].'" lay-setting=\''.(empty($v['setting']) ? '' : $v['setting']).'\'>'.$v['title'].'</option>';
			}
			
			$act = '<form class="layui-form" action="" id="searchform-'.$module.'" lay-filter="searchform-'.$module.'"> 搜索:
					<div class="layui-input-inline" style="width:140px;"><select name="searchkey" lay-filter="select-'.$module.'"  id="searchkey-'.$module.'"><option value="" lay-type="text" lay-fid="">请选择搜索条件</option>'.$_opt.'</select></div>
					<div class="layui-inline" style="width:300px;"><input class="layui-input" name="searchval" id="searchval-'.$module.'" placeholder=" - " autocomplete="off"></div>
					<div class="layui-btn-group">
					<button class="layui-btn layui-btn-sm layui-btn-primary" lay-submit lay-filter="search-'.$module.'"><i class="layui-icon layui-icon-search"></i> 搜索</button>
					</div>
					</form>';		
		
			return $act;
		}

		return '';
	}	

	// 数据表格中的单行操作铵钮
	public function getRenderTableAct($login, $module, $actions){
		$str 	= '';
		$act['edit']	= '<button class="layui-btn layui-btn-xs" lay-event="setEdit"><i class="layui-icon layui-icon-edit"></i></button>';
		$act['del']		= '<button class="layui-btn layui-btn-xs layui-btn-danger" lay-event="setDel"><i class="layui-icon layui-icon-close"></i></button>';		
		$act['view']	= '<button class="layui-btn layui-btn-xs layui-btn-normal" lay-event="setView"><i class="layui-icon layui-icon-chart-screen"></i></button>';
		//$act['auth']	= '<button class="layui-btn layui-btn-xs layui-btn-normal" lay-event="setAuth"><i class="layui-icon layui-icon-auz"></i></button>';				
		$act['setres']	= '<button class="layui-btn layui-btn-xs layui-btn-normal" lay-event="setRes"><i class="layui-icon layui-icon-set"></i></button>';
		$act['setuser']	= '<button class="layui-btn layui-btn-xs layui-btn-normal" lay-event="setGroupUser"><i class="layui-icon layui-icon-user"></i></button>';
		$act['setrole']	= '<button class="layui-btn layui-btn-xs layui-btn-normal" lay-event="setGroupRole"><i class="layui-icon layui-icon-component"></i></button>';		
		$act['setgroup']= '<button class="layui-btn layui-btn-xs layui-btn-normal" lay-event="setGroup"><i class="layui-icon layui-icon-set"></i></button>';
		$act['settask']	= '<button class="layui-btn layui-btn-xs layui-btn-normal" lay-event="setTask"><i class="layui-icon layui-icon-set"></i></button>';
		$act['viewres']	= '<button class="layui-btn layui-btn-xs layui-btn-normal" lay-event="viewRes"><i class="layui-icon layui-icon-flag"></i></button>';
		if ($login['rid'] == '1'){
			foreach ($actions as $k => $v){
				$str .= (!empty($act[$v])) ? $act[$v] : '';
			}
		}else{
			if (!empty($login['act'][$module])){
				foreach ($actions as $k => $v){
					$str .= (!empty($act[$v]) && isset($login['act'][$module][$v])) ? $act[$v] : '';
				}				
			}
		}
		return $str;
	}	
	
	// 初始化索引页数据
	public function setIndexInitData($model, $extbase = null, $tableact=['view','edit','del']){	
		$init = [];
		$init['login'] = $this->getAuth();
		$init['tag'] = $this->getTag($this->request->getPath());
		
		// 模块名
		$init['module'] = $this->request->uri->getSegments()[1];
		
		// 获取扩展字段数据
		if (!empty($extbase)){
			$init['extfields'] = $extbase->getExtFields($model->__get('table'));
			$_searchext = [];
			foreach($init['extfields'] as $k => $v){
				if (!empty($v['search'])) $_searchext[$k] = $v;
			}
		} 
		// 获取基本表搜索字段
		// $_fields = $model->__get('searchFields');
		$_fields = isset($model->searchFields) ? $model->searchFields : [];
		$fields = [];
		if (!empty($_fields)){
			foreach ($_fields as $k => $v){
				$fields[$k]['title'] = isset($v['title']) ? $v['title'] : $this->lang[$k];
				$fields[$k]['type'] = empty($v['type']) ? 'text' : $v['type'];
				$fields[$k]['setting'] = empty($v['setting']) ? '' : json_encode((object)$v['setting']);
			}
		}
		$init['fullfields'] = (!empty($extbase)) ? array_merge($fields, $_searchext) : $fields;
		$init['search'] = ['key'=>'','val'=>'','type'=>''];	
		$init['actions']['topact'] = $this->getRenderTopAct($init['login'], $init['module']);		
		$init['actions']['search'] = self::getRenderSearch($init['login'],$init['module'], $init['fullfields']);
		
		
		$_tableact = [];
		if ($init['login']['rid'] == 1){
			$acts = get_class_methods($this);
			foreach ($this->actions as $k => $v){
				if (in_array($k, $acts)){
					$_tableact[] = $k;
				}
			}
			$init['actions']['checkall'] = in_array('delm',$_tableact) ? 1 : 0;
		}else{
			foreach($tableact as $k => $v){
				if (method_exists($this, $v)) $_tableact[] = $v;
			}
			$init['actions']['checkall'] = empty($init['login']['act'][$init['module']]['delm']) ? 0 : 1;
		}
		$init['actions']['tableact'] = $this->getRenderTableAct($init['login'],$init['module'], $_tableact);		
		return $init;
	}	
	
	public function getViewData($model, $extbase=null){
		$id = $this->request->getPost('id', FILTER_SANITIZE_NUMBER_INT);
		if (empty($id)){
			$ret['code'] = 0;
			$ret['msg'] = '参数丢失';
			return $ret;		
		}
		$ret['data'] = $model->where($model->__get('primaryKey'),$id)->first();
		if (!empty($extbase)) $ret['ext'] = $extbase->getExtValue($model->__get('table'), $id)[$id];
		$ret['code'] = 1;
		return $ret;
	}
	
	// 返回请求的数据，可以包括扩展表数据 
//	public function getSearchData($model, $searchfields, $extbase=null){
	public function getSearchData($m, $extbase=null){
		$login = $this->getAuth();
		// 设置搜索初始值
		$sdata = [];
		$sdata = self::act2Cond($login);
	
		$id = $m->__get('primaryKey');
	
		// 处理排序条件 
		$orderkey = $this->request->getPost('order[key]', FILTER_SANITIZE_STRING);
		$ordertype = $this->request->getPost('order[type]', FILTER_SANITIZE_STRING);
		
		// 排序处理
		if (isset($m->searchFields[$orderkey])){	// 从基本表排序
			$orderkey = empty($orderkey) ? $id : $orderkey;
			$ordertype = empty($ordertype) ? 'desc' : $ordertype;
		}else{									// 扩展表排序
			$orderkey = empty($orderkey) ? 'created_at' : $orderkey;
			$ordertype = empty($ordertype) ? 'desc' : $ordertype;
		}
		// end;
		
		// 处理搜索条件 
		$searchkey = $this->request->getPost('search[key]', FILTER_SANITIZE_STRING);
		$searchval = $this->request->getPost('search[val]', FILTER_SANITIZE_STRING);
		$searchfid = $this->request->getPost('search[fid]', FILTER_SANITIZE_NUMBER_INT);
		$searchtype = $this->request->getPost('search[type]', FILTER_SANITIZE_STRING);
		$likekey = $likeval = '';	// 模糊查询字段，应用于input类型的搜索
		
		$searchkey = empty($searchfid) ? $searchkey : 'val';
		
		
		if (empty($searchkey)){
		}else if (($searchkey == 'created_at') || ($searchkey == 'updated_at') || ($searchtype == 'time')) {
		/*
			if(!$this->validate(['search[val]' => "required|valid_date", 'search[key]' => 'required'])){
				$ret['code'] = 0;
//					$ret['data'] =  \Config\Services::validation()->getErrors();
				$ret['data'] =  '请重新确认搜索条件';
				return retJson($ret);
			}
		*/
			if  (strpos($searchval,' - ') !== false){
				$_t = explode(' - ', $searchval);
				$sdata = [$searchkey.'>=' => trim($_t[0]),$searchkey.'<=' => trim($_t[1])];
				//$sdata[$searchkey.'>='] = trim($_t[0]);
				//$sdata[$searchkey.'<='] = trim($_t[1]);
			}else{
				$ret['code'] = 0;
				$ret['msg'] = '搜索条件设置错误';
				return $ret;
			}
		}else if (($searchtype == 'date') || ($searchtype == 'datetime')) {
			if  (strpos($searchval,' - ') !== false){
				$_t = explode(' - ', $searchval);
				$sdata = [$searchkey.'>=' => strtotime(trim($_t[0])),$searchkey.'<=' => strtotime(trim($_t[1]))];
				//$sdata[$searchkey.'>='] = strtotime(trim($_t[0]));
				//$sdata[$searchkey.'<='] = strtotime(trim($_t[1]));
			}else{
				$ret['code'] = 0;
				$ret['msg'] = '搜索条件设置错误';
				return $ret;
			}
		}else if (($searchtype == 'select') || ($searchtype == 'radio')) {
			$sdata[$searchkey] = $searchval;
		}else if ($searchtype == 'checkbox'){
			$sdata['FIND_IN_SET("'.$searchval.'",val) > 0'] = null;
		}else if (($searchtype == 'text') || ($searchtype == 'color')){
			$likekey = $searchkey;
			$likeval = $searchval;
		}
		
		// 处理搜索条件 
		$page = max(1, $this->request->getPost('page', FILTER_SANITIZE_NUMBER_INT));
		$limit = empty($this->request->getPost('limit')) ? 15 : $this->request->getPost('limit', FILTER_SANITIZE_NUMBER_INT);

		if (isset($m->searchFields[$searchkey]) || empty($searchkey)) {
			
			$count = ($this->request->getPost('count', FILTER_SANITIZE_NUMBER_INT));
			$ret['count'] = empty($count) ? $m->count($sdata, $likekey, $likeval)[$id] : $count;
			$ret['data'] = $m->getData($sdata, $limit, ($page - 1) * $limit, $likekey, $likeval, $orderkey, $ordertype);
			//echo self::$m->__get('db')->getLastQuery();
			if (!empty($ret['data']) && !empty($extbase)){
				$relid = array_column($ret['data'], $id);
				$ret['ext'] = $extbase::getExtValue($m->__get('table'), array_values($relid));
			}else{
				$ret['ext'] = [];
			}
			$ret['code'] = 1;
			return $ret;
		}else{		// 从扩展表查询 
			if (empty($searchfid)){
				$ret['code'] = 0;
				$ret['msg'] = '搜索条件设置错误';
				return $ret;
			}
			
			$sdata['fid'] = $searchfid;
			$ret['count'] = empty($count) ? $extbase::searchCount($m->__get('table'),$sdata,$likeval)['relid'] : $count;
			if (!empty($ret['count'])){
				$_res = $extbase::searchValue($m->__get('table'),$sdata, $limit, ($page - 1) * $limit, $likeval, $orderkey,$ordertype);
				$relid = array_column($_res, 'relid');
				$s2data = self::act2Cond($login);
				$s2data[$id. ' in ('.implode(',',$relid). ')'] = null;
				$ret['data'] = $m->getData($s2data, $limit, ($page - 1) * $limit);
				//echo $m->__get('db')->getLastQuery();
				if (!empty($ret['data'])){
					$relid = array_column($ret['data'], $id);
					$ret['ext'] = $extbase::getExtValue($m->__get('table'), array_values($relid));
				}
			}else{
				$ret['data'] = [];
				$ret['ext'] = [];
			}
			
			
			$ret['code'] = 1;
			return $ret;
		}	
	}	    
}
