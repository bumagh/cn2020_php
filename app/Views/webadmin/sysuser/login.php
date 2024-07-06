<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title></title>
<link rel="stylesheet" type="text/css" href="/<?=((ENVIRONMENT=='development') ? 'jsdev' : 'dist')?>/css/layui.css">
<style>
.online-images{cursor:pointer;}
</style>
<script type="text/javascript" src="/<?=((ENVIRONMENT=='development') ? 'jsdev' : 'dist')?>/layui.js"></script>
</head>
<style>
.fox-width-m {margin: 50px auto 0;max-width: 500px;}
.field {position: relative;}
.button-block{width:100%}
.fox-width-m .layui-tab-card > .layui-tab-title li {font-size: 16px;padding: 0 20px;}
.passcode {
    border-left: 1px solid #ddd;
    border-radius: 0 4px 4px 0;
    height: 35px;
    line-height: 32px;
    margin: 1px;
    position: absolute;
    right: 0;
    text-align: center;
    top: 0;
}
</style>
<body>
    <div class="layui-layout layui-layout-admin layui-box">				
		<div class="container">
			<div class="line">
				<div class="layui-tab-item text-center layui-show" style="padding:10px">
					<div class="fox-width-m">
						<div class="layui-tab layui-tab-card" lay-filter="login">
							<ul class="layui-tab-title">
							  <li class="layui-this">帐号登陆</li>
							</ul>
							<div class="layui-tab-content">
								<div class="layui-tab-item layui-show" style="padding:10px">
									<form method="post" class="layui-form">
										<div class="fox-form">
<!--											<div style="text-align:right"><a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=2494322930&site=qq&menu=yes" style="text-decoration:underline">忘记密码？</a></div>-->
											<fieldset class="layui-elem-field layui-field-title">
											  <legend>登陆</legend>
											</fieldset>
											<div class="layui-form-item">
												<label class="layui-form-label">帐号</label>
												<div class="layui-input-block">
													<input class="layui-input" name="username" lay-verify="required" autocomplete="off" placeholder="请输入用户帐号" type="text">
													<i class="icon icon-user"></i>
												</div>
											</div>

											<div class="layui-form-item">
												<label class="layui-form-label">密码</label>
												<div class="layui-input-block">
													<input class="layui-input" name="passwd" lay-verify="required" autocomplete="off" placeholder="请输入用户密码" type="password">
													<i class="icon icon-key"></i>
												</div>
											</div>
											<div class="layui-form-item">
												<label class="layui-form-label">验证码</label>
												<div class="layui-input-block">
													<input class="layui-input" name="vercode" lay-verify="required" autocomplete="off" placeholder="填写右侧的验证码" type="text">
													<img src="<?=base_url()?>/tools/vcode" name="checkCodeImg" id="login" class="passcode" height="32" border="0" width="80">
												</div>
											</div>
											<div class="form-group">
												<div class="field">
													<button class="layui-btn button-block" lay-submit="" lay-filter="login">立即登陆</button>
												</div>
											</div>
										</div>
									</form>
								</div>								
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<script>
var URL = "<?=base_url('webadmin')?>/";

layui.use(['element', 'layer', 'form'], function(){
  var element = layui.element
  ,layer = layui.layer
  ,form = layui.form
  ,$ = layui.$;
  
	form.verify({
		passwd_confirm: function(value){
			var passwd = $("#passwd").val();
			if (passwd != value){
				return '抱歉，两次输入密码不一致';
			}
		}
	});
    form.on('submit(login)', function(data){
		var i = layer.load(2);
		$.post(URL+'/sysuser/login', data.field, function(d){
			retLogindo(d,i);
		},'json');
		return false;
	});
	form.on('submit(register)', function(data){
		var i = layer.load(2);
		$.post(URL+'/sysuser/reg', data.field, function(d){
			retRegdo(d,i);
		},'json');
		return false;
	});
	element.on('tab(login)', function(data){
		changeverify(data.index+1);
	});

	$("#login").on("click", function(){
		changeverify(1);
	});
	var retRegdo = function(ret,i){
		if (1 == ret.status) {
			layer.msg(ret.msg);
			location.href = ret.url;
		} else if (2 == ret.status){
			 layer.close(i);
			  layer.alert(ret.msg, {
				closeBtn: 0
			  });
			changeverify(2);
		} else {
			layer.close(i);
			layer.msg(ret.msg);
			changeverify(2);
			return false;
		}
	}

	var retLogindo = function(ret,i){
		if (1 == ret.code) {
			var index = undefined;
			/*
			if (window.name) {
				index = parent.layer.getFrameIndex(window.name);
			}*/
			if ($.isEmptyObject(ret.url)) {
				layer.close(i);
				layer.msg(ret.msg);
				return false;
			} else {
				if ('reload' == ret.url) {
					if (index == undefined) {
						parent.location.reload();
					} else {
						parent.layer.close(index);
						parent.location.reload();
					}
				} else if (index == undefined) {
					location.href = ret.url;
				} else {
					parent.layer.close(index);
					parent.location.href = ret.url;
				}
			}
		} else if (2 == ret.code){
			layer.close(i);
			layer.msg(ret.msg);
			changeverify(1);
			return false;
		} else {
			layer.close(i);
			layer.msg(ret.msg);
			changeverify(1);
			return false;
		}
	}

	var changeverify = function (id){
		var ee;
		if (id == 1) ee = 'login';
		if (id == 2) ee = 'register';
		$("#"+ee).attr('src', '<?=base_url()?>/tools/vcode' + '/' + Math.random());
	}	
	
});

</script>
</body>

</html>