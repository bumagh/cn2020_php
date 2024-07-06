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
	// 设置配置
	var _obj = eybase.setTableOpt(module, tag);
	// 处理返回的数据
	_obj.parseData = function(res){ //res 即为原始返回的数据
		var _d = new Array();
		if (res.code == '1'){
			if (res.data.length>0){
				var i = 0;
				var _module = !!eybase[module].fullfields.module.setting ? JSON.parse(eybase[module].fullfields.module.setting) : {};				
				var _type = !!eybase[module].fullfields.type.setting ? JSON.parse(eybase[module].fullfields.type.setting) : {};				
				for (var k in res.data){
					_d[i] = {};
					_d[i] = res.data[k];
					_d[i].typename = _type[res.data[k].type];
					_d[i].module = _module[res.data[k].module];
					_d[i].filesize = eybase.formatSize(parseInt(res.data[k].filesize));
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
		//{field: 'id', title:'ID', width:60, sort: true}
		{field: 'module', title: '来源模块', width:120, sort: true}
		,{field: 'typename', title: '存储性质', width:100}
		,{field: 'thumb', title: '预览', width:120,templet: "#image-thumb-tpl"}
		,{field: 'fileext', title: '附件类型', width:100}
		,{field: 'store', title: '存储方式', width:120,sort:true
			,templet:function(d){
				return (d.store == '0') ? '本地' : '第三方';
			}
		}
		,{field: 'filesize', title: '附件容量', width:120,sort:true}
		,{field: 'created_at', title: EY_Base.lang.created_at, width:180,sort:true}
		,{field: 'act', title: EY_Base.lang.act, width:80, fixed: 'right',templet: "#tableTools-"+module}
	]];	
	eybase[module].tableIns = table.render(_obj);
});
</script>