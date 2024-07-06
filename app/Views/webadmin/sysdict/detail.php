<div class="layui-panel" style="margin:10px;padding:10px;">
<form class="layui-form layui-form-pane" action="" id="form-<?=$init['tag']?>" lay-filter="form-<?=$init['tag']?>">
			  <div class="layui-form-item">
				<label class="layui-form-label"><font class="layui-font-red"> * </font>所属表名</label>
				<div class="layui-input-inline">
					<select name="tname" lay-verify="required">
					<option value="">请选择扩展表名</option>
					<?php foreach ($init['searchFields']['tname']['setting'] as $k => $v) { ?>
					 <option value="<?=$k?>"><?=$v?></option> 
					<?php } ?>
					</select>
				</div>
				<div class="layui-form-mid layui-word-aux">选择要进行扩展的数据表</div>
			  </div>
			  <div class="layui-form-item">
				<label class="layui-form-label"><font class="layui-font-red"> * </font>字段名称</label>
				<div class="layui-input-inline">
				  <input type="text" name="name" required  lay-verify="required" placeholder="请输入字段名称" autocomplete="off" class="layui-input">
				</div>
				<div class="layui-form-mid layui-word-aux">设置字段的中文名称</div>
			  </div>
			  <div class="layui-form-item">
				<label class="layui-form-label"><font class="layui-font-red"> * </font>字段编码</label>
				<div class="layui-input-inline">
				  <input type="text" name="code" required  lay-verify="required" placeholder="请输入字段编码" autocomplete="off" class="layui-input">
				</div>
				<div class="layui-form-mid layui-word-aux">设置字段编码,请使用英文。</div>
			  </div>  
			  <div class="layui-form-item">
				<label class="layui-form-label"><font class="layui-font-red"> * </font>字段类型</label>
				<div class="layui-input-inline">
					<select name="type" lay-verify="required" lay-filter="setItemStatus">
					<?php foreach ($init['searchFields']['type']['setting'] as $k => $v) { ?>
					 <option value="<?=$k?>"><?=$v?></option> 
					<?php } ?>
					</select>
				</div>
			  </div>	
			  <div class="layui-form-item rule-item">
				<label class="layui-form-label">验证规则</label>
				<div class="layui-input-inline">
					<select name="rule" lay-filter="setRuleStatus">
					<?php foreach ($init['searchFields']['rule']['setting'] as $k => $v) { ?>
					 <option value="<?=$k?>"><?=$v?></option> 
					<?php } ?>
					</select>
				</div>
			  </div>				  
			  <div class="layui-form-item layui-form-text setting-item" style="height:100px;width:390px;">
				<label class="layui-form-label">选择项设置</label>
				<div class="layui-input-inline" style="width:100%;">
				  <textarea name="setting" placeholder="请输入内容" class="layui-textarea" style="width:100%;"></textarea>
				</div>
				<div class="layui-form-mid layui-word-aux">设置格式式如下：
				<table class="layui-table">
				  <colgroup><col><col></colgroup>
				  <thead>
					<tr>
					  <th>方式一</th>
					  <th>方式二</th>
					</tr> 
				  </thead>
				  <tbody>
					<tr>
					  <td>男<br/>女<br/>保密</td>
					  <td>1=男<br/>2=女<br/>0=保密</td>
					</tr>
				  </tbody>
				</table>
				</div>				
			  </div>		  
			  <div class="layui-form-item">
				<label class="layui-form-label">字段说明</label>
				<div class="layui-input-inline">
				  <input type="text" name="info"  placeholder="请输入字段说明" autocomplete="off" class="layui-input">
				</div>
			  </div>
			  <div class="layui-form-item">
				<label class="layui-form-label">字段排序</label>
				<div class="layui-input-inline">
				  <input type="text" name="sort" placeholder="请输入字段排序"  autocomplete="off" class="layui-input">
				</div>
				<div class="layui-form-mid layui-word-aux">填数字，数字小的排前面</div>
			  </div>
			  <div class="layui-form-item">
				<label class="layui-form-label">允许查看</label>
				<div class="layui-input-inline">
				<input type="checkbox" name="view" lay-skin="switch" lay-text="是|否" checked>
				</div>
			  </div>
			  <div class="layui-form-item">
				<label class="layui-form-label">允许编辑</label>
				<div class="layui-input-inline">
				<input type="checkbox" name="edit" lay-skin="switch" lay-text="是|否" checked>
				</div>
			  </div>
			  <div class="layui-form-item">
				<label class="layui-form-label">允许搜索</label>
				<div class="layui-input-inline">
				<input type="checkbox" name="search"  lay-skin="switch" lay-text="是|否">
				</div>
			  </div>
			  <div class="layui-form-item">
				<label class="layui-form-label">设为必填</label>
				<div class="layui-input-inline">
				<input type="checkbox" name="force" lay-skin="switch" lay-text="ON|OFF">
				</div>
			  </div>
			  <div class="layui-form-item">
				<div class="layui-input-block">
				<?php if (!empty($init['row'])) { ?>
				  <button class="layui-btn" lay-submit lay-filter="<?=$init['tag'].'_edit'?>">立即提交</button>				
				<?php }else { ?>
				  <button class="layui-btn" lay-submit lay-filter="<?=$init['tag'].'_add'?>">立即提交</button>
				  <button type="reset" class="layui-btn layui-btn-primary">重置</button>
				<?php } ?>
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
	// 赋值基本表-扩展字段
	eybase.setExtFields(tag);
	var setItemStatus = function(type){
		if ((type == 'radio') || (type == 'select') || (type == 'checkbox')){
			$(".setting-item").show();	
			$(".rule-item").hide();	
		}else if ((type == 'text') || (type == '')) {
			$(".rule-item").show();	
			$(".setting-item").hide();				
		}else{
			$(".setting-item").hide();			
			$(".rule-item").hide();				
		}
	}
	
	form.on('select(setItemStatus)', function(data){ setItemStatus(data.value);});      	
	//form.on('select(setRuleStatus)', function(data){ setRuleStatus(data.value);});      	
	setItemStatus((!!row.type) ? row.type : '');
	//setRuleStatus((!!row.rule) ? row.rule : '');
});
</script>