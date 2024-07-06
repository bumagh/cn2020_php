<?php namespace App\Models;

use CodeIgniter\Model;

class SysModuleModel extends Model
{
    protected $table      = 'sys_module';
    protected $primaryKey = 'mid';
	protected $allowedFields = ['pmid','name','code','icon','actions','sort','url','adduid','edituid'];
	protected $returnType = 'array';
    protected $useSoftDeletes = false;		
	protected $useTimestamps = true;
    protected $createdField  = 'created_at';
    protected $updatedField  = 'updated_at';
    protected $deletedField  = 'deleted_at';
    
    public function getBase($fields=['mid','pmid','icon','code','name','actions']) {
//		$mModel = model('App\Models\ModuleBaseModel');		
		return self::__get('db')->table(self::__get('table'))
						->select($fields)
						->where('status',1)
						->where('actions!=','')->get()->getResultArray();				
    }
    
	public function getRenderActions($actions, $checkedary=[]){
		$s = '';
		foreach ($actions as $k => $v){
			$st = (!empty($checkedary) && in_array($k , $checkedary)) ? 'checked' : '';
			$s.= '<input type="checkbox" name="actions['.$k.']" title="'.$v.'" '.$st.'>';
		}
		return $s;
	}
}