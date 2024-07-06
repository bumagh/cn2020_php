<?php namespace App\Models;

use CodeIgniter\Model;

class VoteModel extends Model
{
    protected $table      = 'custom_vote';
    protected $primaryKey = 'id';
	protected $allowedFields = ['tag','title','intro','votemax','voteopt','btime','etime','status','uid','adduid','edituid'];
	protected $returnType = 'array';
    protected $useSoftDeletes = true;	
	protected $useTimestamps = true;
    protected $createdField  = 'created_at';
    protected $updatedField  = 'updated_at';
    protected $deletedField  = 'deleted_at';
    protected $skipValidation     = false;    
    
	protected $validationRules    = [
		'tag'			=> 'required|numeric'
		,'title'		=> 'required|string|min_length[2]|max_length[100]'
		,'intro'		=> 'permit_empty|string|min_length[2]|max_length[150]'
	];

	public $searchFields = ['id'				=>''
								,'title'		=>''
								,'tag'			=>['title'=>'别类','type'=>'select','setting'=>['1'=>'平台发起的投票','2'=>'平台议题研讨','3'=>'会员议题发起']]
								,'status'		=>['type'=>'select','setting'=>['1'=>'进行中','0'=>'待发布','2'=>'已完成']]
								,'etime'			=>['type'=>'datetime']
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