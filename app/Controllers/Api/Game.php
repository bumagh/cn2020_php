<?php

namespace App\Controllers\Api;
use App\Controllers\ApiController;

// 游戏
class Game extends ApiController
{

	protected static $gModel;	
	protected static $cModel;
	public function __construct(){
		self::$gModel = model('App\Models\GameModulesModel');
		self::$cModel = model('App\Models\GameModulesConfModel');
	}
	
	public function test(){
		$game = new \App\Entities\Game;		
		$minfo['id'] = 1;
		$minfo['lvl'] = 3;
		$uinfo['uid'] = 60;
		$uinfo['lvl'] = 2;
		$ret = $game->moduleClone($uinfo,$minfo);
		
		print_r($ret);
		exit;
	
		$db	= \Config\Database::connect();
		$g = self::$gModel->table;
		$c = self::$cModel->table;
		
		$sql = "select a.name,a.avatar,b.uid,b.mid,b.lvl from {$g} as a 
				left join (select * from {$c} where uid=111) as b 
				on a.id=b.mid";
		$query = $db->query($sql);
		print_r($query->getResultArray());
		exit;
		
		$builder = $db->table($g);
		$builder->select($g.'.name,'.$g.'.avatar,'.$c.'.id,'.$c.'.mid,'.$c.'.lvl,'.$c.'.uid');
		$builder->join($c, $g.'.id='.$c.'.mid','right');
		$builder->where($g.'.status=1');
		$builder->where($c.'.status=1');
		$builder->where($c.'.uid=111');
		$query = $builder->get();
		print_r($query->getResultArray());
		exit;
	}
	
	// 读取我的模块制造数据
	private function getModulesConf($uid){
		$db	= \Config\Database::connect();
		$g = self::$gModel->table;
		$c = self::$cModel->table;
		$sql = "select a.id,a.name,a.avatar,b.uid,b.mid,b.lvl from {$g} as a 
				left join (select * from {$c} where uid={$uid}) as b
				on a.id=b.mid
				order by a.sort,a.id asc";
		$query = $db->query($sql);
		return 	$query->getResultArray();
	}
	
	// 读取我配置的战斗模块
	private function getEquipModules($uid){
		$db	= \Config\Database::connect();
		$g 		= self::$gModel->table;
		$eModel	=  model('App\Models\GameUserEquipModel');
		$c 		= $eModel->table;
		$sql = "select a.id,a.name,a.avatar,b.uid,b.mid,b.lvl,b.sort from {$g} as a 
				left join (select * from {$c} where uid={$uid}) as b
				on a.id=b.mid
				order by a.sort,a.id asc";
		$query = $db->query($sql);
		return 	$query->getResultArray();	
	}
	
	// 读取我的AI仓库模块
	private function getMyModules($uid){
		$umModel = model('App\Models\GameUserModulesModel');
		return $umModel->where('uid',$uid)->where('numb>0')->select('id,mid,lvl,numb')->orderby('mid','asc')->orderby('lvl','desc')->orderby('numb','desc')->get()->getResultArray();
	}	
	
	private function getPocket($uid){
		// 顺带上钱包
		$pocketModel = model('App\Models\PocketModel');
		return $pocketModel->getPocket($uid);
	}
	
	public function getMyPocket(){
		$pdata = $this->request->getJSON(true);		
		$this->checkLogin();
		$ret['code'] = 1;
		$ret['pocket'] = $this->getPocket($this->loginfo['uid']);
		return retJson($ret);
	}
	
	public function getModulesBase(){
		$pdata = $this->request->getJSON(true);		
		$this->checkLogin();
		$ret['code'] = 1;
		$ret['data'] = $this->getModulesConf($this->loginfo['uid']);
		$ret['pocket'] = $this->getPocket($this->loginfo['uid']);	
		return retJson($ret);
	}
	
	// 我的模块升级
	public function setModuleUpgrade(){
		$pdata = $this->request->getJSON(true);
		$this->checkLogin();
		
		// 处理升级规则 begin:
		$uinfo = $this->loginfo;
				
		$game = new \App\Entities\Game;		
			
			
		// 用户当前的模块信息
		$minfo['id'] = intval($pdata['id']);
		$minfo['lvl'] = isset($pdata['lvl']) ? intval($pdata['lvl']) : 0;

		
		$ret = $game->setModuleUpgrade($uinfo, $minfo);
		if ($ret['code'] == 1){
			$ret['data'] = $this->getModulesConf($uinfo['uid']);
			$ret['pocket'] = $this->getPocket($uinfo['uid']);
			return retJson($ret);			
		}
		return retJson($ret);			
		// end;
		
		$ret['code'] = 0;
		$ret['msg'] = '升级异常';
		return retJson($ret);		
	}
	
	// 我的模块制造
	public function setModuleMake(){
		$pdata = $this->request->getJSON(true);
		$this->checkLogin();
		
		// 处理升级规则 begin:
		$uinfo = $this->loginfo;
//		if ($uinfo['uid'] == $pdata['uid']){
			$game = new \App\Entities\Game;		
			
			// 用户当前的模块信息
			$minfo['id'] = intval($pdata['id']);
			$minfo['lvl'] = isset($pdata['lvl']) ? intval($pdata['lvl']) : 0;
			
			if (empty($minfo['lvl'])){
				$ret['code'] = 0;
				$ret['msg'] = '请升级后再制造';
				return retJson($ret);					
			}
			
			$ret = $game->setModuleMake($uinfo, $minfo);
			if ($ret['code'] == 1){
				$ret['data'] = $this->getMyModules($uinfo['uid']);
				$ret['pocket'] = $this->getPocket($uinfo['uid']);	
				return retJson($ret);			
			}
			return retJson($ret);			
//		}
		// end;
		
		$ret['code'] = 0;
		$ret['msg'] = '升级异常';
		return retJson($ret);		
	}
	
	// 获取所有出售的模块
	public function getSaleModules(){
		$pdata = $this->request->getJSON(true);	
		$this->checkLogin();
		$uinfo = $this->loginfo;
		$saleModel 	= model('App\Models\GameModulesSaleModel');
		
		if (empty($pdata['cateid'])){
			$ret['code'] = 0;
			$ret['msg'] = '参数异常';
			return retJson($ret);
		}
		
		$sdata['mid'] = intval($pdata['cateid']);
		
		$sdata['status'] = 1;
		$page = max(1, empty($pdata['page']) ? 0 : intval($pdata['page']));
		$limit = empty($pdata['limit']) ? 8 : intval($pdata['limit']);
		$count = empty($pdata['count']) ? 0 : intval($pdata['count']);
		$ret['count'] = empty($count) ? $saleModel->count($sdata)['id'] : $count;		
		
		
		//if (!empty($cateid))
		//	$ret['data'] 	= self::$model->whereIn("id", $this->getExtRelids(self::$model, $cateid))->where('status',1)->orderby('sort','asc')->paginate(10);
		//else
		//$ret['data'] 	= $saleModel->where('status',1)->orderby('mid','asc')->orderby('sort','asc')->select('uid,mid,lvl,sort,coin')->paginate(3);	
		
//		$ret['data'] 	= $saleModel->getData($sdata,'uid,mid,lvl,sort,coin',$limit, ($page - 1) * $limit);
		$ret['data'] 	= $saleModel->where($sdata)->select('id,uid,mid,lvl,sort,coin')->orderby('mid','asc')->orderby('lvl','desc')->limit($limit, ($page - 1) * $limit)->get()->getResultArray();
		$ret['page'] = $page;
		$ret['limit'] = $limit;
		$ret['code'] = 1;
		return retJson($ret);
	}
	
	// 购买模块
	public function buyModule(){
		$pdata = $this->request->getJSON(true);
		$this->checkLogin();
		$uinfo = $this->loginfo;
		
		if (empty($pdata['uid']) || empty($pdata['id']) || empty($pdata['mid']) || empty($pdata['lvl']) || empty($pdata['coin'])){
			$ret['code'] = 0;
			$ret['msg'] = '出售参数异常';
			return retJson($ret);
		}
		
		$saleModel 	= model('App\Models\GameModulesSaleModel');
		
		$sdata['id'] = intval($pdata['id']);
		$sdata['uid'] = intval($pdata['uid']);
		$sdata['mid'] = intval($pdata['mid']);
		$sdata['lvl'] = intval($pdata['lvl']);
		$goods = $saleModel->where($sdata)->where('status',1)->get()->getRowArray();
		if (empty($goods)){
			$ret['code'] = 0;
			$ret['msg'] = '该商品信息异常';
			return retJson($ret);				
		}

		$pocketModel = model('App\Models\PocketModel');
		
		$pocket = $pocketModel->getPocket($uinfo['uid']);
		if ($pocket['coin'] < $goods['coin']){
			$ret['code'] = 0;
			$ret['msg'] = '金币不足';
			return retJson($ret);
		}
		
		// 开始扣除购买者金币到出售者 begin:
		$pocketModel->updateCoin($uinfo['uid'], -1*$goods['coin']);				
		$pocketModel->updateCoin($goods['uid'], 1*$goods['coin']);						
		// end;					
	
		// 从购买者的仓库模块中累加 begin:
		$umModel = model('App\Models\GameUserModulesModel');
		$row = $umModel->where('uid',$uinfo['uid'])->where('mid', $goods['mid'])->where('lvl',$goods['lvl'])->findColumn('numb');
		if (empty($row)){
			$umModel->insert(['uid'=>$uinfo['uid'],'mid'=>$goods['mid'],'lvl'=>$goods['lvl'],'numb'=>1]);
		}else{
			$umModel->where('uid',$uinfo['uid'])->where('mid', $goods['mid'])->where('lvl',$goods['lvl'])->set('numb','numb+1',FALSE)->update();
		}
		// end;
		
		$saleModel->where($sdata)->where('status',1)->delete();
		
		
		$ret['code'] = 1;
		$ret['data'] = $this->getMyModules($uinfo['uid']);
		return retJson($ret);		
	}

	// 回收模块
	public function buyReturnModule(){
		$pdata = $this->request->getJSON(true);
		$this->checkLogin();
		$uinfo = $this->loginfo;
		
		if (empty($pdata['id']) || empty($pdata['mid']) || empty($pdata['lvl'])){
			$ret['code'] = 0;
			$ret['msg'] = '回收参数异常';
			return retJson($ret);
		}
		
		$umModel 	= model('App\Models\GameUserModulesModel');
		
		$sdata['id'] = intval($pdata['id']);
		$sdata['mid'] = intval($pdata['mid']);
		$sdata['lvl'] = intval($pdata['lvl']);
		$sdata['uid'] = $uinfo['uid'];
		$goods = $umModel->where($sdata)->get()->getRowArray();
		if (empty($goods)){
			$ret['code'] = 0;
			$ret['msg'] = '该模块信息异常';
			return retJson($ret);				
		}

		// 退回95%资源 begin:
		$pocketModel = model('App\Models\PocketModel');
		$pocket = $pocketModel->getPocket($uinfo['uid']);
		$pocketModel->updateRes($uinfo['uid'], (pow(10,$goods['lvl']) * 1000) * 0.95);
		// end;
		
		/*
		// 从购买者的仓库模块中累加 begin:
		$umModel = model('App\Models\GameUserModulesModel');
		$row = $umModel->where('uid',$uinfo['uid'])->where('mid', $goods['mid'])->where('lvl',$goods['lvl'])->findColumn('numb');
		if (empty($row)){
			$umModel->insert(['uid'=>$uinfo['uid'],'mid'=>$goods['mid'],'lvl'=>$goods['lvl'],'numb'=>1]);
		}else{
			$umModel->where('uid',$uinfo['uid'])->where('mid', $goods['mid'])->where('lvl',$goods['lvl'])->set('numb','numb+1',FALSE)->update();
		}
		// end;
		*/
		
		$umModel->where($sdata)->set('numb','numb-1',FALSE)->update();
		
		$ret['code'] = 1;
		$ret['data'] = $this->getMyModules($uinfo['uid']);
		return retJson($ret);		
	}	
		
	// 回购模块
	public function buyBackModule(){
		$pdata = $this->request->getJSON(true);
		$this->checkLogin();
		$uinfo = $this->loginfo;
		
		if (($pdata['uid'] != $uinfo['uid']) || empty($pdata['id']) || empty($pdata['mid']) || empty($pdata['lvl']) || empty($pdata['coin'])){
			$ret['code'] = 0;
			$ret['msg'] = '回参数异常';
			return retJson($ret);
		}
		
		$saleModel 	= model('App\Models\GameModulesSaleModel');
		
		$sdata['id'] = intval($pdata['id']);
		$sdata['mid'] = intval($pdata['mid']);
		$sdata['lvl'] = intval($pdata['lvl']);
		$sdata['uid'] = $uinfo['uid'];
		$goods = $saleModel->where($sdata)->where('status',1)->get()->getRowArray();
		if (empty($goods)){
			$ret['code'] = 0;
			$ret['msg'] = '该模块信息异常';
			return retJson($ret);				
		}

		/*
		$pocketModel = model('App\Models\PocketModel');
		$pocket = $pocketModel->getPocket($uinfo['uid']);
		$pocketModel->updateRes($uinfo['uid'], pow(10,$goods['lvl']) * 1000);
		*/
		
		// 从购买者的仓库模块中累加 begin:
		$umModel = model('App\Models\GameUserModulesModel');
		$row = $umModel->where('uid',$uinfo['uid'])->where('mid', $goods['mid'])->where('lvl',$goods['lvl'])->findColumn('numb');
		if (empty($row)){
			$umModel->insert(['uid'=>$uinfo['uid'],'mid'=>$goods['mid'],'lvl'=>$goods['lvl'],'numb'=>1]);
		}else{
			$umModel->where('uid',$uinfo['uid'])->where('mid', $goods['mid'])->where('lvl',$goods['lvl'])->set('numb','numb+1',FALSE)->update();
		}
		// end;
		
		$saleModel->where($sdata)->where('status',1)->delete();
		
		$ret['code'] = 1;
		$ret['data'] = $this->getMyModules($uinfo['uid']);
		return retJson($ret);		
	}	
	// 我的模块出售
	public function setModuleSale(){
		$pdata = $this->request->getJSON(true);
		
		if (empty($pdata['mid']) || empty($pdata['lvl']) || empty($pdata['coin'])){
			$ret['code'] = 0;
			$ret['msg'] = '出售参数异常';
			return retJson($ret);
		}
		
		$coin = intval($pdata['coin']);
		if  (($coin < 1) || ($coin > 99999999)) {
			$ret['code'] = 0;
			$ret['msg'] = '金币设置异常';
			return retJson($ret);		
		}
		
		$this->checkLogin();
		$uinfo = $this->loginfo;
		
		$umModel 	= model('App\Models\GameUserModulesModel');
		$saleModel 	= model('App\Models\GameModulesSaleModel');
		
		$sdata['uid'] = $uinfo['uid'];
		$sdata['mid'] = intval($pdata['mid']);
		$sdata['lvl'] = intval($pdata['lvl']);
		$row = $umModel->where($sdata)->select('mid,lvl,numb')->get()->getRowArray();
		if (empty($row) || ($row['numb'] < 1)){
			$ret['code'] = 0;
			$ret['msg'] = '不存在该模块';
			return retJson($ret);
		}

		$row['uid'] = $uinfo['uid'];
		$row['coin'] = $coin;
		
		if ($saleModel->insert($row)){
			if ($umModel->where($sdata)->set('numb','numb-1',FALSE)->update()){
				$ret['code'] = 1;
				$ret['data'] = $this->getMyModules($uinfo['uid']);
				return retJson($ret);			
			}
		}
		
		$ret['code'] = 0;
		$ret['msg'] = '出售异常';
		return retJson($ret);		
	}
	
	// 获取我已配置的装备
	public function getEquip(){
		$pdata = $this->request->getJSON(true);
		$this->checkLogin();
		$uinfo = $this->loginfo;
		$_d = $this->getEquipModules($uinfo['uid']);
		if (!empty($_d)){
			$ret['data'] = array_column($_d, NULL, 'sort');			
		}else{
			$ret['data'] = [];		
		}
		
		$ret['code'] = 1;
		return retJson($ret);
	}
	
	// 配置我的战斗装备
	public function setEquip(){
		$pdata = $this->request->getJSON(true);
		if (!isset($pdata['sort']) || empty($pdata['obj'])) {
			$ret['code'] = 0;
			$ret['msg'] = '参数异常';
			return retJson($ret);		
		}
		$this->checkLogin();
		$uinfo = $this->loginfo;
		$ueModel = model('App\Models\GameUserEquipModel');
		$umModel = model('App\Models\GameUserModulesModel');		
		
		$data['uid'] = $uinfo['uid'];
		$data['mid'] = intval($pdata['obj']['mid']);
		$data['lvl'] = intval($pdata['obj']['lvl']);
		
		// 从我的仓库模块中减掉 begin:
		$row = $umModel->where($data)->findColumn('numb');
		if (empty($row) || ($row[0] < 1)) {
			$ret['code'] = 0;
			$ret['msg'] = '该模块不存在';
			return retJson($ret);
		}else{
			$umModel->where($data)->set('numb','numb-1',FALSE)->update();
		}
		// end;
		
		// 配置到我的AI战斗配置中
		$data['sort'] = intval($pdata['sort']);
		$row = $ueModel->where('uid',$data['uid'])->where('sort', $data['sort'])->select('uid,mid,lvl')->get()->getRowArray();
		// 如果该位置上之前已经配置过了，则把原先配置的模块移到仓库中
		if (!empty($row)){
			$row2 = $umModel->where($row)->findColumn('numb');
			if (empty($row2)) {
				$umModel->insert($row);
			}else{
				$umModel->where($row)->set('numb','numb+1',FALSE)->update();
			}
			$ret['code'] = 1;			
			// 返回我已配置的装备			
			$_d = $this->getEquipModules($uinfo['uid']);
			$ret['equip'] = (!empty($_d)) ? array_column($_d, NULL, 'sort') : [];
			$ret['modules'] = $this->getMyModules($uinfo['uid']);
			return retJson($ret);			
		}else{
			if ($ueModel->insert($data)){
				$ret['code'] = 1;
				// 返回我已配置的装备			
				$_d = $this->getEquipModules($uinfo['uid']);
				$ret['equip'] = (!empty($_d)) ? array_column($_d, NULL, 'sort') : [];
				$ret['modules'] = $this->getMyModules($uinfo['uid']);
				return retJson($ret);		
			}
		}
		
		$ret['code'] = 0;
		$ret['msg'] = '配置异常';
		return retJson($ret);
	}
	
	// 取消我的战斗装备
	public function delEquip(){
		$pdata = $this->request->getJSON(true);
		if (!isset($pdata['sort']) || empty($pdata['obj'])) {
			$ret['code'] = 0;
			$ret['msg'] = '参数异常';
			return retJson($ret);		
		}
		$this->checkLogin();
		$uinfo = $this->loginfo;
		$ueModel = model('App\Models\GameUserEquipModel');
		$umModel = model('App\Models\GameUserModulesModel');		
		
		$data['uid'] = $uinfo['uid'];
		$data['sort'] = intval($pdata['sort']);
		$sdata = $ueModel->where($data)->select('uid,mid,lvl')->get()->getRowArray();
		if (empty($sdata)){
			$ret['code'] = 0;
			$ret['msg'] = '该模块不存在';
			return retJson($ret);
		}
		
		$ueModel->where($data)->delete();
		
		$row = $umModel->where($sdata)->select('uid,mid,lvl')->get()->getRowArray();
		if (!empty($row)){
			$umModel->where($sdata)->set('numb','numb+1',FALSE)->update();
		}else{
			$umModel->insert($row);
		}
		
		$ret['code'] = 1;
		// 返回我已配置的装备			
		$_d = $this->getEquipModules($uinfo['uid']);
		$ret['equip'] = (!empty($_d)) ? array_column($_d, NULL, 'sort') : [];
		$ret['modules'] = $this->getMyModules($uinfo['uid']);
		return retJson($ret);
	}
}
