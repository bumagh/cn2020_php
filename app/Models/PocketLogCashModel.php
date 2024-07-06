<?php namespace App\Models;

use CodeIgniter\Model;

class PocketLogCashModel extends Model
{
    protected $table      = 'pocket_log_cash';
    protected $primaryKey = 'id';
	protected $allowedFields = ['uid','tag','numb','relid','adduid','status','tradeno','memo'];
	protected $returnType = 'array';
    protected $useSoftDeletes = false;	
	protected $useTimestamps = true;
    protected $createdField  = 'created_at';
    protected $updatedField  = '';
    protected $deletedField  = '';
    protected $skipValidation     = false;    
    
	protected $validationRules    = ['numb' => 'in_list[0,1,2,3,4,5,6,7,8,9,.]'];
	
	public $searchFields = [];
									
	public function getData($sdata=[], $limit=15, $offset=0, $likekey='',$likeval='', $orderkey='',$ordertype=''){	
		$builder = self::__get('db')->table(self::__get('table'));
		$builder->where("deleted_at IS NULL");
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
	// $uid为受影响的ID帐户
	public function setLog($tag,$uid,$numb,$trade='',$status=0,$memo='',$relid='',$adduid=''){
		if (empty($tag) || empty($uid) || empty($numb)) return false;
		$adata['tag'] 		= $tag;		
		$adata['uid'] 		= $uid;
		$adata['numb'] 		= $numb;
		$adata['tradeno'] 	= $trade;
		$adata['status'] 	= $status;
		$adata['memo'] 		= $memo;
		$adata['relid']		= empty($relid) ? $uid : $uid;
		$adata['adduid']	= empty($adduid) ? '' : $adduid;
		$builder = self::__get('db')->table(self::__get('table'));		
		return $builder->insert($adata);	
	}	
}