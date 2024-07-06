<?php namespace App\Models;

use CodeIgniter\Model;

class PaimaiModel extends Model
{
    protected $table      = 'custom_paimai';
    protected $primaryKey = 'id';
	protected $allowedFields = ['tag','name','numbmin','numbmax','content','btime','etime','status','uid','adduid','edituid'];
	protected $returnType = 'array';
    protected $useSoftDeletes = true;	
	protected $useTimestamps = true;
    protected $createdField  = 'created_at';
    protected $updatedField  = 'updated_at';
    protected $deletedField  = 'deleted_at';
    protected $skipValidation     = false;    
    
	protected $validationRules    = [
		'name'			=> 'required|string|min_length[2]'
		,'content'		=> 'required|string|min_length[2]|max_length[250]'
		//,'lvlid'		=> 'required|is_unique[level.lvlid]|numeric|min_length[1]|max_length[4]'
		,'numbmin'		=> 'required|numeric|min_length[1]|max_length[10]'
		,'numbmax'		=> 'permit_empty|numeric|min_length[1]|max_length[10]'		
	];

	public $searchFields = ['id'				=>''
								,'name'			=>''
								,'tag'			=>['title'=>'拍卖分类','type'=>'select','setting'=>['0'=>'现金','1'=>'金币','2'=>'资源']]
								,'status'		=>['type'=>'select','setting'=>['1'=>'完成','0'=>'进行中']]
								,'btime'			=>['title'=>'起拍时间','type'=>'datetime']
								,'etime'			=>['title'=>'截止时间','type'=>'datetime']
							];
		
	public function getData($sdata=[], $limit=15, $offset=0, $likekey='',$likeval='', $orderkey='',$ordertype=''){	
		$builder = self::__get('db')->table(self::__get('table'));
		$builder->where("deleted_at IS NULL");
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