<?php namespace App\Models;

use CodeIgniter\Model;

class SysConfigModel extends Model
{
    protected $table      = 'sys_config';
    protected $primaryKey = 'id';
	protected $allowedFields = ['confkey','confval','confnote','fieldtype','memo','sort','tag','status','edituid'];
	protected $returnType = 'array';
    protected $useSoftDeletes = false;		
	protected $useTimestamps = true;
    protected $createdField  = 'created_at';
    protected $updatedField  = 'updated_at';
    protected $deletedField  = 'deleted_at';
	protected $skipValidation     = false;    
    
	protected $validationRules    = [
        'tag' => 'required|min_length[2]||max_length[30]',
	];	
	
	public $searchFields = [];
	
	public function getConfig($tag){
		if (empty($tag)) return false;
		$builder = self::__get('db')->table(self::__get('table'));
		$builder->orderby('sort','asc');
		$res = $builder->where('tag',$tag)->where('status',1)->select('confkey,confval')->get()->getResultArray();
		$ret =[];
		if (!empty($res)){
			foreach ($res as $k => $v){
				$ret[$v['confkey']] = $v['confval'];
			}			
		}
		return $ret;
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