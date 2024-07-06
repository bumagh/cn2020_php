<?php namespace App\Controllers;

class Tools extends \CodeIgniter\Controller
{
    public function __construct(){
    }
    
	public function vcode($numb=0) { 
		$session = service('session');
		$vModel = model('App\Models\VcodeModel');
		echo $vModel->doimg($numb); 
		$code = $vModel->getCode();
		$session->setFlashdata('vcode', $code);
	}
}