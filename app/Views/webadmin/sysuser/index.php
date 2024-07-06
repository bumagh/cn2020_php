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
			if (res.data.length > 0){		
				var i = 0;
				// 角色值
				var _role = !!eybase[module].fullfields.rid.setting ? JSON.parse(eybase[module].fullfields.rid.setting) : {};
			
				for (var k in res.data){
					_d[i] = {};
					_d[i] = res.data[k];
					_d[i].id = res.data[k].uid;
					_d[i].avatar = (!res.data[k].avatar) ? "/images/default.png" :res.data[k].avatar ;
					_d[i].rid = _role[res.data[k].rid];
					if (!!res.ext[_d[i].uid]){
						for (var _k in res.ext[_d[i].uid]){
							_d[i][_k] = res.ext[_d[i].uid][_k].value;
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
		{field: 'uid', title:'ID', width:60, sort: true}
		,{field: 'avatar', title: EY_Base.lang.avatar, width: 60, templet:"#avatar-index-tpl"}
		,{field: 'username', title: EY_Base.lang.username, width:120, sort: true}
		,{field: 'name', title: '姓名', width:100}		
		,{field: 'rid', title: '系统'+EY_Base.lang.role, width:120,sort:true}
		,{field: 'created_at', title: EY_Base.lang.created_at, width:170, sort: true}
		,{field: 'updated_at', title: EY_Base.lang.updated_at, width:170, sort: true,hide:true}			
		,{field: 'status', title: EY_Base.lang.status, width:100,sort:true, templet:function(d){
			return (d.status == '1') ? '<font class="layui-font-blue">已启用</font>' : '<font class="layui-font-orange">关闭</font>';
		}}
		,{field: 'act', title: EY_Base.lang.act, width:130, fixed: 'right',templet: "#tableTools-"+module}			
	]];	
	eybase[module].tableIns = table.render(_obj);
});
</script>