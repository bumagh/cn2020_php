<?php
namespace App\Controllers\Api;
use App\Controllers\ApiController;

class Attach extends ApiController{

	protected static $model;
	
	public function __construct(){
		self::$model = model('App\Models\SysAttachModel');
	}

	// 上传版块图片
	public function upimage(){	
		$this->checkLogin();		
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
			$adata['usertype'] = 0;
			$adata['adduid'] = $this->loginfo['uid'];
			$adata['filename'] = $file->getRandomName();
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
			
			if ($adata['module'] == 'member'){
				$res = $image->withFile($file->getTempName())->fit(empty($pdata['imagew']) ? 100 : intval($pdata['imagew']), empty($pdata['imageh']) ? 100 : intval($pdata['imageh']), 'center')->save(FCPATH.$paththumb.$adata['filename']);
			}else{
				$res = $image->withFile($file->getTempName())->fit(empty($pdata['imagew']) ? 200 : intval($pdata['imagew']), empty($pdata['imageh']) ? 100 : intval($pdata['imageh']), 'center')->save(FCPATH.$paththumb.$adata['filename']);			
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
}
