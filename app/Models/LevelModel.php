<?php namespace App\Models;

use CodeIgniter\Model;

class LevelModel extends Model
{
    protected $table      = 'level';
    protected $primaryKey = 'id';
	protected $allowedFields = ['name','numbmin','numbmax','policy','status','adduid','edituid'];
	protected $returnType = 'array';
    protected $useSoftDeletes = true;	
	protected $useTimestamps = true;
    protected $createdField  = 'created_at';
    protected $updatedField  = 'updated_at';
    protected $deletedField  = 'deleted_at';
    protected $skipValidation     = false;    
    
	protected $validationRules    = [
		'name'			=> 'required|string|min_length[2]'
		//,'lvlid'		=> 'required|is_unique[level.lvlid]|numeric|min_length[1]|max_length[4]'
		,'numbmin'		=> 'permit_empty|numeric|min_length[1]|max_length[10]'
		,'numbmax'		=> 'permit_empty|numeric|min_length[1]|max_length[10]'		
	];

	public $searchFields = ['id'			=>'',
								'name'			=>'',
								'status'		=>['type'=>'select','setting'=>['1'=>'启用','0'=>'关闭']],
								'created_at'	=>['type'=>'datetime']
							];
	
	
	public function getData($sdata=[], $limit=15, $offset=0, $likekey='',$likeval='', $orderkey='',$ordertype=''){	
		$builder = self::__get('db')->table(self::__get('table'));
		$builder->where("deleted_at IS NULL")->select('id,name,numbmin,numbmax,policy,status,created_at,updated_at');
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