<?php namespace App\Models;

use CodeIgniter\Model;

class SysMessageModel extends Model
{
    protected $table      = 'sys_message';
    protected $primaryKey = 'id';
	protected $allowedFields = ['tag','content','link','formuid','touid','status'];
	protected $searchFields = ['content'=>''];	
	protected $returnType = 'array';
    protected $useSoftDeletes = false;		
	protected $useTimestamps = true;
    protected $createdField  = 'created_at';
    protected $updatedField  = '';
    protected $deletedField  = '';
	protected $skipValidation     = false;    
    
	protected $validationRules    = [
  //      'name'		=> 'required|string|is_unique[role_base.name,rid,{rid}]|min_length[2]',
	];	
	
	public function getData($sdata=[], $limit, $offset, $likekey='',$likeval='', $orderkey='',$ordertype=''){	
		$builder = self::__get('db')->table(self::__get('table'));
		$builder->select('id,content,status,created_at');
		if (!empty($sdata)) $builder->where($sdata);
		if (!empty($likekey) && !empty($likeval)) $builder->like($likekey, $likeval);
		if (!empty($orderkey))
			 $builder->orderby($orderkey, empty($ordertype) ? 'desc' : $ordertype);
		else
			$builder->orderby('id', 'desc');	
		return $builder->limit($limit, $offset)->get()->getResultArray();		
	}

	public function count($sdata=[],$likekey='',$likeval='') {
		$builder = self::__get('db')->table(self::__get('table'));
		//$builder->where("deleted_at IS NULL");
		if (!empty($sdata)) $builder->where($sdata);
		if (!empty($likekey) && !empty($likeval)) $builder->like($likekey, $likeval);
		return $builder->selectCount(self::__get('primaryKey'))->get()->getRowArray();
    }    
	
	public function getNewTips($id) {
		return self::__get('db')->table(self::__get('table'))->where('touid',$id)->where('status',1)->selectCount(self::__get('primaryKey'))->get()->getRowArray()[self::__get('primaryKey')];				
    }
    
}