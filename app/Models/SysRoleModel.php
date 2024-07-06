<?php namespace App\Models;

use CodeIgniter\Model;

class SysRoleModel extends Model
{
    protected $table      = 'sys_role';
    protected $primaryKey = 'rid';
	protected $allowedFields = ['name','modulelist','memo','adduid','edituid'];
	protected $returnType = 'array';
    protected $useSoftDeletes = false;		
	protected $useTimestamps = true;
    protected $createdField  = 'created_at';
    protected $updatedField  = 'updated_at';
    protected $deletedField  = 'deleted_at';
	protected $skipValidation     = false;    
    
	protected $validationRules    = [
        'name'		=> 'required|string|is_unique[sys_role.name,rid,{rid}]|min_length[2]',
	];	

	public $searchFields = [
								'name' =>''
							];	
	
	public function getData($sdata=[], $limit=15, $offset=0, $likekey='',$likeval='', $orderkey='',$ordertype=''){	
		$builder = self::__get('db')->table(self::__get('table'));
		$builder->where("deleted_at IS NULL")->select('rid,name,modulelist,memo,adduid,created_at,updated_at');
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