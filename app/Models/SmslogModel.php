<?php namespace App\Models;

use CodeIgniter\Model;

class SmslogModel extends Model
{
    protected $table      = 'custom_smslog';
    protected $primaryKey = 'id';
	protected $allowedFields = ['tag','phone','mvcode','deviceid'];
	protected $returnType = 'array';
    protected $useSoftDeletes = false;	
	protected $useTimestamps = true;
    protected $createdField  = 'created_at';
    protected $updatedField  = 'updated_at';
    protected $deletedField  = 'deleted_at';
    protected $skipValidation     = false;    
    
	protected $validationRules    = [
		'tag'			=> 'required|string'
		,'phone'		=> 'required|numeric|min_length[11]|max_length[11]'
		,'mvcode'		=> 'required|numeric|min_length[4]|max_length[6]'
	];

	public $searchFields = ['id'				=>''
								,'phone'		=>['title'=>'手机号']
								,'tag'			=>['title'=>'来源','type'=>'select','setting'=>['ey'=>'Ey']]
								,'created_at'	=>['type'=>'datetime']
							];
		
	public function getData($sdata=[], $limit=15, $offset=0, $likekey='',$likeval='', $orderkey='',$ordertype=''){	
		$builder = self::__get('db')->table(self::__get('table'));
		$builder->where("deleted_at IS NULL");
		if (!empty($sdata)) $builder->where($sdata);
		if (!empty($likekey) && !empty($likeval)) $builder->like($likekey, $likeval);
		if (!empty($orderkey))
			 $builder->orderby($orderkey, empty($ordertype) ? 'desc' : $ordertype);
		else 
			$builder->orderby("id","desc");
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