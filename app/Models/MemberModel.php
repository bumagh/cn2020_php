<?php namespace App\Models;

use CodeIgniter\Model;

class MemberModel extends Model
{
    protected $table      = 'member';
    protected $primaryKey = 'uid';
	protected $allowedFields = ['username','phone','passwd','name','invitcode','avatar','lvl','sign','status','adduid','edituid'];
	protected $returnType = 'array';
    protected $useSoftDeletes = false;	
	protected $useTimestamps = true;
    protected $createdField  = 'created_at';
    protected $updatedField  = '';
    protected $deletedField  = 'deleted_at';
    protected $skipValidation     = false;    

	protected $beforeInsert = ['beforeInsert'];
    protected $beforeUpdate = ['beforeUpdate'];
    protected $beforeDelete = ['beforeDelete'];
    protected $afterFind 	= ['afterFind'];
    
    
	protected $validationRules    = [
        //'username'		=> 'required|is_unique[member.username]|min_length[6]|max_length[8]',
        //'phone'			=> 'required|is_unique[member.phone]|min_length[11]|max_length[11]',
        'username'		=> 'required|is_unique[member.username]|min_length[11]|max_length[11]',
		'name'			=> 'required|string|min_length[2]|max_length[20]',
        'passwd'		=> 'required|min_length[6]',
        'repasswd'		=> 'required_with[passwd]|matches[passwd]',
		'sign'			=> 'permit_empty|string|max_length[120]'
		//'email'			=> 'permit_empty|valid_email',
		//'phone'			=> 'permit_empty|numeric|min_length[11]|max_length[11]'
	];	

	protected $validationMessages = [
		'passwd'	=> [
			'required' => '密码不能为空',
			'min_length'=>'密码不能小于6位'
		]
	];
	public $searchFields = ['uid'			=>'',
								'username'		=>'',
								'phone'			=>['title'=>'绑定手机'],
								'lvl'			=>['type'=>'select'],
								'name'			=>'',
								'invitcode'		=>['title'=>'邀请码'],
								'status'		=>['type'=>'select','setting'=>['1'=>'启用','0'=>'关闭']],
								'created_at'	=>['type'=>'datetime'],
								'adduid'=>''];
						
	public static function setEncry($passwd){
		return password_hash($passwd, PASSWORD_DEFAULT);	
	}

	protected function afterFind($data){
        if(isset($data['data']['passwd'])) unset($data['data']['passwd']);
        return $data;		
	}

    protected function beforeInsert( array $data ){
        if( isset($data['data']['passwd']))
            $data['data']['passwd'] = self::setEncry($data['data']['passwd']);
        return $data;
    }

    protected function beforeUpdate( array $data ){
       if(!empty($data['data']['passwd']))
            $data['data']['passwd'] = self::setEncry($data['data']['passwd']);
        else
        	unset($data['data']['passwd']);
        return $data;    
    }
    
    
    protected function beforeDelete($data){
    }
    

    public function getMemberByUids($uids=[], $fields='uid,name,avatar'){
		$builder = self::__get('db')->table(self::__get('table'));
		$builder->where("deleted_at IS NULL");
		if (!empty($uids)) $builder->whereIn("uid", $uids);
		return $builder->select($fields)->get()->getResultArray();		
    }
	
	public function getLogin($value, $field = 'username'){
		return self::__get('db')->table(self::__get('table'))
								->where("deleted_at IS NULL")
								->where("status=1")								
								->where($field, $value)
								->select('uid,username,passwd,name,lvl,status,avatar')
								->get()->getRowArray();		
	}
	
	public function getData($sdata=[], $limit=15, $offset=0, $likekey='',$likeval='', $orderkey='',$ordertype=''){	
		$builder = self::__get('db')->table(self::__get('table'));
		$builder->where("deleted_at IS NULL")->select('uid,username,phone,name,lvl,invitcode,status,avatar,sign,adduid,created_at');
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
	
}