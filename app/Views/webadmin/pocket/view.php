<div class="layui-tab layui-tab-card" lay-filter="pocketType" style="margin:10px;">
  <ul class="layui-tab-title" >
    <li lay-id="coin" class="layui-this">金币日志</li>
    <li lay-id="point">贡献值日志</li>
  </ul>
  <div class="layui-tab-content">
    <div class="layui-tab-item layui-show" style="padding:0 10px 0 10px;">
    	<table id="tbl-<?=$init['module']?>_coin" lay-filter="tbl-<?=$init['module']?>_coin"></table>
    </div>
    <div class="layui-tab-item"  style="padding:0 10px 0 10px;">
    	<table id="tbl-<?=$init['module']?>_point" lay-filter="tbl-<?=$init['module']?>_point"></table>
    </div>
  </div>
</div>
<script>
layui.use(['element','table','laytpl','form','eybase'], function(){
	var table = layui.table
	,element = layui.element 
	,form = layui.form
	,eybase = layui.eybase
	,table = layui.table	
	,$ = layui.jquery;	

	element.on('tab(pocketType)', function(data){
		setRenderLog(this.getAttribute('lay-id'));
	});
	
	var setRenderLog = function(tag){
	
		var module = '<?=$init['module']?>_'+tag;
		var tagurl = '<?=$init['tag']?>_'+tag;
		eybase[module] = {};
		eybase[module] =  <?=json_encode($init)?>;
	
	// 设置配置
		var _obj = eybase.setTableOpt(module, tagurl);
		// 处理返回的数据
		_obj.parseData = function(res){ //res 即为原始返回的数据
			var _d = new Array();
			if (res.code == '1'){
				if (res.data.length>0){
					var i = 0;
					for (var k in res.data){
						_d[i] = res.data[k];
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
			//{field: 'act', title: EY_Base.lang.act, width:130, fixed: 'left',templet: "#tableTools-"+module}
			{field: 'id', title:'ID', width:60, sort: true}
			,{field: 'tag', title: '事件', width:100,sort:true}		
			,{field: 'numb', title: '数额变动', width:110,sort:true}
			,{field: 'memo', title: EY_Base.lang.memo}
			,{field: 'created_at', title: '发生时间', width:165,sort:true}
		]];	
		eybase[module].tableIns = table.render(_obj);
			
	};	
	
	setRenderLog('coin');
});
</script>