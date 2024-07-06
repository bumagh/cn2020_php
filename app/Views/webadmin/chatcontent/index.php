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
			var _member = (!!res.member) ? res.member : {};
			var chatroom = !!eybase[module].fullfields.rid.setting ? JSON.parse(eybase[module].fullfields.rid.setting) : {};				
			for (var k in res.data){
				_d[i] = res.data[k];	
				_d[i].rid = chatroom[res.data[k].rid];
				if (!!_member[_d[i].uid]){
					_d[i].avatar = _member[_d[i].uid].avatar;
					_d[i].name = _member[_d[i].uid].name;

				}
				i++;
			}
		}else if (res.code == '0'){
		}
		return {"code": (res.code == '1') ? 0 : 1,"msg": res.msg,"count": res.count,"data": _d};
	}
	// 渲染处理过的数据
	_obj.cols = [[ //表头
		<?= empty($init['actions']['checkall']) ? "" :  "{type: 'checkbox'}," ?>
		{field: 'rid', title: '所属聊天室',width:200, sort: true}
		,{field: 'id', title: 'ID',width:100, sort: true}
		,{field: 'avatar', title: EY_Base.lang.avatar, width: 60, templet:"#avatar-index-tpl"}
		,{field: 'name', title: '昵称', width:100}		
		,{field: 'content', title: '内容',templet:function(d){
			return (d.tag == 'img') ? ('<img src="<?=base_url()?>/'+d.content+'" width="100">') : d.content;
		}}
//		,{field: 'uid', title: '发布ID', width:100,sort:true}		
		,{field: 'created_at', title: EY_Base.lang.created_at, width:170, sort: true}
		,{field: 'act', title: EY_Base.lang.act, width:30, fixed: 'right',templet: "#tableTools-"+module}		
	]];	
	eybase[module].tableIns = table.render(_obj);
});
</script>