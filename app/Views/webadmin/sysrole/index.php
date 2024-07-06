<?=$this->include('\App\Views\webadmin\comm\indextable') ?>
<script>
var moduledata = <?=json_encode($mdata)?>;

layui.use(['table','laytpl','form','eybase'], function(){
	var table = layui.table
	,form = layui.form
	,eybase = layui.eybase
	,table = layui.table	
	,$ = layui.jquery;	
	var tag = '<?=$init['tag']?>';
	var module = '<?=$init['module']?>';
	// 初始化模块常量
	eybase[module] = {};
	eybase[module] =  <?=json_encode($init)?>;

	var _obj = eybase.setTableOpt(module, tag);
	_obj.parseData = function(res){ 
			var _d = new Array();
			if (res.code == '1'){
				var i = 0;
				var selectModule = {};
				var str = '';
				for (var k in res.data){
					if (!!res.data[k].modulelist){
						selectModule = JSON.parse(res.data[k].modulelist);
						str = '';
						for (var _k in selectModule){
							if (!$.isEmptyObject(moduledata[_k])){
								str += '<span class="layui-badge layui-bg-blue">'+moduledata[_k]+'</span> ';
							}
						}
					}
					_d[i] = {};
					_d[i] = res.data[k];
					_d[i].id = res.data[k].rid;
					_d[i].modulename = str;
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
//			 {checkbox: true, LAY_CHECKED: false}
			<?= empty($init['actions']['checkall']) ? "" :  "{type: 'checkbox'}," ?>
			{field: 'name', title: EY_Base.lang.name, width:100}
			,{field: 'modulename', title: EY_Base.lang.modulelist}
			,{field: 'memo', title: EY_Base.lang.memo, width:200}						
			,{field: 'created_at', title: EY_Base.lang.created_at, width:170,sort:true}
			,{field: 'updated_at', title: EY_Base.lang.updated_at, width:170,sort:true}
			,{field: 'act', title: EY_Base.lang.act, width: 100, fixed: 'right',templet: "#tableTools-"+module}
		]]
	eybase[module].tableIns = table.render(_obj);	
});
</script>