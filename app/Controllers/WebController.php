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
abstract class WebController extends Controller
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
	
	protected $_tpl = '';	// 模版路径

    /**
     * Constructor.
     */
    public function initController(RequestInterface $request, ResponseInterface $response, LoggerInterface $logger)
    {
        // Do Not Edit This Line
        parent::initController($request, $response, $logger);

/*
        // Preload any models, libraries, etc, here.
        // E.g.: $this->session = \Config\Services::session();
		$this->session = \Config\Services::session();
//		$this->lang = lang('Sysfields.fields');		
*/
		$_path = $request->uri->getSegments();				
		$this->_tpl = empty($_path[0]) ? 'h5/' : strtolower($_path[0].'/');
		
    }
    
	public function getAuth(){
	
		//return ['uid'=>1,'rid'=>1,'avatar'=>'/images/1.png','name'=>'达达达','rolename'=>'操管'];
	
//		return (!empty($_SESSION['member'])) ? $_SESSION['member'] : redirect()->to('user/member');
		return (!empty($_SESSION['member'])) ? $_SESSION['member'] : [];
	}
	
	public function setAuth($fields, $value){
		$_SESSION['member'][$fields] = $value;
	}
	
	// 处理局限操作权限的条件
	public function act2Cond($member){
		//if ($member['rid'] == '1') return [];
		$module = $this->request->uri->getSegments()[1];			
		return (isset($member['act'][$module]) && isset($member['act'][$module]['priv'])) ? ['adduid'=>$member['uid']] : [];
	}
	
	public function getTag($route){
		//return str_replace('/', '_', $route);
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
		$init['member'] 	= $this->getAuth();
		$init['module'] = $this->request->uri->getSegments()[1];
		$init['action'] = $this->request->uri->getSegments()[2];
		$init['tag'] = $this->getTag($this->request->getPath());
		$init['table']	= $m->__get('table');
		$init['searchFields'] = isset($m->searchFields) ? $m->searchFields : [];
		if (!empty($id)){
			$init['row'] = ($init['action'] == 'mine') ? $m->find($id) : $m->where($this->act2Cond($init['member']))->find($id);
		}
		return $init;
	}
	
	// 初始化索引页数据
	public function setIndexInitData($model, $extbase = null){
		$init = [];
		$init['member'] = $this->getAuth();
		$init['tag'] = $this->getTag($this->request->getPath());
		
		// 模块名
		$init['module'] = $this->request->uri->getSegments()[1];
		
		// 获取扩展字段数据
		if (!empty($extbase)){
			$init['extfields'] = $extbase->getExtFields($model->__get('table'));
			$_searchext = [];
			foreach($init['extfields'] as $k => $v){
				if (!empty($v['search'])) $_searchext[] = $v;
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
				$fields[$k]['setting'] = empty($v['setting']) ? '' : json_encode($v['setting']);
			}
		}
		$init['fullfields'] = (!empty($extbase)) ? array_merge($fields, $_searchext) : $fields;
		$init['search'] = ['key'=>'','val'=>'','type'=>''];	
		return $init;
	}	
	
	// 返回请求的数据，可以包括扩展表数据 
	public function getSearchData($m, $extbase=null){
		$member = $this->getAuth();
		// 设置搜索初始值
		$sdata = [];
		$sdata = self::act2Cond($member);
	
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
				$s2data = self::act2Cond($member);
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
