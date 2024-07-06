<?php
namespace App\Controllers\Webadmin;
use App\Controllers\AdminController;

class Vote extends AdminController{

	protected static $model;
	protected static $extbase;
	
	public function __construct(){
		self::$model = model('App\Models\VoteModel');
		self::$extbase = new \App\Entities\Extbase;
	}

	public function index(){
		
		if ($this->request->getPost()){
			// 基本表查询字段
			$ret = parent::getSearchData(self::$model, self::$extbase);
			return retJson($ret);
		}		
	
		$data['init'] = parent::setIndexInitData(self::$model, self::$extbase);		
		return  view($this->_tpl . 'index', $data);
	}
		

	private function setFilterData($type){
		$adata['tag']	= $this->request->getPost('tag', FILTER_SANITIZE_NUMBER_INT);		
		$adata['title']		= $this->request->getPost('title', FILTER_SANITIZE_STRING);
		$adata['intro']		= $this->request->getPost('intro', FILTER_SANITIZE_STRING);
		$adata['votemax']	= $this->request->getPost('votemax', FILTER_SANITIZE_NUMBER_INT);	
		$adata['btime']		= empty($this->request->getPost('btime')) ? NULL :  $this->request->getPost('btime',FILTER_SANITIZE_STRING);	
		$adata['etime']		= empty($this->request->getPost('etime')) ? NULL :  $this->request->getPost('etime',FILTER_SANITIZE_STRING);	
		$adata['status']	= $this->request->getPost('status', FILTER_SANITIZE_NUMBER_INT);
		return $adata;
	}
	
	public function add(){	
		if ($this->request->getPost()){
			$adata = $this->setFilterData('add');
			$adata['adduid'] = self::getAuth()['uid'];
			
			//	扩展验证规则,如果有扩展表的话 begin:
			$_res = !empty(self::$extbase) ? self::$extbase->setRulesExt(self::$model, $this->request->getPost('ext')) : [];			
			if (!empty($_res['rules'])){
				self::$model->setValidationRules($_res['rules']);
				$adata = array_merge($adata, empty($_res['post']) ? [] : $_res['post']);
			}
			// end;
		
			$id = self::$model->insert($adata);
			if ($id){
				parent::setDetailPostExt(self::$model, self::$extbase, $id);
				$adata['id'] = $id;
				$ret['data'] = $adata;
				$ret['code'] = 1;
				return retJson($ret);
			}

			$ret['msg'] = self::$model->errors();
			$ret['code'] = 0;
			return retJson($ret);
		}
		
		$data['init'] = parent::setDetailInitData(self::$model);
		return view($this->_tpl . 'detail', $data);
	}
	
	public function edit($id){
		$id = intval($id);
		if ($this->request->getPost()){
			$adata = $this->setFilterData('edit');
			$adata['edituid'] = self::getAuth()['uid'];
		
			//	修改验证规则 
			$validrules = self::$model->getValidationRules();
			self::$model->setValidationRules($validrules);
			
			$_res = !empty(self::$extbase) ? self::$extbase->setRulesExt(self::$model, $this->request->getPost('ext')) : [];			
			if (!empty($_res['rules'])){
				self::$model->setValidationRules($_res['rules']);
				$adata = array_merge($adata, empty($_res['post']) ? [] : $_res['post']);
			}
									
									
			$st = self::$model->update($id,$adata);
			if ($st){
				parent::setDetailPostExt(self::$model, self::$extbase, $id);
				$ret['code'] = 1;
				return retJson($ret);
			}
			$ret['msg'] = self::$model->errors();
			$ret['code'] = 0;
			return retJson($ret);
		}

		$data['init'] = parent::setDetailInitData(self::$model, $id);
		return view($this->_tpl . 'detail', $data);
	}
	
	public function del(){
		if ($this->request->getPost()){
			$id  = $this->request->getPost('id', FILTER_SANITIZE_NUMBER_INT);
			if (self::$model->delete($id)){
				self::$extbase::delExtValue(self::$model->__get('table'), $id);
				
				$ret['code'] = 1;
				$ret['data'] = $id;
				return retJson($ret);
			}
		}
		
		$ret['code'] = 0;
		return retJson($ret);
	}
	
	public function view($id){
		$id = intval($id);
		if (empty($id)) return "参数丢失"; 
		$jModel = model('App\Models\VoteJoinModel');
//		$dModel = model('App\Models\DiscuzModel');
		$pdata = $this->request->getPost();
		if (!empty($pdata)){
			$sdata['vid'] = $id; 
			$page = max(1, empty($pdata['page']) ? 0 : intval($pdata['page']));
			$limit = empty($pdata['limit']) ? 15 : intval($pdata['limit']);
			$count = empty($pdata['count']) ? 0 : intval($pdata['count']);
			$ret['count'] = empty($count) ? $jModel->count($sdata)['id'] : $count;
			$ret['data'] = $jModel->getData($sdata,$limit, ($page - 1) * $limit);			
			
			if (!empty($ret['data'])){
				$mModel = model('App\Models\MemberModel');
				$ret['member'] = array_column($mModel->getMemberByUids(array_column($ret['data'],'uid')),NULL,'uid');
			}

			$ret['page'] = $page;
			$ret['limit'] = $limit;
			$ret['code'] = 1;
			return retJson($ret);
		}

		$data['init']['tag'] = 'vote_view_' . $id;		
		$data['init']['module'] = 'vote_view';
		return view($this->_tpl.'view', $data);		

	}

}
