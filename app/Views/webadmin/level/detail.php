<div class="layui-panel" style="margin:10px;padding:10px;">
<form class="layui-form layui-form-pane" action="" id="form-<?=$init['tag']?>" lay-filter="form-<?=$init['tag']?>">		
			<?php  if (!empty($init['row'])) { ?>
			 <div class="layui-form-item">
				<label class="layui-form-label">等级ID</label>
				<div class="layui-input-inline">
				  <input type="text" name="id" readonly style='background-color:#eee;' class="layui-input">
				</div>
			  </div>
			<?php } ?>			  
			  <div class="layui-form-item">
				<label class="layui-form-label">名称</label>
				<div class="layui-input-inline">
				  <input type="text" name="name"  lay-verify="required" placeholder="请输入名称" autocomplete="off" class="layui-input">
				</div>
			  </div>  
				<div class="layui-form-item">
				<label class="layui-form-label">匹配下限</label>
				<div class="layui-input-inline">
				  <input type="text" name="numbmin" placeholder="请输入匹配下限的数字" autocomplete="off" class="layui-input">
				</div>
			  </div>
				<div class="layui-form-item">
				<label class="layui-form-label">匹配上限</label>
				<div class="layui-input-inline">
				  <input type="text" name="numbmax" placeholder="请输入匹配上限的数字" autocomplete="off" class="layui-input">
				</div>
			  </div>
				<div class="layui-form-item">
				<label class="layui-form-label">匹配策略</label>
				<div class="layui-input-inline">
				  <input type="text" name="policy" required  placeholder="请输入匹配策略" autocomplete="off" class="layui-input">
				</div>
			  </div>
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
	eybase.setExtFields(tag);
});
</script>