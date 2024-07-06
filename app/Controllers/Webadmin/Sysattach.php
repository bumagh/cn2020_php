<?php
namespace App\Controllers\Webadmin;
use App\Controllers\AdminController;

class Sysattach extends AdminController{

	protected static $model;
	//protected static $extbase;
	
	public function __construct(){
		self::$model = model('App\Models\SysAttachModel');
		//self::$extbase = new \App\Entities\Extbase;		
	}

	public function index(){	

		if ($this->request->getPost()){
			$ret = parent::getSearchData(self::$model);
			return retJson($ret);
		}

		$sdModel = model('App\Models\SysDictkeyModel');	
		self::$model->searchFields['module']['setting'] = $sdModel->searchFields['tname']['setting'];
		$data['init'] = parent::setIndexInitData(self::$model);
		
		/*
		echo '<PRE>';
		print_r($data);
		exit;
		*/
		
		return view($this->_tpl.'index', $data);
	}
	
	public function delm(){
		if ($this->request->getPost()){
			$ids  = $this->request->getPost('ids', FILTER_SANITIZE_NUMBER_INT);
			$res = self::$model->whereIn('id',$ids)->get()->getResultArray();
			if (!empty($res)){
				foreach ($res as $k => $v){
					if ($v['store'] == 0){			
						if (file_exists(FCPATH . $v['url'])) unlink(FCPATH . $v['url']);
						if (file_exists(FCPATH . $v['thumb'])) unlink(FCPATH . $v['thumb']);
					}else if ($v['store'] == 1){	// 从第三方存储中删除
					
					}
				}
				self::$model->whereIn('id',$ids)->delete();
				$ret['code'] = 1;
				$ret['data'] = $ids;
				return retJson($ret);
			}
		}
	}
	
	public function del(){
		if ($this->request->getPost()){
			$id  = $this->request->getPost('id', FILTER_SANITIZE_NUMBER_INT);
			$row = self::$model->where('id',$id)->get()->getRowArray();
			if ($row['store'] == 0){			
				if (file_exists(FCPATH . $row['url'])) unlink(FCPATH . $row['url']);
				if (file_exists(FCPATH . $row['thumb'])) unlink(FCPATH . $row['thumb']);
			}else if ($row['store'] == 1){	// 从第三方存储中删除
			}
			
			if (self::$model->delete($id)){
				$ret['code'] = 1;
				$ret['data'] = $id;
				return retJson($ret);
			}
		}
		
		$ret['code'] = 0;
		return retJson($ret);
	}

	// 上传版块图片
	public function upimage(){	
		$pdata = $this->request->getPost();	
		$file = $this->request->getFile("file");
		if ($file && $pdata){
			$adata['module'] = filter_var($pdata['module'], FILTER_SANITIZE_STRING);
			if (empty($adata['module'])) {
				$ret['code'] = 0;
				$ret['msg'] = '上传来源异常';
				return retJson($ret);
			}
			
			$adata['store'] = 0;
			$adata['type'] = 1;
			$adata['usertype'] = 1;	// 后台管理帐号
			$adata['adduid'] = self::getAuth()['uid'];
			//$fname = 'source-'.time().'.'.$file->guessExtension();		
			$adata['filename'] = $file->getRandomName();
			//$adata['filesize'] = $file->getSize();
			$adata['fileext'] = $file->guessExtension();
			
			$pathimage = 'attach/image/';
			$paththumb = 'attach/thumb/';
			
			$image = \Config\Services::image();
			
			if (!empty($pdata['imagew']) && !empty($pdata['imageh'])){
				$adata['width'] = intval($pdata['imagew']);
				$adata['height'] = intval($pdata['imageh']);
				$image->withFile($file->getTempName())->fit($adata['width'], $adata['height'], 'center')->save(FCPATH.$pathimage.$adata['filename']);
			}else{
				$image->withFile($file->getTempName())->save(FCPATH.$pathimage.$adata['filename']);				
			}

			helper('filesystem');
			$_info = get_file_info(FCPATH.$pathimage.$adata['filename']);
			$adata['filesize'] = $_info['size'];					
			
			if (($adata['module'] == 'member') || ($adata['module'] == 'sysuser')){
				$res = $image->withFile($file->getTempName())->fit(empty($pdata['imagew']) ? 64 : intval($pdata['imagew']), empty($pdata['imageh']) ? 64 : intval($pdata['imageh']), 'center')->save(FCPATH.$paththumb.$adata['filename']);
			}else{
				$res = $image->withFile($file->getTempName())->fit(200, 100, 'center')->save(FCPATH.$paththumb.$adata['filename']);			
			}

			
			if ($res == 1){
				$adata['url'] = $pathimage.$adata['filename'];
				$adata['thumb'] = $paththumb.$adata['filename'];

				self::$model->insert($adata);
				$ret['thumb'] = $adata['thumb'];
				$ret['url'] = $adata['url'];
				$ret['code'] = 1;
				return retJson($ret);
			}			
			$ret['msg'] = $res;
			$ret['code'] = 0;
			return retJson($ret);
		}
		
		$ret['code'] = 0;
		return retJson($ret);
	}
	
	/**
	* 渲染要上传的页面
	* @$p['thumb'] 图片缩略
	*/
		
	public function renderUpimage($p){
	
//		return $p['thumb'];
	
		return view($this->_tpl.'../sysattach/upimage', $p);
	}
}
