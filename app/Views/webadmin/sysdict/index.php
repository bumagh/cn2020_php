<?=$this->include('\App\Views\webadmin\comm\indextable') ?>
<script>
layui.use(['table','laytpl','form','eybase'], function(){
	var table = layui.table
//	,util = layui.util 
	,form = layui.form
	,eybase = layui.eybase
	,table = layui.table	
	,$ = layui.jquery;	
	var tag = '<?=$init['tag']?>';
	var module = '<?=$init['module']?>';
	// 初始化模块常量
	eybase[module] = {};
	eybase[module] =  <?=json_encode($init)?>;
	console.log("eybase[module]=>",eybase[module]);
	var _obj = eybase.setTableOpt(module, tag);
	_obj.parseData = function(res){ 
			var _d = new Array();
			if (res.code == '1'){
				var _tname = (!$.isEmptyObject(eybase[module].fullfields.tname.setting)) ? JSON.parse(eybase[module].fullfields.tname.setting) : {};
				var _type = (!$.isEmptyObject(eybase[module].fullfields.type.setting)) ? JSON.parse(eybase[module].fullfields.type.setting) : {};
				
				// 因下标在JS下无法兼容，所以通过服务端直接赋值的方式来做特殊处理
				//var _rule = (!$.isEmptyObject(eybase[module].fullfields.rule.setting)) ? JSON.parse(eybase[module].fullfields.rule.setting) : {};
				<?php $_rule = json_decode($init['fullfields']['rule']['setting'],true) ?>
				var _rulekey = ['<?=implode('\',\'',array_keys($_rule))?>'];
				var _ruleval = ['<?=implode('\',\'',array_values($_rule))?>'];
				
				var i = 0;
				for (var k in res.data){
					_d[i] = {};
					_d[i] = res.data[k];
					_d[i].id = res.data[k].fid;
					_d[i].tname =  (!!_tname[res.data[k].tname]) ? _tname[res.data[k].tname] : '';
					_d[i].type =  (!!_type[res.data[k].type]) ? _type[res.data[k].type] : '';
					_d[i].rule =  _ruleval[_rulekey.indexOf(res.data[k].rule)];
					_d[i].force = (res.data[k].force == '1') ? '是' : '';
					_d[i].view = (res.data[k].view == '1') ? '是' : '<font class="layui-font-orange">否</font>';					
					_d[i].search = (res.data[k].search == '1') ? '是' : '<font class="layui-font-orange">否</font>';
					_d[i].edit = (res.data[k].edit == '1') ? '是' : '<font class="layui-font-orange">否</font>';
					i++;
				}
			}

			return {
				"code": (res.code == '1') ? 0 : 1,
				"msg": res.msg,
				"count": res.count,
				"data": _d
			};
		}
	_obj.cols = [[ //表头
			<?= empty($init['actions']['checkall']) ? "" :  "{type: 'checkbox'}," ?>
			{field: 'fid', title:'ID', width:60, sort: true,hide:true}
			,{field: 'tname', title: EY_Base.lang.tname, width:120,sort:true}
			,{field: 'name', title: EY_Base.lang.name, width:120}
			,{field: 'code', title: EY_Base.lang.code, width:120, sort: true}
			,{field: 'type', title: EY_Base.lang.type, width:120, sort: true}
			,{field: 'force', title: EY_Base.lang.force, width:80}
			,{field: 'view', title: '可查看', width:80}			
			,{field: 'search', title: '可搜索', width:80}
			,{field: 'edit', title: '可编辑', width:80}
			,{field: 'rule', title: EY_Base.lang.rule, width:120, sort: true}
			,{field: 'info', title: EY_Base.lang.info, width:180, hide:true}
			,{field: 'created_at', title: EY_Base.lang.created_at, width:170, sort: true}
			,{field: 'updated_at', title: EY_Base.lang.updated_at, width:170, sort: true,hide:true}
			,{field: 'act', title: EY_Base.lang.act, width: 100, fixed: 'right',templet: "#tableTools-"+module}
		]]
	eybase[module].tableIns = table.render(_obj);	
});
</script>