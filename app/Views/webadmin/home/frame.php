<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <title>后台管理</title>
  <link rel="stylesheet" href="<?=base_url(). ((ENVIRONMENT=='development') ? '/jsdev' : '/dist')?>/css/layui.css">
</head>
<style>
#moduleTab .layui-tab-content{padding-bottom: 50px;}
#viewright-tab .layui-card-body, #viewright-win .layui-card-body{padding:0px;}
.layui-timeline-item .layui-elem-quote{padding:5px;margin-bottom: 5px;}
#viewright-tab .layui-text p,#viewright-win .layui-text p {margin:0px;}
.layui-table thead th {font-weight:500;}
.layui-table-tool{padding:5px;}
.layui-transfer-active {margin:0 10px;}
.layui-form-item .layui-input-inline{width:280px;}
.layui-timeline-item{padding-bottom: 5px;}
.avatar-min{border-radius:100%;width:20px;height:20px;padding-bottom:2px;}
.avatar-sma{border-radius:100%;width:28px;height:28px;}
.avatar-mid{border-radius:100%;width:40px;height:40px;}
.avatar-big{border-radius:100%;width:60px;height:60px;}
</style>
<body>
<div class="layui-layout layui-layout-admin">
  <div class="layui-header">
    <div class="layui-logo layui-hide-xs layui-bg-black">后台管理</div>
    <!-- 头部区域（可配合layui 已有的水平导航） -->
    <ul class="layui-nav layui-layout-left">
      <!-- 移动端显示 -->
      <li class="layui-nav-item layui-show-xs-inline-block layui-hide-sm" ey-event="menuLeft">
        <i class="layui-icon layui-icon-spread-left"></i>
      </li>
      <!--
		<?php foreach ($menu as $k => $v) { ?>
			<li class="layui-nav-item">
			<?php if (!empty($v['submenu'])) { ?>
				<a class="" href="javascript:;"><?=$v['name']?></a>
				<dl class="layui-nav-child">
				<?php foreach ($v['submenu'] as $_k => $_v) { ?>
					<dd><a href="javascript:;" class="menu_left menu_getpage" title="<?=$_v['name']?>" route="/<?=$_v['code']?>"><i class="layui-icon <?=(empty($v['icon']) ? '' : esc($v['icon']))?>"></i> <?=$_v['name']?></a></dd>			
				<?php } ?>
				</dl>
			<?php } else { ?>
				<a class="menu_getpage" href="javascript:;" title="<?=$v['name']?>" route="/<?=$v['code']?>"><i class="layui-icon <?=$v['icon']?>"></i> <?=$v['name']?></a>
			<?php } ?>
			</li>
		<?php } ?>
		-->
    </ul>
    
    <ul class="layui-nav layui-layout-right">
		<li class="layui-nav-item">
		<a href="javascript:;"><i class='layui-icon layui-icon-read'></i> 使用手册</a>
		</li>
		<li class="layui-nav-item">
		<a href="javascript:;" ey-event="openSysTips">消息<span class="layui-badge" id="systips-new" <?=empty($tipsnumb) ? 'style="display:none;"' : ''?>><?=empty($tipsnumb) ? '' : $tipsnumb ?></span></a>
		</li>
      <li class="layui-nav-item layui-hide layui-show-md-inline-block">
        <a href="javascript:;">
          <img src="<?=$login['avatar']?>" class="layui-nav-img avatar-sma avatar-<?=$login['uid']?>">
          <?=$login['name']?>【<?=$login['rolename']?>】
        </a>
        <dl class="layui-nav-child">
        <?php if (($login['rid'] == '1') || (isset($login['act']['sysuser']['setmine']))) { ?>
		 <dd><a href="javascript:;" class="menu_left" title="<i class='layui-icon layui-icon-username'></i> 人个设置" ey-event="openRightView" route="/sysuser/setmine"><i class="layui-icon layui-icon-username"></i> 人个设置</a></dd>
		 <?php } ?>
          <dd><a href="<?=site_url('webadmin/sysuser/logout')?>"><i class="layui-icon layui-icon-logout"></i> 退出登录</a></dd>
        </dl>
      </li>
      <li class="layui-nav-item"  ey-event="menuRight" lay-unselect>
        <a href="javascript:;">
          <i class="layui-icon layui-icon-refresh-3"></i>
        </a>
      </li>
    </ul>
  </div>
  
  <div class="layui-side layui-bg-black">
    <div class="layui-side-scroll">
      <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
      <ul class="layui-nav layui-nav-tree" lay-filter="test" id="menu_left">

		<li class="layui-nav-item layui-nav-itemed"> 
			<a class="menu_getpage" href="javascript:;" title="我的仪表盘" route="/home/center"><i class="layui-icon layui-icon-console"></i> 仪表盘</a>
		</li>
		<?php foreach ($menu as $k => $v) { ?>
			<li class="layui-nav-item layui-nav-itemed">
			<?php if (!empty($v['submenu'])) { ?>
				<a class="" href="javascript:;"><i class="layui-icon <?=$v['icon']?>"></i> <?=$v['name']?></a>
				<dl class="layui-nav-child">
				<?php foreach ($v['submenu'] as $_k => $_v) { ?>
					<dd><a href="javascript:;" class="menu_left menu_getpage" title="<?=$_v['name']?>" route="/<?=$_v['code']?>"><?=$_v['name']?></a></dd>			
				<?php } ?>
				</dl>
			<?php } else { ?>
				<a class="menu_getpage" href="javascript:;" title="<?=$v['name']?>" route="/<?=$v['code']?>"><i class="layui-icon <?=$v['icon']?>"></i> <?=$v['name']?></a>
			<?php } ?>
			</li>
		<?php } ?>
		<li class="layui-nav-item"><a href="<?=base_url('webadmin/sysuser/logout')?>"><i class="layui-icon layui-icon-logout"></i> 登出</a></li>
      </ul>
    </div>
  </div>
	<div class="layui-body" style="padding:0 10px 0 10px;">
		<!-- 内容主体区域 -->
			<div class="layui-tab layui-tab-card" lay-allowClose="true"  lay-filter="moduleTab" id="moduleTab">
				<ul class="layui-tab-title">
				</ul>
				<div class="layui-tab-content" style="padding:10px;">
				</div>
			</div>
	</div>
	<!--<div class="layui-footer">Base v0.1</div>-->
</div>
<script type="text/html" id="avatar-index-tpl">
	<img src="{{d.avatar}}" class="avatar-sma"/>
</script>
<script type="text/html" id="image-thumb-tpl">
	{{# if (d.type == '1') { }}
	<div class="showimageview">
	<img src="{{d.thumb}}" style="max-width:100px;max-height:30px;" layer-src="{{d.url}}" alt="{{d.filename}}图片不存在" ey-event="showImageView" />
	</div>
	{{# }else if(d.type == '2') {  }}
	<i class="layui-icon layui-icon-file" style="font-size: 30px; color: #1E9FFF;" ey-event="setFileDown"></i>
	{{# }else {  }}
	
	{{# } }}
</script>
<script type="text/html" id="view-row-tpl">
<table class="layui-table" lay-skin="line">
	<colgroup><col width="150"><col></colgroup>
	<thead><tr><th>键</th><th>值</th></tr></thead>
	<tbody>
	{{# 
		var setBaseLang = function(key){
			return EY_Base.lang[key] || '';
		};
		var setRenderItem = function(key,val){

			if (!!d.fields[key]){
				if ((key == 'avatar') || (key == 'image')){
				}else if ((d.fields[key].type == 'datetime') || (d.fields[key].type == 'date')){
					val = ((val | 0) === val) ? d.util.toDateString(val*1000, 'yyyy-MM-dd HH:mm:ss') : val;
				}else if ((d.fields[key].type == 'select') || (d.fields[key].type == 'checkbox') || (d.fields[key].type == 'radio')){
					if (!!d.fields[key].setting){
						var _setting = JSON.parse(d.fields[key].setting);
						val = (!!_setting[val]) ? _setting[val] : val;
					} 
				}
			}else{
				if ((d.module == 'sysuser') && (key == 'avatar')){
					val = '<img src="'+EY_Base.ajxurl+val+'" class="avatar-sma">';
				}
			}
			return val;
		};
	}}
	{{#  layui.each(d.data, function(index, item){  if (!!item) { }}
	<tr><td>{{ setBaseLang(index) ? setBaseLang(index) : d.fields[index].title  }}</td><td>{{ setRenderItem(index,item) }}</td></tr>
	{{# } }) }}
	</tbody>
</table>
</script>
<script src="<?=base_url(). ((ENVIRONMENT=='development') ? '/jsdev' : '/dist')?>/layui.js"></script>
<script>
EY_Base = {};
EY_Base.ajxurl = "<?=base_url('webadmin')?>";
EY_Base.path = "<?=((ENVIRONMENT=='development') ? 'jsdev' : 'dist')?>/";
EY_Base.lang = <?=json_encode($lang)?>;
EY_Base.version = '1.26';
layui.config({version:EY_Base.version,base:'/'+EY_Base.path}).use("frame");
</script>
</body>
</html>