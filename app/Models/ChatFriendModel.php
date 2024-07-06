<?php namespace App\Models;

use CodeIgniter\Model;

class ChatFriendModel extends Model
{
    protected $table      = 'chat_friend_content';
    protected $primaryKey = 'id';
	protected $allowedFields = ['uid','fid','content','tag','status','adduid','edituid'];
	protected $returnType = 'array';
    protected $useSoftDeletes = true;	
	protected $useTimestamps = true;
    protected $createdField  = 'created_at';
    protected $updatedField  = 'updated_at';
    protected $deletedField  = 'deleted_at';
    protected $skipValidation     = false;    
    
	protected $validationRules    = [
		'uid'			=> 'required|numeric'
		,'content'		=> 'required|string|min_length[1]|max_length[150]'
	];

	public $searchFields = ['content' =>''];
		
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