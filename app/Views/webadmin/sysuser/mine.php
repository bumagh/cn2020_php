<div class="layui-panel" style="margin:10px;padding:10px;">
<form class="layui-form layui-form-pane" action="" id="form-<?=$init['tag']?>" lay-filter="form-<?=$init['tag']?>">
	<div class="layui-form-item">
		<div class="layui-input-inline" style="padding-left:120px;">
			<input type="hidden" name="avatar" value="<?=(empty($init['row']['avatar']) ? '' : $init['row']['avatar'])?>">
			<img id="avatar-<?=$init['tag']?>" src="<?=(empty($init['row']['avatar']) ? '/images/default.png' : $init['row']['avatar'])?>" width="60" height="60" border="0" style="cursor:pointer;border-radius:50%;padding:2px;">						
		</div>
	</div>				
	<div class="layui-form-item">
		<label class="layui-form-label">帐号</label>
		<div class="layui-input-inline">
		  <input type="text" name="username"  readonly style='background-color:#eee;' required  lay-verify="required" placeholder="请输入帐号" autocomplete="off" class="layui-input">
		</div>
	  </div>
	  <div class="layui-form-item">
		<label class="layui-form-label">姓名</label>
		<div class="layui-input-inline">
		  <input type="text" name="name" required  lay-verify="required" placeholder="请输入姓名" autocomplete="off" class="layui-input">
		</div>
	  </div>
		<div class="layui-form-item">
		<label class="layui-form-label">密码</label>
		<div class="layui-input-inline">
		  <input type="password" name="passwd"  placeholder="留空为保留原密码" autocomplete="off"  class="layui-input">
		</div>
	  </div>
	  <div class="layui-form-item">
		<label class="layui-form-label">确认密码</label>
		<div class="layui-input-inline">
		  <input type="password" name="repasswd" lay-verify="confirmPwd" placeholder="留空为保留原密码" autocomplete="off" class="layui-input">
		</div>
	  </div>				
		<div class="layui-form-item">
		<label class="layui-form-label">邮箱</label>
		<div class="layui-input-inline">
		  <input type="text" name="email" required  placeholder="请输入邮箱" autocomplete="off" class="layui-input">
		</div>
	  </div>
		<div class="layui-form-item">
		<label class="layui-form-label">手机号</label>
		<div class="layui-input-inline">
		  <input type="text" name="phone" required  placeholder="请输入手机号" autocomplete="off" class="layui-input">
		</div>
	  </div>	
	  <input type="hidden" name="rid" value="<?=$init['row']['rid']?>">
	  <div class="layui-form-item">
		<div class="layui-input-block">
		  <button class="layui-btn" lay-submit lay-filter="user-mine"> 修 改 </button>
		</div>
	  </div>
</form>
</div>
<style>
.user-avatar-div{max-width:480px;padding:5px;}
.user-avatar-div img{width:30px;height:30px;border-radius:50%;}
</style>
<script>
layui.use(['element','laytpl','form','eybase','upload','dropdown'], function(){
	var laytpl = layui.laytpl
	,form = layui.form
	,eybase = layui.eybase
	,$ = layui.jquery
	,upload = layui.upload
	,dropdown = layui.dropdown
	,element = layui.element;
	
	var module = '<?=$init['module']?>';
	var tag = '<?=$init['tag']?>';
	var row = <?=(!empty($init['row']) ? json_encode($init['row']) : '{}')?>;	
	eybase.setDetailEvents(module,tag,row);	

	var _s = '<div class="layui-col-xs1"><a href="javascript:;" class="uploadselect"><i class="layui-icon layui-icon-addition" style="padding:3px;font-size: 26px;"></i></a></div>';
		for (var i=0; i<=40;i++){
			_s += '<div class="layui-col-xs1"><a href="javascript:;" class="faceselect"><img src="/images/'+i+'.png"></a></div>';
		}
		_s = '<div class="layui-row layui-col-space2">'+_s+'</div>';
		
	dropdown.render({
		elem: "#avatar-"+tag
		,content: _s
		,className: 'user-avatar-div'
		,ready: function(e){
			// 有效的点击隐藏事件
			$(e).find(".faceselect").click(function(){
				$("#avatar-"+tag).attr("src", $(this).find("img").attr("src"));
				$("#form-"+tag).find("input[name='avatar']").val($(this).find("img").attr("src"));
				// 关闭表情层
				eybase.setHideDropdown($(e));
			});
			
			upload.render({
				elem: $(e).find(".uploadselect")
				,url: EY_Base.ajxurl+'/sysattach/upimage'				
				,size: 2048
				,data: {
					module : module
					,imagew:64
					,imageh:64
				}
				,accept: 'images'
				,acceptMime: 'image/*'
				,done: function(d){
					if (d.code == '1'){
						$("#avatar-"+tag).attr("src", d.thumb);
						$("#form-"+tag).find("input[name='avatar']").val(d.thumb);
					}else{
						layer.msg(d.msg);
					}
					eybase.setHideDropdown($(e));
				}
			});		
		}
	});
	eybase.setExtFields(tag);
	form.verify({
	  confirmPwd: function(value, item){ //value：表单的值、item：表单的DOM对象
		if(value!=$("#form-"+tag).find("input[name='passwd']").val()){
		  return '两次密码不一致';
		}
	  }
	})	
	form.on('submit(user-mine)', function (data) {
		layer.load(2);	
		var pdata = {};
		pdata = data.field;
		eybase.postdata('/'+module+'/setmine', pdata, function(d){
			if (d.code == '1'){
				$(".avatar-"+d.data.uid).attr("src", d.data.avatar);			
				layer.msg('操作成功', {time:eybase.tipstime},function(){
				});
			}else if (d.code == '0'){
				for (var k in d.msg){
					layer.tips(d.msg[k], $("#form-"+tag).find(":input[name='"+k+"']").parent(".layui-input-inline"),  {tipsMore: true});
				}
			}
		});
		return false;
	});		
});
</script>