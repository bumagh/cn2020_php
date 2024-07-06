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
				  <input type="text" name="username" <?=(!empty($init['row']['uid']) ? "readonly style='background-color:#eee;' " : '')?> required  lay-verify="required" placeholder="请输入帐号" autocomplete="off" class="layui-input">
				</div>
			  </div>
			  <div class="layui-form-item">
				<label class="layui-form-label">姓名</label>
				<div class="layui-input-inline">
				  <input type="text" name="name" required  lay-verify="required" placeholder="请输入姓名" autocomplete="off" class="layui-input">
				</div>
			  </div>
			<?php if (!empty($init['row']['uid'])) { ?>
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
			  <?php }else{ ?>
			  <div class="layui-form-item">
				<label class="layui-form-label">密码</label>
				<div class="layui-input-inline">
				  <input type="password" name="passwd" required lay-verify="required" placeholder="请输入密码" autocomplete="off" class="layui-input">
				</div>
			  </div>
			  <div class="layui-form-item">
				<label class="layui-form-label">确认密码</label>
				<div class="layui-input-inline">
				  <input type="password" name="repasswd" required lay-verify="required|confirmPwd" placeholder="确认密码" autocomplete="off" class="layui-input">
				</div>
			  </div>
			  <?php } ?>	
			  <div class="layui-form-item">
				<label class="layui-form-label">个性签名</label>
				<div class="layui-input-inline">
				  <input type="text" name="sign" required  lay-verify="required" placeholder="请输入个性签名" autocomplete="off" class="layui-input">
				</div>
			  </div>	 
				<?= view_cell('\App\entities\Extbase::getRenderFields', ['tname' => $init['table'], 'relid' => empty($init['row']['uid']) ? '' : $init['row']['uid']]) ?>
			  <div class="layui-form-item">
				<label class="layui-form-label">状态</label>
				<div class="layui-input-inline">
				   <input type="checkbox" name="status" lay-skin="switch" lay-text="启用|关闭">
				</div>
			  </div>
			  <div class="layui-form-item">
				<div class="layui-input-block">
				<?php  if (!empty($init['row'])) { ?>
				  <button class="layui-btn" lay-submit lay-filter="<?=$init['tag'].'_edit'?>">立即提交</button>				
				<?php }else { ?>
				  <button class="layui-btn" lay-submit lay-filter="<?=$init['tag'].'_add'?>">立即提交</button>
				  <button type="reset" class="layui-btn layui-btn-primary">重置</button>
				<?php } ?>
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
});
</script>