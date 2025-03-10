<?php

return [
	'message' =>[
				'task_process'		=> '你有新任务『{taskname}』需要处理。',
				'task_audit' 		=> '你有新任务『{taskname}』需要审核。',
				'task_audit_pass'	=>	'任务审核通过',
				'task_audit_fail'	=>	'任务审核失败，需要重新提交任务',
				'uninvit'	=> '解绑请求',
				'levelup'	=> '等级提升',
				'cashjoin'	=> '竞拍结果',
				'friendadd'	=> '好友申请',
				],
	'pocketlog'	=>[
					'qiandao'	=> '签到',
					'invited'	=> '收取绑定',
					'cashjoin'	=> '现金竞拍',
					'recharge'	=> '充值奖励',
					'levelup'	=> '会员升级',
					'manual'	=> '手动变更',
				],		
	'actions'=>['index'		=> '索引',
				'view'		=> '明细',
				'add'		=> '添加',
				'edit'		=> '编辑',
				'del'		=> '删除',
				'delm'		=> '批量删除',
				'clear'		=> '清空',
				'priv'		=> '局部',
				'upimage'	=> '上传图片',
				'upfile'	=> '上传文件',
				'setmine'	=> '个人设置'],
	'fields' =>[
				'id'		=>'ID',
				'uid'		=>'用户ID',
				'rid'		=>'角色ID',
				'mid'		=>'模块ID',
				'fid'		=>'字段ID',
				'wid'		=>'工作ID',
				'prid'		=>'项目角色ID',
				'ptid'		=>'任务ID',
				'avatar'	=>'头像',
				'user'		=>'用户',
				'username'	=>'用户名',
				'name'		=>'名称',
				'title'		=>'标题',
				'lvl'		=>'等级',
				'invitcode'	=>'邀请码',
				'content'	=>'内容',
				'role'		=>'角色',
				'email'		=>'邮箱',
				'phone'		=>'手机号',
				'status'	=>'状态',
				'linkman'	=>'联系人',
				'url'		=>'网址',
				'memo'		=>'备注',
				'tname'		=>'表名',
				'fields'	=>'字段',
				'code'		=>'编码',
				'type'		=>'类型',	
				'validate'	=>'验证项',
				'force'		=>'必填项',
				'rule'		=>'验证规则',
				'info'		=>'说明',
				'sort'		=>'排序',
				'time'		=>'时间',
				'btime'		=>'开始时间',
				'etime'		=>'截止时间',	
				'created_at'=>'创建时间',
				'updated_at'=>'更新时间',
				'modulelist'=>'模块列表',
				'audituid'	=>'审核者ID',
				'adduid'	=>'创建ID',
				'edituid'	=>'更新ID',
				'act'		=>'操作'
				],
];
