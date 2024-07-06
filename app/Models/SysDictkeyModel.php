<?php namespace App\Models;

use CodeIgniter\Model;

class SysDictkeyModel extends Model
{
    protected $table      = 'sys_dict';
    protected $primaryKey = 'fid';
	protected $allowedFields = ['name','code','type','info', 'setting','force','rule','view','search','edit','sort','tname','adduid','edituid'];
	protected $returnType = 'array';
    protected $useSoftDeletes = false;	
	protected $useTimestamps = true;
    protected $createdField  = 'created_at';
    protected $updatedField  = 'updated_at';
    protected $deletedField  = 'deleted_at';
	protected $validationRules    = [
		'name'		=> 'required|min_length[2]'
		,'tname' 	=> 'required|alpha_dash'
//		,'code'		=> 'required|alpha_dash|is_unique[sys_dict.code]|min_length[3]'
		,'code'		=> 'required|alpha_dash|is_unique2[sys_dict.code,tname,{tname}]|min_length[3]'
		,'type' 	=> 'required|in_list[text,radio,select,checkbox,datetime,date,time,color]'
		,'sort' 	=> 'permit_empty|decimal'
	];
	protected $validationMessages = [
		'code'	=> [
			'is_unique' => '字段编码已被占用,请更改。'
		]
	];
	public $searchFields = [
								'tname' =>['title'=>'表名'
											,'type'=>'select'
											,'setting'=>[
														'member'=>'会员信息模块'
														,'pocket'=>'钱包信息模块'
														,'section'=>'版块信息模块'
														,'sysuser'=>'管理帐号模块'
														,'custom_vote'=>'投票模块'
														,'chat'=>'聊天模块'
														]
											],
								'type' =>['title'=>'字段类型'
											,'type'=>'select'
											,'setting'=>[
														'text'=>'文本框',
														'radio'=>'单选框',
														'select'=>'下拉框',
														'checkbox'=>'复选框',
														'datetime'=>'日期时间',
														'date'=>'日期',
														'time'=>'时间',
														'color'=>'颜色'
														]
											],
								'force' =>['title'=>'必填项'
											,'type'=>'select'
											,'setting'=>['1'=>'强制','0'=>'']
											],
								'rule'	=>['title'=>'验证规则'
											,'type'=>'select'
											,'setting'=>[
														''				=> '不限'
														,'numeric'		=> '纯数字'
														,'valid_url'	=> 'URL地址'
														,'valid_email'	=> '电子邮件'
														,'valid_emails'		=> '电子邮件组'
														,'numeric|min_length[11]|max_length[13]' => '手机号'
														,'valid_cc_number[unionpay]'	=> '信用卡号'
														,'valid_ip[ipv4]'	=> 'IP4地址'
														,'valid_ip[ipv6]'	=> 'IP6地址'
														,'valid_json'		=> 'JSON串'
														]
											],
								'fid'	=>'',
								'name'	=>'',
								'code'	=>'',
								'info'  =>''];	
								
 	public  function getTable($name = ''){
		//$_table = self::__get('searchFields')['tname']['setting'];
		$_table = $this->searchFields['tname']['setting'];
		//$_table = self::$searchFields['tname']['setting'];
		if (empty($name)){
			return $_table;
		}else{
			return (!empty($_table[$name])) ? $_table[$name] : false;
		}
	}
	
	public function getType(){
		return $this->searchFields['type']['setting'];
	}
	
	/**
	* 预留验证字段，以便后期扩充
	*/
	public static function getValidate(){
		return self::$searchFields['rule']['setting'];	
	}

	public function getData($sdata=[], $limit, $offset, $likekey='',$likeval='', $orderkey='',$ordertype=''){	
		$builder = self::__get('db')->table(self::__get('table'));
		$builder->where("deleted_at IS NULL")->select('fid,tname,name,code,type,info,force,rule,view,search,edit,adduid,created_at');
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