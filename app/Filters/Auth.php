<?php namespace App\Filters;

use CodeIgniter\HTTP\RequestInterface;
use CodeIgniter\HTTP\ResponseInterface;
use CodeIgniter\Filters\FilterInterface;
//use Config\Services;

class Auth implements FilterInterface
{

	public function before(RequestInterface $request, $arguments = null)
	{
	}

	public function after(RequestInterface $request, ResponseInterface $response, $arguments = null){
	}
	
	
	private static function hasLogin(){
		return (!empty($_SESSION['member'])) ? $_SESSION['member'] : false;
	}
}