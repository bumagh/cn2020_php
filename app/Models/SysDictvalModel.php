<?php namespace App\Models;

use CodeIgniter\Model;

class SysDictvelModel extends Model
{

    protected $table		 = '';
    protected $prefix		 = '';	// 前缀
	protected $suffix		 = '_ext';	// 后缀
    protected $primaryKey	 = 'id';
	protected $allowedFields = ['fid','relid','val','adduid','edituid'];
	protected $returnType = 'array';
    protected $useSoftDeletes = false;	
	protected $useTimestamps = true;
    protected $createdField  = 'created_at';
    protected $updatedField  = 'updated_at';
    protected $deletedField  = 'deleted_at';
	protected $validationRules    = [
		'fid' 	=> 'required|greater_than[0]'
		,'relid' 	=> 'required|greater_than[0]'
	]; 
	
	public function __set($key, $value)
	{
		if (property_exists($this, $key))
		{
			$this->$key = $value;
		}
	}
	
	public function setTname($tname){
		self::__set("table", self::__get("prefix") . $tname . self::__get("suffix"));
	}	
}