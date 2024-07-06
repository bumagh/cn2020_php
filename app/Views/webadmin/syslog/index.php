
<table id="tbl-<?=$init['module']?>" lay-filter="tbl-<?=$init['module']?>"></table>
<?php if (isset($init['login']['act']['syslog']['clear']) || ($init['login']['rid']==1)) { ?>
<script type="text/html" id="headerTools-<?=$init['module']?>">
<button class="layui-btn layui-btn-danger layui-btn-sm" lay-active="doClear" route="/<?=$init['module']?>/clear"> <i class="layui-icon layui-icon-add-1"></i> 清空日志</button>
</script>
<?php } ?>
<script>
layui.use(['util','table','laytpl','form','eybase'], function(){
	var table = layui.table
	,util = layui.util 
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
	var _actions = {'login':'登录','add':'添加','edit':'编辑','del':'删除','setmine':'更新设置'};
	_obj.parseData = function(res){ //res 即为原始返回的数据
		var _d = new Array();
		if (res.code == '1'){
			var i = 0;
			for (var k in res.data){
				_d[i] = {};
				if (res.data[k].actions == 'login'){
					_d[i].title = ' 【'+res.data[k].name+'】登录管理后台';
				}else{
					_d[i].title = '【'+res.data[k].name+'】'+_actions[res.data[k].actions]+'【'+res.data[k].title+'】';				
				}
				_d[i].module = res.data[k].module;
				_d[i].route = res.data[k].route;
				_d[i].actions = !!_actions[res.data[k].actions] ? _actions[res.data[k].actions] : '';
				_d[i].created_at = res.data[k].created_at;
				i++;
			}
		}else if (res.code == '0'){
			//layer.alert(res.msg);
		}
		return {"code": (res.code == '1') ? 0 : 1,"msg": res.msg,"count": res.count,"data": _d};
	}
	// 渲染处理过的数据
	_obj.cols = [[ //表头
//		,{field: 'act', title: EY_Base.lang.act, width:130, fixed: 'left',templet: "#tableTools-"+module}
		{field: 'title', title: '事件描述',width:300,}
		,{field: 'module', title: '所属模块'}
		,{field: 'route', title: '执行路由'}
		,{field: 'actions', title: '动作',width:100,sort: true}		
		,{field: 'created_at', title: '时间',width:200,sort: true}		
	]];	
	eybase[module].tableIns = table.render(_obj);
	
	util.event('lay-active', {
		doClear: function(othis){
			layer.confirm('确认要清空日志吗？',{icon:2}, function(index){
				eybase.postdata('/'+module+'/clear', {}, function(d){
					if (d.code=='1'){
						eybase[module].tableIns.reload();
					}else {
						layer.msg(d.msg)
					}
				})
				layer.close(index);
			});
		}
	});
	
});
</script>