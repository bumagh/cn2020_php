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
	
	// 设置配置
//	eybase[module].order.key = 'sort';
//	eybase[module].order.type = 'asc';
	var _obj = eybase.setTableOpt(module, tag);
	// 处理返回的数据
	_obj.parseData = function(res){ //res 即为原始返回的数据
		var _d = new Array();
		if (res.code == '1'){
			if (res.data.length>0){
				var i = 0;
				var _username = {};
				for (var k in res.data){
					_d[i] = {};
					_d[i] = res.data[k];
					_d[i].type = (_d[i].image != '') ? 1 : 0;
					if (!!res.ext[_d[i].id]){
						for (var _k in res.ext[_d[i].id]){
							_d[i][_k] = res.ext[_d[i].id][_k].value;
						}
					}
					i++;
				}
			}
		}else if (res.code == '0'){
			//layer.alert(res.msg);
		}
		return {"code": (res.code == '1') ? 0 : 1,"msg": res.msg,"count": res.count,"data": _d};
	}
	// 渲染处理过的数据
	_obj.cols = [[ //表头
		<?= empty($init['actions']['checkall']) ? "" :  "{type: 'checkbox'}," ?>		
		{field: 'name', title: '版块名称', width:150,sort:true}		
		,{field: 'desc', title: '文字描述',sort:true}
		,{field: 'thumb', title: '预览', width:120,templet: "#image-thumb-tpl"}
		
		,{field: 'tourl', title: '目标链接',sort:true,templet:function(d){
				return (d.tourl != '') ? ('<a href="'+d.tourl+'" target="_blank">'+d.tourl+'</a>') : '无';
			}
		}
		/*
		,{field: 'bdate', title: '开始日期', width:120,sort:true
			,templet:function(d){
				return (d.bdate == '') ? '不限' : d.bdate;
			}
		}
		,{field: 'edate', title: '结束日期', width:120,sort:true
			,templet:function(d){
				return (d.edate == '') ? '不限' : d.edate;
			}		
		}
		*/
		,{field: 'sort', title: '排序', width:100,sort:true}
		<?php foreach ($init['extfields'] as $k => $v) { ?>
		,{field: '<?=$k?>', title: '<?=$v['title']?>'}			
		<?php } ?>
		,{field: 'status', title: EY_Base.lang.status, width:100,sort:true, templet:function(d){
			return (d.status == '1') ? '<font class="layui-font-blue">已启用</font>' : '<font class="layui-font-orange">关闭</font>';
		}}
		,{field: 'act', title: EY_Base.lang.act, width:130, fixed: 'right',templet: "#tableTools-"+module}
	]];	
	eybase[module].tableIns = table.render(_obj);
});
</script>