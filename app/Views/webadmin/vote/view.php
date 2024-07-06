<table id="tbl-<?=$init['module']?>_join" lay-filter="tbl-<?=$init['module']?>_join"></table>
<script>
layui.use(['element','table','laytpl','form','eybase'], function(){
	var table = layui.table
	,element = layui.element 
	,form = layui.form
	,eybase = layui.eybase
	,table = layui.table	
	,$ = layui.jquery;	
	
	var setRenderJoin = function(tag){
	
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
					var member = res.member;
					var _options = (!$.isEmptyObject(eybase.vote.fullfields.voteitem.setting)) ? JSON.parse(eybase.vote.fullfields.voteitem.setting) : {};
					var i = 0;
					for (var k in res.data){
						_d[i] = res.data[k];
						_d[i].value = (!!_options[_d[i].value]) ? _options[_d[i].value] : '';
						if (!!member[_d[i].uid]){
							_d[i].avatar = (!member[_d[i].uid].avatar) ? "/images/default.png" :member[_d[i].uid].avatar ;
							_d[i].uname = (!member[_d[i].uid].name) ? "昵名" :member[_d[i].uid].name ;
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
			//{field: 'act', title: EY_Base.lang.act, width:30, fixed: 'left',templet: "#tableTools-"+module}
			{field: 'uid', title:'用户ID', width:80}
			,{field: 'avatar', title: EY_Base.lang.avatar, width: 60, templet:"#avatar-index-tpl"}
			,{field: 'uname', title: EY_Base.lang.username, width:130}
			,{field: 'value', title: '投票项'}		
			,{field: 'created_at', title: '投票时间',sort:true}
		]];	
		eybase[module].tableIns = table.render(_obj);
			
	};	
	
	setRenderJoin('join');
});
</script>