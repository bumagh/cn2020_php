<?php
namespace App\Controllers\Webadmin;
use App\Controllers\AdminController;

class Pocket extends AdminController{

	protected static $model;
	protected static $extbase;
	
	public function __construct(){
		self::$model = model('App\Models\PocketModel');
		self::$extbase = new \App\Entities\Extbase;		
	}

	private function setFilterData($type){
		$adata['uid']		= $this->request->getPost('uid', FILTER_SANITIZE_NUMBER_INT);		
		$adata['cash']		= $this->request->getPost('cash', FILTER_SANITIZE_NUMBER_INT);	
		$adata['cashfix']	= $this->request->getPost('cashfix', FILTER_SANITIZE_NUMBER_INT);	
		$adata['coin']		= $this->request->getPost('coin', FILTER_SANITIZE_NUMBER_INT);	
		$adata['coinfix']	= $this->request->getPost('coinfix', FILTER_SANITIZE_NUMBER_INT);	
		$adata['point']		= $this->request->getPost('point', FILTER_SANITIZE_NUMBER_INT);	
		$adata['res']		= $this->request->getPost('res', FILTER_SANITIZE_NUMBER_INT);	
		$_status			= $this->request->getPost('status', FILTER_SANITIZE_STRING);
		$adata['status']	= (!empty($_status)) ? 1 : 0;
		$adata['memo']		= $this->request->getPost('memo', FILTER_SANITIZE_STRING);
		return $adata;
	}

	public function index(){	
//		$mModel = model('App\Models\MemberModel');	
		if ($this->request->getPost()){
			// 从会员表中读取
			$ret = parent::getSearchData(self::$model);
			// 需要通过UID获取用户名,
			
			return retJson($ret);
		}
		
		$data['init'] = parent::setIndexInitData(self::$model, self::$extbase,['view']);
		return view($this->_tpl.'index', $data);
	}

	public function view($id,$type='coin'){
			
		$id = intval($id);
		if (empty($id)) return "参数丢失"; 

		if ($type == 'coin'){
			$logModel = model('App\Models\PocketLogCoinModel');
		}else if ($type == 'point'){
			$logModel = model('App\Models\PocketLogPointModel');
		}else{
			return "参数丢失"; 
		}

		$pdata = $this->request->getPost();
		if (!empty($pdata)){
			$sdata['uid'] = $id; 
			$page = max(1, empty($pdata['page']) ? 0 : intval($pdata['page']));
			$limit = empty($pdata['limit']) ? 15 : intval($pdata['limit']);
			$count = empty($pdata['count']) ? 0 : intval($pdata['count']);
			$ret['count'] = empty($count) ? $logModel->count($sdata)['id'] : $count;
			$ret['data'] = $logModel->getData($sdata,$limit, ($page - 1) * $limit);			
			if (!empty($ret['data'])){
				$lang = lang('Sysfields.pocketlog');
				foreach ($ret['data'] as $k => $v){
					$ret['data'][$k]['tag'] = $lang[$v['tag']];
				}
			}

			$ret['page'] = $page;
			$ret['limit'] = $limit;
			$ret['code'] = 1;
			return retJson($ret);
		}

		/*
		if ($this->request->getPost()){
			$ret = parent::getSearchData($coinModel);
			return retJson($ret);
		}				
				
		$data['init'] = parent::setIndexInitData($coinModel,null,[]);		
		$data['init']['tag'] = 'pocket_view_' . $id . "_" . $type;		
		$data['init']['module'] = 'pocket_'.$type.'_view';
		$data['init']['search']['key'] = 'uid';
		$data['init']['search']['val'] = $id;
		$data['init']['search']['type'] = 'text';
		$data['init']['search']['fid'] = '';
		*/
		
		$data['init']['tag'] = 'pocket_view_' . $id;		
		$data['init']['module'] = 'pocket_view';

		$data['init']['type'] = $type;

		return view($this->_tpl.'view', $data);		
	}
	
	/*
	public function add(){		
		if ($this->request->getPost()){
			$adata = $this->setFilterData('add');
			$adata['adduid'] = self::getAuth()['uid'];			
			$id = self::$model->insert($adata);
			if ($id){
				$ret['id'] = $id;
				$ret['code'] = 1;
				return retJson($ret);
			}

			$ret['msg'] = self::$model->errors();
			$ret['code'] = 0;
			return retJson($ret);
		}
		
		$data['init'] = parent::setDetailInitData(self::$model);
		return view($this->_tpl.'detail', $data);
	}
	*/
	
	// 变更用户钱包
	public function edit($id){
		$id = intval($id);
		if (empty($id)) return "参数丢失"; 
		$pdata = $this->request->getPost();
		if (!empty($pdata)){
			if (empty($pdata['type']) || empty($pdata['numb']) || empty($pdata['act'])){
				$ret['code'] = 0;
				$ret['msg']  = '参数不全';
				return retJson($ret);			
			}
			
			$pdata['tag'] = 'manual';
			$pdata['uid'] = $id;
			$pdata['adduid'] = self::getAuth()['uid'];

			$pocket = new \App\Entities\Pocket;
			if ($pocket->setChange($pdata)){
				$ret['code'] = 1;
				return retJson($ret);				
			}
			
			$ret['code'] = 0;
			$ret['msg'] = '钱包变更异常';
			return retJson($ret);							
		}
	
//		$data['init'] = parent::setDetailInitData(self::$model, $id);
		$data['init'] = parent::setDetailInitData(self::$model);
		return view($this->_tpl.'detail', $data);
	}
}
