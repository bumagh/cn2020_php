layui.define(['jquery','form','layer','element','util','laytpl','eybase'],function(exports){	
	"use strict";
	var layer = layui.layer
	,form = layui.form
	,element = layui.element
	,util = layui.util
//	,table = layui.table	
	,laytpl = layui.laytpl
//	,dropdown = layui.dropdown
//	,transfer = layui.transfer
	,eybase = layui.eybase
	,$ = layui.jquery;
	//菜单事件
	util.event('ey-event', {
		//左侧菜单事件
		menuLeft: function(othis){
		  layer.msg('展开左侧菜单的操作', {icon: 0});
		}
		,menuRight: function(){
			location.reload();
		}
		,openRightView:function(e){
			console.log("add=>e=>",$(this).attr("route"),$(this).attr("title"));
			var route = $(this).attr("route");
			var obj = {};
			obj.title = $(this).attr("title");
			obj.id = eybase.getTag(route);
			eybase.setRenderRightView(obj,function(){
				$.ajax({
					url: EY_Base.ajxurl+route,dataType: "html"
					,success: function(html){
						$("#"+obj.id).html(html);
					}
					,complete: function(){
					}
				});

			});
		}
		,openSysTips: function(){
			var obj = {};
			obj.title = '系统消息';
			obj.id = 'systips';
			eybase.setRenderRightView(obj,function(){openSysTips()});
		}
		,setClosePage : function(o){
			alert('ok');
			element.tabDelete('moduleTab', EY_Base.tag);
		}
		,closeRightView : function(o){
			layer.close(eybase.indexRight);
		}
		,setStatDetail : function(o){
			var module = $(o).data("module");
			var pdata = {};
			pdata.id = $(o).data("retid");

			$.ajax({
				url: EY_Base.ajxurl+ "/"+module+'/view/'+pdata.id,dataType: "html"
				,success: function(html){
					$("#stat-"+module+"-"+pdata.id).html(html);
				}
				,complete: function(){
				}
			});
		}
		,showImageView : function(o){
			var url = $(o).attr("src").replace("thumb","image");
			layer.tips('<a href="'+url+'" target="_blank"><img src="'+$(o).attr("src")+'"/></a>', o);

		}
		,setFileDown : function(o){
			console.log("setFileDown=>",o);
		}
		/*
		,onChange: function(o){
			$(o).removeClass('layui-font-orange');
		}
		*/
	});	
	
	var openSysTips = function(){
			$.ajax({
				url: EY_Base.ajxurl+ '/systips',dataType: "html"
				,success: function(html){
					$("#systips").html(html);
				}
				,complete: function(){
					form.render();
				}
			});
	}
	
	$(document).ready(function(){
		EY_Base.tblHeight = $(".layui-body").height() - 100;	
		// 左边栏点击事件
		$(".layui-layout-admin").on("click",".menu_getpage", function(){
			layer.load(2, {time:eybase.loadtime});
			eybase.getPageHtml($(this).attr("route"), $(this).attr("title"));
			EY_Base.tag = eybase.getTag($(this).attr("route"));
			console.log("clicktag=>",EY_Base.tag);
		})
	})
	
	element.on('tab(moduleTab)', function(data){
		var id = this.getAttribute('lay-id');
		var _tag = eybase.getRoute(id);
		_tag = _tag.substr(1,_tag.length)				
		var e = $("#menu_left").find(".layui-nav-item");
		e.removeClass('layui-this');		
		
		if (e.find("a[route='/"+_tag+"']:first").length > 0){	// 一级菜单
			e.find("a[route='/"+_tag+"']:first").parent(".layui-nav-item").addClass('layui-this');
		}else{	
		}
		
		EY_Base.prevtag = id;
			console.log("prevtag=>",EY_Base.prevtag);		
		
	});	
	element.on('tabDelete(moduleTab)', function(data){
	  	var tag = $(this).parent().attr('lay-id');
		element.tabChange('moduleTab', EY_Base.prevtag);
		console.log("changetag=>",EY_Base.prevtag);
//		console.log("tabDelete=>EY_Base.tag=>",EY_Base.tag);
	});
	eybase.getPageHtml('/home/center', '我的仪表盘');
	exports('frame', {});
})