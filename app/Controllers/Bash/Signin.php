<?php
namespace App\Controllers\Bash;
use App\Controllers\BashController;

class Signin extends BashController{

	protected static $sModel;

	public function __construct(){
		self::$sModel 		= model('App\Models\SignInModel');
	}

	public function setMonthInit(){
		$today = date('Y-m').'-01';
		self::$sModel->where("updated_at<'".$today."'")->set('curmonth',0)->update();
	}
}
