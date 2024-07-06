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
	
	var _status = (!$.isEmptyObject(eybase[module].fullfields.status.setting)) ? JSON.parse(eybase[module].fullfields.status.setting) : {};	
	
	// 处理返回的数据
	_obj.parseData = function(res){ //res 即为原始返回的数据
		var _d = new Array();
		if (res.code == '1'){
			var i = 0;
			var _tag = (!$.isEmptyObject(eybase[module].fullfields.tag.setting)) ? JSON.parse(eybase[module].fullfields.tag.setting) : {};
			for (var k in res.data){
				_d[i] = res.data[k];	
				_d[i].tagname =  _tag[res.data[k].tag];
				//_d[i].status =  _status[res.data[k].status];
				_d[i].uid = (res.data[k].uid == '0') ? '平台' : '用户';
				//_d[i].votemax = res.data[k].votemax;
				//if (res.data[k].btime != '') _d[i].btime = res.data[k].btime;
				if (!!res.ext[_d[i].id]){
						for (var _k in res.ext[_d[i].id]){
							_d[i][_k] = res.ext[_d[i].id][_k].value;
						}
					}
				i++;
			}
		}else if (res.code == '0'){
			//layer.alert(res.msg);
		}
		return {"code": (res.code == '1') ? 0 : 1,"msg": res.msg,"count": res.count,"data": _d};
	}
	// 渲染处理过的数据
	_obj.cols = [[ //表头
		
		{field: 'id', title:'ID', width:60, sort: true}
		,{field: 'tagname', title: '分类'}
		,{field: 'title', title: EY_Base.lang.name}
		,{field: 'intro', title: '说明'}
		//,{field: 'votemax', title: '投票上限', width:100}
		//,{field: 'btime', title: '起拍时间', width:100}
		,{field: 'etime', title: '截止', width:100}
		,{field: 'uid', title: '来源', width:100,sort:true}		
		,{field: 'status', title: EY_Base.lang.status, width:100,sort:true, templet:function(d){
			return (d.status == '2') ? (_status[d.status]) 
				: ((d.status == '1') ? ('<font class="layui-font-blue">'+_status[d.status]+'</font>') : '<font class="layui-font-red">'+_status[d.status]+'</font>');
		}}
		<?php foreach ($init['extfields'] as $k => $v) { ?>
		,{field: '<?=$k?>', title: '<?=$v['title']?>'}			
		<?php } ?>
		,{field: 'created_at', title: EY_Base.lang.created_at, width:170, sort: true}
		,{field: 'act', title: EY_Base.lang.act, width:130, fixed: 'right',templet: "#tableTools-"+module}
	]];	
	eybase[module].tableIns = table.render(_obj);
});
</script>