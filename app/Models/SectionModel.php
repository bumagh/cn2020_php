<?php namespace App\Models;

use CodeIgniter\Model;

class SectionModel extends Model
{
    protected $table      = 'section';
    protected $primaryKey = 'id';
	protected $allowedFields = ['name','desc','tourl','thumb','image','imagew','imageh','bdate','edate','sort','status','adduid','edituid'];
	protected $returnType = 'array';
    protected $useSoftDeletes = false;	
	protected $useTimestamps = true;
    protected $createdField  = 'created_at';
    protected $updatedField  = 'updated_at';
    protected $deletedField  = 'deleted_at';
    protected $skipValidation     = false;    
    
	protected $validationRules    = [
		'name'			=> 'required'
		//,'lvlid'		=> 'required|is_unique[level.lvlid]|numeric|min_length[1]|max_length[4]'
		,'sort'		=> 'permit_empty|numeric|min_length[1]|max_length[4]'
		,'tourl'	=> 'permit_empty|valid_url'
		,'image'	=> 'permit_empty|valid_url'
		,'thumb'	=> 'permit_empty|valid_url'
		,'imagew'	=> 'permit_empty|numeric|min_length[2]|max_length[4]'
		,'imageh'	=> 'permit_empty|numeric|min_length[2]|max_length[4]'
		//,'bdate'	=> 'permit_empty|valid_date[y-m-d]'
		//,'edate'	=> 'permit_empty|valid_date'
		,'desc'		=> 'permit_empty|string|max_length[250]'		
	];

	public $searchFields = [
							'name'			=>'',
							'desc'			=>['title'=>'文字描述'],
							'status'		=>['type'=>'select','setting'=>['1'=>'启用','0'=>'关闭']]
							];
	
	
	public function getData($sdata=[], $limit=15, $offset=0, $likekey='',$likeval='', $orderkey='',$ordertype=''){	
		$builder = self::__get('db')->table(self::__get('table'));
		$builder->where("deleted_at IS NULL")->select('*');
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