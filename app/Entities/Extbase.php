<?php namespace App\Entities;

use CodeIgniter\Entity;

class Extbase extends Entity
{
	/**
	* 根据relid获取渲染相关字段
	* @ $data [$tname, $relid];
	*/
	public static function getRenderFields($data){
		$str = '';
		if (empty($data['tname'])) return $str;
		
		$kModel = model('App\Models\SysDictkeyModel');		
		$fields = $kModel->where('tname', $data['tname'])->orderBy('sort','asc')->findAll();
		if (!empty($fields)){	
			//$str = '<fieldset class="layui-elem-field layui-field-title"> <legend>扩展信息</legend></fieldset>';	
			$values = [];
			if (!empty($data['relid'])){
				$vModel = model('App\Models\SysDictvalModel');
				$vModel->setTname($data['tname']);
				$_fids = array_column($fields, 'fid');
				
				$_values = $vModel->whereIn('fid', $_fids)->where('relid', $data['relid'])->findAll();
				$values = array_column($_values, 'val','fid');
			}
			
			foreach($fields as $k => $v){
				if (empty($v['edit'])) continue;
				$_title = '<label class="layui-form-label">'.(!empty($v['force']) ? '<font class="layui-font-red"> * </font>' : '').$v['name'].'</label>';				
				if ($v['type'] == 'text'){				
					$str .= '<div class="layui-form-item">'.$_title;
					$str .= '<div class="layui-input-inline"><input '. (!empty($v['force']) ? 'lay-verify="required"' : '') . ' value="'.(isset($values[$v['fid']]) ? $values[$v['fid']] : '').'" type="text" name="ext['.$v['type'].']['.$v['code'].']" placeholder="请输入'.$v['name'].'" autocomplete="off" ey-event="onChange" class="layui-input"></div>';
					$str .= '<div class="layui-form-mid layui-word-aux">'.$v['info'].'</div></div>';
				}else if ($v['type'] == 'radio'){
					$str .= '<div class="layui-form-item">'.$_title;
     				$str .= '<div class="layui-input-inline">';
					$_set = empty($v['setting']) ? '' : json_decode($v['setting']);
					if ($_set){
						$selectv = isset($values[$v['fid']]) ? $values[$v['fid']] : '';
						if (is_object($_set)){							
							foreach($_set as $_k => $_v){	
								$str .= ' <input type="radio" '. (!empty($v['force']) ? 'lay-verify="required"' : '') . '  name="ext['.$v['type'].']['.$v['code'].']" value="'.$_k.'" title="'.$_v.'"' . (($_k == $selectv) ? "checked" : '') . '>';
							}
						}else{
							foreach($_set as $_k => $_v){	
								$str .= ' <input type="radio" '. (!empty($v['force']) ? 'lay-verify="required"' : '') . '  name="ext['.$v['type'].']['.$v['code'].']" value="'.$_v.'" title="'.$_v.'"' . (($_v == $selectv) ? "checked" : '') . '>';
							}						
						}						
					}
					$str .= '</div></div>';				
				}else if ($v['type'] == 'select'){
					$str .= '<div class="layui-form-item">'.$_title;
     				$str .= '<div class="layui-input-inline"><select  '. (!empty($v['force']) ? 'lay-verify="required"' : '') . ' name="ext['.$v['type'].']['.$v['code'].']"><option value="">请选择'.$v['name'].'</option>';
//					$_set = empty($v['setting']) ? '' : json_decode($v['setting'], true);
					$_set = empty($v['setting']) ? '' : json_decode($v['setting']);					
					if ($_set){
						$selectv = isset($values[$v['fid']]) ? $values[$v['fid']] : '';					
						if (is_object($_set)){							
							foreach($_set as $_k => $_v){							
								$str .= '<option value="'.$_k.'" ' . (($_k == $selectv) ? "selected" : '') . '>'.$_v.'</option>';
							}						
						}else{
							foreach($_set as $_k => $_v){							
								$str .= '<option value="'.$_v.'" ' . (($_v == $selectv) ? "selected" : '') . '>'.$_v.'</option>';
							}
						}
					}
					$str .= '</select></div><div class="layui-form-mid layui-word-aux">'.$v['info'].'</div></div>';
				}else if ($v['type'] == 'checkbox'){
					$str .= '<div class="layui-form-item">'.$_title;
     				$str .= '<div class="layui-input-inline">';
					$_set = empty($v['setting']) ? '' : json_decode($v['setting']);
					if ($_set){
						$selectv = (!empty($values[$v['fid']])) ? explode(',', $values[$v['fid']]) : [];
						if (is_object($_set)){
							foreach($_set as $_k => $_v){							
								$str .= ' <input type="checkbox" '. (!empty($v['force']) ? 'required lay-verify="required"' : '') . ' name="ext['.$v['type'].']['.$v['code'].'][]" value="'.$_k.'" title="'.$_v.'" lay-skin="primary" '.(in_array($_k, $selectv) ? "checked" : '').'>';
							}
						}else{
							foreach($_set as $_k => $_v){							
								$str .= ' <input type="checkbox" '. (!empty($v['force']) ? 'required lay-verify="required"' : '') . ' name="ext['.$v['type'].']['.$v['code'].'][]" value="'.$_v.'" title="'.$_v.'" lay-skin="primary" '.(in_array($_v, $selectv) ? "checked" : '').'>';
							}
						}
					}
					$str .= '</div></div>';
				}else if ($v['type'] == 'datetime'){				
					$str .= '<div class="layui-form-item">'.$_title;
					$str .= '<div class="layui-input-inline"><input  '. (!empty($v['force']) ? 'lay-verify="required"' : '') . ' type="text" value="'.(!empty($values[$v['fid']]) ? date('Y-m-d H:i:s',intval($values[$v['fid']])) : '').'" lay-type="'.$v['type'].'" name="ext['.$v['type'].']['.$v['code'].']" placeholder="请选择日期时间" autocomplete="off" class="layui-input"></div><div class="layui-form-mid layui-word-aux">'.$v['info'].'</div></div>';	  
				}else if ($v['type'] == 'date'){				
					$str .= '<div class="layui-form-item">'.$_title;
					$str .= '<div class="layui-input-inline"><input '. (!empty($v['force']) ? 'lay-verify="required"' : '') . '  type="text" value="'.(!empty($values[$v['fid']]) ? date('Y-m-d', intval($values[$v['fid']])) : '').'" lay-type="'.$v['type'].'" name="ext['.$v['type'].']['.$v['code'].']" placeholder="请选择日期" autocomplete="off" class="layui-input"></div><div class="layui-form-mid layui-word-aux">'.$v['info'].'</div></div>';	  
				}else if ($v['type'] == 'time'){				
					$str .= '<div class="layui-form-item">'.$_title;
					$str .= '<div class="layui-input-inline"><input '. (!empty($v['force']) ? 'lay-verify="required"' : '') . '  type="text" value="'.(isset($values[$v['fid']]) ? $values[$v['fid']] : '').'" lay-type="'.$v['type'].'" name="ext['.$v['type'].']['.$v['code'].']" placeholder="请选择时间" autocomplete="off" class="layui-input"></div><div class="layui-form-mid layui-word-aux">'.$v['info'].'</div></div>';	  
				}else if ($v['type'] == 'color'){
					$str .= '<div class="layui-form-item">'.$_title;
					$str .= '<div class="layui-input-inline"><input  '. (!empty($v['force']) ? 'lay-verify="required"' : '') . ' type="text" value="'.(isset($values[$v['fid']]) ? $values[$v['fid']] : '').'"  lay-type="'.$v['type'].'" name="ext['.$v['type'].']['.$v['code'].']" placeholder="请选择颜色" class="layui-input" style="float:right;width:230px;"><div lay-type="'.$v['type'].'"></div></div>';
					$str .= '<div class="layui-form-mid layui-word-aux">'.$v['info'].'</div></div>';				
				}							
			}
		}
		
		return $str;
		
	}
	
	public static function getExtFields($tname){
		$kModel = model('App\Models\SysDictkeyModel');		
		$fields = $kModel->where('tname', $tname)->orderBy('sort','asc')->findAll();
		$res = [];
		if (!empty($fields)){	
			foreach ($fields as $k => $v){
				$res[$v['code']] = ['fid'=>$v['fid'],'title'=>$v['name'], 'setting'=>$v['setting'],'type'=>$v['type'],'search'=>$v['search']];
			}
		}
		return $res;
	}
	
	public static function searchCount($table, $sdata=[], $likeval=''){	
			$vModel = model('App\Models\SysDictvalModel');
			$vModel->setTname($table);
			$builder = $vModel->__get('db')->table($vModel->__get('table'));
			if (!empty($sdata))		$builder->where($sdata);
			if (!empty($likeval))	$builder->like('val', $likeval);
			return $builder->selectCount("relid")->get()->getRowArray();
	}
		
	public static function searchValue($table, $sdata=[], $limit, $offset, $likeval='', $orderkey='',$ordertype=''){	
			$vModel = model('App\Models\SysDictvalModel');
			$vModel->setTname($table);
			$builder = $vModel->__get('db')->table($vModel->__get('table'));			
			$builder->select('fid,relid,val');
			if (!empty($sdata))		$builder->where($sdata);
			if (!empty($likeval))	$builder->like('val', $likeval);

			//if ($orderkey == 'uid') 
			//	$builder->orderby('relid', empty($ordertype) ? 'desc' : $ordertype);
			//else 
				$builder->orderby('val', empty($ordertype) ? 'desc' : $ordertype);

			return $builder->limit($limit, $offset)->get()->getResultArray();			
	}
	
	public static function getExtValue($table, $relid){
		$vdata = [];
		$kModel = model('App\Models\SysDictkeyModel');	
		$fields = $kModel->where('tname', $table)->orderBy('sort','asc')->findAll();
		if (!empty($fields)){	
			$fids = $code = [];
			foreach ($fields as $k => $v){
//				$f[$v['code']] = ['title'=>$v['name'], 'value'=>'','setting'=>$v['setting'],'type'=>$v['type']];
				$f[$v['code']] = ['type'=>$v['type']];
				$fids[] = $v['fid'];
				$code[$v['fid']] = $v['code'];
				$set[$v['code']] = $v['setting'];
			}

			$relid = is_array($relid) ? $relid : (array)$relid;
			$vdata = array_fill_keys($relid, $f);
			/*
			$vModel = model('App\Models\SysDictvalModel');
			$vModel->setTname($table);
			$_res = $vModel->whereIn('fid', $fids)->whereIn('relid', $relid)->findAll();
			*/
			$builder = $kModel->__get('db')->table($table."_ext");			
			$_res = $builder->whereIn('fid', $fids)->whereIn('relid', $relid)->get()->getResultArray();					
			
			
			foreach ($_res as $k => $v){
				$v['key'] = $v['val'];
				if ($f[$code[$v['fid']]]['type'] == 'date') {
					$v['val'] = (!empty($v['val'])) ? date("Y-m-d", intval($v['val'])) : '';
				}elseif ($f[$code[$v['fid']]]['type'] == 'datetime'){
					$v['val'] = (!empty($v['val'])) ? date("Y-m-d H:i:s", intval($v['val'])) : '';				
				}elseif ($f[$code[$v['fid']]]['type'] == 'color'){
					$v['val'] = '<span style="background-color:'.$v['val'].'">'.$v['val'].'</span>';
				}elseif (($f[$code[$v['fid']]]['type'] == 'radio') || ($f[$code[$v['fid']]]['type'] == 'select')){
					if (isset($v['val']) && !empty($set[$code[$v['fid']]])){
						$_v = json_decode($set[$code[$v['fid']]]);

						if (is_object($_v)){
							$v['val'] = isset($_v->{$v['val']}) ? $_v->{$v['val']} : '';
						}

					}
				}elseif ($f[$code[$v['fid']]]['type'] == 'checkbox'){
					if (isset($v['val']) && !empty($set[$code[$v['fid']]])){						
						$_v = json_decode($set[$code[$v['fid']]], true);
						if (strpos($v['val'],',')){
							$_t = explode(',',$v['val']);
							$_s = $_k = '';

							foreach ($_t as $k2 => $v2){
								$_s .= (isset($_v[$v2]) ? $_v[$v2] : '') . ',';
								$_k .= $v2 . ',';
							}
							$v['val'] = rtrim($_s,',');
							$v['key'] = rtrim($_k,',');
						}else{
							$v['val'] = isset($_v[$v['val']]) ? ($_v[$v['val']].' ') : '';
						}
						//if (is_object($_v)){
							//$v['val'] = isset($_v->{$v['val']}) ? $_v->{$v['val']} : '';
						//}
					}				
				}
				$vdata[$v['relid']][$code[$v['fid']]]['value'] = $v['val'];
				$vdata[$v['relid']][$code[$v['fid']]]['key'] = isset($v['key']) ? $v['key'] : '';
			}
		}
    	return $vdata;			
	}
	
	
	public static function setExtValue($table, $relid, $extdata, $actid=''){
		$kModel = model('App\Models\SysDictkeyModel');	
		$fields = $kModel->where('tname', $table)->findAll();		
		if (!empty($fields)){
			$data = [];
			$type = $kModel->getType();
			foreach ($type as $k => $v){
				if (!empty($extdata[$k])){
					foreach($extdata[$k] as $_k => $_v){
							if (($k == 'date') || ($k == 'datetime')){
								$_v = (!empty($_v)) ? strtotime($_v) : '';
							}else if($k == 'checkbox'){
								$_v = implode(",", $_v);
							}else{
								$_v = filter_var($_v, FILTER_SANITIZE_STRING);
							}
							$data[$_k] = $_v;
						
					}
				}
			}
			
			$vdata = [];
			$vModel = model('App\Models\SysDictvalModel');
			$vModel->setTname($table);			
			$extval = $vModel->where('relid', $relid)->findColumn('fid');
			if ($extval){	// 已有扩展数据，则更新扩展数，可能新增，可能更新
				foreach ($fields as $k => $v){
					if (isset($data[$v['code']])){
						if (in_array($v['fid'], $extval)) {
							$vModel->where('relid', $relid)->where('fid', $v['fid'])->set(['val'=>$data[$v['code']],'edituid'=>$actid])->update();
						}else{
							$vModel->insert(['relid'=>$relid,'fid'=>$v['fid'],'val'=>$data[$v['code']],'adduid'=>$actid]);
						}
					}
				}
				return true;
			}else{
				foreach ($fields as $k => $v){
					if (isset($data[$v['code']])){
						array_push($vdata,['relid'=>$relid,'fid'=>$v['fid'],'val'=>$data[$v['code']],'adduid'=>$actid]);					
					}
				}							
				if ($vdata){
					 $vModel->insertBatch($vdata);
					 return $vdata;
				}
			}
		}
		return false;
    }
    
    public static function delExtValue($table, $relid){
		$kModel = model('App\Models\SysDictkeyModel');	
		$fields = $kModel->where('tname', $table)->findColumn('fid');		
		if (!empty($fields)){
			$vModel = model('App\Models\SysDictvalModel');
			$vModel->setTname($table);
			if (is_array($relid))
				return $vModel->whereIn('fid', $fields)->whereIn('relid', $relid)->delete();
			else
				return $vModel->whereIn('fid', $fields)->where('relid', $relid)->delete();
		}
    	return false;
    }
    
    /**
    * 设置验证规则，验证信息
    */
    public function setRulesExt($m, $post){
  		$res = [];
		$kModel = model('App\Models\SysDictkeyModel');
		$res['rules'] = $m->getValidationRules();
		
		/*
		$m->setValidationMessages([
			'ext[checkbox][tag]'        => [
				'required' => 'Sorry. That email has already been taken. Please choose another.'
			]
		]);
		*/
		
		$tname = $m->__get('table');
		$_rules = $kModel->where('tname', $m->__get('table'))
						->select('name,type,force,code,rule')
						->get()->getResultArray();
		if (!empty($_rules)){
			foreach ($_rules as $k => $v){
				$res['rules']['ext['.$v['type'].']['.$v['code'].']'] = rtrim((empty($v['force']) ? 'permit_empty|' : 'required|') . (empty($v['rule']) ? '' : $v['rule']),'|');
				//$res['messages']['ext['.$v['type'].']['.$v['code'].']'] = ['name'=>$v['name'],'message'=>['required'=>'请检查该字段的正确性']];
				$res['post']['ext['.$v['type'].']['.$v['code'].']'] = empty($post[$v['type']][$v['code']]) ? null : $post[$v['type']][$v['code']];
			}
		}
		return $res;
    }
}