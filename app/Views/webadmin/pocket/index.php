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
				//var _username = !!eybase[module].fullfields.username.setting ? JSON.parse(eybase[module].fullfields.username.setting) : {};
				//var _name = (!$.isEmptyObject(eybase[module].fullfields.name.setting)) ? JSON.parse(eybase[module].fullfields.name.setting) : {};
				var _username = {};
				for (var k in res.data){
					_d[i] = res.data[k];
					_d[i].id = res.data[k].uid;
					_d[i].name = '用户ID['+res.data[k].uid+']的钱包变更';
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
		{field: 'uid', title: '用户ID', width:120,sort:true}		
		,{field: 'coin', title: '金币', width:120,sort:true}
		,{field: 'coinfix', title: '冻结金币', width:120,sort:true}
		,{field: 'point', title: '贡献值',width:120,sort:true}
		,{field: 'res', title: '资源',width:120,sort:true}
		<?php foreach ($init['extfields'] as $k => $v) { ?>
		,{field: '<?=$k?>', title: '<?=$v['title']?>'}			
		<?php } ?>
		,{field: 'act', title: EY_Base.lang.act, width:130, fixed: 'right',templet: "#tableTools-"+module}
		/*
		,{field: 'status', title: EY_Base.lang.status, width:100,sort:true, templet:function(d){
			return (d.status == '1') ? '<font class="layui-font-blue">已启用</font>' : '<font class="layui-font-orange">关闭</font>';
		}}
		*/
	]];	
	eybase[module].tableIns = table.render(_obj);
});
</script>