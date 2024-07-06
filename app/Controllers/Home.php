<?php

namespace App\Controllers;
use App\Controllers\WebController;

class Home extends WebController
{
    public function index()
    {
		echo  "这是在首页Home：";
    	return  redirect()->to('/h5');
    }
}
