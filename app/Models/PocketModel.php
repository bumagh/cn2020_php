<?php namespace App\Models;

use CodeIgniter\Model;

class PocketModel extends Model
{
    protected $table      = 'pocket';
    protected $primaryKey = 'id';
	protected $allowedFields = ['uid','coin','coinfix','cash','cashfix','point','res','memo','status','adduid','edituid'];
	protected $returnType = 'array';
    protected $useSoftDeletes = false;	
	protected $useTimestamps = true;
    protected $createdField  = 'created_at';
    protected $updatedField  = 'updated_at';
    protected $deletedField  = 'deleted_at';
    protected $skipValidation     = false;    
    
	protected $validationRules    = [
//		'name'			=> 'required|string|min_length[2]'
		'coin'			=> 'permit_empty|numeric'
		,'coinfix'		=> 'permit_empty|numeric'
		,'cash'			=> 'permit_empty|regex_match[/(^\d+|^\d+[.]\d+)+$/]'
		,'cashfix'		=> 'permit_empty|regex_match[/(^\d+|^\d+[.]\d+)+$/]'
		,'point'		=> 'permit_empty|numeric'
		,'res'			=> 'permit_empty|numeric'		
	];
	
	public $searchFields = [
								'uid'	=>['title'=>'用户ID']
							//	,'type'	=>['type'=>'select','setting'=>['coin'=>'金币','coinfix'=>'冻结金币','point'=>'贡献值']]
							//	,'status' =>['type'=>'select','setting'=>['1'=>'启用','0'=>'关闭']]
							];
									
	public function getData($sdata=[], $limit=15, $offset=0, $likekey='',$likeval='', $orderkey='',$ordertype=''){	
		$builder = self::__get('db')->table(self::__get('table'));
		$builder->where("deleted_at IS NULL");
		if (!empty($sdata)) $builder->where($sdata);
		if (!empty($likekey) && !empty($likeval)) $builder->like($likekey, $likeval);
		if (!empty($orderkey)) $builder->orderby($orderkey, empty($ordertype) ? 'desc' : $ordertype);
		return $builder->limit($limit, $offset)->select("uid as id,uid,coin,coinfix,point,res,status")->get()->getResultArray();		
	}

	public function count($sdata=[],$likekey='',$likeval='') {
		$builder = self::__get('db')->table(self::__get('table'));
		$builder->where("deleted_at IS NULL");
		if (!empty($sdata)) $builder->where($sdata);
		if (!empty($likekey) && !empty($likeval)) $builder->like($likekey, $likeval);
		return $builder->selectCount(self::__get('primaryKey'))->get()->getRowArray();
    }
    
    // 打开钱包
    public function getPocket($uid){
	    $builder = self::__get('db')->table(self::__get('table'));
		return $builder->where('status',1)->where('uid', $uid)->select('uid,cash,cashfix,coin,coinfix,point,res')->get()->getRowArray(); 	
    }

	// 初始化钱包-现金，积分，金币
	public function setPocket($uid, $data=[]){
	    $builder = self::__get('db')->table(self::__get('table'));
		$pocket = $builder->where('uid', $uid)->get()->getRowArray();
		if (empty($pocket)){
			$data['uid'] = $uid;
			$data['status'] = 1;	// 自动启用钱包功能
			return  ($builder->insert($data)) ? $numb : 0;
		}else{
			return  ($builder->where('uid', $uid)->set($data)->update()) ? true : false;
		}		
	}
	
	// 更新钱包-现金，积分，金币，资源
	public function updatePocket($uid, $data=[]){
		if (empty($data)) return false;
	    $builder = self::__get('db')->table(self::__get('table'));
		$pocket = $builder->where('uid', $uid)->get()->getRowArray();
		if (empty($pocket)){
			$data['uid'] = $uid;
			$data['status'] = 1;	// 自动启用钱包功能
			return  ($builder->insert($data)) ? $data : false;
		}else{
			$udata['cash'] 		= empty($data['cash']) ?  $pocket['cash'] : ($pocket['cash']+$data['cash']);
			$udata['cashfix']	= empty($data['cashfix']) ?  $pocket['cashfix'] : ($pocket['cashfix']+$data['cashfix']);
			$udata['coin'] 		= empty($data['coin']) ?  $pocket['coin'] : ($pocket['coin']+$data['coin']);
			$udata['coinfix']	= empty($data['coinfix']) ?  $pocket['coinfix'] : ($pocket['coinfix']+$data['coinfix']);
			$udata['point'] 	= empty($data['point']) ?  $pocket['point'] : ($pocket['point']+$data['point']);
			$udata['res'] 		= empty($data['res']) ?  $pocket['res'] : ($pocket['res']+$data['res']);
			return  ($builder->where('uid', $uid)->set($udata)->update()) ? $udata : false;
		}
	}	

    // 更新钱包-现金
    public function updateCash($uid, $numb){
	    $builder = self::__get('db')->table(self::__get('table'));
		$pocket = $builder->where('uid', $uid)->get()->getRowArray();
		if (empty($pocket)){
			$data['uid'] = $uid;
			$data['cash'] = $numb;
			$data['status'] = 1;	// 自动启用钱包功能
			return  ($builder->insert($data)) ? $numb : 0;
		}else{
			$curnumb = $pocket['cash']+$numb;
			return  ($builder->where('uid', $uid)->set('cash', $curnumb)->update()) ? $curnumb : $pocket['cash'];
		}
    }

    // 更新钱包-资源
    public function updateRes($uid, $numb){
	    $builder = self::__get('db')->table(self::__get('table'));
		$pocket = $builder->where('uid', $uid)->get()->getRowArray();
		if (empty($pocket)){
			$data['uid'] = $uid;
			$data['res'] = $numb;
			$data['status'] = 1;	// 自动启用钱包功能
			return  ($builder->insert($data)) ? $numb : 0;
		}else{
			$curnumb = $pocket['res']+$numb;
			return  ($builder->where('uid', $uid)->set('res', $curnumb)->update()) ? $curnumb : $pocket['res'];
		}
    }
        
    // 更新钱包-积分
    public function updatePoint($uid, $numb){
	    $builder = self::__get('db')->table(self::__get('table'));
		$pocket = $builder->where('uid', $uid)->get()->getRowArray();
		if (empty($pocket)){
			$data['uid'] = $uid;
			$data['point'] = $numb;
			$data['status'] = 1;	// 自动启用钱包功能
			return  ($builder->insert($data)) ? $numb : 0;
		}else{
			$curnumb = $pocket['point']+$numb;
			return  ($builder->where('uid', $uid)->set('point', $curnumb)->update()) ? $curnumb : $pocket['point'];
		}
    }
    // 更新钱包-金币
    public function updateCoin($uid, $numb){
	    $builder = self::__get('db')->table(self::__get('table'));
		$pocket = $builder->where('uid', $uid)->get()->getRowArray();
		if (empty($pocket)){
			$data['uid'] = $uid;
			$data['coin'] = $numb;
			$data['status'] = 1;	// 自动启用钱包功能
			return  ($builder->insert($data)) ? $numb : 0;
		}else{
			$curnumb = $pocket['coin']+$numb;
			return  ($builder->where('uid', $uid)->set('coin', $curnumb)->update()) ? $curnumb : $pocket['coin'];
		}
    }
    
    // 更新钱包-冻结金币
    public function updateCoinFix($uid, $numb){
	    $builder = self::__get('db')->table(self::__get('table'));
		$pocket = $builder->where('uid', $uid)->get()->getRowArray();
		if (empty($pocket)){
			$data['uid'] = $uid;
			$data['coinfix'] = $numb;
			$data['status'] = 1;	// 自动启用钱包功能
			return  ($builder->insert($data)) ? $numb : 0;
		}else{
			$curnumb = $pocket['coinfix']+$numb;
			return  ($builder->where('uid', $uid)->set('coinfix', $curnumb)->update()) ? $curnumb : $pocket['coinfix'];
		}
    }
    // 更新钱包-金币解冻
    public function cancelCoinFix($uid, $numb){
	    $builder = self::__get('db')->table(self::__get('table'));
		$pocket = $builder->where('uid', $uid)->get()->getRowArray();
		if (empty($pocket)){
			$data['uid'] = $uid;
			$data['coin'] = (empty($pocket['coin']) ? 0 : $pocket['coin'])+$numb;
			$data['coinfix'] = (empty($pocket['coinfix']) ? 0 : $pocket['coinfix'])-$numb;
			$data['status'] = 1;	// 自动启用钱包功能
			return  ($builder->insert($data)) ? $numb : 0;
		}else{
			$curnumb = $pocket['coin']+$numb;
			$fixnumb = $pocket['coinfix']-$numb;
			return  ($builder->where('uid', $uid)->set('coin', $curnumb)->set('coinfix', $fixnumb)->update()) ? ['coin'=>$curnumb,'coinfix'=>$fixnumb] : false;
		}
    }
}