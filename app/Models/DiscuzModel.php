<?php namespace App\Models;

use CodeIgniter\Model;

class DiscuzModel extends Model
{
    protected $table      = 'custom_discuz';
    protected $primaryKey = 'id';
	protected $allowedFields = ['module','relid','tag','title','content','status','uid','adduid','edituid'];
	protected $returnType = 'array';
    protected $useSoftDeletes = false;	
	protected $useTimestamps = true;
    protected $createdField  = 'created_at';
    protected $updatedField  = 'updated_at';
    protected $deletedField  = 'deleted_at';
    protected $skipValidation     = false;    
    
	protected $validationRules    = [
		//'module'		=> 'required|string|min_length[2]|max_length[32]'
		'module' 		=> 'required|in_list[vote,discuz]'
		,'title'			=> 'permit_empty|string|min_length[2]|max_length[100]'
		,'content'		=> 'required|string|min_length[2]|max_length[500]'
	];

	public $searchFields = ['content'			=>''
								,'module'		=>['title'=>'所属模块','type'=>'select','setting'=>['vote'=>'投票议题','discuz'=>'留言']]
								,'uid'			=>['title'=>'发布者ID']
							];
		
	public function getData($sdata=[], $limit=15, $offset=0, $likekey='',$likeval='', $orderkey='',$ordertype=''){	
		$builder = self::__get('db')->table(self::__get('table'));
		//$builder->where("deleted_at IS NULL");
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
		//$builder->where("deleted_at IS NULL");
		if (!empty($sdata)) $builder->where($sdata);
		if (!empty($likekey) && !empty($likeval)) $builder->like($likekey, $likeval);
		return $builder->selectCount(self::__get('primaryKey'))->get()->getRowArray();
    }
	
}