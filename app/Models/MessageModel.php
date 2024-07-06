<?php namespace App\Models;

use CodeIgniter\Model;

class MessageModel extends Model
{
    protected $table      = 'message';
    protected $primaryKey = 'id';
	protected $allowedFields = ['tag','content','link','fromuid','touid','status'];
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
	
	
	// 系统给当前用户发系统消息
	public function sendSysMessage($uid, $tag, $title='',$content=''){
		if (empty($tag) || empty($uid)) return false;
		switch ($tag) {
			case 'levelup': 
				$content = '恭喜！您的等级已提升，重新登录后生效。';
				break;
			case 'cashjoin:ok':
				$tag = 'cashjoin';
				$content = '恭喜！您在竞拍【'.$title.'】中胜出。获得【'. $content."】";
				break;
			case 'cashjoin:fail':
				$tag = 'cashjoin';
				$content = '很遗憾，您在竞拍【'.$title.'】中被淘汰，相关金币已解冻并退还至钱包。';
				break;			
			case 'friendadd':
				break;			
		}

		if (!empty($content)){
			$tips['tag'] = $tag;
			$tips['content'] = $content;
			$tips['touid'] = $uid;
			$builder = self::__get('db')->table(self::__get('table'));
			return $builder->insert($tips);
		}
	}	
	
	public function getData($sdata=[], $limit=15, $offset=0, $likekey='',$likeval='', $orderkey='',$ordertype=''){	
		$builder = self::__get('db')->table(self::__get('table'));
		$builder->select('*');
		if (!empty($sdata)) $builder->where($sdata);
		if (!empty($likekey) && !empty($likeval)) $builder->like($likekey, $likeval);
		$builder->orderby('status','desc');
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
	
	public function getNewMessage($id) {
		return self::__get('db')->table(self::__get('table'))->where('touid',$id)->where('status',1)->selectCount(self::__get('primaryKey'))->get()->getRowArray()[self::__get('primaryKey')];				
    }
}