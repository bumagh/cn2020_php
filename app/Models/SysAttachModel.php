<?php namespace App\Models;

use CodeIgniter\Model;

class AttachModel extends Model
{
    protected $table      = 'sys_attach';
    protected $primaryKey = 'id';
	protected $allowedFields = ['module','store','url','type','url','thumb','width','height','fileext','filesize','filename','usertype','adduid','edituid'];
	protected $returnType = 'array';
    protected $useSoftDeletes = true;	
	protected $useTimestamps = true;
    protected $createdField  = 'created_at';
    protected $updatedField  = 'updated_at';
    protected $deletedField  = 'deleted_at';
    protected $skipValidation     = false;    
    
	protected $validationRules    = [
		'module'		=> 'required'
		,'store'		=> 'required|numeric|min_length[1]|max_length[2]'
		,'type'			=> 'required|numeric|min_length[1]|max_length[2]'
		,'url'			=> 'required|valid_url'
		,'filesize'		=> 'required|numeric'
		,'width'		=> 'permit_empty|numeric'
		,'height'		=> 'permit_empty|numeric'
	];

	public $searchFields = [
							'module'		=>['title'	=>'来源模块'
												,'type'	=>'select'
												,'setting'=>[]
												]
							,'store'		=>['title'	=>'存储方式'
												,'type'	=>'select'
												,'setting'=>['0'=>'本地存储','1'=>'七牛存储','2'=>'阿里存储']
												]
							,'type'			=>['title'	=>'存储性质'
												,'type'	=>'select'
												,'setting'=>['0'=>'','1'=>'图片','2'=>'文件','3'=>'视频','4'=>'音频']
												]
							,'usertype'		=>['title'	=>'用户类型'
												,'type'	=>'select'
												,'setting'=>['0'=>'会员','1'=>'管理帐号']
												]
							];
	
	
	public function getData($sdata=[], $limit=15, $offset=0, $likekey='',$likeval='', $orderkey='',$ordertype=''){	
		$builder = self::__get('db')->table(self::__get('table'));
		$builder->where("deleted_at IS NULL")->select('*');
		if (!empty($sdata)) $builder->where($sdata);
		if (!empty($likekey) && !empty($likeval)) $builder->like($likekey, $likeval);
		if (!empty($orderkey)) $builder->orderby($orderkey, empty($ordertype) ? 'desc' : $ordertype);
		return $builder->limit($limit, $offset)->get()->getResultArray();		
	}

	public function count($sdata=[],$likekey='',$likeval='') {
		$builder = self::__get('db')->table(self::__get('table'));
		$builder->where("deleted_at IS NULL");
		if (!empty($sdata)) $builder->where($sdata);
		if (!empty($likekey) && !empty($likeval)) $builder->like($likekey, $likeval);
		return $builder->selectCount(self::__get('primaryKey'))->get()->getRowArray();
    }
	
}