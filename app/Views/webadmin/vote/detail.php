<div class="layui-panel" style="margin:10px;padding:10px;">
<form class="layui-form layui-form-pane" action="" id="form-<?=$init['tag']?>" lay-filter="form-<?=$init['tag']?>">		
			<input type="hidden" name="uid"/>
			<?php  if (!empty($init['row'])) { ?>
			 <div class="layui-form-item">
				<label class="layui-form-label">编号ID</label>
				<div class="layui-input-inline">
				  <input type="text" name="id" readonly style='background-color:#eee;' class="layui-input">
				</div>
			  </div>
			<?php } ?>			  
			  <div class="layui-form-item">
				<label class="layui-form-label"><font class="layui-font-red"> * </font>标题</label>
				<div class="layui-input-inline">
				  <input type="text" name="title"  lay-verify="required" placeholder="请输入标题" autocomplete="off" class="layui-input">
				</div>
			  </div>  
			<div class="layui-form-item">
				<label class="layui-form-label"><font class="layui-font-red"> * </font>分类</label>
			 	 <div class="layui-input-inline">
					<select name="tag" lay-verify="required">
					<option value="">请选择分类</option>
					<?php foreach ($init['searchFields']['tag']['setting'] as $k => $v) { ?>
					 <option value="<?=$k?>"><?=$v?></option> 
					<?php } ?>
					</select>
				</div>
			</div>
			<div class="layui-form-item layui-form-text">
				<label class="layui-form-label">说明</label>
				<div class="layui-input-block">
				  <textarea name="intro" placeholder="" class="layui-textarea"></textarea>
				</div>
			</div>
			<?= view_cell('\App\entities\Extbase::getRenderFields', ['tname' => $init['table'], 'relid' => empty($init['row']['id']) ? '' : $init['row']['id']]) ?>
			<div class="layui-form-item">
				<label class="layui-form-label">截止时间</label>
				<div class="layui-input-inline">
				  <input type="text" name="etime" lay-type="datetime" placeholder="请输入截止时间" autocomplete="off" class="layui-input">
				</div>
			  </div>
			  <div class="layui-form-item">
				<label class="layui-form-label">状态</label>
					<div class="layui-input-block">
						<input type="radio" name="status" value="0" title="待发布">
						<input type="radio" name="status" value="1" title="进行中">
						<input type="radio" name="status" value="2" title="已结束">
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