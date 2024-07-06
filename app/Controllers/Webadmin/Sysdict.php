<?php

namespace App\Controllers\Webadmin;
use App\Controllers\AdminController;

class Sysdict extends AdminController
{

	protected static $model;
	
	public function __construct(){
		self::$model = model('App\Models\SysDictkeyModel');
	}
		
	public function index(){
	
		if ($this->request->getPost()){
			// 基本表查询字段
			//$searchfields = self::$model->searchFields;
			$ret = parent::getSearchData(self::$model);
			return retJson($ret);
		}		

		$data['init'] = parent::setIndexInitData(self::$model);
		return view($this->_tpl.'index', $data);
	}
	
	private function setFilterData(){
		$adata['tname']		= $this->request->getPost('tname', FILTER_SANITIZE_STRING);	
		$adata['name']		= $this->request->getPost('name', FILTER_SANITIZE_STRING);
		$adata['code']		= $this->request->getPost('code', FILTER_SANITIZE_STRING);
		$adata['type']		= $this->request->getPost('type', FILTER_SANITIZE_STRING);
		$adata['info']		= $this->request->getPost('info', FILTER_SANITIZE_STRING);
		$adata['setting']	= $this->request->getPost('setting', FILTER_SANITIZE_STRING);		
		$adata['sort']		= $this->request->getPost('sort', FILTER_SANITIZE_NUMBER_INT);
		$_force				= $this->request->getPost('force', FILTER_SANITIZE_STRING);
		$adata['force']		= (!empty($_force)) ? 1 : 0;
		$_view				= $this->request->getPost('view', FILTER_SANITIZE_STRING);
		$adata['view']		= (!empty($_view)) ? 1 : 0;
		$_search			= $this->request->getPost('search', FILTER_SANITIZE_STRING);
		$adata['search']	= (!empty($_search)) ? 1 : 0;
		$_edit				= $this->request->getPost('edit', FILTER_SANITIZE_STRING);
		$adata['edit']		= (!empty($_edit)) ? 1 : 0;

		//$adata['rule']		= ($adata['force']) ? 'required' : '';
		if ($adata['type'] == 'text'){
			$_rule = $this->request->getPost('rule', FILTER_SANITIZE_STRING);
			if (empty($_rule)){
				$adata['rule'] = '';
			}else if (!empty($_rule) && isset(self::$model->searchFields['rule']['setting'][$_rule])) {
				$adata['rule'] = $_rule;
			}
		}		
		return $adata;
	}
	
	private function checkHasFields($tname, $code){
		$db = self::$model->__get("db");
		if ($db->fieldExists($code, $tname)){
			return true;
		}
		return false;
	}
	
	private function resetSetting($data){
		if (empty($data['setting'])) return $data;
		$_s = '';
		//if (($data['type'] == 'radio') ||($data['type'] == 'select') || ($data['type'] == 'checkbox')){	
			if (strpos($data['setting'], '=') != false){
				$_s = str_replace(["\n","\s"],['&',''], $data['setting']);
				if (empty($_s)) return false;
				parse_str($_s, $retary);
				$data['setting'] = json_encode($retary);		
				return $data;		
			}else{
				$_s = explode("\n", $data['setting']);
				if (empty($_s)) return false;
				$data['setting'] = json_encode($_s);		
				return $data;				
			}
			return false;		
		//}
		return $data;
			
	}
	
	private function resetValidRules(){
	//	修改验证规则 
		$validrules = self::$model->getValidationRules();		
		$validrules['code'] = 'required|alpha_dash|is_unique[sys_dict.code,code,{code}]|min_length[3]';
		self::$model->setValidationRules($validrules);	
	}
	/**
	* 添加
	*/
	public function add(){	
		
		if ($this->request->getPost()){
			$adata = $this->setFilterData();
			$adata['adduid'] = self::getAuth()['uid'];
			
			if ($this->checkHasFields($adata['tname'], $adata['code'])){
				$ret['msg'] = ['code'=>'字段编码已被占用,请更改。'];
				$ret['code'] = 0;
				return retJson($ret);					
			}
			
			$adata = $this->resetSetting($adata);
			if (!$adata){
				$ret['msg'] = ['setting'=>'『选择项设置』不符合标准，请重新编辑。'];
				$ret['code'] = 0;
				return retJson($ret);										
			}
			
			$id = self::$model->insert($adata);
			if ($id){
				$adata['fid'] = $id;
				$ret['code'] = 1;
				return retJson($ret);
			}

			$ret['msg'] = self::$model->errors();
			$ret['code'] = 0;
			return retJson($ret);
		}
		
		$data['init'] = parent::setDetailInitData(self::$model);
		//$data['init']['tname'] = self::$model::getTable();
		//$data['init']['type'] = self::$model::getType();				
		return view($this->_tpl.'detail', $data);
	}
	
	public function edit($id){
		if (empty($id)) return "参数丢失"; 
		$id = intval($id);
	
		if ($this->request->getPost()){
			$adata = $this->setFilterData();
			$adata['edituid'] = self::getAuth()['uid'];

			if ($this->checkHasFields($adata['tname'], $adata['code'])){
				$ret['msg'] = ['code'=>'字段编码已被占用,请更改。'];
				$ret['code'] = 0;
				return retJson($ret);					
			}

			$adata = $this->resetSetting($adata);
			if (!$adata){
				$ret['msg'] = ['setting'=>'『选择项设置』不符合标准，请重新编辑。'];
				$ret['code'] = 0;
				return retJson($ret);										
			}
			$this->resetValidRules();
			$st = self::$model->update($id,$adata);
			if ($st){
				$ret['data'] = $adata;
				$ret['code'] = 1;
				return retJson($ret);
			}
			$ret['msg'] = self::$model->errors();
			$ret['code'] = 0;
			return retJson($ret);
		}
	
		$data['init'] = parent::setDetailInitData(self::$model, $id);

		if (!empty($data['init']['row']['setting'])){
			$_setting = json_decode($data['init']['row']['setting']);
			$setting = '';
			if (is_object($_setting)){
				foreach ($_setting as $k => $v) $setting .= $k . "=" . $v . "\n";
			}else{
				foreach ($_setting as $k => $v) $setting .= $v . "\n";
			}
			$data['init']['row']['setting'] = trim($setting);
		}
		return view($this->_tpl.'detail', $data);
	}
	
	public function del(){
		if ($this->request->getPost()){
			$id  = $this->request->getPost('id', FILTER_SANITIZE_NUMBER_INT);
			$tname = $this->request->getPost('tname', FILTER_SANITIZE_STRING);	
			$_tcode = array_search($tname,self::$model->searchFields['tname']['setting']);
			if (!$_tcode){
				$ret['code'] = 0;
				$ret['msg'] = $_tcode.'的扩展表不存在';
				return retJson($ret);			
			}

			if (self::$model->delete($id)){
				$vModel = model('App\Models\SysDictvalModel');
				$vModel->setTname($_tcode);
				$vModel->where('fid', $id)->delete();

				$ret['code'] = 1;
				$ret['data'] = $id;
				return retJson($ret);
			}
		}
		
		$ret['code'] = 0;
		return retJson($ret);
	}
}
