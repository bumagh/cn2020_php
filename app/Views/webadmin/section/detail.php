<div class="layui-panel" style="margin:10px;padding:10px;">
<form class="layui-form layui-form-pane" action="" id="form-<?=$init['tag']?>" lay-filter="form-<?=$init['tag']?>">
			<input type="hidden" name="image">
			<input type="hidden" name="thumb">
			  <div class="layui-form-item">
				<label class="layui-form-label"><font class="layui-font-red"> * </font>版块名称</label>
				<div class="layui-input-inline">
				  <input type="text" name="name"  lay-verify="required" placeholder="请输入名称" autocomplete="off" class="layui-input">
				</div>
			  </div>  
				<div class="layui-form-item">
				<label class="layui-form-label">目标链接</label>
				<div class="layui-input-inline">
				  <input type="text" name="tourl" required  placeholder="请输入链接" autocomplete="off" class="layui-input">
				</div>
			  </div>
			<div class="layui-form-item layui-form-text">
				<label class="layui-form-label">文字描述（用于前台版块的文字显示）</label>
				<div class="layui-input-block">
				  <textarea name="desc" placeholder="" class="layui-textarea"></textarea>
				</div>
			  </div>
			<?= view_cell('\App\Controllers\Webadmin\Sysattach::renderUpimage', ['module'=>$init['module'], 'tag'=>$init['tag'],'thumb' => empty($init['row']['thumb']) ? '' : $init['row']['thumb']]) ?> 
			  <div class="layui-form-item">
				<label class="layui-form-label">排序</label>
				<div class="layui-input-inline">
				  <input type="text" name="sort"  placeholder="请输入排序值" autocomplete="off" class="layui-input">
				</div>
				<div class="layui-form-mid layui-word-aux">数值越小越靠前，可负数</div>
			  </div>  
			<?= view_cell('\App\entities\Extbase::getRenderFields', ['tname' => $init['table'], 'relid' => empty($init['row']['id']) ? '' : $init['row']['id']]) ?>  
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