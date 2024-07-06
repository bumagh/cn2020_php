<?php

/**
 * This file is part of the CodeIgniter 4 framework.
 *
 * (c) CodeIgniter Foundation <admin@codeigniter.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

// Validation language settings
return [
	// Core Messages
	'noRuleSets' => '验证配置中没有指定规则集。',
	'ruleNotFound' => '{0} 不是有效规则。',
	'groupNotFound' => '{0} 不是验证规则组。',
	'groupNotArray' => '{0} 规则组必须是一个数组。',
	'invalidTemplate' => '{0} 不是有效的验证模板。',
	// 规则消息
	'alpha' => ' {field} 只能包含字母字符。',
	'alpha_dash' => ' {field} 只能包含字母数字、下划线和短划线字符。',
	'alpha_numeric' => ' {field} 只能包含字母数字字符。',
	'alpha_numeric_punct' => ' {field} 只能包含字母数字字符、空格和~！ # $ % & * - _ + = | : .人物。',
	'alpha_numeric_space' => ' {field} 只能包含字母数字和空格字符。',
	'alpha_space' => ' {field} 只能包含字母字符和空格。',
	'decimal' => ' {field} 必须包含十进制数。',
	'differs' => ' {field} 必须与 {param} 字段不同。',
	'equals' => ' {field} 必须完全是：{param}。',
	'exact_length' => ' {field} 的长度必须正好是 {param} 个字符。',
	'greater_than' => ' {field} 必须包含大于 {param} 的数字。',
	'greater_than_equal_to' => ' {field} 必须包含大于或等于 {param} 的数字。',
	'hex' => ' {field} 只能包含十六进制字符。',
	'in_list' => ' {field} 必须是以下之一：{param}。',
	'integer' => ' {field} 必须包含整数。',
	'is_natural' => ' {field} 只能包含数字。',
	'is_natural_no_zero' => ' {field} 只能包含数字并且必须大于零。',
	'is_not_unique' => ' {field} 必须包含数据库中先前存在的值。',
	'is_unique' => ' {field} 已存在，请修改。',
	'less_than' => ' {field} 必须包含小于 {param} 的数字。',
	'less_than_equal_to' => ' {field} 必须包含小于或等于 {param} 的数字。',
	'matches' => ' {field} 与 {param} 字段不匹配。',
	'max_length' => ' {field} 的长度不能超过 {param} 个字符。',
	'min_length' => ' {field} 的长度必须至少为 {param} 个字符。',
	'not_equals' => ' {field} 不能是：{param}。',
	'not_in_list' => ' {field} 不能是以下之一：{param}。',
	'numeric' => ' {field} 必须只包含数字。',
	'regex_match' => ' {field} 的格式不正确。',
	'required' => ' {field} 是必需的。',
	'required_with' => '当 {param} 存在时， {field} 是必需的。',
	'required_without' => '当 {param} 不存在时， {field} 是必需的。',
	'string' => ' {field} 必须是有效的字符串。',
	'timezone' => ' {field} 必须是有效的时区。',
	'valid_base64' => ' {field} 必须是有效的 base64 字符串。',
	'valid_email' => ' {field} 必须包含有效的电子邮件地址。',
	'valid_emails' => ' {field} 必须包含所有有效的电子邮件地址。',
	'valid_ip' => ' {field} 必须包含有效 IP。',
	'valid_url' => ' {field} 必须包含有效的 URL。',
	'valid_date' => ' {field} 必须包含有效日期。',

	// 信用卡
	'valid_cc_number' => ' {field} 似乎不是有效的信用卡号。',

	// 文件
	'uploaded' => ' {field} 不是一个有效的上传文件。',
	'max_size' => ' {field} 文件太大。',
	'is_image' => ' {field} 不是有效的上传图片文件。',
	'mime_in' => ' {field} 没有有效的 mime 类型。',
	'ext_in' => ' {field} 没有有效的文件扩展名。',
	'max_dims' => ' {field} 要么不是图像，要么太宽或太高。',
	
	// EyRules:
	'is_unique2' => ' 该项已存在，请修改。',	
];
