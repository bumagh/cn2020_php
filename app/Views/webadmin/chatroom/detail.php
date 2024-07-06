<div class="layui-panel" style="margin:10px;padding:10px;">
<form class="layui-form layui-form-pane" action="" id="form-<?=$init['tag']?>" lay-filter="form-<?=$init['tag']?>">		
			<input type="hidden" name="id"/>
			  <div class="layui-form-item">
				<label class="layui-form-label"><font class="layui-font-red"> * </font>标题</label>
				<div class="layui-input-inline">
				  <input type="text" name="title"  lay-verify="required" placeholder="请输入标题" autocomplete="off" class="layui-input">
				</div>
			  </div>  
			<div class="layui-form-item layui-form-text">
				<label class="layui-form-label">说明</label>
				<div class="layui-input-block">
				  <textarea name="intro" placeholder="" class="layui-textarea"></textarea>
				</div>
			</div>
		
			  <div class="layui-form-item">
				<label class="layui-form-label">状态</label>
					<div class="layui-input-block">
						<input type="radio" name="status" value="0" title="隐藏">
						<input type="radio" name="status" value="1" title="显示">
					</div>
				  <!--<input type="checkbox" name="status" lay-skin="switch" lay-text="已完成|进行中">-->
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
	eybase.setExtFields(tag);
});
</script>