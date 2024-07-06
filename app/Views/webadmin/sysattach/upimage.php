<div class="layui-form-item">
	<div class="layui-inline">
		<label class="layui-form-label">版块图片</label>
		<div class="layui-input-inline" style="width:200px;">
			<div class="layui-upload-drag"  style="padding:10px;">
			  <i class="layui-icon layui-icon-upload-drag"></i> 
			  <p>点击上传，或将文件拖拽到此处</p>
			</div>
		</div>
		<div class="layui-input-inline" style="width:220px;">
			 <div class="layui-hide" id="imageview"><img src="" alt="上传成功后渲染" style="max-width:220px;max-height:110px;"></div>
		</div>
	</div>
  </div>
<div class="layui-form-item">
  <div class="layui-inline">
	  <label class="layui-form-label">图片裁剪</label>
	  <div class="layui-input-inline" style="width: 100px;">
		<input type="text" name="imagew" placeholder="裁剪宽度:px" autocomplete="off" class="layui-input">
	  </div>
	  <div class="layui-form-mid">-</div>
	  <div class="layui-input-inline" style="width: 100px;">
		<input type="text" name="imageh" placeholder="裁剪高度:px" autocomplete="off" class="layui-input">
	  </div>
	  <label class="layui-form-label">裁剪规格</label>
	  <div class="layui-input-inline" style="width:100px;">
		<select name="imagecrop" lay-filter="setImageCrop">
		  <option value="">可选择规格</option>
		  <option value="1">PC版适应</option>
		  <option value="2">手机版适应</option>
		</select>
	  </div>
	</div>
</div>
<script>

layui.use(['element','form','eybase','upload','dropdown'], function(){
	var laytpl = layui.laytpl
	,form = layui.form
	,eybase = layui.eybase
	,$ = layui.jquery
	,upload = layui.upload
	,dropdown = layui.dropdown
	,element = layui.element;
	var module = '<?=$module?>';
	var tag = '<?=$tag?>';	
	var row = {};
	row.thumb = '<?=(!empty($thumb)) ? $thumb : ""?>';
	
	var setImageCrop = function(type){
		if (type == '1'){
			form.val("form-<?=$init['tag']?>", {"imagew":1280,"imageh":640});
		}else if (type == '2'){
			form.val("form-<?=$init['tag']?>", {"imagew":640,"imageh":320});
		}		
	}
	
	form.on('select(setImageCrop)', function(data){ setImageCrop(data.value);});      	
	
	if (row.thumb != ''){
		layui.$('#imageview').removeClass('layui-hide').find('img').attr('src', row.thumb);
	}else{
		setImageCrop(2);
	}

	var _val = form.val("form-"+tag);
	
	var postdata = {};
	postdata.module = module;
	postdata.imagew = !!_val.imagew ? _val.imagew : '';
	postdata.imageh = !!_val.imageh ? _val.imageh : '';
	//console.log("_val=>",_val);
	upload.render({
		elem: $("#form-"+tag).find(".layui-upload-drag")
		,url: EY_Base.ajxurl+'/sysattach/upimage'
		,size: 2048
		,data: postdata
		,accept: 'images'
		,acceptMime: 'image/*'
		,done: function(d){
			if (d.code == '1'){
				layer.msg('上传成功');
		 		layui.$('#imageview').removeClass('layui-hide').find('img').attr('src', d.thumb);
				$("#form-"+tag).find("input[name='image']").val(d.url);
				$("#form-"+tag).find("input[name='thumb']").val(d.thumb);
			}else{
				layer.msg(d.msg);
			}
		}
	});
});

</script>