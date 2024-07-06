<?php namespace App\Entities;

use CodeIgniter\Entity;

class Discuz extends Entity{

	/**
	* 根据模块读取该模块分类下最新一条的留言数据
	*/
	public static function getNewoneByModule($module, $relid='', $tag=0){
		if (empty($module)) return false;
		$c_relid = '';
		if (!empty($relid)){
			$c_relid = ' and relid in(';		
			$c_relid .= is_array($relid) ? implode(',', $relid) : $relid;
			$c_relid .= ')';
		}
		
		$where = " where module='".$module."' and status=1 and tag=" . $tag . $c_relid;
		
		$dModel = model('App\Models\DiscuzModel');
		$mModel = model('App\Models\MemberModel');
		$db = db_connect();
		$sql = "select d.*,m.uid,m.name,m.avatar 
				from (SELECT max.* 
					FROM (SELECT DISTINCT (relid),uid,content,created_at 
						FROM ".$dModel->__get("table"). $where . "
						ORDER BY created_at DESC
					) max GROUP BY relid) as d
				left join ".$mModel->__get("table")."  as m
				on d.uid = m.uid";
		$query = $db->query($sql);
		return $query->getResultArray();			
	}
	public static function getNewoneByModule2($module, $relid=[],$tag=0){
		if (empty($module)) return false;	
		/*
		$builder->select('*')->from('my_table')
        ->groupStart()
                ->where('a', 'a')
                ->orGroupStart()
                        ->where('b', 'b')
                        ->where('c', 'c')
                ->groupEnd()
        ->groupEnd()
        ->where('d', 'd')
		->get();
		*/
		
		$dModel = model('App\Models\DiscuzModel');
		$mModel = model('App\Models\MemberModel');
		return $dModel->where('module',$module)
						->where("status",1)
						->where("tag",$tag)
						->distinct('relid')
						->select('module,relid,uid,content,created_at')
						->orderBy('created_at','DESC')
						->get()->getResultArray();		
	}
}