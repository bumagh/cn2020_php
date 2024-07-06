<?php namespace App\Models;

use CodeIgniter\Model;

class GameModulesConfModel extends Model
{
    public $table      = 'game_modules_conf';
    protected $primaryKey = 'id';
	protected $allowedFields = ['uid','mid','memo','sort','lvl','status','adduid','edituid'];
	protected $returnType = 'array';
    protected $useSoftDeletes = true;	
	protected $useTimestamps = true;
    protected $createdField  = 'created_at';
    protected $updatedField  = 'updated_at';
    protected $deletedField  = 'deleted_at';
    protected $skipValidation     = false;    
    
	protected $validationRules    = [
		'uid'		=> 'required|numeric'
		,'mid'		=> 'required|numeric'
	];

	public $searchFields = [];
		
	public function getData($sdata=[], $fields="*",$limit=15, $offset=0, $likekey='',$likeval='', $orderkey='',$ordertype=''){	
		$builder = self::__get('db')->table(self::__get('table'));
		$builder->where("deleted_at IS NULL");
		if (!empty($sdata)) $builder->where($sdata);
		if (!empty($likekey) && !empty($likeval)) $builder->like($likekey, $likeval);
		if (!empty($orderkey))
			 $builder->orderby($orderkey, empty($ordertype) ? 'desc' : $ordertype);
		else 
			$builder->orderby("id","desc");
		return $builder->limit($limit, $offset)->select($fields)->get()->getResultArray();
	}

	public function count($sdata=[],$likekey='',$likeval='') {
		$builder = self::__get('db')->table(self::__get('table'));
		$builder->where("deleted_at IS NULL");
		if (!empty($sdata)) $builder->where($sdata);
		if (!empty($likekey) && !empty($likeval)) $builder->like($likekey, $likeval);
		return $builder->selectCount(self::__get('primaryKey'))->get()->getRowArray();
    }
	
}