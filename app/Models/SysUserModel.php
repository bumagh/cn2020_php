<?php namespace App\Models;

use CodeIgniter\Model;

class SysUserModel extends Model
{
    protected $table      = 'sys_user';
    protected $primaryKey = 'uid';
	protected $allowedFields = ['username','passwd','name','email','phone','avatar','rid','status','adduid','edituid'];
	protected $returnType = 'array';
    protected $useSoftDeletes = true;	
	protected $useTimestamps = true;
    protected $createdField  = 'created_at';
    protected $updatedField  = 'updated_at';
    protected $deletedField  = 'deleted_at';
    protected $skipValidation     = false;    

	protected $beforeInsert = ['beforeInsert'];
    protected $beforeUpdate = ['beforeUpdate'];
    protected $beforeDelete = ['beforeDelete'];
    protected $afterFind 	= ['afterFind'];
    
    
	protected $validationRules    = [
        'username'		=> 'required|string|is_unique[sys_user.username]|min_length[3]',
		'name'			=> 'required|string|min_length[2]',
        'passwd'		=> 'required|min_length[6]',
        'repasswd'		=> 'required_with[passwd]|matches[passwd]',
		'email'			=> 'permit_empty|valid_email',
		'phone'			=> 'permit_empty|numeric|min_length[11]|max_length[11]', 		
        'rid'			=> 'required|greater_than[0]'
	];	

	protected $validationMessages = [
		'rid'	=> [
			'greater_than' => '请选择角色。'
		]
	];
	public $searchFields = ['uid'			=>'',
								'username'		=>'',
								'rid'			=>['type'=>'select'],
								'name'			=>'',
								'email'			=>'',
								'phone'			=>'',								
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
    	
//    	print_r($data);  	
//    	return false;
    }
    
    public function getUserByUids($uids=[], $fields='uid,name,avatar'){
		$builder = self::__get('db')->table(self::__get('table'));
		$builder->where("deleted_at IS NULL");
		if (!empty($uids)) $builder->whereIn("uid", $uids);
		return $builder->select($fields)->get()->getResultArray();		
    }
	
	public function getLogin($username){
		return self::__get('db')->table(self::__get('table'))
								->where("deleted_at IS NULL")
								->where("status=1")								
								->where("username", $username)
								->select('uid,passwd,name,rid,status,avatar')
								->get()->getRowArray();		
	}
	
	public function getData($sdata=[], $limit, $offset, $likekey='',$likeval='', $orderkey='',$ordertype=''){	
		$builder = self::__get('db')->table(self::__get('table'));
		$builder->where("deleted_at IS NULL")->select('uid,username,name,rid,status,avatar,email,phone,adduid,created_at,updated_at');
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