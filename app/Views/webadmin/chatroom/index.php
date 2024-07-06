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
			var i = 0;
			for (var k in res.data){
				_d[i] = {};
				_d[i] = res.data[k];
				i++;
			}
		}else if (res.code == '0'){
		}
		return {"code": (res.code == '1') ? 0 : 1,"msg": res.msg,"count": res.count,"data": _d};
	}
	// 渲染处理过的数据
	_obj.cols = [[ //表头
		{field: 'id', title:'ID', width:60, sort: true}
		,{field: 'title', title: '聊天室名称', width:250,sort:true}		
		,{field: 'intro', title: '说明'}
		//,{field: 'etime', title: '拍卖截止', width:100}
		,{field: 'status', title: EY_Base.lang.status, width:100,sort:true, templet:function(d){
			return (d.status == '1') ? '<font class="layui-font-blue">显示</font>' : '<font class="layui-font-orange">不显示</font>';
		}}
		,{field: 'created_at', title: EY_Base.lang.created_at, width:170, sort: true}
		,{field: 'act', title: EY_Base.lang.act, width:130, fixed: 'right',templet: "#tableTools-"+module}
	]];	
	eybase[module].tableIns = table.render(_obj);
});
</script>