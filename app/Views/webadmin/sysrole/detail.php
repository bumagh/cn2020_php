<div class="layui-panel" style="margin:10px;padding:10px;">
<form class="layui-form layui-form-pane" action="" id="form-<?=$init['tag']?>" lay-filter="form-<?=$init['tag']?>">
			  <div class="layui-form-item">
				<label class="layui-form-label">角色名称</label>
				<div class="layui-input-block">
				  <input type="text" name="name" required  lay-verify="required" placeholder="请输入角色名称" autocomplete="off" class="layui-input">
				</div>
			  </div>
			  <div class="layui-form-item">
				<label class="layui-form-label">模块配置</label>
				<div class="layui-input-block">
					<div class="moduleSelect"></div>
				</div>
			  </div>
			  <div class="layui-form-item layui-form-text">
				<label class="layui-form-label">角色说明</label>
				<div class="layui-input-block">
				  <textarea name="memo" placeholder="角色说明" class="layui-textarea"></textarea>
				</div>
			  </div>
			  <div class="layui-form-item">
			  <fieldset class="layui-elem-field layui-field-title"> <legend>权限配置</legend></fieldset>
			  <div class="layui-collapse actionsDiv" style="padding-bottom:20px;"></div>
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
		</div>
</form>
<script type="text/html" class="tpl_actions">
{{# 
	var actall = <?=json_encode($actionsall)?>;
	var getActItems = function(code, acthas, actchecked,mid,actstr){
		var s = '';
		var st = 'checked';
		for (var k in acthas){
			if (!!actall[acthas[k]]){
				if (actchecked.length == 0)
					 st =  'checked' ;
				else 
					st = (!!actchecked[acthas[k]]) ? 'checked' : '';
				s += '<input lay-skin="primary" type="checkbox" '+ st +' name="'+code+'['+acthas[k]+']" title="'+actall[acthas[k]]+'">'
			}
		}
		s += '<input type="hidden" name="modulelist['+mid+'][actions]" value="'+actstr+'">';
		return s;
	};
}}
  <div class="layui-colla-item moduelitem{{d.mid}}">
	<h2 class="layui-colla-title">{{d.name}}</h2>
	<div class="layui-colla-content layui-show">
		<input type="hidden" name="modulelist[{{d.mid}}][mid]" value="{{d.mid}}">
		<input type="hidden" name="modulelist[{{d.mid}}][value]" value="{{d.code}}">
		<input type="hidden" name="modulelist[{{d.mid}}][title]" value="{{d.name}}">
		{{ getActItems(d.code,d.actions, d.checked, d.mid,d.actionstr) }}
	</div>
  </div>
</script>
<script>
layui.use(['util','transfer','element','laytpl','form','eybase','upload','dropdown'], function(){
	var laytpl = layui.laytpl
	,form = layui.form
	,eybase = layui.eybase
	,$ = layui.jquery
	,util = layui.util
	,upload = layui.upload
	,transfer = layui.transfer
	,dropdown = layui.dropdown
	,element = layui.element;
	
	var module = '<?=$init['module']?>';
	var tag = '<?=$init['tag']?>';
	var row = <?=(!empty($init['row']) ? json_encode($init['row']) : '{}')?>;		
	
	var curobj = $("#form-"+tag);
	var moduledata = <?=json_encode($mdata)?>;
	var actselect = {};
	var moduleselect = [];
	<?php if (!empty($modulelist)) {
	 foreach ($modulelist as $k => $v) { ?>
		moduleselect.push('<?=$k?>');
		actselect.<?=$k?> = <?=json_encode($v)?>;
	<?php }
	}
	?>
	var renderActions = function(obj){
		var d = {};
		for (var k in obj){
			d.mid =  obj[k].mid;
			d.name = obj[k].title;
			d.code = obj[k].value;
			d.actionstr = obj[k].actions;
			d.actions = obj[k].actions.split(',');
			d.checked = (!$.isEmptyObject(actselect)) ? (!!actselect[d.code] ? actselect[d.code] : [])  : [] ;
			laytpl($(".tpl_actions").html()).render(d, function(s){
				curobj.find(".actionsDiv").append(util.unescape(s));
			});
		}
		element.render();
		form.render();
	}
	transfer.render({
		elem: curobj.find('.moduleSelect')
		,title: ['可选模块', '已选模块']
		,data: moduledata
		,value: moduleselect
		,id : 'modulelist-'+tag
		,onchange: function(obj, index){
			if (index == 0){
				renderActions(obj);
			}else if (index == 1){
				for (var k in obj){
					curobj.find(".actionsDiv").find('.moduelitem'+obj[k].mid).remove();
				}
			}
		}
	})


	row.modulelist = transfer.getData('modulelist-'+tag); 
	renderActions(row.modulelist);
	
	eybase.setDetailEvents(module,tag,row);
});
</script>