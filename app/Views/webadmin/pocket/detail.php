<div class="layui-panel" style="margin:10px;padding:10px;">
<form class="layui-form layui-form-pane" action="" id="form-<?=$init['tag']?>" lay-filter="form-<?=$init['tag']?>">		
			<?php  if (!empty($init['row'])) { ?>
			 <div class="layui-form-item">
				<label class="layui-form-label">用户ID</label>
				<div class="layui-input-inline">
				  <input type="text" name="uid" readonly style='background-color:#eee;' class="layui-input">
				</div>
			  </div>
			<?php } ?>			  
			  <div class="layui-form-item">
				<label class="layui-form-label">变更积分</label>
				<div class="layui-input-inline">
				  <div class="layui-input-inline">
					  <select name="type" lay-verify="required">
						<option value="">请选择积分种类</option>
						<option value="coin">金币</option>
						<option value="coinfix">冻结金币</option>
						<option value="point">贡献值</option>
						<option value="res">资源</option>
					  </select>
					</div>				  
				</div>
			  </div>  
				<div class="layui-form-item">
				<label class="layui-form-label">变更数额</label>
				<div class="layui-inline">
				  	<div class="layui-input-inline" style="width:100px;">
					  <select name="act" lay-verify="required" >
						<option value="add" selected="">增加</option>
						<option value="sub">减少</option>
					  </select>
					</div>	
					<div class="layui-input-inline"  style="width:150px;">
					  <input type="text" name="numb"   lay-verify="required|number" placeholder="请输入变更数额" autocomplete="off" class="layui-input">
					</div>			  
				</div>
				
			  </div>
				<div class="layui-form-item">
				<label class="layui-form-label">备注</label>
				<div class="layui-input-inline">
				  <input type="text" name="memo" placeholder="请输入备注" autocomplete="off" class="layui-input">
				</div>
			  </div>
			  <div class="layui-form-item">
				<div class="layui-input-block">
				  <button class="layui-btn" lay-submit lay-filter="<?=$init['tag'].'_edit'?>">立即提交</button>				
				  <button type="reset" class="layui-btn layui-btn-primary">重置</button>
				</div>
			  </div>
</form>
</div>
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
	//eybase.setExtFields(tag);
});
</script>