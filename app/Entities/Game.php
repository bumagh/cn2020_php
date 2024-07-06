<?php namespace App\Entities;

use CodeIgniter\Entity;

class Game extends Entity{
	
	/**
	* 用户模块升级
	* 最高5级『每一种升级需要同级资源一万，金币100*等级；升级属性每级加成10%，制造需要同级资源一千』
	* @uinfo 用户的当前信息
	* @minfo 用户的当前模块信息
	*/
	public static function setModuleUpgrade($uinfo, $minfo){
		if ($minfo['lvl'] >= 5) {
			$ret['code'] = 0;
			$ret['msg'] = '已经到达最高等级。';
			return $ret;
		}
		
		/*
		$gModel = model('App\Models\GameModulesModel');
		$_t = $gModel->where('id',$minfo['id'])->findColumn('rule');
		var_dump($_t);
		exit;
		*/
		
		// 用户当前模块的升级要求：计算所需要消耗的资源(能晶)+
		$res = pow(10,$minfo['lvl']) * 1000;
		$coin = 100 * $minfo['lvl'];
		
		// 获得用户当前钱包
		$pModel = model('App\Models\PocketModel');
		$pocket = $pModel->getPocket($uinfo['uid']);

		if ($pocket['coin'] < $coin){		
			$ret['code'] = 0;
			$ret['msg'] = '金币不足。';
			return $ret;		
		}

		if ($pocket['res'] < $res) {
			$ret['code'] = 0;
			$ret['msg'] = '资源不足。';
			return $ret;
		}
		
		// 开始处理升级业务
		$data['coin'] 	= -1 * $coin;
		$data['res'] 	= -1 * $res;
		if ($pModel->updatePocket($uinfo['uid'], $data)){
			$cModel = model('App\Models\GameModulesConfModel');
			
			$row = $cModel->where('mid',$minfo['id'])->where('uid',$uinfo['uid'])->get()->getRowArray();
			
			if (!empty($row)){
				if ($cModel->where('mid',$minfo['id'])->where('uid',$uinfo['uid'])->set('lvl','lvl+1',FALSE)->update()){
					$ret['code'] = 1;
					return $ret;
				}			
			}else{
				$row['uid'] = $uinfo['uid'];
				$row['mid'] = $minfo['id'];
				$row['lvl'] = 1;
				if ($cModel->insert($row)){
					$ret['code'] = 1;
					return $ret;
				}
			}
			
		}
		
		$ret['code'] = 0;
		$ret['msg'] = '升级异常';
		return $ret;
		
	}

	/**
	* 用户模块制造
	*/
	
	public static function setModuleMake($uinfo, $minfo){
		// 用户当前模块的复制要求：计算所需要消耗的资源(能晶)+
		$res = pow(10,$minfo['lvl']) * 100;
		
		// 获得用户当前钱包
		$pModel = model('App\Models\PocketModel');
		$pocket = $pModel->getPocket($uinfo['uid']);

		if ($pocket['res'] < $res) {
			$ret['code'] = 0;
			$ret['msg'] = '资源不足。';
			return $ret;
		}
		
		// 消费资源
		if ($pModel->updateRes($uinfo['uid'], -1 * $res)){
			// 开始处理制造业务		
			$umModel = model('App\Models\GameUserModulesModel');
			$data['uid'] 	= $uinfo['uid'];
			$data['mid'] 	= $minfo['id'];
			$data['lvl'] 	= $minfo['lvl'];
			$item = $umModel->where($data)->get()->getRowArray();
			if ($item){
				if ($umModel->where($data)->set('numb','numb+1',FALSE)->update()){
					$ret['code'] = 1;
					return $ret;				
				}
			}else{
				if ($umModel->insert($data)){
					$ret['code'] = 1;
					return $ret;				
				}			
			}
		}
		
		$ret['code'] = 0;
		$ret['msg'] = '制造异常';
		return $ret;
			
	}
}