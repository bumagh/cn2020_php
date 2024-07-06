layui.define(['element','form','laydate','util','colorpicker','laytpl','table'],function(exports){	
	"use strict";
	var layer = layui.layer
	,form = layui.form
	,element = layui.element
	,laydate = layui.laydate
	,colorpicker = layui.colorpicker	
	,util = layui.util
	,table = layui.table	
	,laytpl = layui.laytpl
//	,dropdown = layui.dropdown
//	,transfer = layui.transfer
	,$ = layui.jquery
	,eybase = {
		tipstime: 1500
		,loadtime: 5000
		,limit : 10
		,limits : [10,15,20,30,50,80,100]
		,search: {}			// 用来存储列表搜索功能中的相关数据
		,order: {}
		,indexRight:''
		,formatSize: function(bytes) {
			if (bytes === 0) return '0 B';
			var k = 1024,
			sizes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'],
			i = Math.floor(Math.log(bytes) / Math.log(k));
		   return (bytes / Math.pow(k, i)).toPrecision(3) + ' ' + sizes[i];
		}
		,getTag : function(route){
			return  route.substr(1,route.length).replace(/\//g,'_');
		}
		,getRoute : function(tag){
			return '/'+tag.replace(/_/g,"/");
		}
		,postdata : function (route, pdata, callback){
			route = (route.substr(0,1) != '/') ? ('/'+route) : route;
			$.ajax({
				url: EY_Base.ajxurl + route,dataType: "json",data:pdata,type:"POST"
				,headers:{'X-Requested-With': 'XMLHttpRequest'}
				,success: function(ret){
					if (ret.code == '-1'){
						document.location.href=EY_Base.ajxurl+'/user/login';
					}
					if (typeof callback === 'function'){
						callback(ret);
					}
				}
				,complete: function(ret){
					layer.closeAll('loading');
				}
			});
		}
		,setSysTips : function(numb){
			if (numb > 0){
				$("#systips-new").html(numb);
				$("#systips-new").show();
			}else{
				$("#systips-new").html(0);
				$("#systips-new").hide();					
			}		
		}
		// 渲染编辑页字段的插件加载	
		,setExtFields : function(tag){
			// 绑定日期扩展字段的插件
			lay('#form-'+tag).find('input[lay-type="datetime"]').each(function(){
				laydate.render({
				  elem: this
				  ,type: 'datetime'
				  ,trigger: 'click'
				});
			});
			lay('#form-'+tag).find('input[lay-type="date"]').each(function(){
				laydate.render({
				  elem: this
				  ,type: 'date'
				  ,trigger: 'click'
				});
			});
			lay('#form-'+tag).find('input[lay-type="time"]').each(function(){
				laydate.render({
				  elem: this
				  ,type: 'time'
				  ,trigger: 'click'
				});
			});						
			lay('#form-'+tag).find('div[lay-type="color"]').each(function(i){
				colorpicker.render({
					elem: this
					,color: $("#form-"+tag).find('input[lay-type="color"]').eq(i).val()
					,done: function(color){
						$("#form-"+tag).find('input[lay-type="color"]').eq(i).val(color);
					}
				});
			});			
		}
		// 渲染搜索字段的插件加载
		,setExtSearch : function(module, data){		
			$("#searchform-"+module).find(".layui-inline").html(eybase[module].searchvalHTML);			
			eybase[module].search.fid = '';
			eybase[module].search.type = '';
			
			var type = $(data.elem).find("option[value='"+data.value+"']").attr('lay-type');
			var fid = $(data.elem).find("option[value='"+data.value+"']").attr('lay-fid');
			eybase[module].search.key = data.value;
			eybase[module].search.fid = fid;
			eybase[module].search.type = type;
			if (type == 'date'){
//			  laydate.render({elem: lay('#search-'+module).find('input[name="searchval"]'),type: 'date',range: true});				
			  laydate.render({elem: '#searchval-'+module,type: 'date',range: true});
			}else if (type == 'datetime'){
//			  laydate.render({elem: lay('#search-'+module).find('input[name="searchval"]'),type: 'datetime',range: true});
			  laydate.render({elem: '#searchval-'+module,type: 'datetime',range: true});
			}else if (type == 'time'){
			  laydate.render({elem: '#searchval-'+module,type: 'time',range: true});
			}else if ((type == 'select') || (type=='radio') || (type=='checkbox')) {
				//console.log('isjson?=>',$(data.elem).find("option[value='"+data.value+"']").attr('lay-setting'));
				var setting = JSON.parse($(data.elem).find("option[value='"+data.value+"']").attr('lay-setting'));
				var _s = '';
				if (!$.isEmptyObject(setting)){
					_s = '<select name="searchval" id="searchval-'+module+'"><option value="">请选择</option>';
					if (layui._typeof(setting) == 'object'){
						for (var k in setting) _s += '<option value="'+k+'">'+setting[k]+'</option>';					
					}else if (layui._typeof(setting) == 'array'){
						for (var k in setting) _s += '<option value="'+setting[k]+'">'+setting[k]+'</option>';					
					}
					_s += '</select>';
				}				
				if (_s != ''){
					$("#searchform-"+module).find(".layui-inline").html(_s);
					form.render();
				}
			}
		}
		/*
		,getRenderTableAct : function (act){
			var actions = {};
			actions.edit = '<button class="layui-btn layui-btn-xs" lay-event="setEdit"><i class="layui-icon layui-icon-edit"></i></button>';
			actions.del = '<button class="layui-btn layui-btn-xs layui-btn-danger" lay-event="setDel"><i class="layui-icon layui-icon-close"></i></button>';
			
			var str = '';
			for (var k in actions){
				if (act.includes(k)){
					str += actions[k];
				}
			}
			return '<div class="layui-btn-group">' + str + '</div>';
		}
		*/
		
		/**
		* 异步获取模块已渲染页面
		* param:title,route,tag,
		*/
		,getPageHtml : function(route,title){
			var tag = eybase.getTag(route);
			EY_Base.tag = tag;								
			if ($("#moduleTab").find(".layui-tab-title").find("li[lay-id='"+tag+"']").length==0){
				$.ajax({
					url: EY_Base.ajxurl+ route,dataType: "html"
		//			url: EY_Base.ajxurl+ obj.route,dataType: "json"
		//			,headers:{'X-Requested-With': 'XMLHttpRequest','Get-Type':'getPageHtml'}
					,success: function(html){
						element.tabAdd('moduleTab', {
							title: title
							,content: html
							,id: tag
						});
						element.tabChange('moduleTab', tag);
					}
					,complete: function(){
						form.render();
					}
				});
			}else{
				element.tabChange('moduleTab', tag);
			}
			layer.closeAll('loading');		
		}
		,setHideDropdown : function(o){	// 用户来处理弹出菜单及内容的关闭，当内容为自定义时无法自动关闭
			if (o){
				o.data('prevElem') && (o.data('prevElem').data('layui_dropdown_index_opened',false));
			}
			o.remove();	
		}
		,setTableOpt : function(module, tag){
			//console.log("module=>",module,'tag=>',tag);
			return {
				elem: '#tbl-'+module
				,defaultToolbar: [{
					title: '刷新'
					,layEvent: 'refresh'
					,icon: 'layui-icon-refresh'
				  },'filter', 'print', 'exports']	
				,limit: eybase.limit
				,height: EY_Base.tblHeight
				,limits: eybase.limits
				,toolbar: '#headerTools-'+module
				,url: EY_Base.ajxurl+eybase.getRoute(tag)
				,page: true //开启分页
				,method: 'post'
				,where :{
					search : eybase[module].search
				}
				,escape : false
				,done : function(){
					eybase.setTableInitEvents(module);
				}	
			}
		}
		,setTableInitEvents : function(module, callback){
			eybase[module].searchvalHTML = $("#searchform-"+module).find(".layui-inline").html();
			 //排序事件
			table.on('sort(tbl-'+module+')', function(obj){
				var order = {};
				order.key = obj.field;
				order.type = obj.type;
				table.reload('tbl-'+module, {
					initSort: obj
					,page: {curr: 1} //重新从第一页开始
					,where: {
						search : eybase[module].search
						,order : order
					}
					,done: function(){
						if (typeof callback === 'function'){
							callback();
						}
					}
				}, true);
			});	
			// 数据表格头部铵钮
			table.on('toolbar(tbl-'+module+')', function(obj){
		//	  var checkStatus = table.checkStatus(obj.config.id);
			  switch(obj.event){
				case 'refresh':
					table.reload('tbl-'+module);
					break;
				case 'delbatch':
					var checkStatus = table.checkStatus(obj.config.id)
				    ,data = checkStatus.data; //获取选中的数据
					if(data.length === 0){
					  layer.msg('至少选择一行');
					} else {
						layer.confirm('确认要删除所有选择的行吗？',{icon:2}, function(index){
							var pdata = {};
							pdata.ids = new Array();
							for (var k in data) pdata.ids.push(data[k].id);
							eybase.postdata('/'+module+'/delm', pdata, function(d){
								if (d.code=='1'){
									layer.msg('删除成功');
									table.reload('tbl-'+module);
								}else {
									layer.msg(d.msg)
								}
							})
							layer.close(index);
						});						
					}
					break;
			  };
			});			
			// 加载数据表格操作事件
			table.on('tool(tbl-'+module+')', function(obj){
				var post = {};
				switch(obj.event){
					//case 'setGroupUser':
					//		eybase.setRenderGroupUser(module,obj.data);
						//	break;

					/*
						eybase.postdata('/'+module+'/setuser', obj.data, function(d){
							if (d.code=='1'){
								console.log("eybase[module]=>",eybase[module]);
								console.log("obj=>",obj);
								eybase.setRenderUser(module,obj.data, d);
							}else {
								layer.msg(d.msg)
							}
						})
					*/
					case 'setView':
						//eybase.setRenderView(module,obj);
						var _obj = {};
						_obj.id = obj.data.id;
						_obj.title = '<i class="layui-icon layui-icon-chart-screen"></i> 显示明细';
						eybase.setRenderRightView(_obj,function(){
							$.ajax({
								url: EY_Base.ajxurl+'/'+module+'/view/'+obj.data.id,dataType: "html"
								,success: function(html){
									$("#"+obj.data.id).html(html);
								}
								,complete: function(){
								}
							});

						});		
						break;
					case 'setEdit':
						var _obj = {};
						_obj.id = obj.data.id;
						_obj.title = '<i class="layui-icon layui-icon-edit"></i> '+(!!obj.data.name ? obj.data.name : obj.data.title) ;
						eybase.setRenderRightView(_obj,function(){
							$.ajax({
								url: EY_Base.ajxurl+'/'+module+'/edit/'+obj.data.id,dataType: "html"
								,success: function(html){
									$("#"+obj.data.id).html(html);
								}
								,complete: function(){
								}
							});

						});						
						break;
					case 'setDel':
						layer.confirm('确认要删除吗？',{icon:2}, function(index){
							post = {};
							//post.id = obj.data.id;
							//post.name = obj.data.name;
							post = obj.data;
							eybase.postdata('/'+module+'/del', post, function(d){
								if (d.code=='1'){
									obj.del();
								}else {
									layer.msg(d.msg)
								}
							})
							layer.close(index);
						});
						break;
					default : break;
				};
			});		
			// 加载搜索
			form.on('select(select-'+module+')', function(data){
				eybase.setExtSearch(module, data);
			});

			form.on('submit(search-'+module+')', function (data) {
				layer.load(2,{time:eybase.loadtime});
				var pdata = {};
				pdata = data.field;
				if (!$.isEmptyObject(eybase[module].search)){
					eybase[module].search.val = pdata.searchval;	
				}
				table.reload('tbl-'+module, {
					page: {curr: 1}
					,where :{
						search : eybase[module].search
						,order : ''
					}
					,done : function(){
			
						if (!$.isEmptyObject(eybase[module].search)){
							var data = {};
							data.elem = "#searchkey-"+module;
							data.value = eybase[module].search.key;
							eybase.setExtSearch(module, data);
							var v = {};
							v.searchkey = eybase[module].search.key;
							v.searchval = eybase[module].search.val;
							form.val('searchform-'+module, v);
						}
						
						if (typeof callback === 'function'){
							callback();
						}
						
						layer.closeAll('loading');
					}
					,cols: eybase[module].tableIns.config.cols
					}, true);
				return false;
			});				
		}
		,setDetailEvents : function(module,tag,row){
			form.val('form-'+tag, row);
			
			$("#form-"+tag).find("input").on("change",function(){
				$(this).removeClass("layui-font-orange");
			})
			
			// 处理switch组件
			var _switchnumb = $("#form-"+tag).find(":input[lay-skin='switch']").length;
			if (_switchnumb > 0){
				var _key = '';			
				$("#form-"+tag).find(":input[lay-skin='switch']").each(function(i){
					_key = $(this).attr("name");
					if (!!row[_key] && (row[_key] == '1')){
						$(this).attr("checked", 'true');
					}else{
						$(this).removeAttr("checked");
					}
				})			
				form.render();				
			}
			form.on('submit('+tag+'_add)', function (data) {
				layer.load(2);	
				var pdata = {};
				pdata = data.field;
				//if (!!pdata.content) pdata.content = util.escape(pdata.content);
				eybase.postdata(module+'/add', pdata, function(d){
					if (d.code == '1'){
						layer.msg('操作成功', {time:eybase.tipstime},function(){
							$("#form-"+tag)[0].reset();	
							eybase[module].tableIns.reload('tbl-'+module);			
						});
					}else if (d.code == '0'){
						for (var k in d.msg){
							$("#form-"+tag).find(":input[name='"+k+"']").addClass('layui-font-orange');
							$("#form-"+tag).find(":checkbox[name^='"+k+"']").addClass('layui-font-orange');

							layer.tips(d.msg[k], $("#form-"+tag).find(":input[name='"+k+"']").parent("div"),  {tipsMore: true});
							layer.tips(d.msg[k], $("#form-"+tag).find(":checkbox[name^='"+k+"']").parent("div"),  {tipsMore: true});
						}
					}
				});
				return false;
			});
			form.on('submit('+tag+'_edit)', function (data) {
				layer.load(2);	
				var pdata = {};
				pdata = data.field;
				//if (!!pdata.content) pdata.content = util.escape(pdata.content);				
				eybase.postdata(eybase.getRoute(tag), pdata, function(d){
					if (d.code == '1'){
						layer.msg('操作成功', {time:eybase.tipstime},function(){
							//element.tabDelete('moduleTab', tag);		
							eybase[module].tableIns.reload('tbl-'+module);
						});

					}else if (d.code == '0'){
						if (!$.isArray(d.msg)){
							layer.msg(d.msg);
						}else{
							for (var k in d.msg){						
								$("#form-"+tag).find(":input[name='"+k+"']").addClass('layui-font-orange');
								$("#form-"+tag).find(":checkbox[name^='"+k+"']").addClass('layui-font-orange');
								layer.tips(d.msg[k], $("#form-"+tag).find(":input[name='"+k+"']").parent("div"),  {tipsMore: true});
								layer.tips(d.msg[k], $("#form-"+tag).find(":checkbox[name^='"+k+"']").parent("div"),  {tipsMore: true});
							}
						}
					}
				});
				return false;
			});	
		}
		,bindUserTips : function(module){
			$("div[lay-id='tbl-"+module+"']").find('.avatar-sma').hover(function(){
				layer.tips($(this).attr("name"), this, {tips: 1});
			},function(){
				layer.close(layer.tips());
			})	
		}		
		// 渲染打开视图页面
		,setRenderView : function(module, obj){
			var d = {};
			var row = obj.data;
			d.module = module;
			d.fields = eybase[module].fullfields;
			d.data = obj.data;
			d.util = util;
			layer.tab({
				type: 1
				,id: "viewright-tab"
				,area: ['680px', '100%']
				,offset: 'rt' //右上角
				,anim: 5
				,shadeClose: true
				,tab: [{
					title : '<i class="layui-icon layui-icon-about"></i> ' + row.name,
					content: laytpl($("#view-row-tpl").html()).render(d)
				},{
					title: '<span data-module="'+module+'" data-retid="'+row.id+'" ey-event="setStatDetail"><i class="layui-icon layui-icon-chart-screen"></i> 汇总</span> ', 
					content: '<div id="stat-'+module+'-'+row.id+'"></div>'
				}]
				,success: function(layero, index){
				}
				// 点击关闭时回调
				,cancel: function(index, layero){
					layer.closeAll('loading');
				}
				,end: function(){
				}
			});		
		}		
		// 应用于查看，点击其他区域自动关闭
		,setRenderRightView : function(obj,callback){
			layer.open({
				type: 1
				,title : obj.title
				,content: ''
				,area: ['640px', '100%']
				,offset: 'rt' //右上角
				,anim: 5
				,shadeClose: true
				,id : obj.id
				,success : function(){
					if (typeof callback === 'function'){
						callback();
					}					
				}
			});		
		}	
		// 应用于设置页，需要点击页面内"关闭"才能关闭
		,setRenderRight : function(obj,callback){
			eybase.indexRight = layer.open({
				type: 1
				,title : obj.title
				,content: ''
				,area: ['580px', '100%']
				,offset: 'rt' //右上角
				,anim: 5
				//,shadeClose: true
				,id : "rightview-"+obj.id
				,success : function(){
					if (typeof callback === 'function'){
						callback();
					}					
				}
			});		
		}	
	};
	exports('eybase', eybase);
})