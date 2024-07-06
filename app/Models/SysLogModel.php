<?php namespace App\Models;

use CodeIgniter\Model;

class SysLogModel extends Model
{
    protected $table      = 'sys_log';
    protected $primaryKey = 'id';
	protected $allowedFields = ['title','module','route','actions','relid','adduid','name'];
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
	
	public $searchFields = [
									'module' =>['title'=>'所属模块']
									,'route' =>['title'=>'执行路由']
								];
	
	public function setEmpty(){
		$builder = self::__get('db')->table(self::__get('table'));
		return $builder->emptyTable();	
	}
	
	public function getData($sdata=[], $limit=15, $offset=0, $likekey='',$likeval='', $orderkey='',$ordertype=''){	
		$builder = self::__get('db')->table(self::__get('table'));
		$builder->select('title,module,route,actions,name,created_at');
		if (!empty($sdata)) $builder->where($sdata);
		if (!empty($likekey) && !empty($likeval)) $builder->like($likekey, $likeval);
		if (!empty($orderkey)) $builder->orderby($orderkey, empty($ordertype) ? 'desc' : $ordertype);
		return $builder->limit($limit, $offset)->get()->getResultArray();		
	}

	public function count($sdata=[],$likekey='',$likeval='') {
		$builder = self::__get('db')->table(self::__get('table'));
		if (!empty($sdata)) $builder->where($sdata);
		if (!empty($likekey) && !empty($likeval)) $builder->like($likekey, $likeval);
		return $builder->selectCount(self::__get('primaryKey'))->get()->getRowArray();
    }
}