/*
 Navicat MySQL Data Transfer

 Source Server         : RDS_hangzhou(H)
 Source Server Type    : MySQL
 Source Server Version : 80025
 Source Host           : servicecenter.mysql.rds.aliyuncs.com:3306
 Source Schema         : project_ey56

 Target Server Type    : MySQL
 Target Server Version : 80025
 File Encoding         : 65001

 Date: 06/11/2023 08:44:50
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for chat
-- ----------------------------
DROP TABLE IF EXISTS `chat`;
CREATE TABLE `chat` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `avatar` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `intro` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `limitmember` int DEFAULT '0',
  `limitonline` int DEFAULT '0',
  `membernumb` int DEFAULT '0',
  `roomtype` tinyint DEFAULT '0',
  `sort` int DEFAULT '0',
  `setting` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `template` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `func` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `themes` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `notice` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `status` tinyint DEFAULT '1',
  `recomm` tinyint DEFAULT '1',
  `memo` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `adduid` int DEFAULT NULL COMMENT '添加者ID',
  `edituid` int DEFAULT NULL COMMENT '最后编辑者ID',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of chat
-- ----------------------------
BEGIN;
INSERT INTO `chat` VALUES (1, '广告交友，百无禁忌', 'http://local.dz35:8888/source/plugin/ey_chatplus/images/group_logo.png', '让人找上你', 2, 2, 1, 0, 0, '{\"join\":2,\"join2\":\"111\",\"allowtalk\":0,\"join2circle\":12,\"savechat\":1,\"chatshow\":1,\"limitcontent\":100,\"limitspeed\":0,\"faceopen\":1,\"imageupload\":1,\"imagelimit\":1024,\"imagenotvisitor\":0,\"fileupload\":1,\"filelimit\":2048,\"filenotvisitor\":1,\"fileext\":\"zip|rar|7z|doc|docx|pdf\",\"atmail\":1,\"redbagopen\":1,\"redbagrel\":2,\"redbagname\":\"\\u7ea2\\u5305\",\"maskwords\":\"fuck,\\u50bb\\u903c,\\u5988\\u903c,\\u65e5\\u4f60,\\u64cd\\u4f60,\"}', '{\"list\":{\"widthval\":980,\"widthunit\":1},\"detail\":{\"widthval\":980,\"leftwidth\":40,\"leftunit\":1,\"middlewidth\":40,\"middleunit\":1,\"rightwidth\":20,\"rightunit\":1}}', NULL, 'eydef', '这是群公告', 1, 1, NULL, NULL, NULL, '2022-12-29 13:01:47', '2023-04-22 20:18:14', NULL);
INSERT INTO `chat` VALUES (8, '让百姓拥有自己的经济力量', NULL, '没有力量，你的诉求，你的利益就得不到保障，只有自身有力量才能寻求公平与正义！', 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, '2023-04-22 20:15:55', '2023-04-22 20:15:55', NULL);
INSERT INTO `chat` VALUES (9, '网站游戏交流群', NULL, '本网站游戏闲聊建议', 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, '2023-04-22 20:22:44', '2023-04-22 20:22:44', NULL);
INSERT INTO `chat` VALUES (10, '心理咨询', NULL, '', 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, '2023-05-18 17:03:21', '2023-05-18 17:03:21', NULL);
COMMIT;

-- ----------------------------
-- Table structure for chat_friend_content
-- ----------------------------
DROP TABLE IF EXISTS `chat_friend_content`;
CREATE TABLE `chat_friend_content` (
  `id` int NOT NULL AUTO_INCREMENT,
  `uid` int DEFAULT NULL,
  `fid` int DEFAULT NULL,
  `content` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `status` tinyint DEFAULT '1',
  `tag` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '',
  `adduid` int DEFAULT NULL COMMENT '添加者ID',
  `edituid` int DEFAULT NULL COMMENT '最后编辑者ID',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `uid` (`uid`) USING BTREE,
  KEY `oid` (`fid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of chat_friend_content
-- ----------------------------
BEGIN;
INSERT INTO `chat_friend_content` VALUES (1, 60, 89, 'Hello', 1, 'text', NULL, NULL, '2023-01-09 14:01:20', '2023-01-09 14:01:20', NULL);
INSERT INTO `chat_friend_content` VALUES (2, 60, 88, 'Hello?', 1, 'text', NULL, NULL, '2023-01-09 14:01:38', '2023-01-09 14:01:38', NULL);
INSERT INTO `chat_friend_content` VALUES (3, 106, 60, 'attach/thumb/1673246745_da9f40f8b50bcec396fc.jpg', 1, 'img', NULL, NULL, '2023-01-09 14:45:45', '2023-01-09 14:45:45', NULL);
INSERT INTO `chat_friend_content` VALUES (4, 88, 80, '聊天', 1, 'text', NULL, NULL, '2023-01-09 17:31:38', '2023-01-09 17:31:38', NULL);
INSERT INTO `chat_friend_content` VALUES (5, 88, 106, '你好', 1, 'text', NULL, NULL, '2023-01-09 17:37:37', '2023-01-09 17:37:37', NULL);
INSERT INTO `chat_friend_content` VALUES (6, 106, 88, '[微笑][微笑][微笑][微笑][微笑][微笑][微笑]', 1, 'text', NULL, NULL, '2023-01-09 19:06:53', '2023-01-09 19:06:53', NULL);
INSERT INTO `chat_friend_content` VALUES (7, 60, 80, 'Hello?', 1, 'text', NULL, NULL, '2023-01-10 15:12:36', '2023-01-10 15:12:36', NULL);
INSERT INTO `chat_friend_content` VALUES (8, 60, 88, '[蛋糕][生病]', 1, 'text', NULL, NULL, '2023-01-10 18:51:41', '2023-01-10 18:51:41', NULL);
INSERT INTO `chat_friend_content` VALUES (9, 60, 86, '加你好友了', 1, 'text', NULL, NULL, '2023-01-13 18:20:50', '2023-01-13 18:20:50', NULL);
INSERT INTO `chat_friend_content` VALUES (10, 60, 86, '请通过一下', 1, 'text', NULL, NULL, '2023-01-13 18:20:56', '2023-01-13 18:20:56', NULL);
INSERT INTO `chat_friend_content` VALUES (11, 88, 60, '[哭]', 1, 'text', NULL, NULL, '2023-01-14 18:13:07', '2023-01-14 18:13:07', NULL);
INSERT INTO `chat_friend_content` VALUES (12, 88, 60, '手机里面的文件怎么发？', 1, 'text', NULL, NULL, '2023-01-14 18:14:13', '2023-01-14 18:14:13', NULL);
INSERT INTO `chat_friend_content` VALUES (13, 88, 60, '收拾收拾', 1, 'text', NULL, NULL, '2023-01-14 18:14:24', '2023-01-14 18:14:24', NULL);
INSERT INTO `chat_friend_content` VALUES (14, 88, 60, '啊啊啊啊', 1, 'text', NULL, NULL, '2023-01-14 18:15:07', '2023-01-14 18:15:07', NULL);
INSERT INTO `chat_friend_content` VALUES (15, 88, 60, 'attach/thumb/1673700444_42cd2e3227b7fba47459.jpg', 1, 'img', NULL, NULL, '2023-01-14 20:47:25', '2023-01-14 20:47:25', NULL);
INSERT INTO `chat_friend_content` VALUES (16, 88, 60, '2020cn.cn', 1, 'text', NULL, NULL, '2023-01-15 10:09:06', '2023-01-15 10:09:06', NULL);
INSERT INTO `chat_friend_content` VALUES (17, 60, 88, '[哭][哭][哭]', 1, 'text', NULL, NULL, '2023-01-15 13:19:52', '2023-01-15 13:19:52', NULL);
INSERT INTO `chat_friend_content` VALUES (18, 60, 80, '[墨镜][墨镜][墨镜]', 1, 'text', NULL, NULL, '2023-01-15 13:20:05', '2023-01-15 13:20:05', NULL);
INSERT INTO `chat_friend_content` VALUES (19, 60, 80, '[墨镜][墨镜][墨镜]', 1, 'text', NULL, NULL, '2023-01-15 15:20:07', '2023-01-15 15:20:07', NULL);
INSERT INTO `chat_friend_content` VALUES (20, 60, 80, '[墨镜][墨镜][墨镜]', 1, 'text', NULL, NULL, '2023-01-15 15:24:20', '2023-01-15 15:24:20', NULL);
INSERT INTO `chat_friend_content` VALUES (21, 88, 107, '[抱拳]', 1, 'text', NULL, NULL, '2023-02-21 23:38:32', '2023-02-21 23:38:32', NULL);
INSERT INTO `chat_friend_content` VALUES (22, 107, 88, '[微笑]', 1, 'text', NULL, NULL, '2023-04-19 17:04:48', '2023-04-19 17:04:48', NULL);
INSERT INTO `chat_friend_content` VALUES (23, 125, 88, 'attach/thumb/1691483370_70547efeb532365016a8.jpeg', 1, 'img', NULL, NULL, '2023-08-08 16:29:30', '2023-08-08 16:29:30', NULL);
COMMIT;

-- ----------------------------
-- Table structure for chat_group_content
-- ----------------------------
DROP TABLE IF EXISTS `chat_group_content`;
CREATE TABLE `chat_group_content` (
  `id` int NOT NULL AUTO_INCREMENT,
  `rid` int DEFAULT '0',
  `uid` int DEFAULT NULL,
  `content` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `oid` int DEFAULT NULL,
  `status` tinyint DEFAULT '1',
  `tag` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '',
  `adduid` int DEFAULT NULL COMMENT '添加者ID',
  `edituid` int DEFAULT NULL COMMENT '最后编辑者ID',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `uid` (`uid`) USING BTREE,
  KEY `rid` (`rid`) USING BTREE,
  KEY `oid` (`oid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=264 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of chat_group_content
-- ----------------------------
BEGIN;
INSERT INTO `chat_group_content` VALUES (1, 1, 60, '这是什么', NULL, 1, 'text', NULL, NULL, '2023-01-03 13:46:15', '2023-01-09 14:00:12', '2023-01-09 14:00:12');
INSERT INTO `chat_group_content` VALUES (2, 1, 64, '你好，大家好', NULL, 1, 'text', NULL, NULL, '2023-01-03 13:56:10', '2023-01-09 13:48:28', '2023-01-09 13:48:28');
INSERT INTO `chat_group_content` VALUES (3, 2, 64, '在么？', 60, 1, 'text', NULL, NULL, '2023-01-03 15:23:23', '2023-01-09 13:48:26', '2023-01-09 13:48:26');
INSERT INTO `chat_group_content` VALUES (4, 3, 86, 'HELLOE', NULL, 1, 'text', NULL, NULL, '2023-01-04 11:05:20', '2023-01-09 14:00:12', '2023-01-09 14:00:12');
INSERT INTO `chat_group_content` VALUES (5, 1, 87, '搞什么搞？？', NULL, 1, 'text', NULL, NULL, '2023-01-04 14:26:28', '2023-01-09 14:00:12', '2023-01-09 14:00:12');
INSERT INTO `chat_group_content` VALUES (6, 1, 80, '全都是泡沫！！！！', NULL, 1, 'text', NULL, NULL, '2023-01-05 15:21:52', '2023-04-22 20:24:00', '2023-04-22 20:24:00');
INSERT INTO `chat_group_content` VALUES (7, 2, 80, '你是个什么东西？？？', NULL, 1, 'text', NULL, NULL, '2023-01-05 15:24:09', '2023-01-09 13:48:22', '2023-01-09 13:48:22');
INSERT INTO `chat_group_content` VALUES (8, 3, 88, 'YES', NULL, 1, 'text', NULL, NULL, '2023-01-05 15:34:01', '2023-01-15 08:56:50', '2023-01-15 08:56:50');
INSERT INTO `chat_group_content` VALUES (9, 3, 60, '@@@@@', NULL, 1, 'text', NULL, NULL, '2023-01-05 15:34:23', '2023-01-09 13:12:58', '2023-01-09 13:12:58');
INSERT INTO `chat_group_content` VALUES (10, 3, 81, 'TTTTTTTTT', NULL, 1, 'text', NULL, NULL, '2023-01-05 21:09:33', '2023-01-15 08:56:45', '2023-01-15 08:56:45');
INSERT INTO `chat_group_content` VALUES (11, 2, 81, 'FFFFFF', NULL, 1, 'text', NULL, NULL, '2023-01-05 21:10:48', '2023-01-15 08:56:45', '2023-01-15 08:56:45');
INSERT INTO `chat_group_content` VALUES (12, 1, 88, '你个小王八蛋子', NULL, 1, 'text', NULL, NULL, '2023-01-06 08:50:34', '2023-04-22 20:24:00', '2023-04-22 20:24:00');
INSERT INTO `chat_group_content` VALUES (13, 2, 60, '<div style=\"display: flex;align-items: center;word-wrap:break-word;\">222222</div>', NULL, 1, 'text', NULL, NULL, '2023-01-06 09:47:58', '2023-01-09 14:28:26', '2023-01-09 14:28:26');
INSERT INTO `chat_group_content` VALUES (14, 1, 60, '我来喝饮料\n', NULL, 1, 'text', NULL, NULL, '2023-01-06 09:50:22', '2023-04-22 20:24:00', '2023-04-22 20:24:00');
INSERT INTO `chat_group_content` VALUES (15, 2, 60, '冯更好', NULL, 1, 'text', NULL, NULL, '2023-01-06 09:53:31', '2023-01-09 14:28:26', '2023-01-09 14:28:26');
INSERT INTO `chat_group_content` VALUES (16, 1, 60, '我来来亚', NULL, 1, 'text', NULL, NULL, '2023-01-06 09:58:35', '2023-04-22 20:23:49', '2023-04-22 20:23:49');
INSERT INTO `chat_group_content` VALUES (17, 3, 60, 'YYY', NULL, 1, 'text', NULL, NULL, '2023-01-06 10:18:37', '2023-01-09 14:21:19', '2023-01-09 14:21:19');
INSERT INTO `chat_group_content` VALUES (18, 3, 60, 'SSSS', NULL, 1, 'text', NULL, NULL, '2023-01-06 10:19:26', '2023-01-09 14:21:19', '2023-01-09 14:21:19');
INSERT INTO `chat_group_content` VALUES (19, 3, 60, 'OK', NULL, 1, 'text', NULL, NULL, '2023-01-06 10:19:43', '2023-01-09 14:21:19', '2023-01-09 14:21:19');
INSERT INTO `chat_group_content` VALUES (20, 3, 60, '22', NULL, 1, 'text', NULL, NULL, '2023-01-06 10:21:07', '2023-01-09 14:21:19', '2023-01-09 14:21:19');
INSERT INTO `chat_group_content` VALUES (21, 3, 60, 'fdsafsal', NULL, 1, 'text', NULL, NULL, '2023-01-06 10:21:19', '2023-01-09 14:21:19', '2023-01-09 14:21:19');
INSERT INTO `chat_group_content` VALUES (22, 3, 60, '[笑]', NULL, 1, 'text', NULL, NULL, '2023-01-06 11:05:20', '2023-01-15 08:56:40', '2023-01-15 08:56:40');
INSERT INTO `chat_group_content` VALUES (23, 1, 60, '哈哈哈', NULL, 1, 'text', NULL, NULL, '2023-01-06 15:46:46', '2023-04-22 20:23:49', '2023-04-22 20:23:49');
INSERT INTO `chat_group_content` VALUES (24, 3, 83, '3333', NULL, 1, 'text', NULL, NULL, '2023-01-06 15:51:46', '2023-01-15 08:56:40', '2023-01-15 08:56:40');
INSERT INTO `chat_group_content` VALUES (25, 3, 83, '44444', NULL, 1, 'text', NULL, NULL, '2023-01-06 15:51:53', '2023-01-09 14:20:32', '2023-01-09 14:20:32');
INSERT INTO `chat_group_content` VALUES (26, 3, 83, '55555', NULL, 1, 'text', NULL, NULL, '2023-01-06 15:52:00', '2023-01-09 14:20:32', '2023-01-09 14:20:32');
INSERT INTO `chat_group_content` VALUES (27, 3, 85, '6666666', NULL, 1, 'text', NULL, NULL, '2023-01-06 15:52:08', '2023-01-09 14:20:32', '2023-01-09 14:20:32');
INSERT INTO `chat_group_content` VALUES (28, 3, 80, '777777', NULL, 1, 'text', NULL, NULL, '2023-01-06 15:52:14', '2023-01-09 14:20:32', '2023-01-09 14:20:32');
INSERT INTO `chat_group_content` VALUES (29, 3, 60, '8888', NULL, 1, 'text', NULL, NULL, '2023-01-06 15:52:57', '2023-01-09 14:20:32', '2023-01-09 14:20:32');
INSERT INTO `chat_group_content` VALUES (30, 3, 60, '9999', NULL, 1, 'text', NULL, NULL, '2023-01-06 15:53:02', '2023-01-09 14:20:32', '2023-01-09 14:20:32');
INSERT INTO `chat_group_content` VALUES (31, 3, 81, '1010101', NULL, 1, 'text', NULL, NULL, '2023-01-06 15:53:12', '2023-01-09 14:20:32', '2023-01-09 14:20:32');
INSERT INTO `chat_group_content` VALUES (32, 3, 60, '[惊讶]', NULL, 1, 'text', NULL, NULL, '2023-01-06 17:16:34', '2023-01-09 14:20:32', '2023-01-09 14:20:32');
INSERT INTO `chat_group_content` VALUES (33, 2, 60, '[调皮]', NULL, 1, 'text', NULL, NULL, '2023-01-06 20:06:36', '2023-01-09 14:21:19', '2023-01-09 14:21:19');
INSERT INTO `chat_group_content` VALUES (34, 3, 60, 'fdsafdsafa', NULL, 1, 'text', NULL, NULL, '2023-01-06 20:28:34', '2023-01-09 14:20:32', '2023-01-09 14:20:32');
INSERT INTO `chat_group_content` VALUES (35, 3, 60, 'aaa', NULL, 1, 'text', NULL, NULL, '2023-01-06 20:30:50', '2023-01-09 14:20:32', '2023-01-09 14:20:32');
INSERT INTO `chat_group_content` VALUES (36, 3, 60, 'aaa', NULL, 1, 'text', NULL, NULL, '2023-01-06 20:30:52', '2023-01-09 14:20:28', '2023-01-09 14:20:28');
INSERT INTO `chat_group_content` VALUES (37, 3, 60, 'bbbb', NULL, 1, 'text', NULL, NULL, '2023-01-06 20:33:00', '2023-01-09 14:20:28', '2023-01-09 14:20:28');
INSERT INTO `chat_group_content` VALUES (38, 3, 60, 'ccc', NULL, 1, 'text', NULL, NULL, '2023-01-06 20:33:20', '2023-01-09 14:20:28', '2023-01-09 14:20:28');
INSERT INTO `chat_group_content` VALUES (39, 3, 60, 'DDD', NULL, 1, 'text', NULL, NULL, '2023-01-06 20:33:36', '2023-01-09 14:20:23', '2023-01-09 14:20:23');
INSERT INTO `chat_group_content` VALUES (40, 3, 60, 'EEE', NULL, 1, 'text', NULL, NULL, '2023-01-06 20:33:59', '2023-01-09 14:20:23', '2023-01-09 14:20:23');
INSERT INTO `chat_group_content` VALUES (41, 3, 60, 'FF', NULL, 1, 'text', NULL, NULL, '2023-01-06 20:34:29', '2023-01-09 14:20:23', '2023-01-09 14:20:23');
INSERT INTO `chat_group_content` VALUES (42, 3, 60, 'GGGG', NULL, 1, 'text', NULL, NULL, '2023-01-06 20:52:56', '2023-01-09 14:20:23', '2023-01-09 14:20:23');
INSERT INTO `chat_group_content` VALUES (43, 3, 60, 'HHH', NULL, 1, 'text', NULL, NULL, '2023-01-06 20:54:05', '2023-01-09 14:20:23', '2023-01-09 14:20:23');
INSERT INTO `chat_group_content` VALUES (44, 3, 60, 'iii', NULL, 1, 'text', NULL, NULL, '2023-01-06 20:54:26', '2023-01-09 14:20:23', '2023-01-09 14:20:23');
INSERT INTO `chat_group_content` VALUES (45, 1, 60, '你可以的', NULL, 1, 'text', NULL, NULL, '2023-01-06 20:59:29', '2023-01-09 14:20:23', '2023-01-09 14:20:23');
INSERT INTO `chat_group_content` VALUES (46, 2, 60, 'test', NULL, 1, 'text', NULL, NULL, '2023-01-06 21:04:03', '2023-01-09 14:20:23', '2023-01-09 14:20:23');
INSERT INTO `chat_group_content` VALUES (47, 1, 60, '是的', NULL, 1, 'text', NULL, NULL, '2023-01-06 21:05:20', '2023-01-09 14:20:23', '2023-01-09 14:20:23');
INSERT INTO `chat_group_content` VALUES (48, 1, 60, 'Yes', NULL, 1, 'text', NULL, NULL, '2023-01-06 21:06:58', '2023-01-09 14:20:23', '2023-01-09 14:20:23');
INSERT INTO `chat_group_content` VALUES (49, 1, 60, '略略略', NULL, 1, 'text', NULL, NULL, '2023-01-06 21:11:49', '2023-04-22 20:23:49', '2023-04-22 20:23:49');
INSERT INTO `chat_group_content` VALUES (50, 3, 60, 'JJJ', NULL, 1, 'text', NULL, NULL, '2023-01-06 21:13:52', '2023-01-09 14:20:28', '2023-01-09 14:20:28');
INSERT INTO `chat_group_content` VALUES (51, 1, 60, 'YYY', NULL, 1, 'text', NULL, NULL, '2023-01-06 21:14:02', '2023-04-22 20:23:49', '2023-04-22 20:23:49');
INSERT INTO `chat_group_content` VALUES (52, 2, 60, 'ABC', NULL, 1, 'text', NULL, NULL, '2023-01-06 21:14:12', '2023-01-09 14:21:19', '2023-01-09 14:21:19');
INSERT INTO `chat_group_content` VALUES (53, 3, 60, 'uuu', NULL, 1, 'text', NULL, NULL, '2023-01-06 21:16:03', '2023-01-09 14:20:28', '2023-01-09 14:20:28');
INSERT INTO `chat_group_content` VALUES (54, 3, 60, 'TT', NULL, 1, 'text', NULL, NULL, '2023-01-06 21:17:18', '2023-01-09 14:20:28', '2023-01-09 14:20:28');
INSERT INTO `chat_group_content` VALUES (55, 2, 60, 'YYY', NULL, 1, 'text', NULL, NULL, '2023-01-06 21:17:29', '2023-01-09 14:21:19', '2023-01-09 14:21:19');
INSERT INTO `chat_group_content` VALUES (56, 2, 60, 'ZZZ', NULL, 1, 'text', NULL, NULL, '2023-01-06 21:18:43', '2023-01-09 14:21:19', '2023-01-09 14:21:19');
INSERT INTO `chat_group_content` VALUES (57, 2, 60, 'XX', NULL, 1, 'text', NULL, NULL, '2023-01-06 21:19:01', '2023-01-09 14:21:19', '2023-01-09 14:21:19');
INSERT INTO `chat_group_content` VALUES (58, 1, 60, 'AA', NULL, 1, 'text', NULL, NULL, '2023-01-06 21:20:37', '2023-04-22 20:23:49', '2023-04-22 20:23:49');
INSERT INTO `chat_group_content` VALUES (59, 1, 60, 'BB', NULL, 1, 'text', NULL, NULL, '2023-01-06 21:21:15', '2023-01-09 14:26:19', '2023-01-09 14:26:19');
INSERT INTO `chat_group_content` VALUES (60, 1, 60, 'CC', NULL, 1, 'text', NULL, NULL, '2023-01-06 21:23:10', '2023-01-13 18:16:46', '2023-01-13 18:16:46');
INSERT INTO `chat_group_content` VALUES (61, 1, 60, 'DD', NULL, 1, 'text', NULL, NULL, '2023-01-06 21:27:19', '2023-01-09 14:26:13', '2023-01-09 14:26:13');
INSERT INTO `chat_group_content` VALUES (62, 2, 60, 'VV', NULL, 1, 'text', NULL, NULL, '2023-01-06 21:27:50', '2023-01-09 14:21:19', '2023-01-09 14:21:19');
INSERT INTO `chat_group_content` VALUES (63, 2, 60, 'R', NULL, 1, 'text', NULL, NULL, '2023-01-06 21:28:56', '2023-01-09 14:21:19', '2023-01-09 14:21:19');
INSERT INTO `chat_group_content` VALUES (64, 2, 60, 'RR', NULL, 1, 'text', NULL, NULL, '2023-01-06 21:29:35', '2023-01-09 14:21:19', '2023-01-09 14:21:19');
INSERT INTO `chat_group_content` VALUES (65, 2, 60, 'RRR', NULL, 1, 'text', NULL, NULL, '2023-01-06 21:29:58', '2023-01-09 14:21:19', '2023-01-09 14:21:19');
INSERT INTO `chat_group_content` VALUES (66, 2, 60, 'RRRR', NULL, 1, 'text', NULL, NULL, '2023-01-06 21:33:12', '2023-01-09 14:21:19', '2023-01-09 14:21:19');
INSERT INTO `chat_group_content` VALUES (67, 2, 60, 'RRRRR', NULL, 1, 'text', NULL, NULL, '2023-01-06 21:33:45', '2023-01-09 14:21:19', '2023-01-09 14:21:19');
INSERT INTO `chat_group_content` VALUES (68, 1, 60, 'EE', NULL, 1, 'text', NULL, NULL, '2023-01-07 09:00:14', '2023-01-13 18:16:46', '2023-01-13 18:16:46');
INSERT INTO `chat_group_content` VALUES (69, 1, 60, 'FF', NULL, 1, 'text', NULL, NULL, '2023-01-07 09:02:23', '2023-01-09 14:09:10', '2023-01-09 14:09:10');
INSERT INTO `chat_group_content` VALUES (70, 1, 60, 'GGG', NULL, 1, 'text', NULL, NULL, '2023-01-07 09:03:18', '2023-01-09 14:09:10', '2023-01-09 14:09:10');
INSERT INTO `chat_group_content` VALUES (71, 1, 60, 'HHH', NULL, 1, 'text', NULL, NULL, '2023-01-07 09:03:52', '2023-01-09 13:37:03', '2023-01-09 13:37:03');
INSERT INTO `chat_group_content` VALUES (72, 1, 60, '上', NULL, 1, 'text', NULL, NULL, '2023-01-07 09:07:12', '2023-01-09 13:37:03', '2023-01-09 13:37:03');
INSERT INTO `chat_group_content` VALUES (73, 1, 60, 'f', NULL, 1, 'text', NULL, NULL, '2023-01-07 09:11:16', '2023-01-09 13:37:03', '2023-01-09 13:37:03');
INSERT INTO `chat_group_content` VALUES (74, 1, 60, 'G', NULL, 1, 'text', NULL, NULL, '2023-01-07 09:11:51', '2023-01-09 13:37:03', '2023-01-09 13:37:03');
INSERT INTO `chat_group_content` VALUES (75, 2, 60, 'FF', NULL, 1, 'text', NULL, NULL, '2023-01-07 09:17:32', '2023-01-09 14:09:10', '2023-01-09 14:09:10');
INSERT INTO `chat_group_content` VALUES (76, 2, 60, 'HHHH', NULL, 1, 'text', NULL, NULL, '2023-01-07 09:18:35', '2023-01-09 14:09:10', '2023-01-09 14:09:10');
INSERT INTO `chat_group_content` VALUES (77, 1, 60, 'ABC', NULL, 1, 'text', NULL, NULL, '2023-01-07 09:21:37', '2023-01-09 13:37:03', '2023-01-09 13:37:03');
INSERT INTO `chat_group_content` VALUES (78, 1, 60, 'BBB', NULL, 1, 'text', NULL, NULL, '2023-01-07 09:22:26', '2023-01-09 13:37:03', '2023-01-09 13:37:03');
INSERT INTO `chat_group_content` VALUES (79, 1, 60, 'CCCC', NULL, 1, 'text', NULL, NULL, '2023-01-07 09:25:24', '2023-01-09 13:37:03', '2023-01-09 13:37:03');
INSERT INTO `chat_group_content` VALUES (80, 1, 60, 'DDD', NULL, 1, 'text', NULL, NULL, '2023-01-07 09:28:08', '2023-01-09 13:37:03', '2023-01-09 13:37:03');
INSERT INTO `chat_group_content` VALUES (81, 1, 60, 'EEE', NULL, 1, 'text', NULL, NULL, '2023-01-07 09:31:53', '2023-01-09 13:37:03', '2023-01-09 13:37:03');
INSERT INTO `chat_group_content` VALUES (82, 1, 60, 'FF', NULL, 1, 'text', NULL, NULL, '2023-01-07 09:35:35', '2023-01-09 13:37:03', '2023-01-09 13:37:03');
INSERT INTO `chat_group_content` VALUES (83, 2, 60, 'GGGGG', NULL, 1, 'text', NULL, NULL, '2023-01-07 09:36:02', '2023-01-09 14:09:10', '2023-01-09 14:09:10');
INSERT INTO `chat_group_content` VALUES (84, 2, 60, 'JJJJ', NULL, 1, 'text', NULL, NULL, '2023-01-07 09:37:51', '2023-01-09 14:09:10', '2023-01-09 14:09:10');
INSERT INTO `chat_group_content` VALUES (85, 1, 60, 'uuu', NULL, 1, 'text', NULL, NULL, '2023-01-07 09:38:16', '2023-01-09 14:09:10', '2023-01-09 14:09:10');
INSERT INTO `chat_group_content` VALUES (86, 1, 60, 'iiiii', NULL, 1, 'text', NULL, NULL, '2023-01-07 09:39:56', '2023-01-09 14:09:10', '2023-01-09 14:09:10');
INSERT INTO `chat_group_content` VALUES (87, 1, 60, 'JJJJ', NULL, 1, 'text', NULL, NULL, '2023-01-07 09:41:08', '2023-01-09 14:09:10', '2023-01-09 14:09:10');
INSERT INTO `chat_group_content` VALUES (88, 2, 60, 'XXXX', NULL, 1, 'text', NULL, NULL, '2023-01-07 09:41:38', '2023-01-09 14:09:10', '2023-01-09 14:09:10');
INSERT INTO `chat_group_content` VALUES (89, 3, 60, 'FFF', NULL, 1, 'text', NULL, NULL, '2023-01-07 09:50:47', '2023-01-09 14:09:05', '2023-01-09 14:09:05');
INSERT INTO `chat_group_content` VALUES (90, 2, 60, 'ZZZZ', NULL, 1, 'text', NULL, NULL, '2023-01-07 09:51:09', '2023-01-09 14:09:05', '2023-01-09 14:09:05');
INSERT INTO `chat_group_content` VALUES (91, 2, 60, 'AAAAAA', NULL, 1, 'text', NULL, NULL, '2023-01-07 09:52:39', '2023-01-09 14:09:05', '2023-01-09 14:09:05');
INSERT INTO `chat_group_content` VALUES (92, 1, 60, 'BBBBB', NULL, 1, 'text', NULL, NULL, '2023-01-07 09:52:56', '2023-01-09 14:09:05', '2023-01-09 14:09:05');
INSERT INTO `chat_group_content` VALUES (93, 1, 60, 'CCCC', NULL, 1, 'text', NULL, NULL, '2023-01-07 09:53:27', '2023-01-09 14:09:05', '2023-01-09 14:09:05');
INSERT INTO `chat_group_content` VALUES (94, 3, 60, 'afsdafaewf', NULL, 1, 'text', NULL, NULL, '2023-01-07 09:53:39', '2023-01-09 14:09:05', '2023-01-09 14:09:05');
INSERT INTO `chat_group_content` VALUES (95, 3, 60, 'FFUCCCCKKK', NULL, 1, 'text', NULL, NULL, '2023-01-07 09:55:14', '2023-01-09 14:09:05', '2023-01-09 14:09:05');
INSERT INTO `chat_group_content` VALUES (96, 3, 60, 'AAAAA', NULL, 1, 'text', NULL, NULL, '2023-01-07 09:57:05', '2023-01-09 14:09:05', '2023-01-09 14:09:05');
INSERT INTO `chat_group_content` VALUES (97, 2, 60, 'BBBBBBB', NULL, 1, 'text', NULL, NULL, '2023-01-07 10:01:28', '2023-01-09 14:09:05', '2023-01-09 14:09:05');
INSERT INTO `chat_group_content` VALUES (98, 2, 60, 'FFFFFDFewf', NULL, 1, 'text', NULL, NULL, '2023-01-07 10:02:18', '2023-01-09 14:09:05', '2023-01-09 14:09:05');
INSERT INTO `chat_group_content` VALUES (99, 2, 60, 'CCCCCCCCC', NULL, 1, 'text', NULL, NULL, '2023-01-07 10:02:38', '2023-01-09 14:09:02', '2023-01-09 14:09:02');
INSERT INTO `chat_group_content` VALUES (100, 2, 60, 'DDDDD', NULL, 1, 'text', NULL, NULL, '2023-01-07 10:03:43', '2023-01-09 14:09:02', '2023-01-09 14:09:02');
INSERT INTO `chat_group_content` VALUES (101, 4, 60, 'CCC', NULL, 1, 'text', NULL, NULL, '2023-01-07 10:04:47', '2023-01-09 14:09:02', '2023-01-09 14:09:02');
INSERT INTO `chat_group_content` VALUES (102, 3, 60, 'BBBBB', NULL, 1, 'text', NULL, NULL, '2023-01-07 10:16:50', '2023-01-09 14:09:02', '2023-01-09 14:09:02');
INSERT INTO `chat_group_content` VALUES (103, 3, 60, 'CCCCC', NULL, 1, 'text', NULL, NULL, '2023-01-07 10:16:56', '2023-01-09 14:09:02', '2023-01-09 14:09:02');
INSERT INTO `chat_group_content` VALUES (104, 3, 60, '[笑]', NULL, 1, 'text', NULL, NULL, '2023-01-07 10:17:01', '2023-01-09 14:09:02', '2023-01-09 14:09:02');
INSERT INTO `chat_group_content` VALUES (105, 3, 60, '[怒]fdsafsafFFdsfs[墨镜]fdsaf', NULL, 1, 'text', NULL, NULL, '2023-01-07 10:17:41', '2023-01-09 14:09:02', '2023-01-09 14:09:02');
INSERT INTO `chat_group_content` VALUES (106, 1, 60, 'DDDDD', NULL, 1, 'text', NULL, NULL, '2023-01-07 10:19:00', '2023-01-09 14:09:02', '2023-01-09 14:09:02');
INSERT INTO `chat_group_content` VALUES (107, 1, 60, 'XXX[惊讶]GGGG', NULL, 1, 'text', NULL, NULL, '2023-01-07 10:22:28', '2023-01-09 14:09:02', '2023-01-09 14:09:02');
INSERT INTO `chat_group_content` VALUES (108, 1, 60, '[羞]', NULL, 1, 'text', NULL, NULL, '2023-01-07 10:25:01', '2023-01-09 14:09:02', '2023-01-09 14:09:02');
INSERT INTO `chat_group_content` VALUES (109, 1, 60, '[笑]', NULL, 1, 'text', NULL, NULL, '2023-01-07 10:27:01', '2023-01-09 14:08:53', '2023-01-09 14:08:53');
INSERT INTO `chat_group_content` VALUES (110, 1, 60, '[墨镜]', NULL, 1, 'text', NULL, NULL, '2023-01-07 10:27:19', '2023-01-09 14:08:53', '2023-01-09 14:08:53');
INSERT INTO `chat_group_content` VALUES (111, 4, 60, '[抓狂]', NULL, 1, 'text', NULL, NULL, '2023-01-07 10:28:04', '2023-01-09 13:37:37', '2023-01-09 13:37:37');
INSERT INTO `chat_group_content` VALUES (112, 4, 60, '[怒]', NULL, 1, 'text', NULL, NULL, '2023-01-07 10:29:27', '2023-01-09 13:37:37', '2023-01-09 13:37:37');
INSERT INTO `chat_group_content` VALUES (113, 2, 60, 'EEEEE[笑]', NULL, 1, 'text', NULL, NULL, '2023-01-07 10:41:08', '2023-01-09 14:08:53', '2023-01-09 14:08:53');
INSERT INTO `chat_group_content` VALUES (114, 1, 60, '你好苏中战役', NULL, 1, 'text', NULL, NULL, '2023-01-07 11:08:49', '2023-01-09 14:00:21', '2023-01-09 14:00:21');
INSERT INTO `chat_group_content` VALUES (115, 1, 60, '[笑][调皮]', NULL, 1, 'text', NULL, NULL, '2023-01-07 11:08:53', '2023-01-09 14:00:21', '2023-01-09 14:00:21');
INSERT INTO `chat_group_content` VALUES (116, 1, 60, 'FFFF', NULL, 1, 'text', NULL, NULL, '2023-01-07 11:09:06', '2023-01-09 14:00:21', '2023-01-09 14:00:21');
INSERT INTO `chat_group_content` VALUES (117, 1, 89, '我就是我，李梅', NULL, 1, 'text', NULL, NULL, '2023-01-07 11:12:09', '2023-01-09 14:00:21', '2023-01-09 14:00:21');
INSERT INTO `chat_group_content` VALUES (118, 1, 89, '[囧]', NULL, 1, 'text', NULL, NULL, '2023-01-07 11:16:03', '2023-01-09 14:00:21', '2023-01-09 14:00:21');
INSERT INTO `chat_group_content` VALUES (119, 1, 89, '第几集', NULL, 1, 'text', NULL, NULL, '2023-01-07 11:16:07', '2023-01-09 14:00:21', '2023-01-09 14:00:21');
INSERT INTO `chat_group_content` VALUES (120, 1, 89, '[发呆]', NULL, 1, 'text', NULL, NULL, '2023-01-07 11:20:32', '2023-01-09 14:00:21', '2023-01-09 14:00:21');
INSERT INTO `chat_group_content` VALUES (121, 5, 60, 'fdsaf', NULL, 1, 'text', NULL, NULL, '2023-01-07 13:33:17', '2023-01-09 14:08:53', '2023-01-09 14:08:53');
INSERT INTO `chat_group_content` VALUES (122, 3, 60, '好好建好了！', NULL, 1, 'text', NULL, NULL, '2023-01-07 13:36:21', '2023-01-09 14:08:53', '2023-01-09 14:08:53');
INSERT INTO `chat_group_content` VALUES (123, 2, 60, 'attach/thumb/1673071872_3768d53491b322472784.jpeg', NULL, 1, 'img', NULL, NULL, '2023-01-07 14:11:12', '2023-01-09 14:08:53', '2023-01-09 14:08:53');
INSERT INTO `chat_group_content` VALUES (124, 2, 60, 'attach/thumb/1673072548_37004ed2f369f0e6dddf.jpg', NULL, 1, 'img', NULL, NULL, '2023-01-07 14:22:28', '2023-01-09 14:08:53', '2023-01-09 14:08:53');
INSERT INTO `chat_group_content` VALUES (125, 2, 60, 'attach/thumb/1673073179_853795e090247cf99735.jpeg', NULL, 1, 'img', NULL, NULL, '2023-01-07 14:32:59', '2023-01-09 14:08:53', '2023-01-09 14:08:53');
INSERT INTO `chat_group_content` VALUES (126, 5, 60, '[调皮]', NULL, 1, 'text', NULL, NULL, '2023-01-07 14:39:10', '2023-01-09 14:08:53', '2023-01-09 14:08:53');
INSERT INTO `chat_group_content` VALUES (127, 5, 60, 'attach/thumb/1673073774_ddbf6e0db1503e7d1f70.jpg', NULL, 1, 'img', NULL, NULL, '2023-01-07 14:42:54', '2023-01-09 14:08:53', '2023-01-09 14:08:53');
INSERT INTO `chat_group_content` VALUES (128, 2, 60, '很透彻', NULL, 1, 'text', NULL, NULL, '2023-01-07 15:24:51', '2023-01-09 14:08:50', '2023-01-09 14:08:50');
INSERT INTO `chat_group_content` VALUES (129, 1, 60, '搞什么？？？', NULL, 1, 'text', NULL, NULL, '2023-01-07 15:25:00', '2023-01-09 14:00:21', '2023-01-09 14:00:21');
INSERT INTO `chat_group_content` VALUES (130, 3, 60, '[怒]', NULL, 1, 'text', NULL, NULL, '2023-01-07 19:48:59', '2023-01-09 14:08:50', '2023-01-09 14:08:50');
INSERT INTO `chat_group_content` VALUES (131, 1, 89, '你是不是来搞笑的？？[吐]', NULL, 1, 'text', NULL, NULL, '2023-01-07 20:36:38', '2023-01-09 14:00:21', '2023-01-09 14:00:21');
INSERT INTO `chat_group_content` VALUES (132, 1, 89, 'fuck', NULL, 1, 'text', NULL, NULL, '2023-01-07 20:36:58', '2023-01-09 13:57:45', '2023-01-09 13:57:45');
INSERT INTO `chat_group_content` VALUES (133, 1, 60, 'gg', NULL, 1, 'text', NULL, NULL, '2023-01-08 08:57:45', '2023-01-09 14:00:21', '2023-01-09 14:00:21');
INSERT INTO `chat_group_content` VALUES (134, 4, 60, '[哭]', NULL, 1, 'text', NULL, NULL, '2023-01-08 09:05:48', '2023-01-09 13:37:27', '2023-01-09 13:37:27');
INSERT INTO `chat_group_content` VALUES (135, 60, 60, 'ffff', NULL, 1, 'text', NULL, NULL, '2023-01-08 10:24:42', '2023-01-09 13:32:57', '2023-01-09 13:32:57');
INSERT INTO `chat_group_content` VALUES (136, 64, 60, '你看起来很漂亮？', NULL, 1, 'text', NULL, NULL, '2023-01-08 10:26:08', '2023-01-09 13:37:24', '2023-01-09 13:37:24');
INSERT INTO `chat_group_content` VALUES (137, 86, 60, '你是个小子', NULL, 1, 'text', NULL, NULL, '2023-01-08 10:27:59', '2023-01-09 13:37:24', '2023-01-09 13:37:24');
INSERT INTO `chat_group_content` VALUES (138, 4, 89, '搞什么么？', NULL, 1, 'text', NULL, NULL, '2023-01-08 10:36:35', '2023-01-09 13:37:24', '2023-01-09 13:37:24');
INSERT INTO `chat_group_content` VALUES (139, 3, 89, '你想干什么？', NULL, 1, 'text', NULL, NULL, '2023-01-08 13:09:12', '2023-01-09 14:08:50', '2023-01-09 14:08:50');
INSERT INTO `chat_group_content` VALUES (140, 1, 89, 'ttttt', NULL, 1, 'text', NULL, NULL, '2023-01-08 13:50:51', '2023-01-09 13:16:13', '2023-01-09 13:16:13');
INSERT INTO `chat_group_content` VALUES (141, 2, 89, '你搞什么嘛？', NULL, 1, 'text', NULL, NULL, '2023-01-08 14:16:22', '2023-01-09 13:16:13', '2023-01-09 13:16:13');
INSERT INTO `chat_group_content` VALUES (142, 5, 89, '好的好的', NULL, 1, 'text', NULL, NULL, '2023-01-09 08:58:17', '2023-01-09 14:08:50', '2023-01-09 14:08:50');
INSERT INTO `chat_group_content` VALUES (143, 3, 89, 'FFFF', NULL, 1, 'text', NULL, NULL, '2023-01-09 09:42:29', '2023-01-09 14:08:50', '2023-01-09 14:08:50');
INSERT INTO `chat_group_content` VALUES (144, 3, 89, 'ok?', NULL, 1, 'text', NULL, NULL, '2023-01-09 09:45:00', '2023-01-09 14:08:50', '2023-01-09 14:08:50');
INSERT INTO `chat_group_content` VALUES (145, 3, 60, 'Yes', NULL, 1, 'text', NULL, NULL, '2023-01-09 09:47:45', '2023-01-09 14:08:50', '2023-01-09 14:08:50');
INSERT INTO `chat_group_content` VALUES (146, 3, 89, 'OOO', NULL, 1, 'text', NULL, NULL, '2023-01-09 09:47:57', '2023-01-09 13:16:24', '2023-01-09 13:16:24');
INSERT INTO `chat_group_content` VALUES (147, 3, 60, '好的', NULL, 1, 'text', NULL, NULL, '2023-01-09 09:48:04', '2023-01-09 14:08:50', '2023-01-09 14:08:50');
INSERT INTO `chat_group_content` VALUES (148, 3, 60, 'tttt', NULL, 1, 'text', NULL, NULL, '2023-01-09 10:40:48', '2023-01-09 14:08:50', '2023-01-09 14:08:50');
INSERT INTO `chat_group_content` VALUES (149, 4, 105, 'hello', NULL, 1, 'text', NULL, NULL, '2023-01-09 14:04:09', '2023-01-09 14:08:50', '2023-01-09 14:08:50');
INSERT INTO `chat_group_content` VALUES (150, 4, 105, '[伤心]', NULL, 1, 'text', NULL, NULL, '2023-01-09 14:09:52', '2023-01-09 14:20:28', '2023-01-09 14:20:28');
INSERT INTO `chat_group_content` VALUES (151, 5, 105, '[微笑][微笑][微笑][微笑]', NULL, 1, 'text', NULL, NULL, '2023-01-09 14:11:53', '2023-01-09 14:20:28', '2023-01-09 14:20:28');
INSERT INTO `chat_group_content` VALUES (152, 5, 60, '在啊', NULL, 1, 'text', NULL, NULL, '2023-01-09 14:12:21', '2023-01-09 14:20:28', '2023-01-09 14:20:28');
INSERT INTO `chat_group_content` VALUES (153, 4, 60, 'attach/thumb/1673244826_4ae9ae3bcaa7fec08b5c.jpeg', NULL, 1, 'img', NULL, NULL, '2023-01-09 14:13:46', '2023-01-09 14:20:28', '2023-01-09 14:20:28');
INSERT INTO `chat_group_content` VALUES (154, 5, 60, '你们好！', NULL, 1, 'text', NULL, NULL, '2023-01-09 14:22:02', '2023-04-22 20:23:49', '2023-04-22 20:23:49');
INSERT INTO `chat_group_content` VALUES (155, 4, 60, '[笑][笑][笑][笑][笑]', NULL, 1, 'text', NULL, NULL, '2023-01-09 14:22:10', '2023-04-22 20:23:49', '2023-04-22 20:23:49');
INSERT INTO `chat_group_content` VALUES (156, 4, 106, '古德', NULL, 1, 'text', NULL, NULL, '2023-01-09 14:36:24', '2023-04-22 20:23:49', '2023-04-22 20:23:49');
INSERT INTO `chat_group_content` VALUES (157, 1, 106, '[美女][美女]', NULL, 1, 'text', NULL, NULL, '2023-01-09 14:45:15', '2023-04-22 20:23:49', '2023-04-22 20:23:49');
INSERT INTO `chat_group_content` VALUES (158, 1, 88, '啊啊啊', NULL, 1, 'text', NULL, NULL, '2023-01-09 17:30:23', '2023-04-22 20:23:49', '2023-04-22 20:23:49');
INSERT INTO `chat_group_content` VALUES (159, 5, 88, '[怒]', NULL, 1, 'text', NULL, NULL, '2023-01-10 00:04:25', '2023-04-22 20:23:45', '2023-04-22 20:23:45');
INSERT INTO `chat_group_content` VALUES (160, 1, 60, '嘿 另赤', NULL, 1, 'text', NULL, NULL, '2023-01-13 18:18:00', '2023-04-22 20:23:45', '2023-04-22 20:23:45');
INSERT INTO `chat_group_content` VALUES (161, 5, 60, 'H来啊', NULL, 1, 'text', NULL, NULL, '2023-01-13 18:19:14', '2023-04-22 20:23:45', '2023-04-22 20:23:45');
INSERT INTO `chat_group_content` VALUES (162, 5, 60, '是啊是啊', NULL, 1, 'text', NULL, NULL, '2023-01-13 18:19:25', '2023-04-22 20:23:45', '2023-04-22 20:23:45');
INSERT INTO `chat_group_content` VALUES (163, 5, 88, '手机文件发不了', NULL, 1, 'text', NULL, NULL, '2023-01-14 18:16:05', '2023-04-22 20:23:45', '2023-04-22 20:23:45');
INSERT INTO `chat_group_content` VALUES (164, 4, 88, 'attach/thumb/1673691482_b5cf0aa743ec2716def2.jpg', NULL, 1, 'img', NULL, NULL, '2023-01-14 18:18:02', '2023-04-22 20:23:45', '2023-04-22 20:23:45');
INSERT INTO `chat_group_content` VALUES (165, 5, 60, 'aaa', NULL, 1, 'text', NULL, NULL, '2023-01-15 13:50:47', '2023-04-22 20:23:45', '2023-04-22 20:23:45');
INSERT INTO `chat_group_content` VALUES (166, 5, 60, 'XX[怒]土[调皮]有什么也不起', NULL, 1, 'text', NULL, NULL, '2023-01-15 14:07:39', '2023-04-22 20:23:45', '2023-04-22 20:23:45');
INSERT INTO `chat_group_content` VALUES (167, 5, 60, 'XX[怒]土[调皮]有什么也不起', NULL, 1, 'text', NULL, NULL, '2023-01-15 15:17:54', '2023-04-22 20:23:45', '2023-04-22 20:23:45');
INSERT INTO `chat_group_content` VALUES (168, 5, 60, 'XX[怒]土[调皮]有什么也不起', NULL, 1, 'text', NULL, NULL, '2023-01-15 15:18:06', '2023-04-22 20:23:45', '2023-04-22 20:23:45');
INSERT INTO `chat_group_content` VALUES (169, 5, 60, '手机文件发不了', NULL, 1, 'text', NULL, NULL, '2023-01-15 15:19:37', '2023-04-22 20:23:40', '2023-04-22 20:23:40');
INSERT INTO `chat_group_content` VALUES (170, 4, 60, '[笑][笑][笑][笑][笑]', NULL, 1, 'text', NULL, NULL, '2023-01-15 15:20:15', '2023-04-22 20:23:40', '2023-04-22 20:23:40');
INSERT INTO `chat_group_content` VALUES (171, 1, 60, 'XXX[惊讶]GGGG', NULL, 1, 'text', NULL, NULL, '2023-01-15 15:20:24', '2023-04-22 20:23:40', '2023-04-22 20:23:40');
INSERT INTO `chat_group_content` VALUES (172, 5, 60, 'XX[怒]土[调皮]有什么也不起', NULL, 1, 'text', NULL, NULL, '2023-01-15 15:24:28', '2023-04-22 20:23:40', '2023-04-22 20:23:40');
INSERT INTO `chat_group_content` VALUES (173, 4, 88, '[礼物]', NULL, 1, 'text', NULL, NULL, '2023-01-15 17:35:43', '2023-04-22 20:23:40', '2023-04-22 20:23:40');
INSERT INTO `chat_group_content` VALUES (174, 1, 88, '第一聊天室', NULL, 1, 'text', NULL, NULL, '2023-01-16 14:23:21', '2023-04-22 20:23:40', '2023-04-22 20:23:40');
INSERT INTO `chat_group_content` VALUES (175, 1, 107, '在吗', NULL, 1, 'text', NULL, NULL, '2023-01-16 14:25:07', '2023-04-22 20:23:40', '2023-04-22 20:23:40');
INSERT INTO `chat_group_content` VALUES (176, 1, 107, '谁在', NULL, 1, 'text', NULL, NULL, '2023-01-16 14:25:14', '2023-04-22 20:23:40', '2023-04-22 20:23:40');
INSERT INTO `chat_group_content` VALUES (177, 1, 88, '没有谁在', NULL, 1, 'text', NULL, NULL, '2023-01-16 14:25:36', '2023-04-22 20:23:40', '2023-04-22 20:23:40');
INSERT INTO `chat_group_content` VALUES (178, 1, 107, '[笑]', NULL, 1, 'text', NULL, NULL, '2023-01-16 14:25:45', '2023-04-22 20:23:40', '2023-04-22 20:23:40');
INSERT INTO `chat_group_content` VALUES (179, 1, 107, '我原来的冯立唯帐号多少', NULL, 1, 'text', NULL, NULL, '2023-01-16 14:26:21', '2023-04-22 20:23:36', '2023-04-22 20:23:36');
INSERT INTO `chat_group_content` VALUES (180, 1, 88, '这里随便发，没有人封号了', NULL, 1, 'text', NULL, NULL, '2023-01-16 14:26:25', '2023-04-22 20:23:36', '2023-04-22 20:23:36');
INSERT INTO `chat_group_content` VALUES (181, 1, 88, '晕，发不了', NULL, 1, 'text', NULL, NULL, '2023-01-16 14:26:37', '2023-04-22 20:23:36', '2023-04-22 20:23:36');
INSERT INTO `chat_group_content` VALUES (182, 1, 88, '发不了', NULL, 1, 'text', NULL, NULL, '2023-01-16 14:26:50', '2023-04-22 20:23:36', '2023-04-22 20:23:36');
INSERT INTO `chat_group_content` VALUES (183, 1, 107, '什么发不了', NULL, 1, 'text', NULL, NULL, '2023-01-16 14:26:55', '2023-04-22 20:23:36', '2023-04-22 20:23:36');
INSERT INTO `chat_group_content` VALUES (184, 1, 88, '就是自己发的看不到，退出后进去才显示', NULL, 1, 'text', NULL, NULL, '2023-01-16 14:27:35', '2023-04-22 20:23:36', '2023-04-22 20:23:36');
INSERT INTO `chat_group_content` VALUES (185, 1, 88, '现在好了，奇怪', NULL, 1, 'text', NULL, NULL, '2023-01-16 14:27:45', '2023-04-22 20:23:36', '2023-04-22 20:23:36');
INSERT INTO `chat_group_content` VALUES (186, 1, 88, 'attach/thumb/1673850494_4480233bd927812f6c67.jpg', NULL, 1, 'img', NULL, NULL, '2023-01-16 14:28:15', '2023-04-22 20:23:36', '2023-04-22 20:23:36');
INSERT INTO `chat_group_content` VALUES (187, 1, 88, '你这里看，有你的号', NULL, 1, 'text', NULL, NULL, '2023-01-16 14:28:34', '2023-04-22 20:23:36', '2023-04-22 20:23:36');
INSERT INTO `chat_group_content` VALUES (188, 1, 107, '密码不记得了', NULL, 1, 'text', NULL, NULL, '2023-01-16 14:30:37', '2023-04-22 20:23:36', '2023-04-22 20:23:36');
INSERT INTO `chat_group_content` VALUES (189, 1, 88, '找回密码，没有绑定手机吧？', NULL, 1, 'text', NULL, NULL, '2023-01-16 14:31:50', '2023-04-22 20:23:30', '2023-04-22 20:23:30');
INSERT INTO `chat_group_content` VALUES (190, 1, 107, '没有', NULL, 1, 'text', NULL, NULL, '2023-01-16 14:33:28', '2023-04-22 20:23:30', '2023-04-22 20:23:30');
INSERT INTO `chat_group_content` VALUES (191, 1, 107, '挺好的呀', NULL, 1, 'text', NULL, NULL, '2023-01-16 14:33:34', '2023-04-22 20:23:30', '2023-04-22 20:23:30');
INSERT INTO `chat_group_content` VALUES (192, 1, 88, '没有绑定就找不回密码了', NULL, 1, 'text', NULL, NULL, '2023-01-16 14:33:57', '2023-04-22 20:23:30', '2023-04-22 20:23:30');
INSERT INTO `chat_group_content` VALUES (193, 1, 107, '这样人多了，监管会不会找问题', NULL, 1, 'text', NULL, NULL, '2023-01-16 14:34:04', '2023-04-22 20:23:30', '2023-04-22 20:23:30');
INSERT INTO `chat_group_content` VALUES (194, 1, 107, '后台能看到改吧', NULL, 1, 'text', NULL, NULL, '2023-01-16 14:34:19', '2023-04-22 20:23:30', '2023-04-22 20:23:30');
INSERT INTO `chat_group_content` VALUES (195, 1, 88, '不知道，至少现在不会', NULL, 1, 'text', NULL, NULL, '2023-01-16 14:34:22', '2023-04-22 20:23:30', '2023-04-22 20:23:30');
INSERT INTO `chat_group_content` VALUES (196, 1, 88, '后台能看到改吧：应该可以吧，我也不知道', NULL, 1, 'text', NULL, NULL, '2023-01-16 14:34:48', '2023-04-22 20:23:30', '2023-04-22 20:23:30');
INSERT INTO `chat_group_content` VALUES (197, 1, 88, '后台好久没进去了', NULL, 1, 'text', NULL, NULL, '2023-01-16 14:35:11', '2023-04-22 20:23:30', '2023-04-22 20:23:30');
INSERT INTO `chat_group_content` VALUES (198, 1, 107, '那现在能用没', NULL, 1, 'text', NULL, NULL, '2023-01-16 14:35:12', '2023-04-22 20:23:30', '2023-04-22 20:23:30');
INSERT INTO `chat_group_content` VALUES (199, 1, 88, '后台需要电脑进去', NULL, 1, 'text', NULL, NULL, '2023-01-16 14:35:42', '2023-04-22 20:23:27', '2023-04-22 20:23:27');
INSERT INTO `chat_group_content` VALUES (200, 1, 88, '人多几个这里聊天也没有问题', NULL, 1, 'text', NULL, NULL, '2023-01-16 14:36:32', '2023-04-22 20:23:27', '2023-04-22 20:23:27');
INSERT INTO `chat_group_content` VALUES (201, 1, 88, '不过好像不能发语音', NULL, 1, 'text', NULL, NULL, '2023-01-16 14:36:54', '2023-04-22 20:23:27', '2023-04-22 20:23:27');
INSERT INTO `chat_group_content` VALUES (202, 1, 88, '文件也发不了，只能粘贴和图片', NULL, 1, 'text', NULL, NULL, '2023-01-16 14:37:27', '2023-04-22 20:23:27', '2023-04-22 20:23:27');
INSERT INTO `chat_group_content` VALUES (203, 1, 107, '问题是能不能保存好记录', NULL, 1, 'text', NULL, NULL, '2023-01-16 14:37:44', '2023-04-22 20:23:27', '2023-04-22 20:23:27');
INSERT INTO `chat_group_content` VALUES (204, 1, 88, '好像不能吧，不能多选', NULL, 1, 'text', NULL, NULL, '2023-01-16 14:38:52', '2023-04-22 20:23:27', '2023-04-22 20:23:27');
INSERT INTO `chat_group_content` VALUES (205, 1, 88, '不过聊天记录好多天前的都还在', NULL, 1, 'text', NULL, NULL, '2023-01-16 14:39:50', '2023-04-22 20:23:27', '2023-04-22 20:23:27');
INSERT INTO `chat_group_content` VALUES (206, 1, 88, '这聊天室是固定聊天室，任何人直接可以进入聊天，也可以直接退出', NULL, 1, 'text', NULL, NULL, '2023-01-16 14:41:50', '2023-04-22 20:23:27', '2023-04-22 20:23:27');
INSERT INTO `chat_group_content` VALUES (207, 1, 107, '你后台有没有保存好数据', NULL, 1, 'text', NULL, NULL, '2023-01-16 14:44:35', '2023-04-22 20:23:27', '2023-04-22 20:23:27');
INSERT INTO `chat_group_content` VALUES (208, 1, 107, '别调试删了，那现在就只能闲聊', NULL, 1, 'text', NULL, NULL, '2023-01-16 14:45:36', '2023-04-22 20:23:27', '2023-04-22 20:23:27');
INSERT INTO `chat_group_content` VALUES (209, 1, 107, '没问题大家就用起来', NULL, 1, 'text', NULL, NULL, '2023-01-16 14:47:27', '2023-04-22 20:23:16', '2023-04-22 20:23:16');
INSERT INTO `chat_group_content` VALUES (210, 1, 88, '打字的聊天到可以随意聊', NULL, 1, 'text', NULL, NULL, '2023-01-16 16:18:59', '2023-04-22 20:23:16', '2023-04-22 20:23:16');
INSERT INTO `chat_group_content` VALUES (211, 1, 88, '[发呆]', NULL, 1, 'text', NULL, NULL, '2023-02-02 12:04:40', '2023-04-22 20:23:16', '2023-04-22 20:23:16');
INSERT INTO `chat_group_content` VALUES (212, 1, 107, '[笑]', NULL, 1, 'text', NULL, NULL, '2023-02-21 07:51:46', '2023-04-22 20:23:16', '2023-04-22 20:23:16');
INSERT INTO `chat_group_content` VALUES (213, 5, 107, '[囧]', NULL, 1, 'text', NULL, NULL, '2023-02-21 07:52:03', '2023-04-22 20:23:16', '2023-04-22 20:23:16');
INSERT INTO `chat_group_content` VALUES (214, 1, 107, '把我的自在到家网链上来呀', NULL, 1, 'text', NULL, NULL, '2023-02-21 07:53:06', '2023-04-22 20:23:16', '2023-04-22 20:23:16');
INSERT INTO `chat_group_content` VALUES (215, 4, 114, '[美女][美女][美女]', NULL, 1, 'text', NULL, NULL, '2023-04-21 11:13:29', '2023-04-22 20:23:16', '2023-04-22 20:23:16');
INSERT INTO `chat_group_content` VALUES (216, 5, 114, 'attach/thumb/1682046876_8dd6c4e07dec36a9f5ed.jpg', NULL, 1, 'img', NULL, NULL, '2023-04-21 11:14:37', '2023-04-22 20:23:16', '2023-04-22 20:23:16');
INSERT INTO `chat_group_content` VALUES (217, 1, 114, '在', NULL, 1, 'text', NULL, NULL, '2023-04-22 09:42:47', '2023-04-22 20:23:16', '2023-04-22 20:23:16');
INSERT INTO `chat_group_content` VALUES (218, 4, 114, '[笑][笑][笑][笑][笑]', NULL, 1, 'text', NULL, NULL, '2023-04-22 09:43:24', '2023-04-22 20:23:16', '2023-04-22 20:23:16');
INSERT INTO `chat_group_content` VALUES (219, 8, 114, '看不到聊天内容了', NULL, 1, 'text', NULL, NULL, '2023-04-23 15:38:48', '2023-04-23 15:38:48', NULL);
INSERT INTO `chat_group_content` VALUES (220, 8, 88, '给我删除了', NULL, 1, 'text', NULL, NULL, '2023-04-23 23:34:29', '2023-04-23 23:34:29', NULL);
INSERT INTO `chat_group_content` VALUES (221, 8, 114, '让大家都习惯在这聊天', NULL, 1, 'text', NULL, NULL, '2023-04-24 12:48:37', '2023-04-24 12:48:37', NULL);
INSERT INTO `chat_group_content` VALUES (222, 8, 88, '我把没有手机注册的用户都删除了，出现了一些问题。', NULL, 1, 'text', NULL, NULL, '2023-04-25 00:36:15', '2023-04-25 00:36:15', NULL);
INSERT INTO `chat_group_content` VALUES (223, 8, 114, '[微笑]', NULL, 1, 'text', NULL, NULL, '2023-04-25 13:10:48', '2023-04-25 13:10:48', NULL);
INSERT INTO `chat_group_content` VALUES (224, 8, 88, '试试这里的聊天', NULL, 1, 'text', NULL, NULL, '2023-04-26 20:45:50', '2023-04-26 20:45:50', NULL);
INSERT INTO `chat_group_content` VALUES (225, 8, 88, '有没有人', NULL, 1, 'text', NULL, NULL, '2023-04-26 20:46:46', '2023-04-26 20:46:46', NULL);
INSERT INTO `chat_group_content` VALUES (226, 8, 113, '[微笑][微笑]', NULL, 1, 'text', NULL, NULL, '2023-04-26 20:53:20', '2023-04-26 20:53:20', NULL);
INSERT INTO `chat_group_content` VALUES (227, 4, 116, '什么状况？', NULL, 1, 'text', NULL, NULL, '2023-04-26 21:18:07', '2023-04-26 21:18:07', NULL);
INSERT INTO `chat_group_content` VALUES (228, 8, 88, '刚和水溅飞聊了一个小时', NULL, 1, 'text', NULL, NULL, '2023-04-26 22:46:45', '2023-04-26 22:46:45', NULL);
INSERT INTO `chat_group_content` VALUES (229, 8, 114, '[微笑][微笑]', NULL, 1, 'text', NULL, NULL, '2023-04-27 11:26:13', '2023-04-27 11:26:13', NULL);
INSERT INTO `chat_group_content` VALUES (230, 1, 88, '这个还没有架到服务器上', NULL, 1, 'text', NULL, NULL, '2023-04-28 02:27:01', '2023-04-28 02:27:01', NULL);
INSERT INTO `chat_group_content` VALUES (231, 1, 114, '要聊天让大家过来聊，至少可以把这里的热气搞上来嘛', NULL, 1, 'text', NULL, NULL, '2023-04-28 20:54:14', '2023-04-28 20:54:14', NULL);
INSERT INTO `chat_group_content` VALUES (232, 1, 114, '要聊天，这边也可以呀', NULL, 1, 'text', NULL, NULL, '2023-04-28 20:54:41', '2023-04-28 20:54:41', NULL);
INSERT INTO `chat_group_content` VALUES (233, 1, 114, '[发呆]', NULL, 1, 'text', NULL, NULL, '2023-04-28 20:54:45', '2023-04-28 20:54:45', NULL);
INSERT INTO `chat_group_content` VALUES (234, 1, 88, '这就是烧钱的好处，形成气候，很难改变。微信人多，不好拉。', NULL, 1, 'text', NULL, NULL, '2023-04-29 00:50:02', '2023-04-29 00:50:02', NULL);
INSERT INTO `chat_group_content` VALUES (235, 4, 86, 'Hello', NULL, 1, 'text', NULL, NULL, '2023-05-05 12:58:56', '2023-05-05 12:58:56', NULL);
INSERT INTO `chat_group_content` VALUES (236, 1, 88, '签到多的VIP升级不会么？', NULL, 1, 'text', NULL, NULL, '2023-05-06 10:11:55', '2023-05-06 10:11:55', NULL);
INSERT INTO `chat_group_content` VALUES (237, 8, 119, '可以一对一的私聊吗', NULL, 1, 'text', NULL, NULL, '2023-05-06 19:47:49', '2023-05-06 19:47:49', NULL);
INSERT INTO `chat_group_content` VALUES (238, 8, 119, '如何在桌面生成图标？', NULL, 1, 'text', NULL, NULL, '2023-05-06 19:48:37', '2023-05-06 19:48:37', NULL);
INSERT INTO `chat_group_content` VALUES (239, 8, 88, '这个只能APP模式，因为不是浏览器，浏览器本身就是APP，也就是下载APP安装到桌面', NULL, 1, 'text', NULL, NULL, '2023-05-07 03:36:18', '2023-05-07 03:36:18', NULL);
INSERT INTO `chat_group_content` VALUES (240, 1, 88, '发信息不会直接显示', NULL, 1, 'text', NULL, NULL, '2023-05-07 08:35:34', '2023-05-07 08:35:34', NULL);
INSERT INTO `chat_group_content` VALUES (241, 1, 88, '现在可以了', NULL, 1, 'text', NULL, NULL, '2023-05-07 08:36:17', '2023-05-07 08:36:17', NULL);
INSERT INTO `chat_group_content` VALUES (242, 9, 88, '聊天室', NULL, 1, 'text', NULL, NULL, '2023-05-07 08:37:15', '2023-05-07 08:37:15', NULL);
INSERT INTO `chat_group_content` VALUES (243, 9, 88, 'attach/thumb/1683420757_5525b27db5c0fa4b8b39.jpg', NULL, 1, 'img', NULL, NULL, '2023-05-07 08:52:37', '2023-05-07 08:52:37', NULL);
INSERT INTO `chat_group_content` VALUES (244, 9, 88, '[抱拳]', NULL, 1, 'text', NULL, NULL, '2023-05-07 08:53:19', '2023-05-07 08:53:19', NULL);
INSERT INTO `chat_group_content` VALUES (245, 5, 88, '啊哈哈哈', NULL, 1, 'text', NULL, NULL, '2023-05-18 10:33:31', '2023-05-18 10:33:31', NULL);
INSERT INTO `chat_group_content` VALUES (246, 4, 88, '发个信息', NULL, 1, 'text', NULL, NULL, '2023-05-18 10:33:50', '2023-05-18 10:33:50', NULL);
INSERT INTO `chat_group_content` VALUES (247, 9, 88, '[笑]', NULL, 1, 'text', NULL, NULL, '2023-05-18 10:34:02', '2023-05-18 10:34:02', NULL);
INSERT INTO `chat_group_content` VALUES (248, 8, 88, '[忧愁]', NULL, 1, 'text', NULL, NULL, '2023-05-18 10:34:28', '2023-05-18 10:34:28', NULL);
INSERT INTO `chat_group_content` VALUES (249, 10, 88, '[美女]', NULL, 1, 'text', NULL, NULL, '2023-05-18 17:03:46', '2023-05-18 17:03:46', NULL);
INSERT INTO `chat_group_content` VALUES (250, 9, 115, '死一般的寂寞，这个游戏估计也就如此了', NULL, 1, 'text', NULL, NULL, '2023-05-19 14:57:40', '2023-05-19 14:57:40', NULL);
INSERT INTO `chat_group_content` VALUES (251, 10, 115, '[怒]', NULL, 1, 'text', NULL, NULL, '2023-05-19 14:58:06', '2023-05-19 14:58:06', NULL);
INSERT INTO `chat_group_content` VALUES (252, 9, 88, '别急', NULL, 1, 'text', NULL, NULL, '2023-05-20 16:10:00', '2023-05-20 16:10:00', NULL);
INSERT INTO `chat_group_content` VALUES (253, 10, 88, '你谁啊？', NULL, 1, 'text', NULL, NULL, '2023-06-01 22:58:41', '2023-06-01 22:58:41', NULL);
INSERT INTO `chat_group_content` VALUES (254, 10, 124, '[伤心]', NULL, 1, 'text', NULL, NULL, '2023-08-02 14:00:07', '2023-08-02 14:00:07', NULL);
INSERT INTO `chat_group_content` VALUES (255, 1, 124, '[笑]', NULL, 1, 'text', NULL, NULL, '2023-08-02 14:01:00', '2023-08-02 14:01:00', NULL);
INSERT INTO `chat_group_content` VALUES (256, 8, 125, '呵呵', NULL, 1, 'text', NULL, NULL, '2023-08-08 16:31:08', '2023-08-08 16:31:08', NULL);
INSERT INTO `chat_group_content` VALUES (257, 8, 125, 'attach/thumb/1691483475_8ba2c12310608d103786.jpeg', NULL, 1, 'img', NULL, NULL, '2023-08-08 16:31:15', '2023-08-08 16:31:15', NULL);
INSERT INTO `chat_group_content` VALUES (258, 8, 125, 'attach/thumb/1691483497_893ee14a442ff0093af6.jpg', NULL, 1, 'img', NULL, NULL, '2023-08-08 16:31:37', '2023-08-08 16:31:37', NULL);
INSERT INTO `chat_group_content` VALUES (259, 10, 125, '好啊', NULL, 1, 'text', NULL, NULL, '2023-08-08 16:31:51', '2023-08-08 16:31:51', NULL);
INSERT INTO `chat_group_content` VALUES (260, 8, 124, '[微笑]', NULL, 1, 'text', NULL, NULL, '2023-08-09 07:11:48', '2023-08-09 07:11:48', NULL);
INSERT INTO `chat_group_content` VALUES (261, 10, 124, '好', NULL, 1, 'text', NULL, NULL, '2023-08-09 07:12:37', '2023-08-09 07:12:37', NULL);
INSERT INTO `chat_group_content` VALUES (262, 10, 88, '你是哪位啊？', NULL, 1, 'text', NULL, NULL, '2023-08-09 13:10:37', '2023-08-09 13:10:37', NULL);
INSERT INTO `chat_group_content` VALUES (263, 10, 88, '修改一下和微信一样的', NULL, 1, 'text', NULL, NULL, '2023-08-09 13:11:39', '2023-08-09 13:11:39', NULL);
COMMIT;

-- ----------------------------
-- Table structure for custom_discuz
-- ----------------------------
DROP TABLE IF EXISTS `custom_discuz`;
CREATE TABLE `custom_discuz` (
  `id` int NOT NULL AUTO_INCREMENT,
  `module` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '相关模块',
  `relid` int DEFAULT '0' COMMENT '关联ID',
  `tag` tinyint(1) DEFAULT '0' COMMENT '类别：',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '投票议题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '讨论内容',
  `status` tinyint DEFAULT '0' COMMENT '状态',
  `uid` int DEFAULT '0' COMMENT '发布者ID，平台发布时为0',
  `adduid` int DEFAULT NULL COMMENT '添加者ID',
  `edituid` int DEFAULT NULL COMMENT '最后编辑者ID',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `relid` (`relid`,`tag`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='讨论信息表';

-- ----------------------------
-- Records of custom_discuz
-- ----------------------------
BEGIN;
INSERT INTO `custom_discuz` VALUES (11, 'vote', 8, 0, NULL, '好的', 1, 60, NULL, NULL, '2022-11-27 15:36:52', '2022-11-27 15:36:52', NULL);
INSERT INTO `custom_discuz` VALUES (12, 'vote', 9, 0, NULL, '有什么用呢？？', 1, 60, NULL, NULL, '2022-11-27 15:37:02', '2022-11-27 15:37:02', NULL);
INSERT INTO `custom_discuz` VALUES (19, 'vote', 9, 0, NULL, '有什么可以说的呢？', 1, 86, NULL, NULL, '2022-11-28 08:12:20', '2022-11-28 08:12:20', NULL);
INSERT INTO `custom_discuz` VALUES (20, 'vote', 8, 0, NULL, 'Hello Hello Hello!!!', 1, 86, NULL, NULL, '2022-11-28 08:12:47', '2022-11-28 08:12:47', NULL);
INSERT INTO `custom_discuz` VALUES (22, 'vote', 9, 0, NULL, '我没什么可以说的了', 1, 86, NULL, NULL, '2022-11-28 10:17:58', '2022-11-28 10:17:58', NULL);
INSERT INTO `custom_discuz` VALUES (23, 'vote', 4, 1, NULL, '没人说话吗？', 1, 86, NULL, NULL, '2022-11-28 10:18:17', '2022-11-28 10:18:17', NULL);
INSERT INTO `custom_discuz` VALUES (24, 'vote', 4, 1, NULL, '我再说说看', 1, 86, NULL, NULL, '2022-11-28 10:26:08', '2022-11-28 10:26:08', NULL);
INSERT INTO `custom_discuz` VALUES (25, 'vote', 10, 1, NULL, '我就想发发发', 1, 86, NULL, NULL, '2022-11-28 10:54:56', '2022-11-28 10:54:56', NULL);
INSERT INTO `custom_discuz` VALUES (31, 'vote', 4, 1, NULL, '哈哈哈各个', 1, 88, NULL, NULL, '2022-11-29 20:13:50', '2022-11-29 20:13:50', NULL);
INSERT INTO `custom_discuz` VALUES (32, 'vote', 5, 1, NULL, '我的看法', 1, 88, NULL, NULL, '2022-11-29 20:17:12', '2022-11-29 20:17:12', NULL);
INSERT INTO `custom_discuz` VALUES (33, 'vote', 5, 1, NULL, '个人建议', 1, 88, NULL, NULL, '2022-11-30 14:27:26', '2022-11-30 14:27:26', NULL);
INSERT INTO `custom_discuz` VALUES (34, 'vote', 1, 2, NULL, '个人建议1', 1, 88, NULL, NULL, '2022-11-30 14:28:33', '2022-11-30 14:28:33', NULL);
INSERT INTO `custom_discuz` VALUES (35, 'vote', 15, 3, NULL, '收到', 1, 88, NULL, NULL, '2022-11-30 14:32:06', '2022-11-30 14:32:06', NULL);
INSERT INTO `custom_discuz` VALUES (42, 'vote', 5, 1, NULL, '个人建议90%以上', 1, 88, NULL, NULL, '2022-12-06 10:34:08', '2022-12-06 10:34:08', NULL);
INSERT INTO `custom_discuz` VALUES (43, 'vote', 10, 1, NULL, '个人中心', 1, 88, NULL, NULL, '2022-12-06 10:34:25', '2022-12-06 10:34:25', NULL);
INSERT INTO `custom_discuz` VALUES (45, 'vote', 7, 1, NULL, '哈哈哈哈', 1, 88, NULL, NULL, '2022-12-06 10:43:55', '2022-12-06 10:43:55', NULL);
INSERT INTO `custom_discuz` VALUES (48, 'vote', 17, 1, NULL, '这是我的留言', 1, 86, NULL, NULL, '2022-12-06 10:57:01', '2022-12-06 10:57:01', NULL);
INSERT INTO `custom_discuz` VALUES (59, 'discuz', 0, 0, NULL, '广告引流无限制\n视频链接；网址链接等等', 1, 88, NULL, NULL, '2023-07-11 17:41:06', '2023-07-11 17:41:06', NULL);
COMMIT;

-- ----------------------------
-- Table structure for custom_paimai
-- ----------------------------
DROP TABLE IF EXISTS `custom_paimai`;
CREATE TABLE `custom_paimai` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tag` tinyint DEFAULT NULL COMMENT '分类标识',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '拍卖名称',
  `numbmin` int DEFAULT '0' COMMENT '起拍数额',
  `numbmax` int DEFAULT '0' COMMENT '起拍限额',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '拍卖内容',
  `btime` datetime DEFAULT NULL COMMENT '开始时间',
  `etime` datetime DEFAULT NULL COMMENT '截止时间',
  `status` tinyint DEFAULT '0' COMMENT '状态',
  `uid` int DEFAULT '0' COMMENT '发布者ID，系统发布时为0',
  `adduid` int DEFAULT NULL COMMENT '添加者ID',
  `edituid` int DEFAULT NULL COMMENT '最后编辑者ID',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `tag` (`tag`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='拍卖信息表';

-- ----------------------------
-- Records of custom_paimai
-- ----------------------------
BEGIN;
INSERT INTO `custom_paimai` VALUES (1, 0, '1级', 0, 0, '振动真', NULL, NULL, 1, 0, 1, 1, '2022-11-04 14:55:36', '2023-04-22 20:37:28', '2023-04-22 20:37:28');
INSERT INTO `custom_paimai` VALUES (2, 0, '资深', 100, 0, '99*level', NULL, NULL, 1, 0, 1, 1, '2022-11-04 14:56:56', '2023-04-22 20:37:26', '2023-04-22 20:37:26');
INSERT INTO `custom_paimai` VALUES (3, 0, '出售100元', 1000, 9999, '兑换号码：10000\n兑换密码：999999', NULL, NULL, 1, 0, NULL, 1, '2022-11-16 08:42:52', '2023-04-22 20:37:24', '2023-04-22 20:37:24');
INSERT INTO `custom_paimai` VALUES (4, 0, '4级杀手', 1, 99999, '沣东镇', '0000-00-00 00:00:00', NULL, 1, 0, NULL, 1, '2022-11-21 13:40:33', '2023-04-22 20:37:21', '2023-04-22 20:37:21');
INSERT INTO `custom_paimai` VALUES (5, 0, 'testtest', 0, 100, 'fdsafa', NULL, NULL, 1, 0, 1, 1, '2022-11-22 15:35:28', '2023-04-22 20:37:16', '2023-04-22 20:37:16');
INSERT INTO `custom_paimai` VALUES (6, 0, '出售现金300元人民币', 10000, 0, '卡号：333334；\n卡密：XXXXXXX', NULL, NULL, 1, 0, 1, NULL, '2022-11-23 21:33:09', '2023-04-22 20:35:34', '2023-04-22 20:35:34');
INSERT INTO `custom_paimai` VALUES (7, 0, '现金250先到先得', 1000, 0, '房东招揽\n房东振动真fwe\nfewff', NULL, NULL, 1, 0, 1, NULL, '2022-11-24 13:17:39', '2023-04-22 20:35:30', '2023-04-22 20:35:30');
INSERT INTO `custom_paimai` VALUES (8, 0, '出888', 888, 0, '沣东镇撒\nfdsafdsaffewf\n沣东镇吃完', NULL, NULL, 1, 0, 1, NULL, '2022-11-24 13:19:49', '2023-04-22 20:35:28', '2023-04-22 20:35:28');
INSERT INTO `custom_paimai` VALUES (9, 0, '测试是否过期', 1, 0, '沣东镇', '2022-11-30 00:00:00', '2022-11-23 00:00:00', 1, 0, 1, NULL, '2022-11-24 13:48:37', '2023-04-22 20:35:25', '2023-04-22 20:35:25');
INSERT INTO `custom_paimai` VALUES (10, 0, 'money很多很多', 200, 0, '这是个好东西，好好收藏', NULL, NULL, 1, 0, 1, NULL, '2022-11-25 09:40:21', '2023-04-22 20:35:22', '2023-04-22 20:35:22');
INSERT INTO `custom_paimai` VALUES (11, 0, '300Money出售', 100, 0, 'ok', NULL, NULL, 1, 0, 1, NULL, '2022-11-25 09:44:05', '2023-04-22 20:35:16', '2023-04-22 20:35:16');
INSERT INTO `custom_paimai` VALUES (12, 0, '出售50', 100, 0, '魂牵梦萦', NULL, NULL, 1, 0, 1, NULL, '2022-11-25 09:47:14', '2023-04-22 20:35:13', '2023-04-22 20:35:13');
INSERT INTO `custom_paimai` VALUES (13, 0, 'test50', 50, 0, 'fdsa', NULL, NULL, 1, 0, 1, 56, '2022-11-25 09:51:27', '2023-04-22 20:35:10', '2023-04-22 20:35:10');
INSERT INTO `custom_paimai` VALUES (14, 0, '出售出售出售', 100, 0, '这个看起来很漂亮！！', NULL, NULL, 1, 0, 56, NULL, '2022-12-01 14:38:30', '2023-04-22 20:35:07', '2023-04-22 20:35:07');
INSERT INTO `custom_paimai` VALUES (15, 0, '现金十元', 20, 0, '添加微信号cncn,卡密20221206105588', NULL, NULL, 1, 0, 56, 56, '2022-12-06 10:48:38', '2023-04-22 20:35:01', '2023-04-22 20:35:01');
INSERT INTO `custom_paimai` VALUES (16, 0, '现金10元', 200, 0, '卡密：123456789', NULL, NULL, 1, 0, 56, NULL, '2023-04-22 20:36:58', '2023-04-25 14:48:17', NULL);
INSERT INTO `custom_paimai` VALUES (17, 0, '现金20元', 400, 0, '1234512345', NULL, NULL, 1, 0, 56, 1, '2023-04-22 20:38:50', '2023-04-25 14:48:17', NULL);
INSERT INTO `custom_paimai` VALUES (18, 0, '现金10元', 10, 0, '123456789', NULL, NULL, 1, 0, 56, 56, '2023-05-18 16:48:28', '2023-05-18 17:00:08', NULL);
INSERT INTO `custom_paimai` VALUES (19, 0, '现金99', 10, 100, '嘿嘿嘿：XXXXXX', NULL, NULL, 1, 0, 1, 1, '2023-05-22 13:52:52', '2023-05-22 21:59:01', NULL);
INSERT INTO `custom_paimai` VALUES (20, 0, '88', 8, 0, 'XXXXX', NULL, NULL, 1, 0, 1, NULL, '2023-05-22 14:01:09', '2023-05-22 21:59:01', NULL);
INSERT INTO `custom_paimai` VALUES (21, 0, '现金10元', 10, 0, '123456789', NULL, NULL, 1, 0, 56, NULL, '2023-05-22 18:12:35', '2023-05-22 21:59:01', NULL);
COMMIT;

-- ----------------------------
-- Table structure for custom_paimai_join
-- ----------------------------
DROP TABLE IF EXISTS `custom_paimai_join`;
CREATE TABLE `custom_paimai_join` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pid` int DEFAULT NULL COMMENT '拍卖ID',
  `uid` int DEFAULT '0' COMMENT '参与者ID',
  `numb` int DEFAULT '0' COMMENT '起拍出价',
  `status` tinyint(1) DEFAULT '0' COMMENT '获胜状态',
  `adduid` int DEFAULT NULL COMMENT '添加者ID',
  `edituid` int DEFAULT NULL COMMENT '最后编辑者ID',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='拍卖参与表';

-- ----------------------------
-- Records of custom_paimai_join
-- ----------------------------
BEGIN;
INSERT INTO `custom_paimai_join` VALUES (1, 3, 71, 99, NULL, 1, 13, '2022-11-04 14:55:36', '2022-11-05 10:31:16', NULL);
INSERT INTO `custom_paimai_join` VALUES (2, 3, 72, 999, NULL, 1, 1, '2022-11-04 14:56:56', '2022-11-08 09:17:53', NULL);
INSERT INTO `custom_paimai_join` VALUES (3, 9, 82, 9999, NULL, NULL, NULL, '2022-11-16 08:42:52', NULL, NULL);
INSERT INTO `custom_paimai_join` VALUES (4, 4, 73, 99999, NULL, NULL, NULL, '2022-11-21 13:40:33', NULL, NULL);
INSERT INTO `custom_paimai_join` VALUES (5, 2, 74, 33, NULL, NULL, NULL, '2022-11-23 08:21:56', NULL, NULL);
INSERT INTO `custom_paimai_join` VALUES (6, 1, 73, 8888, 1, NULL, NULL, '2022-11-23 08:22:03', '2022-11-30 11:29:01', NULL);
INSERT INTO `custom_paimai_join` VALUES (7, 3, 74, 232, NULL, NULL, NULL, '2022-11-23 09:24:53', NULL, NULL);
INSERT INTO `custom_paimai_join` VALUES (8, 8, 80, 199, NULL, NULL, NULL, '2022-11-23 09:25:30', NULL, NULL);
INSERT INTO `custom_paimai_join` VALUES (9, 1, 60, 87, NULL, NULL, NULL, '2022-11-23 09:25:39', NULL, NULL);
INSERT INTO `custom_paimai_join` VALUES (10, 2, 60, 200, 1, NULL, NULL, '2022-11-23 09:26:02', '2022-11-30 11:29:01', NULL);
INSERT INTO `custom_paimai_join` VALUES (11, 3, 77, 8888, NULL, NULL, NULL, '2022-11-23 09:26:11', NULL, NULL);
INSERT INTO `custom_paimai_join` VALUES (12, 3, 78, 977788, NULL, NULL, NULL, '2022-11-23 09:26:19', NULL, NULL);
INSERT INTO `custom_paimai_join` VALUES (13, 6, 79, 2222, NULL, NULL, NULL, '2022-11-23 09:26:25', NULL, NULL);
INSERT INTO `custom_paimai_join` VALUES (14, 4, 60, 300, NULL, NULL, NULL, '2022-11-23 09:27:36', NULL, NULL);
INSERT INTO `custom_paimai_join` VALUES (15, 5, 60, 1, NULL, NULL, NULL, '2022-11-23 20:21:25', '2022-11-23 20:21:25', NULL);
INSERT INTO `custom_paimai_join` VALUES (16, 5, 60, 2, NULL, NULL, NULL, '2022-11-23 20:25:03', '2022-11-23 20:25:03', NULL);
INSERT INTO `custom_paimai_join` VALUES (17, 5, 60, 3, NULL, NULL, NULL, '2022-11-23 20:25:09', '2022-11-23 20:25:09', NULL);
INSERT INTO `custom_paimai_join` VALUES (18, 4, 71, 120000, NULL, NULL, NULL, '2022-11-23 20:25:51', '2022-11-23 20:25:51', NULL);
INSERT INTO `custom_paimai_join` VALUES (19, 3, 60, 77789, NULL, NULL, NULL, '2022-11-23 20:26:12', '2022-11-23 20:26:12', NULL);
INSERT INTO `custom_paimai_join` VALUES (20, 7, 81, 77790, NULL, NULL, NULL, '2022-11-23 20:26:15', '2022-11-23 20:26:15', NULL);
INSERT INTO `custom_paimai_join` VALUES (21, 4, 60, 100001, NULL, NULL, NULL, '2022-11-23 20:29:19', '2022-11-23 20:29:19', NULL);
INSERT INTO `custom_paimai_join` VALUES (22, 3, 60, 977789, 1, NULL, NULL, '2022-11-23 21:19:57', '2022-11-30 11:29:01', NULL);
INSERT INTO `custom_paimai_join` VALUES (23, 6, 60, 10, NULL, NULL, NULL, '2022-11-23 21:34:57', '2022-11-23 21:34:57', NULL);
INSERT INTO `custom_paimai_join` VALUES (24, 7, 60, 1001, NULL, NULL, NULL, '2022-11-24 13:17:56', '2022-11-24 13:17:56', NULL);
INSERT INTO `custom_paimai_join` VALUES (25, 8, 60, 889, NULL, NULL, NULL, '2022-11-24 13:20:03', '2022-11-24 13:20:03', NULL);
INSERT INTO `custom_paimai_join` VALUES (26, 10, 60, 210, NULL, NULL, NULL, '2022-11-25 09:40:37', '2022-11-25 09:40:37', NULL);
INSERT INTO `custom_paimai_join` VALUES (27, 11, 60, 101, 1, NULL, NULL, '2022-11-25 09:44:12', '2022-11-25 10:27:14', NULL);
INSERT INTO `custom_paimai_join` VALUES (28, 12, 60, 101, NULL, NULL, NULL, '2022-11-25 09:47:31', '2022-11-25 09:47:31', NULL);
INSERT INTO `custom_paimai_join` VALUES (29, 13, 60, 50, 1, NULL, NULL, '2022-11-25 09:54:37', '2022-11-25 10:27:14', NULL);
INSERT INTO `custom_paimai_join` VALUES (30, 12, 78, 106, 1, NULL, NULL, '2022-11-25 09:55:05', '2022-11-25 10:27:14', NULL);
INSERT INTO `custom_paimai_join` VALUES (31, 12, 60, 105, NULL, NULL, NULL, '2022-11-25 09:55:16', '2022-11-25 09:55:16', NULL);
INSERT INTO `custom_paimai_join` VALUES (32, 13, 88, 51, 1, NULL, NULL, '2022-11-29 20:26:03', '2022-11-30 11:29:01', NULL);
INSERT INTO `custom_paimai_join` VALUES (33, 14, 60, 100, 1, NULL, NULL, '2022-12-01 19:32:34', '2022-12-07 09:39:13', NULL);
INSERT INTO `custom_paimai_join` VALUES (34, 15, 88, 20, 0, NULL, NULL, '2022-12-06 12:13:30', '2022-12-06 12:13:30', NULL);
INSERT INTO `custom_paimai_join` VALUES (35, 15, 94, 21, 0, NULL, NULL, '2022-12-06 12:46:23', '2022-12-06 12:46:23', NULL);
INSERT INTO `custom_paimai_join` VALUES (36, 15, 88, 22, 0, NULL, NULL, '2022-12-06 12:48:32', '2022-12-06 12:48:32', NULL);
INSERT INTO `custom_paimai_join` VALUES (37, 15, 86, 23, 1, NULL, NULL, '2022-12-06 14:52:18', '2022-12-07 09:39:13', NULL);
INSERT INTO `custom_paimai_join` VALUES (38, 16, 60, 201, 0, NULL, NULL, '2023-04-23 09:19:39', '2023-04-23 09:19:39', NULL);
INSERT INTO `custom_paimai_join` VALUES (39, 17, 88, 410, 0, NULL, NULL, '2023-04-23 10:01:28', '2023-04-23 10:01:28', NULL);
INSERT INTO `custom_paimai_join` VALUES (40, 17, 86, 600, 1, NULL, NULL, '2023-04-23 10:12:05', '2023-04-25 14:48:17', NULL);
INSERT INTO `custom_paimai_join` VALUES (41, 16, 88, 210, 0, NULL, NULL, '2023-04-23 10:37:40', '2023-04-23 10:37:40', NULL);
INSERT INTO `custom_paimai_join` VALUES (42, 16, 60, 211, 0, NULL, NULL, '2023-04-24 08:23:32', '2023-04-24 08:23:32', NULL);
INSERT INTO `custom_paimai_join` VALUES (43, 16, 88, 220, 1, NULL, NULL, '2023-04-25 14:25:09', '2023-04-25 14:48:17', NULL);
INSERT INTO `custom_paimai_join` VALUES (44, 19, 86, 10, 1, NULL, NULL, '2023-05-22 14:32:50', '2023-05-22 21:59:01', NULL);
INSERT INTO `custom_paimai_join` VALUES (45, 21, 88, 11, 1, NULL, NULL, '2023-05-22 18:14:28', '2023-05-22 21:59:01', NULL);
INSERT INTO `custom_paimai_join` VALUES (46, 20, 88, 11, 1, NULL, NULL, '2023-05-22 18:15:11', '2023-05-22 21:59:01', NULL);
COMMIT;

-- ----------------------------
-- Table structure for custom_share
-- ----------------------------
DROP TABLE IF EXISTS `custom_share`;
CREATE TABLE `custom_share` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '分享的标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '分享的内容',
  `url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` tinyint DEFAULT '1',
  `uid` int DEFAULT '0' COMMENT '投票者ID',
  `adduid` int DEFAULT NULL COMMENT '添加者ID',
  `edituid` int DEFAULT NULL COMMENT '最后编辑者ID',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `uid` (`uid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='分享内容编辑表';

-- ----------------------------
-- Records of custom_share
-- ----------------------------
BEGIN;
INSERT INTO `custom_share` VALUES (1, 'fasdfsaf', 'fdsafdsaf', 'https://app.yuyaoit.cn/h5/#/pages/member/reg?invited=123123', 1, 60, NULL, NULL, '2022-12-07 15:04:17', '2023-01-15 13:48:17', NULL);
INSERT INTO `custom_share` VALUES (2, '捣乱游戏', '远程捉弄捣乱游戏', 'https://app.yuyaoit.cn/h5/#/pages/member/reg?invited=53260884', 1, 88, NULL, NULL, '2022-12-07 15:39:43', '2023-07-12 06:53:02', NULL);
INSERT INTO `custom_share` VALUES (3, 'fdsfda', 'fdsafdsa', 'https://app.yuyaoit.cn/h5/#/pages/member/reg?invited=111111', 1, 86, NULL, NULL, '2022-12-08 09:28:07', '2022-12-10 15:39:30', NULL);
INSERT INTO `custom_share` VALUES (4, '愿意采纳我们的人员讨论', '注册的时候弄个手机绑定，不过不是必须项，然后绑定的可以用手机号和密码登录，也就是另外给一个账号，咕咕咕…哦吼的东西，在不知道什么鬼知道吧啦啦啦德玛西亚皇子~哦！好好休息一下…哦！好看到这个是你想吃你说了什么的人民是~哦！好吧，哦了路由器？好了路线旁边加油站？好好休息一下…哦豁口腔', 'https://app.yuyaoit.cn/h5/#/pages/member/reg?invited=84139522', 1, 99, NULL, NULL, '2022-12-08 14:55:43', '2022-12-08 14:55:43', NULL);
INSERT INTO `custom_share` VALUES (5, '噜啦噜啦嘞力量', '又要开始反正接触铁元素周期表~哦了解了解下来吧，在', 'https://app.yuyaoit.cn/h5/#/pages/member/reg?invited=69079282', 1, 101, NULL, NULL, '2022-12-10 09:55:31', '2022-12-10 09:55:31', NULL);
INSERT INTO `custom_share` VALUES (6, '滴里里里里', '还急急急', 'https://app.yuyaoit.cn/h5/#/pages/member/reg?invited=35077561', 1, 100, NULL, NULL, '2022-12-10 10:58:26', '2022-12-10 16:36:00', NULL);
INSERT INTO `custom_share` VALUES (7, '这是什么', '我来试试我再看看我们这边有个女的就是这个样子货到时候再说这话没错没错啊哈哈吧', 'https://app.yuyaoit.cn/h5/#/pages/member/reg?invited=91362660', 1, 102, NULL, NULL, '2022-12-10 12:25:36', '2022-12-10 16:37:08', NULL);
INSERT INTO `custom_share` VALUES (8, 'fdsfdsaf', 'fdsafdsaf', 'https://app.yuyaoit.cn/h5/#/pages/member/reg?invited=79164123', 1, 105, NULL, NULL, '2022-12-10 16:35:16', '2022-12-10 16:35:16', NULL);
COMMIT;

-- ----------------------------
-- Table structure for custom_signin
-- ----------------------------
DROP TABLE IF EXISTS `custom_signin`;
CREATE TABLE `custom_signin` (
  `id` int NOT NULL AUTO_INCREMENT,
  `uid` int DEFAULT '0' COMMENT '用户ID',
  `total` int DEFAULT '1' COMMENT '签到累计',
  `curmonth` int DEFAULT '1' COMMENT '当月累计',
  `adduid` int DEFAULT NULL COMMENT '添加者ID',
  `edituid` int DEFAULT NULL COMMENT '最后编辑者ID',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `vid` (`uid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='签到汇总表';

-- ----------------------------
-- Records of custom_signin
-- ----------------------------
BEGIN;
INSERT INTO `custom_signin` VALUES (1, 60, 6, 0, NULL, NULL, '2023-04-13 14:02:39', '2023-06-04 17:33:09', NULL);
INSERT INTO `custom_signin` VALUES (2, 88, 81, 3, NULL, NULL, '2023-04-13 14:57:46', '2023-09-10 22:35:30', NULL);
INSERT INTO `custom_signin` VALUES (5, 107, 2, 0, NULL, NULL, '2023-04-19 17:01:44', '2023-06-04 17:33:09', NULL);
INSERT INTO `custom_signin` VALUES (6, 114, 23, 1, NULL, NULL, '2023-04-21 11:03:48', '2023-08-21 12:26:32', NULL);
INSERT INTO `custom_signin` VALUES (7, 115, 1, 0, NULL, NULL, '2023-04-22 17:49:07', '2023-06-04 17:33:09', NULL);
INSERT INTO `custom_signin` VALUES (8, 86, 6, 1, NULL, NULL, '2023-04-23 13:54:23', '2023-06-03 21:30:52', NULL);
INSERT INTO `custom_signin` VALUES (9, 116, 1, 0, NULL, NULL, '2023-04-26 21:18:51', '2023-06-04 17:33:09', NULL);
INSERT INTO `custom_signin` VALUES (10, 118, 1, 0, NULL, NULL, '2023-04-27 09:49:56', '2023-06-04 17:33:09', NULL);
INSERT INTO `custom_signin` VALUES (11, 122, 1, 0, NULL, NULL, '2023-05-30 08:32:20', '2023-06-04 17:33:09', NULL);
INSERT INTO `custom_signin` VALUES (12, 121, 1, 1, NULL, NULL, '2023-07-07 18:12:31', '2023-07-07 18:12:31', NULL);
INSERT INTO `custom_signin` VALUES (13, 124, 4, 1, NULL, NULL, '2023-08-02 12:45:28', '2023-09-11 17:54:52', NULL);
INSERT INTO `custom_signin` VALUES (14, 125, 1, 1, NULL, NULL, '2023-08-08 16:30:13', '2023-08-08 16:30:13', NULL);
INSERT INTO `custom_signin` VALUES (15, 126, 1, 1, NULL, NULL, '2023-08-09 22:07:13', '2023-08-09 22:07:13', NULL);
COMMIT;

-- ----------------------------
-- Table structure for custom_smslog
-- ----------------------------
DROP TABLE IF EXISTS `custom_smslog`;
CREATE TABLE `custom_smslog` (
  `id` int NOT NULL AUTO_INCREMENT,
  `deviceid` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `tag` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' COMMENT '来源',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `mvcode` int DEFAULT '0' COMMENT '验证码',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `tag` (`tag`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='短信发送日志';

-- ----------------------------
-- Records of custom_smslog
-- ----------------------------
BEGIN;
INSERT INTO `custom_smslog` VALUES (19, '16705742517742164908', 'ey', '15057489802', 5560, '2022-12-09 19:35:04', '2022-12-09 19:35:04', NULL);
INSERT INTO `custom_smslog` VALUES (20, '16705581843253486987', 'ey', '13958345202', 4112, '2022-12-10 09:56:27', '2022-12-10 09:56:27', NULL);
INSERT INTO `custom_smslog` VALUES (21, '16706317127286330010', 'ey', '15057489802', 1751, '2022-12-10 14:14:38', '2022-12-10 14:14:38', NULL);
INSERT INTO `custom_smslog` VALUES (22, '18E8D46CE68C0DFA3AD1054EE061D4B2', 'ey', '15913284755', 1555, '2023-01-16 14:23:10', '2023-01-16 14:23:10', NULL);
INSERT INTO `custom_smslog` VALUES (23, '18E8D46CE68C0DFA3AD1054EE061D4B2', 'ey', '15913284755', 5811, '2023-01-16 14:24:16', '2023-01-16 14:24:16', NULL);
INSERT INTO `custom_smslog` VALUES (24, '18E8D46CE68C0DFA3AD1054EE061D4B2', 'ey', '15913284755', 2319, '2023-01-16 14:29:37', '2023-01-16 14:29:37', NULL);
INSERT INTO `custom_smslog` VALUES (25, '16828194700162254241', 'ey', '13588738976', 1132, '2023-04-30 10:51:59', '2023-04-30 10:51:59', NULL);
COMMIT;

-- ----------------------------
-- Table structure for custom_vote
-- ----------------------------
DROP TABLE IF EXISTS `custom_vote`;
CREATE TABLE `custom_vote` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tag` tinyint(1) DEFAULT '0' COMMENT '类别：',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '投票议题',
  `intro` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '议题说明',
  `btime` datetime DEFAULT NULL COMMENT '开始时间',
  `etime` datetime DEFAULT NULL COMMENT '截止时间',
  `votemax` int DEFAULT NULL COMMENT '投票上限，达到上限自动结束',
  `voteopt` tinyint(1) DEFAULT '1' COMMENT '投票选项，1为单选，0为多选',
  `status` tinyint DEFAULT '0' COMMENT '状态',
  `uid` int DEFAULT '0' COMMENT '发布者ID，平台发布时为0',
  `adduid` int DEFAULT NULL COMMENT '添加者ID',
  `edituid` int DEFAULT NULL COMMENT '最后编辑者ID',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='投票信息表';

-- ----------------------------
-- Records of custom_vote
-- ----------------------------
BEGIN;
INSERT INTO `custom_vote` VALUES (1, 2, '调查一下看看22', '222由平台根据讨论结果提起的投票以及平台直接提请的投票', NULL, NULL, NULL, 1, 1, 0, 1, 1, '2022-11-04 14:55:36', '2022-11-28 14:45:21', NULL);
INSERT INTO `custom_vote` VALUES (3, 3, '出售100元', '兑换号码：10000\n兑换密码：999999', NULL, NULL, NULL, 1, 1, 0, NULL, 1, '2022-11-16 08:42:52', '2022-11-28 10:59:03', NULL);
INSERT INTO `custom_vote` VALUES (4, 1, '你是第几级杀手？', '你是第几级杀手？你是第几级杀手？你是第几级杀手？\n你是第几级杀手？你是第几级杀手？', NULL, NULL, NULL, 1, 1, 0, NULL, 1, '2022-11-21 13:40:33', '2022-11-28 10:05:55', NULL);
INSERT INTO `custom_vote` VALUES (5, 1, 'testtest', 'fdsafa', NULL, NULL, NULL, 1, 2, 0, 1, 1, '2022-11-22 15:35:28', '2022-11-28 15:07:42', NULL);
INSERT INTO `custom_vote` VALUES (6, 0, '这是新的投票', '', NULL, '2022-11-30 00:00:00', NULL, 1, 1, 0, 1, NULL, '2022-11-23 10:28:45', '2022-11-28 09:53:45', '2022-11-28 09:53:45');
INSERT INTO `custom_vote` VALUES (7, 1, '再来一次', '', NULL, NULL, NULL, 1, 1, 0, 1, 1, '2022-11-23 10:29:25', '2022-11-28 10:58:42', NULL);
INSERT INTO `custom_vote` VALUES (8, 1, '再再再一次', '', NULL, NULL, NULL, 1, 1, 0, 1, 1, '2022-11-23 10:30:56', '2022-11-28 15:04:04', NULL);
INSERT INTO `custom_vote` VALUES (9, 1, '关于讨论一下这个是需要房东真的萨沙', '关于讨论一下这个是需要房东真的萨沙关于讨论一下这个是需要房东真的萨沙', NULL, NULL, NULL, 1, 0, 0, 1, 1, '2022-11-26 09:53:07', '2022-11-28 10:57:21', NULL);
INSERT INTO `custom_vote` VALUES (10, 1, '一直在想', '', NULL, NULL, NULL, 1, 1, 0, 1, 1, '2022-11-28 10:34:40', '2022-11-28 15:03:42', NULL);
INSERT INTO `custom_vote` VALUES (11, 3, '主题', '主题主题主题', NULL, NULL, NULL, 1, 1, 60, NULL, NULL, '2022-11-28 20:16:31', '2022-11-28 20:16:31', NULL);
INSERT INTO `custom_vote` VALUES (12, 3, '时间限制', 'abcdefg', NULL, NULL, NULL, 1, 1, 88, NULL, NULL, '2022-11-29 20:10:41', '2022-11-29 20:10:41', NULL);
INSERT INTO `custom_vote` VALUES (13, 3, '时间限制', 'abcdefg', NULL, NULL, NULL, 1, 1, 88, NULL, NULL, '2022-11-29 20:10:45', '2022-11-29 20:10:45', NULL);
INSERT INTO `custom_vote` VALUES (14, 3, '时间限制', 'abcdefg', NULL, NULL, NULL, 1, 1, 88, NULL, NULL, '2022-11-29 20:10:48', '2022-11-29 20:10:48', NULL);
INSERT INTO `custom_vote` VALUES (15, 3, '测试议题讨论', '一二三四五六七八九十', NULL, '2022-12-02 00:00:00', NULL, 1, 1, 88, NULL, NULL, '2022-11-30 14:31:13', '2022-11-30 14:31:13', NULL);
INSERT INTO `custom_vote` VALUES (16, 1, '投票规则', '通过率达到80%以上，才算通过，修改规则则需要投票人数大于或约等于前次投票数。', NULL, '2022-12-31 00:00:00', NULL, 1, 1, 0, 56, 56, '2022-12-06 10:26:25', '2022-12-06 10:51:54', '2022-12-06 10:51:54');
INSERT INTO `custom_vote` VALUES (17, 1, '投票规则', '通过率80%以上', NULL, '2022-12-31 00:00:00', NULL, 1, 1, 0, 56, 56, '2022-12-06 10:52:50', '2022-12-06 10:53:41', NULL);
COMMIT;

-- ----------------------------
-- Table structure for custom_vote_ext
-- ----------------------------
DROP TABLE IF EXISTS `custom_vote_ext`;
CREATE TABLE `custom_vote_ext` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fid` int DEFAULT NULL COMMENT '所属扩展ID',
  `relid` int DEFAULT NULL COMMENT '所属相关ID',
  `val` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '字段值',
  `adduid` int DEFAULT NULL,
  `edituid` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fid` (`fid`) USING BTREE,
  KEY `relid` (`relid`) USING BTREE,
  KEY `adduid` (`adduid`) USING BTREE,
  KEY `val` (`val`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='扩展字段值存储表';

-- ----------------------------
-- Records of custom_vote_ext
-- ----------------------------
BEGIN;
INSERT INTO `custom_vote_ext` VALUES (1, 33, 8, '1,2,3', 1, 1, '2022-11-23 10:58:39', '2022-11-28 15:04:04', NULL);
INSERT INTO `custom_vote_ext` VALUES (2, 33, 1, '1,2,4', 1, 1, '2022-11-23 11:02:04', '2022-11-28 14:45:21', NULL);
INSERT INTO `custom_vote_ext` VALUES (3, 33, 7, '1,2,4', 1, 1, '2022-11-23 12:20:28', '2022-11-28 10:58:42', NULL);
INSERT INTO `custom_vote_ext` VALUES (4, 33, 3, '1,2,3,4', 1, 1, '2022-11-25 11:05:11', '2022-11-28 10:59:03', NULL);
INSERT INTO `custom_vote_ext` VALUES (5, 33, 4, '1,2,4', 1, 1, '2022-11-25 13:14:46', '2022-11-28 10:05:55', NULL);
INSERT INTO `custom_vote_ext` VALUES (6, 33, 9, '2,3,4', 1, 1, '2022-11-26 09:53:07', '2022-11-28 10:57:21', NULL);
INSERT INTO `custom_vote_ext` VALUES (7, 33, 5, '1,2,3,4', 1, 1, '2022-11-26 15:47:02', '2022-11-28 15:07:42', NULL);
INSERT INTO `custom_vote_ext` VALUES (8, 33, 10, '1,2', 1, 1, '2022-11-28 10:34:40', '2022-11-28 15:03:42', NULL);
INSERT INTO `custom_vote_ext` VALUES (9, 33, 11, '2,3', 60, NULL, '2022-11-28 20:16:31', '2022-11-28 20:16:31', NULL);
INSERT INTO `custom_vote_ext` VALUES (10, 33, 12, '1,2,3', 88, NULL, '2022-11-29 20:10:41', '2022-11-29 20:10:41', NULL);
INSERT INTO `custom_vote_ext` VALUES (11, 33, 13, '1,2,3', 88, NULL, '2022-11-29 20:10:45', '2022-11-29 20:10:45', NULL);
INSERT INTO `custom_vote_ext` VALUES (12, 33, 14, '1,2,3', 88, NULL, '2022-11-29 20:10:48', '2022-11-29 20:10:48', NULL);
INSERT INTO `custom_vote_ext` VALUES (13, 33, 15, '1,2,3,4', 88, NULL, '2022-11-30 14:31:13', '2022-11-30 14:31:13', NULL);
INSERT INTO `custom_vote_ext` VALUES (15, 33, 17, '1,2,3,4', 56, 56, '2022-12-06 10:52:50', '2022-12-06 10:53:41', NULL);
COMMIT;

-- ----------------------------
-- Table structure for custom_vote_join
-- ----------------------------
DROP TABLE IF EXISTS `custom_vote_join`;
CREATE TABLE `custom_vote_join` (
  `id` int NOT NULL AUTO_INCREMENT,
  `vid` int DEFAULT NULL COMMENT '投票ID',
  `value` tinyint(1) DEFAULT '0' COMMENT '投票值',
  `uid` int DEFAULT '0' COMMENT '投票者ID',
  `adduid` int DEFAULT NULL COMMENT '添加者ID',
  `edituid` int DEFAULT NULL COMMENT '最后编辑者ID',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `vid` (`vid`,`uid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='投票参与表';

-- ----------------------------
-- Records of custom_vote_join
-- ----------------------------
BEGIN;
INSERT INTO `custom_vote_join` VALUES (2, 8, 4, 70, NULL, NULL, '2022-11-26 14:26:23', NULL, NULL);
INSERT INTO `custom_vote_join` VALUES (3, 8, 3, 71, NULL, NULL, '2022-11-26 14:26:24', NULL, NULL);
INSERT INTO `custom_vote_join` VALUES (4, 8, 3, 72, NULL, NULL, '2022-11-26 14:26:26', NULL, NULL);
INSERT INTO `custom_vote_join` VALUES (5, 8, 1, 75, NULL, NULL, '2022-11-26 14:27:57', NULL, NULL);
INSERT INTO `custom_vote_join` VALUES (7, 9, 3, 73, NULL, NULL, '2022-11-26 20:00:28', NULL, NULL);
INSERT INTO `custom_vote_join` VALUES (8, 7, 1, 60, NULL, NULL, '2022-11-27 09:30:37', '2022-11-27 09:30:37', NULL);
INSERT INTO `custom_vote_join` VALUES (12, 9, 3, 86, NULL, NULL, '2022-11-28 08:10:49', '2022-11-28 08:10:49', NULL);
INSERT INTO `custom_vote_join` VALUES (13, 5, 2, 86, NULL, NULL, '2022-11-28 08:11:43', '2022-11-28 08:11:43', NULL);
INSERT INTO `custom_vote_join` VALUES (14, 7, 4, 86, NULL, NULL, '2022-11-28 10:26:26', '2022-11-28 10:26:26', NULL);
INSERT INTO `custom_vote_join` VALUES (15, 10, 1, 86, NULL, NULL, '2022-11-28 10:35:10', '2022-11-28 10:35:10', NULL);
INSERT INTO `custom_vote_join` VALUES (16, 3, 1, 86, NULL, NULL, '2022-11-28 15:12:14', '2022-11-28 15:12:14', NULL);
INSERT INTO `custom_vote_join` VALUES (17, 1, 1, 86, NULL, NULL, '2022-11-28 19:15:01', '2022-11-28 19:15:01', NULL);
INSERT INTO `custom_vote_join` VALUES (18, 4, 2, 86, NULL, NULL, '2022-11-28 19:20:04', '2022-11-28 19:20:04', NULL);
INSERT INTO `custom_vote_join` VALUES (19, 3, 4, 60, NULL, NULL, '2022-11-28 19:43:35', '2022-11-28 19:43:35', NULL);
INSERT INTO `custom_vote_join` VALUES (20, 11, 2, 60, NULL, NULL, '2022-11-28 20:16:59', '2022-11-28 20:16:59', NULL);
INSERT INTO `custom_vote_join` VALUES (21, 3, 1, 89, NULL, NULL, '2022-11-29 20:10:12', '2022-11-29 20:10:12', NULL);
INSERT INTO `custom_vote_join` VALUES (22, 13, 1, 88, NULL, NULL, '2022-11-29 20:11:07', '2022-11-29 20:11:07', NULL);
INSERT INTO `custom_vote_join` VALUES (23, 1, 2, 89, NULL, NULL, '2022-11-29 20:11:28', '2022-11-29 20:11:28', NULL);
INSERT INTO `custom_vote_join` VALUES (24, 14, 2, 89, NULL, NULL, '2022-11-29 20:11:38', '2022-11-29 20:11:38', NULL);
INSERT INTO `custom_vote_join` VALUES (25, 8, 1, 88, NULL, NULL, '2022-11-29 20:12:24', '2022-11-29 20:12:24', NULL);
INSERT INTO `custom_vote_join` VALUES (26, 7, 1, 88, NULL, NULL, '2022-11-29 20:12:33', '2022-11-29 20:12:33', NULL);
INSERT INTO `custom_vote_join` VALUES (27, 10, 1, 88, NULL, NULL, '2022-11-29 20:12:55', '2022-11-29 20:12:55', NULL);
INSERT INTO `custom_vote_join` VALUES (28, 4, 4, 88, NULL, NULL, '2022-11-29 20:13:13', '2022-11-29 20:13:13', NULL);
INSERT INTO `custom_vote_join` VALUES (29, 13, 2, 87, NULL, NULL, '2022-11-29 20:33:06', '2022-11-29 20:33:06', NULL);
INSERT INTO `custom_vote_join` VALUES (30, 1, 1, 88, NULL, NULL, '2022-11-30 14:28:02', '2022-11-30 14:28:02', NULL);
INSERT INTO `custom_vote_join` VALUES (31, 15, 1, 88, NULL, NULL, '2022-11-30 14:31:26', '2022-11-30 14:31:26', NULL);
INSERT INTO `custom_vote_join` VALUES (32, 15, 1, 87, NULL, NULL, '2022-11-30 21:25:47', '2022-11-30 21:25:47', NULL);
INSERT INTO `custom_vote_join` VALUES (33, 16, 1, 88, NULL, NULL, '2022-12-06 10:27:25', '2022-12-06 10:27:25', NULL);
INSERT INTO `custom_vote_join` VALUES (34, 17, 3, 88, NULL, NULL, '2022-12-06 10:54:01', '2022-12-06 10:54:01', NULL);
INSERT INTO `custom_vote_join` VALUES (35, 17, 2, 86, NULL, NULL, '2022-12-06 11:02:36', '2022-12-06 11:02:36', NULL);
INSERT INTO `custom_vote_join` VALUES (36, 8, 1, 86, NULL, NULL, '2022-12-06 11:03:14', '2022-12-06 11:03:14', NULL);
INSERT INTO `custom_vote_join` VALUES (37, 17, 1, 94, NULL, NULL, '2022-12-06 12:42:58', '2022-12-06 12:42:58', NULL);
INSERT INTO `custom_vote_join` VALUES (38, 10, 1, 105, NULL, NULL, '2022-12-10 13:46:37', '2022-12-10 13:46:37', NULL);
COMMIT;

-- ----------------------------
-- Table structure for friend
-- ----------------------------
DROP TABLE IF EXISTS `friend`;
CREATE TABLE `friend` (
  `id` int NOT NULL AUTO_INCREMENT,
  `uid` int DEFAULT '0' COMMENT '最小满足分数',
  `fid` int DEFAULT '0' COMMENT '最高满足分数',
  `status` tinyint DEFAULT '0' COMMENT '状态',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `uid` (`uid`) USING BTREE,
  KEY `fid` (`fid`) USING BTREE,
  KEY `uid_2` (`uid`,`status`) USING BTREE,
  KEY `fid_2` (`fid`,`status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='好友关系表';

-- ----------------------------
-- Records of friend
-- ----------------------------
BEGIN;
INSERT INTO `friend` VALUES (1, 60, 86, 0, '2023-01-13 18:20:42', '2023-01-13 18:20:42', NULL);
INSERT INTO `friend` VALUES (2, 60, 106, 0, '2023-01-13 18:36:38', '2023-01-13 18:36:38', NULL);
INSERT INTO `friend` VALUES (3, 60, 88, 1, '2023-01-13 18:36:46', '2023-01-14 18:01:21', NULL);
INSERT INTO `friend` VALUES (4, 60, 89, 0, '2023-01-13 18:37:17', '2023-01-13 18:37:17', NULL);
INSERT INTO `friend` VALUES (5, 106, 60, 1, '2023-01-14 08:47:14', '2023-01-14 08:47:27', NULL);
INSERT INTO `friend` VALUES (6, 60, 80, 0, '2023-01-16 20:29:24', '2023-01-16 20:29:24', NULL);
INSERT INTO `friend` VALUES (7, 88, 107, 1, '2023-02-21 23:38:17', '2023-04-19 17:02:05', NULL);
INSERT INTO `friend` VALUES (8, 115, 88, 1, '2023-04-22 17:52:15', '2023-04-22 20:31:39', NULL);
INSERT INTO `friend` VALUES (9, 114, 88, 1, '2023-04-24 12:48:55', '2023-04-25 00:37:24', NULL);
COMMIT;

-- ----------------------------
-- Table structure for game_modules
-- ----------------------------
DROP TABLE IF EXISTS `game_modules`;
CREATE TABLE `game_modules` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '模块名称',
  `avatar` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '模块图标',
  `intro` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `a` int DEFAULT '0',
  `b` int DEFAULT '0',
  `rule` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '模块升级规则',
  `status` tinyint DEFAULT '1',
  `memo` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sort` int DEFAULT '0',
  `adduid` int DEFAULT NULL COMMENT '添加者ID',
  `edituid` int DEFAULT NULL COMMENT '最后编辑者ID',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='游戏-模块信息表';

-- ----------------------------
-- Records of game_modules
-- ----------------------------
BEGIN;
INSERT INTO `game_modules` VALUES (1, '攻击', 'gongji.png', '意识潮汐，属性伤害加成', 0, 0, '{coin}*{lvl}', 1, NULL, 0, NULL, NULL, '2023-03-21 15:44:43', NULL, NULL);
INSERT INTO `game_modules` VALUES (2, '护盾', 'hudun.png', '意识护盾，属性防御加成', 0, 0, NULL, 1, NULL, 0, NULL, NULL, '2023-03-21 15:45:03', NULL, NULL);
INSERT INTO `game_modules` VALUES (3, '血量', 'shengming.png', '意识结构，属性生命', 0, 0, NULL, 1, NULL, 0, NULL, NULL, '2023-03-21 15:45:16', NULL, NULL);
INSERT INTO `game_modules` VALUES (4, '速度', 'sudu.png', '意识推动，属性速度加成', 0, 0, NULL, 1, NULL, 0, NULL, NULL, '2023-03-21 15:45:28', NULL, NULL);
INSERT INTO `game_modules` VALUES (5, '射程', 'shechen.png', '意识专注，属性攻击距离', 0, 0, NULL, 1, NULL, 0, NULL, NULL, '2023-03-21 15:45:39', NULL, NULL);
INSERT INTO `game_modules` VALUES (6, '修理', 'xiuli.png', '意识平衡，属性自动修理', 0, 0, NULL, 1, NULL, 0, NULL, NULL, '2023-03-21 15:45:50', NULL, NULL);
INSERT INTO `game_modules` VALUES (7, '采矿', 'caikuang.png', '意识吸引，属性采矿加成', 0, 0, NULL, 1, NULL, 0, NULL, NULL, '2023-03-21 15:46:03', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for game_modules_conf
-- ----------------------------
DROP TABLE IF EXISTS `game_modules_conf`;
CREATE TABLE `game_modules_conf` (
  `id` int NOT NULL AUTO_INCREMENT,
  `uid` int DEFAULT '0',
  `mid` int DEFAULT '0',
  `lvl` tinyint DEFAULT NULL COMMENT '模块等级',
  `status` tinyint DEFAULT '1',
  `memo` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sort` int DEFAULT '0',
  `adduid` int DEFAULT NULL COMMENT '添加者ID',
  `edituid` int DEFAULT NULL COMMENT '最后编辑者ID',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `uid` (`uid`,`mid`) USING BTREE,
  KEY `uid_2` (`uid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='游戏-用户模块生产基地';

-- ----------------------------
-- Records of game_modules_conf
-- ----------------------------
BEGIN;
INSERT INTO `game_modules_conf` VALUES (1, 60, 3, 5, 1, NULL, 0, NULL, NULL, '2023-03-27 15:01:48', '2023-03-31 15:04:59', NULL);
INSERT INTO `game_modules_conf` VALUES (2, 112, 5, 4, 1, NULL, 0, NULL, NULL, '2023-03-27 15:15:58', NULL, NULL);
INSERT INTO `game_modules_conf` VALUES (3, 60, 1, 5, 1, NULL, 0, NULL, NULL, '2023-03-27 15:16:36', '2023-03-31 14:32:09', NULL);
INSERT INTO `game_modules_conf` VALUES (4, 60, 2, 4, 1, NULL, 0, NULL, NULL, '2023-03-28 08:07:14', '2023-04-01 09:28:55', NULL);
INSERT INTO `game_modules_conf` VALUES (5, 60, 7, 4, 1, NULL, 0, NULL, NULL, '2023-03-31 14:44:32', '2023-04-07 14:25:15', NULL);
INSERT INTO `game_modules_conf` VALUES (6, 60, 6, 4, 1, NULL, 0, NULL, NULL, '2023-03-31 14:45:28', '2023-04-11 08:53:37', NULL);
INSERT INTO `game_modules_conf` VALUES (7, 60, 5, 5, 1, NULL, 0, NULL, NULL, '2023-03-31 15:07:19', '2023-04-11 08:53:33', NULL);
INSERT INTO `game_modules_conf` VALUES (8, 60, 4, 5, 1, NULL, 0, NULL, NULL, '2023-04-01 08:14:27', '2023-04-02 15:50:29', NULL);
INSERT INTO `game_modules_conf` VALUES (9, 88, 1, 4, 1, NULL, 0, NULL, NULL, '2023-04-05 15:10:17', '2023-05-08 01:40:15', NULL);
INSERT INTO `game_modules_conf` VALUES (10, 88, 2, 4, 1, NULL, 0, NULL, NULL, '2023-04-05 15:10:19', '2023-06-05 15:36:28', NULL);
INSERT INTO `game_modules_conf` VALUES (11, 88, 3, 3, 1, NULL, 0, NULL, NULL, '2023-04-10 13:48:36', '2023-05-06 10:12:54', NULL);
INSERT INTO `game_modules_conf` VALUES (12, 88, 5, 4, 1, NULL, 0, NULL, NULL, '2023-04-13 14:59:19', '2023-07-17 23:23:29', NULL);
INSERT INTO `game_modules_conf` VALUES (13, 88, 4, 3, 1, NULL, 0, NULL, NULL, '2023-04-21 15:35:58', '2023-05-08 01:41:26', NULL);
INSERT INTO `game_modules_conf` VALUES (14, 88, 6, 3, 1, NULL, 0, NULL, NULL, '2023-04-21 15:36:16', '2023-05-24 09:01:48', NULL);
INSERT INTO `game_modules_conf` VALUES (15, 88, 7, 3, 1, NULL, 0, NULL, NULL, '2023-04-21 15:36:19', '2023-05-24 09:01:51', NULL);
INSERT INTO `game_modules_conf` VALUES (16, 115, 1, 1, 1, NULL, 0, NULL, NULL, '2023-04-22 17:53:07', '2023-04-22 17:53:07', NULL);
INSERT INTO `game_modules_conf` VALUES (17, 86, 1, 1, 1, NULL, 0, NULL, NULL, '2023-04-25 14:57:24', '2023-04-25 14:57:24', NULL);
INSERT INTO `game_modules_conf` VALUES (18, 86, 3, 1, 1, NULL, 0, NULL, NULL, '2023-05-09 07:57:28', '2023-05-09 07:57:28', NULL);
INSERT INTO `game_modules_conf` VALUES (19, 124, 1, 1, 1, NULL, 0, NULL, NULL, '2023-08-02 13:58:25', '2023-08-02 13:58:25', NULL);
INSERT INTO `game_modules_conf` VALUES (20, 124, 2, 1, 1, NULL, 0, NULL, NULL, '2023-08-02 13:58:43', '2023-08-02 13:58:43', NULL);
INSERT INTO `game_modules_conf` VALUES (21, 124, 3, 1, 1, NULL, 0, NULL, NULL, '2023-08-02 13:58:44', '2023-08-02 13:58:44', NULL);
INSERT INTO `game_modules_conf` VALUES (22, 124, 4, 1, 1, NULL, 0, NULL, NULL, '2023-08-02 13:58:46', '2023-08-02 13:58:46', NULL);
INSERT INTO `game_modules_conf` VALUES (23, 124, 5, 1, 1, NULL, 0, NULL, NULL, '2023-08-02 13:58:49', '2023-08-02 13:58:49', NULL);
INSERT INTO `game_modules_conf` VALUES (24, 124, 6, 1, 1, NULL, 0, NULL, NULL, '2023-08-02 13:58:50', '2023-08-02 13:58:50', NULL);
INSERT INTO `game_modules_conf` VALUES (25, 124, 7, 1, 1, NULL, 0, NULL, NULL, '2023-08-02 13:58:51', '2023-08-02 13:58:51', NULL);
COMMIT;

-- ----------------------------
-- Table structure for game_modules_sale
-- ----------------------------
DROP TABLE IF EXISTS `game_modules_sale`;
CREATE TABLE `game_modules_sale` (
  `id` int NOT NULL AUTO_INCREMENT,
  `uid` int DEFAULT '0',
  `mid` int DEFAULT '0',
  `lvl` tinyint DEFAULT NULL COMMENT '模块等级',
  `coin` int DEFAULT NULL,
  `sort` int DEFAULT '0',
  `status` int DEFAULT '1',
  `adduid` int DEFAULT NULL COMMENT '添加者ID',
  `edituid` int DEFAULT NULL COMMENT '最后编辑者ID',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `uid` (`uid`,`mid`) USING BTREE,
  KEY `uid_2` (`uid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='游戏-战斗装备出售表';

-- ----------------------------
-- Records of game_modules_sale
-- ----------------------------
BEGIN;
INSERT INTO `game_modules_sale` VALUES (6, 60, 7, 2, 1, 0, 1, NULL, NULL, '2023-04-03 15:37:13', '2023-04-03 15:37:13', NULL);
INSERT INTO `game_modules_sale` VALUES (7, 101, 2, 2, 99, 0, 1, NULL, NULL, '2023-04-03 15:44:51', '2023-04-03 15:44:51', NULL);
INSERT INTO `game_modules_sale` VALUES (8, 102, 2, 1, 100, 0, 1, NULL, NULL, '2023-04-03 15:44:59', '2023-04-03 15:44:59', NULL);
INSERT INTO `game_modules_sale` VALUES (23, 88, 7, 2, 20, 0, 1, NULL, NULL, '2023-04-05 16:09:19', '2023-04-05 16:09:19', NULL);
INSERT INTO `game_modules_sale` VALUES (26, 88, 7, 2, 100, 0, 1, NULL, NULL, '2023-04-06 00:26:43', '2023-04-06 00:26:43', NULL);
INSERT INTO `game_modules_sale` VALUES (28, 60, 7, 4, 90000, 0, 1, NULL, NULL, '2023-04-07 14:25:29', '2023-04-07 14:25:29', NULL);
INSERT INTO `game_modules_sale` VALUES (31, 60, 1, 5, 10000, 0, 1, NULL, NULL, '2023-04-10 11:44:45', '2023-04-10 11:44:45', NULL);
INSERT INTO `game_modules_sale` VALUES (32, 88, 7, 2, 168, 0, 1, NULL, NULL, '2023-04-11 08:42:46', '2023-04-11 08:42:46', NULL);
COMMIT;

-- ----------------------------
-- Table structure for game_user_equip
-- ----------------------------
DROP TABLE IF EXISTS `game_user_equip`;
CREATE TABLE `game_user_equip` (
  `id` int NOT NULL AUTO_INCREMENT,
  `uid` int DEFAULT '0',
  `mid` int DEFAULT '0',
  `lvl` tinyint DEFAULT NULL COMMENT '模块等级',
  `sort` int DEFAULT '0',
  `adduid` int DEFAULT NULL COMMENT '添加者ID',
  `edituid` int DEFAULT NULL COMMENT '最后编辑者ID',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `uid` (`uid`,`mid`) USING BTREE,
  KEY `uid_2` (`uid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=151 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='游戏-用户的战斗装备';

-- ----------------------------
-- Records of game_user_equip
-- ----------------------------
BEGIN;
INSERT INTO `game_user_equip` VALUES (6, 60, 2, 1, 18, NULL, NULL, '2023-04-03 09:39:18', '2023-04-03 09:39:18', NULL);
INSERT INTO `game_user_equip` VALUES (33, 60, 3, 2, 15, NULL, NULL, '2023-04-04 15:34:32', '2023-04-04 15:34:32', NULL);
INSERT INTO `game_user_equip` VALUES (37, 60, 2, 5, 17, NULL, NULL, '2023-04-05 14:50:39', '2023-04-05 14:50:39', NULL);
INSERT INTO `game_user_equip` VALUES (47, 88, 1, 1, 12, NULL, NULL, '2023-04-05 15:15:31', '2023-04-05 15:15:31', NULL);
INSERT INTO `game_user_equip` VALUES (59, 60, 5, 4, 12, NULL, NULL, '2023-04-05 15:43:52', '2023-04-05 15:43:52', NULL);
INSERT INTO `game_user_equip` VALUES (70, 88, 7, 2, 15, NULL, NULL, '2023-04-06 09:21:44', '2023-04-06 09:21:44', NULL);
INSERT INTO `game_user_equip` VALUES (71, 88, 7, 2, 18, NULL, NULL, '2023-04-06 09:21:46', '2023-04-06 09:21:46', NULL);
INSERT INTO `game_user_equip` VALUES (72, 88, 7, 2, 17, NULL, NULL, '2023-04-06 09:21:48', '2023-04-06 09:21:48', NULL);
INSERT INTO `game_user_equip` VALUES (106, 60, 5, 4, 9, NULL, NULL, '2023-04-10 11:47:15', '2023-04-10 11:47:15', NULL);
INSERT INTO `game_user_equip` VALUES (111, 60, 3, 5, 2, NULL, NULL, '2023-04-10 14:03:28', '2023-04-10 14:03:28', NULL);
INSERT INTO `game_user_equip` VALUES (114, 60, 5, 4, 3, NULL, NULL, '2023-04-10 14:23:00', '2023-04-10 14:23:00', NULL);
INSERT INTO `game_user_equip` VALUES (115, 60, 3, 5, 7, NULL, NULL, '2023-04-10 14:26:49', '2023-04-10 14:26:49', NULL);
INSERT INTO `game_user_equip` VALUES (126, 60, 5, 4, 1, NULL, NULL, '2023-04-11 08:52:10', '2023-04-11 08:52:10', NULL);
INSERT INTO `game_user_equip` VALUES (127, 60, 5, 4, 0, NULL, NULL, '2023-04-11 08:52:15', '2023-04-11 08:52:15', NULL);
INSERT INTO `game_user_equip` VALUES (129, 60, 3, 3, 10, NULL, NULL, '2023-04-11 09:31:29', '2023-04-11 09:31:29', NULL);
INSERT INTO `game_user_equip` VALUES (130, 60, 2, 1, 11, NULL, NULL, '2023-04-11 09:31:33', '2023-04-11 09:31:33', NULL);
INSERT INTO `game_user_equip` VALUES (134, 86, 3, 1, 1, NULL, NULL, '2023-05-09 07:57:38', '2023-05-09 07:57:38', NULL);
INSERT INTO `game_user_equip` VALUES (135, 86, 1, 1, 2, NULL, NULL, '2023-05-09 07:57:42', '2023-05-09 07:57:42', NULL);
INSERT INTO `game_user_equip` VALUES (141, 88, 2, 3, 1, NULL, NULL, '2023-07-18 17:08:59', '2023-07-18 17:08:59', NULL);
INSERT INTO `game_user_equip` VALUES (142, 88, 3, 3, 2, NULL, NULL, '2023-07-18 17:09:01', '2023-07-18 17:09:01', NULL);
INSERT INTO `game_user_equip` VALUES (143, 88, 5, 4, 3, NULL, NULL, '2023-07-18 17:09:04', '2023-07-18 17:09:04', NULL);
INSERT INTO `game_user_equip` VALUES (144, 88, 6, 2, 4, NULL, NULL, '2023-07-18 17:09:07', '2023-07-18 17:09:07', NULL);
INSERT INTO `game_user_equip` VALUES (145, 88, 7, 2, 8, NULL, NULL, '2023-07-18 17:09:10', '2023-07-18 17:09:10', NULL);
INSERT INTO `game_user_equip` VALUES (146, 88, 4, 3, 9, NULL, NULL, '2023-07-18 17:09:13', '2023-07-18 17:09:13', NULL);
INSERT INTO `game_user_equip` VALUES (147, 88, 7, 2, 10, NULL, NULL, '2023-07-18 17:09:15', '2023-07-18 17:09:15', NULL);
INSERT INTO `game_user_equip` VALUES (148, 88, 7, 2, 7, NULL, NULL, '2023-07-18 17:09:18', '2023-07-18 17:09:18', NULL);
INSERT INTO `game_user_equip` VALUES (150, 88, 3, 3, 11, NULL, NULL, '2023-07-18 21:04:56', '2023-07-18 21:04:56', NULL);
COMMIT;

-- ----------------------------
-- Table structure for game_user_modules
-- ----------------------------
DROP TABLE IF EXISTS `game_user_modules`;
CREATE TABLE `game_user_modules` (
  `id` int NOT NULL AUTO_INCREMENT,
  `uid` int DEFAULT '0',
  `mid` int DEFAULT '0',
  `lvl` tinyint DEFAULT NULL COMMENT '模块等级',
  `numb` int DEFAULT '1' COMMENT '数量',
  `sort` int DEFAULT '0',
  `adduid` int DEFAULT NULL COMMENT '添加者ID',
  `edituid` int DEFAULT NULL COMMENT '最后编辑者ID',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `uid` (`uid`,`mid`) USING BTREE,
  KEY `uid_2` (`uid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='游戏-用户的模块仓库';

-- ----------------------------
-- Records of game_user_modules
-- ----------------------------
BEGIN;
INSERT INTO `game_user_modules` VALUES (5, 60, 1, 3, 1, 0, NULL, NULL, '2023-03-29 14:31:45', '2023-04-09 16:15:42', NULL);
INSERT INTO `game_user_modules` VALUES (6, 60, 1, 1, 2, 0, NULL, NULL, '2023-03-29 15:29:42', '2023-04-04 13:22:14', NULL);
INSERT INTO `game_user_modules` VALUES (7, 60, 2, 0, 2, 0, NULL, NULL, '2023-03-29 15:29:53', '2023-03-29 15:40:13', NULL);
INSERT INTO `game_user_modules` VALUES (8, 60, 4, 0, 2, 0, NULL, NULL, '2023-03-29 15:41:24', '2023-03-31 13:29:44', NULL);
INSERT INTO `game_user_modules` VALUES (9, 60, 2, 1, 4, 0, NULL, NULL, '2023-03-29 15:43:18', '2023-04-11 09:31:33', NULL);
INSERT INTO `game_user_modules` VALUES (10, 60, 3, 2, 0, 0, NULL, NULL, '2023-03-29 15:49:03', '2023-04-05 16:06:32', NULL);
INSERT INTO `game_user_modules` VALUES (11, 60, 2, 2, 2, 0, NULL, NULL, '2023-03-30 09:40:15', '2023-04-12 10:00:37', NULL);
INSERT INTO `game_user_modules` VALUES (12, 60, 1, 4, 0, 0, NULL, NULL, '2023-03-31 09:34:52', '2023-04-07 13:26:06', NULL);
INSERT INTO `game_user_modules` VALUES (13, 60, 2, 5, 0, 0, NULL, NULL, '2023-03-31 11:02:25', '2023-04-05 16:06:34', NULL);
INSERT INTO `game_user_modules` VALUES (14, 60, 5, 0, 2, 0, NULL, NULL, '2023-03-31 11:02:29', '2023-03-31 14:45:41', NULL);
INSERT INTO `game_user_modules` VALUES (15, 60, 1, 5, 0, 0, NULL, NULL, '2023-03-31 13:40:49', '2023-04-11 08:50:20', NULL);
INSERT INTO `game_user_modules` VALUES (16, 60, 3, 5, 6, 0, NULL, NULL, '2023-03-31 13:50:42', '2023-04-10 14:26:49', NULL);
INSERT INTO `game_user_modules` VALUES (17, 60, 6, 2, 0, 0, NULL, NULL, '2023-03-31 14:47:01', '2023-04-03 09:30:15', NULL);
INSERT INTO `game_user_modules` VALUES (18, 60, 3, 3, 0, 0, NULL, NULL, '2023-03-31 14:49:48', '2023-04-11 09:31:29', NULL);
INSERT INTO `game_user_modules` VALUES (19, 60, 4, 1, 0, 0, NULL, NULL, '2023-04-01 08:16:21', '2023-04-04 13:41:36', NULL);
INSERT INTO `game_user_modules` VALUES (20, 60, 5, 4, 16, 0, NULL, NULL, '2023-04-02 15:57:10', '2023-04-11 09:31:27', NULL);
INSERT INTO `game_user_modules` VALUES (21, 60, 4, 5, 1, 0, NULL, NULL, '2023-04-02 20:01:17', '2023-04-14 09:17:53', NULL);
INSERT INTO `game_user_modules` VALUES (22, 60, 2, 4, 3, 0, NULL, NULL, '2023-04-02 20:33:57', '2023-04-11 08:51:57', NULL);
INSERT INTO `game_user_modules` VALUES (23, 60, 7, 2, 0, 0, NULL, NULL, '2023-04-03 09:46:11', '2023-04-07 13:28:51', NULL);
INSERT INTO `game_user_modules` VALUES (24, 60, 7, 3, 0, 0, NULL, NULL, '2023-04-03 15:55:39', '2023-04-07 13:26:57', NULL);
INSERT INTO `game_user_modules` VALUES (25, 88, 1, 1, 0, 0, NULL, NULL, '2023-04-05 15:10:31', '2023-05-24 09:00:26', NULL);
INSERT INTO `game_user_modules` VALUES (26, 88, 7, 2, 0, 0, NULL, NULL, '2023-04-05 15:12:06', '2023-07-18 17:09:18', NULL);
INSERT INTO `game_user_modules` VALUES (27, 88, 2, 1, 0, 0, NULL, NULL, '2023-04-05 15:14:54', '2023-05-24 09:00:21', NULL);
INSERT INTO `game_user_modules` VALUES (28, 60, 7, 4, 1, 0, NULL, NULL, '2023-04-07 14:25:17', '2023-04-10 14:04:16', NULL);
INSERT INTO `game_user_modules` VALUES (29, 88, 1, 4, 1, 0, NULL, NULL, '2023-04-09 11:00:47', '2023-07-18 21:12:37', NULL);
INSERT INTO `game_user_modules` VALUES (30, 88, 3, 1, 0, 0, NULL, NULL, '2023-04-10 13:48:45', '2023-05-24 09:00:09', NULL);
INSERT INTO `game_user_modules` VALUES (31, 88, 5, 1, 0, 0, NULL, NULL, '2023-04-13 14:59:22', '2023-05-24 09:00:16', NULL);
INSERT INTO `game_user_modules` VALUES (32, 88, 1, 2, 0, 0, NULL, NULL, '2023-04-20 15:57:54', '2023-07-17 23:25:10', NULL);
INSERT INTO `game_user_modules` VALUES (33, 88, 1, 3, 0, 0, NULL, NULL, '2023-04-21 15:36:38', '2023-07-17 23:25:16', NULL);
INSERT INTO `game_user_modules` VALUES (34, 86, 1, 1, 1, 0, NULL, NULL, '2023-04-25 14:57:36', '2023-05-09 07:57:52', NULL);
INSERT INTO `game_user_modules` VALUES (35, 115, 1, 1, 1, 0, NULL, NULL, '2023-05-06 19:21:55', '2023-05-06 19:21:55', NULL);
INSERT INTO `game_user_modules` VALUES (36, 86, 3, 1, 0, 0, NULL, NULL, '2023-05-09 07:57:32', '2023-05-09 07:57:38', NULL);
INSERT INTO `game_user_modules` VALUES (37, 88, 4, 3, 0, 0, NULL, NULL, '2023-05-24 08:57:39', '2023-07-18 17:09:13', NULL);
INSERT INTO `game_user_modules` VALUES (38, 88, 6, 2, 0, 0, NULL, NULL, '2023-05-24 08:57:45', '2023-07-18 17:09:07', NULL);
INSERT INTO `game_user_modules` VALUES (39, 88, 3, 3, 2, 0, NULL, NULL, '2023-05-24 08:58:50', '2023-07-18 21:04:56', NULL);
INSERT INTO `game_user_modules` VALUES (40, 88, 2, 3, 0, 0, NULL, NULL, '2023-05-24 08:59:12', '2023-07-18 17:08:59', NULL);
INSERT INTO `game_user_modules` VALUES (41, 88, 5, 4, 0, 0, NULL, NULL, '2023-07-17 23:25:33', '2023-07-18 17:09:04', NULL);
INSERT INTO `game_user_modules` VALUES (42, 124, 1, 1, 1, 0, NULL, NULL, '2023-08-02 13:58:54', '2023-08-02 13:58:54', NULL);
INSERT INTO `game_user_modules` VALUES (43, 124, 2, 1, 1, 0, NULL, NULL, '2023-08-02 13:59:00', '2023-08-02 13:59:00', NULL);
COMMIT;

-- ----------------------------
-- Table structure for level
-- ----------------------------
DROP TABLE IF EXISTS `level`;
CREATE TABLE `level` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '等级名称',
  `numbmin` int DEFAULT '0' COMMENT '最小满足分数',
  `numbmax` int DEFAULT '0' COMMENT '最高满足分数',
  `policy` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '等级策略配置',
  `icon` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '等级图标',
  `status` tinyint DEFAULT '0' COMMENT '状态',
  `adduid` int DEFAULT NULL COMMENT '添加者ID',
  `edituid` int DEFAULT NULL COMMENT '最后编辑者ID',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='等级信息表';

-- ----------------------------
-- Records of level
-- ----------------------------
BEGIN;
INSERT INTO `level` VALUES (1, '1级', 0, 99, '', NULL, 1, 1, 13, '2022-11-04 14:55:36', '2022-11-05 10:31:16', NULL);
INSERT INTO `level` VALUES (2, '资深', 100, 999, '99*level', NULL, 1, 1, 1, '2022-11-04 14:56:56', '2022-11-08 09:17:53', NULL);
INSERT INTO `level` VALUES (3, '3级', 1000, 9999, NULL, NULL, 1, NULL, NULL, '2022-11-16 08:42:52', NULL, NULL);
INSERT INTO `level` VALUES (4, '4级杀手', 10000, 99999, NULL, NULL, 0, NULL, NULL, '2022-11-21 13:40:33', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for member
-- ----------------------------
DROP TABLE IF EXISTS `member`;
CREATE TABLE `member` (
  `uid` int NOT NULL AUTO_INCREMENT,
  `username` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '登录帐号',
  `passwd` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '登录密码',
  `phone` varchar(11) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '手机号',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '姓名',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '头像',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `lvl` tinyint DEFAULT NULL COMMENT '等级',
  `invitcode` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '邀请码',
  `sign` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '个人签名',
  `status` tinyint DEFAULT '0' COMMENT '帐号状态',
  `adduid` int DEFAULT NULL COMMENT '添加者ID',
  `edituid` int DEFAULT NULL COMMENT '最后编辑者ID',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`uid`) USING BTREE,
  UNIQUE KEY `username` (`username`) USING BTREE,
  KEY `phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=127 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='会员帐号信息表';

-- ----------------------------
-- Records of member
-- ----------------------------
BEGIN;
INSERT INTO `member` VALUES (86, '111111', '$2y$10$6mTcFVq8cXKoALbF2fbuseXHQ6YO2XU76ptEoUl1l.45I4BZgbYZS', '15057489802', '世界第一等', '/images/12.png', NULL, 1, '123123', '我有好东西，有需要的关注我', 1, NULL, 1, '2022-11-28 07:55:30', NULL);
INSERT INTO `member` VALUES (88, '53260884', '$2y$10$aSlMPiuL5c7emTvyIAbpuOwaSQn4HHI71YWJQdknWP4HCOa2LINw6', '13958345202', '小船儿', 'attach/thumb/1669724950_00c5b68364d0ab2206fd.jpg', NULL, 8, '53260884', '有事请联系，电话号码13958345202', 1, NULL, NULL, '2022-11-29 20:00:31', NULL);
INSERT INTO `member` VALUES (101, '69079282', '$2y$10$VgzMCLhsRQuSo1VP7v5n1.yPe9f0efstQGo10MdIJAYIro1kPCaDG', '13905840455', '会员69079282', '/images/default.png', NULL, 1, '', NULL, 1, NULL, NULL, '2022-12-10 09:54:46', NULL);
INSERT INTO `member` VALUES (107, '78116498', '$2y$10$3fzMDOTy/hAOWP8zwTpMfeIapsynwI8oxrZbCZCPgqFN.ZmGCswdm', '15913284755', '冯立唯', '/images/default.png', NULL, 1, '', '', 1, NULL, NULL, '2023-01-16 14:12:53', NULL);
INSERT INTO `member` VALUES (112, '82031968', '$2y$10$URz.kT2/hIpoY.fkM2hhjOFiu9okuv1tl48St97SD81IhrtTnUWHK', '18180681248', '会员82031968', '/images/default.png', NULL, 1, '', NULL, 1, NULL, NULL, '2023-04-20 21:11:15', NULL);
INSERT INTO `member` VALUES (113, '16028687', '$2y$10$Afz8k6OtSAMow9dXqty9TurGjV9890/FeAZYchwrrh4KDSUgbRjha', '13682620454', '会员16028687', '/images/default.png', NULL, 1, '', NULL, 1, NULL, NULL, '2023-04-20 23:22:22', NULL);
INSERT INTO `member` VALUES (114, '61901648', '$2y$10$Hv2TIClPGfmnkxIaEGG0MOrw2mzjiLzkuioGdTkGAh897riZv3/Sa', '13997592141', '会员61901648', '/images/default.png', NULL, 1, '', NULL, 1, NULL, NULL, '2023-04-21 11:03:25', NULL);
INSERT INTO `member` VALUES (115, '23901931', '$2y$10$ua9wolM2T6Ngp2VDqFrth.hASNJB2TWZCnu7DsEo791K8a4Rsy0sO', '15600693610', '会员23901931', '/images/default.png', NULL, 1, '', NULL, 1, NULL, NULL, '2023-04-22 17:48:38', NULL);
INSERT INTO `member` VALUES (116, '25491452', '$2y$10$H8Y3ggKLuk4eLuovxKAcleeCWIUx2x1tXWXTG5xdL9KzzFnNbOAgu', '13544204005', '会员25491452', '/images/default.png', NULL, 1, '', NULL, 1, NULL, NULL, '2023-04-26 21:17:17', NULL);
INSERT INTO `member` VALUES (117, '19439580', '$2y$10$cWJe2uhfrBiGezh8of.tXu9ONX4NpY/522PhkiJM5U/SuHTgGNiMm', '13819439580', '会员19439580', '/images/default.png', NULL, 1, '53260884', NULL, 1, NULL, NULL, '2023-04-26 23:51:41', NULL);
INSERT INTO `member` VALUES (118, '31982413', '$2y$10$LdFqi0OIeMRuEMzzEsxWM.U0QV/oFGfvMwv9N5Q/PrGT.sOz8yM.S', '13836801365', '会员31982413', '/images/default.png', NULL, 1, '53260884', NULL, 1, NULL, NULL, '2023-04-27 09:47:54', NULL);
INSERT INTO `member` VALUES (119, '26993425', '$2y$10$a84vK4irqAZ8Pn6m5qbBaek35hlcfV5.akF4Wc.xSIE82QNzzz1g2', '15510510649', '会员26993425', '/images/default.png', NULL, 1, '', NULL, 1, NULL, NULL, '2023-05-06 19:41:59', NULL);
INSERT INTO `member` VALUES (120, '11111111111', '$2y$10$YyKYlt2soKsQbBihvLPLIO1AQYNmWrMxjrsQ9mNsb6nuefWxsTREG', '11111111111', '会员883639', '/images/default.png', NULL, 1, '', NULL, 1, NULL, NULL, '2023-05-18 10:41:27', NULL);
INSERT INTO `member` VALUES (121, '12222222222', '$2y$10$V.SEu4CYQohxodbkSW5tG.T5Db3FF0oQ/u8jPUm3L7ezlhz4HvZwW', '12222222222', '会员619658', '/images/default.png', NULL, 1, '11111111111', NULL, 1, NULL, NULL, '2023-05-22 14:28:33', NULL);
INSERT INTO `member` VALUES (122, '15618257066', '$2y$10$x/XX8fJ/MvCJSiyWGTku7eoOgTOzXJZfp9PFQs6MG/W1Tabc3SIzW', '15618257066', '会员364434', '/images/default.png', NULL, 1, '', NULL, 1, NULL, NULL, '2023-05-30 08:27:32', NULL);
INSERT INTO `member` VALUES (123, '18866666666', '$2y$10$Kecp27I5cEAMArHiTlblgu7XMx7rlIXEEyq5SOyiSf5QCLMJy0B0q', '18866666666', '会员730595', '/images/default.png', NULL, 1, '', NULL, 1, NULL, NULL, '2023-05-30 13:50:08', NULL);
INSERT INTO `member` VALUES (124, '18996311935', '$2y$10$hzd8VwKpkEEu4h7/n8SM3.chR1A6LgxWt7D.A1nHWi49I34BIIA7O', '18996311935', '会员608200', '/images/default.png', NULL, 1, '', NULL, 1, NULL, NULL, '2023-08-02 12:45:14', NULL);
INSERT INTO `member` VALUES (125, '18500742517', '$2y$10$q9A4egJOv1jyqJYiaWd3Me4JFxiyCTIINxggzMWr7IPpiORjDPNdu', '18500742517', '会员502807', '/images/default.png', NULL, 1, '', NULL, 1, NULL, NULL, '2023-08-08 16:28:44', NULL);
INSERT INTO `member` VALUES (126, '13659597159', '$2y$10$/BZE6KTGbimEEIAaBdC7HerHY/XVlWTWVFmFaSVoRtHNs/zL85fDC', '13659597159', '会员628123', '/images/default.png', NULL, 1, '', NULL, 1, NULL, NULL, '2023-08-09 21:03:15', NULL);
COMMIT;

-- ----------------------------
-- Table structure for member_ext
-- ----------------------------
DROP TABLE IF EXISTS `member_ext`;
CREATE TABLE `member_ext` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fid` int DEFAULT NULL COMMENT '所属扩展ID',
  `relid` int DEFAULT NULL COMMENT '所属相关ID',
  `val` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '字段值',
  `adduid` int DEFAULT NULL,
  `edituid` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fid` (`fid`) USING BTREE,
  KEY `relid` (`relid`) USING BTREE,
  KEY `adduid` (`adduid`) USING BTREE,
  KEY `val` (`val`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='扩展字段值存储表';

-- ----------------------------
-- Records of member_ext
-- ----------------------------
BEGIN;
INSERT INTO `member_ext` VALUES (1, 5, 52, 'FFF', 1, NULL, '2022-11-05 12:11:26', '2022-11-05 12:11:26', NULL);
INSERT INTO `member_ext` VALUES (2, 5, 55, '', 1, NULL, '2022-11-05 12:23:23', '2022-11-05 12:23:23', NULL);
INSERT INTO `member_ext` VALUES (3, 12, 55, '意向客户', 1, NULL, '2022-11-05 12:23:23', '2022-11-05 12:23:23', NULL);
INSERT INTO `member_ext` VALUES (4, 5, 48, '', 1, 1, '2022-11-05 19:54:06', '2022-11-05 19:57:06', NULL);
INSERT INTO `member_ext` VALUES (5, 12, 48, '一般客户', 1, 1, '2022-11-05 19:54:06', '2022-11-05 19:57:06', NULL);
INSERT INTO `member_ext` VALUES (6, 24, 55, '', 1, 1, '2022-11-06 20:23:05', '2022-11-11 13:38:17', NULL);
INSERT INTO `member_ext` VALUES (7, 25, 55, '13588743891', 1, 1, '2022-11-06 20:23:05', '2022-11-11 13:38:17', NULL);
INSERT INTO `member_ext` VALUES (8, 24, 48, '大柳塔', 1, 1, '2022-11-07 15:22:20', '2022-11-07 15:22:25', NULL);
INSERT INTO `member_ext` VALUES (9, 24, 56, '', 1, 1, '2022-11-07 15:24:52', '2022-11-11 13:27:56', NULL);
INSERT INTO `member_ext` VALUES (10, 26, 56, 'b', 1, 1, '2022-11-07 15:29:26', '2022-11-11 13:27:56', NULL);
INSERT INTO `member_ext` VALUES (11, 26, 55, 's', 1, 1, '2022-11-07 16:02:18', '2022-11-11 13:38:17', NULL);
INSERT INTO `member_ext` VALUES (12, 24, 53, 'tes', 1, 1, '2022-11-07 20:19:59', '2022-11-07 20:22:55', NULL);
INSERT INTO `member_ext` VALUES (13, 25, 53, '11', 1, 1, '2022-11-07 20:19:59', '2022-11-07 20:22:55', NULL);
INSERT INTO `member_ext` VALUES (14, 25, 56, '134887387767', 1, 1, '2022-11-07 20:42:58', '2022-11-11 13:27:56', NULL);
INSERT INTO `member_ext` VALUES (20, 31, 61, 'aaa', 1, NULL, '2022-11-13 09:50:46', '2022-11-13 09:50:46', NULL);
INSERT INTO `member_ext` VALUES (21, 31, 59, 'bbb', 1, NULL, '2022-11-13 09:50:52', '2022-11-13 09:50:52', NULL);
INSERT INTO `member_ext` VALUES (31, 29, 86, 'oJXGJwEVaad2NhHUu1tDz_fEPEyI', 86, 86, '2022-11-28 08:00:33', '2023-05-11 10:18:45', NULL);
INSERT INTO `member_ext` VALUES (34, 29, 88, 'oJXGJwM_quWcWXCvSLUlJa9hoA48', 88, 88, '2022-11-29 20:01:49', '2023-05-11 19:15:52', NULL);
INSERT INTO `member_ext` VALUES (42, 29, 107, '', 107, NULL, '2023-04-19 17:03:04', '2023-04-19 17:03:04', NULL);
INSERT INTO `member_ext` VALUES (43, 29, 60, 'oJXGJwEVaad2NhHUu1tDz_fEPEyI', NULL, NULL, '2023-05-11 10:16:04', '2023-05-11 10:16:04', NULL);
COMMIT;

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tag` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '业务标识',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '消息提示内容',
  `link` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '访问链接如果存在的话',
  `fromuid` int DEFAULT '0' COMMENT '触发者ID',
  `touid` int DEFAULT NULL COMMENT '接收者ID',
  `status` tinyint DEFAULT '1' COMMENT '消息状态',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `touid` (`touid`) USING BTREE,
  KEY `tag` (`tag`) USING BTREE,
  KEY `tag_2` (`tag`,`touid`) USING BTREE,
  KEY `tag_3` (`tag`,`fromuid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=234 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='消息记录表';

-- ----------------------------
-- Records of message
-- ----------------------------
BEGIN;
INSERT INTO `message` VALUES (117, 'cashjoin', '恭喜！您在竞拍【1级】中胜出。获得【振动真】', NULL, 0, 73, 1, '2022-11-24 16:58:04');
INSERT INTO `message` VALUES (120, 'cashjoin', '很遗憾，您在竞拍【资深】中被淘汰，相关金币已解冻并退还至钱包。', NULL, 0, 74, 1, '2022-11-24 16:58:04');
INSERT INTO `message` VALUES (122, 'cashjoin', '很遗憾，您在竞拍【出售100元】中被淘汰，相关金币已解冻并退还至钱包。', NULL, 0, 78, 1, '2022-11-24 16:58:04');
INSERT INTO `message` VALUES (124, 'cashjoin', '很遗憾，您在竞拍【出售100元】中被淘汰，相关金币已解冻并退还至钱包。', NULL, 0, 77, 1, '2022-11-24 16:58:04');
INSERT INTO `message` VALUES (125, 'cashjoin', '很遗憾，您在竞拍【出售100元】中被淘汰，相关金币已解冻并退还至钱包。', NULL, 0, 72, 1, '2022-11-24 16:58:04');
INSERT INTO `message` VALUES (126, 'cashjoin', '很遗憾，您在竞拍【出售100元】中被淘汰，相关金币已解冻并退还至钱包。', NULL, 0, 74, 1, '2022-11-24 16:58:04');
INSERT INTO `message` VALUES (127, 'cashjoin', '很遗憾，您在竞拍【出售100元】中被淘汰，相关金币已解冻并退还至钱包。', NULL, 0, 71, 1, '2022-11-24 16:58:04');
INSERT INTO `message` VALUES (128, 'cashjoin', '恭喜！您在竞拍【4级杀手】中胜出。获得【沣东镇】', NULL, 0, 71, 1, '2022-11-24 16:58:04');
INSERT INTO `message` VALUES (130, 'cashjoin', '很遗憾，您在竞拍【4级杀手】中被淘汰，相关金币已解冻并退还至钱包。', NULL, 0, 73, 1, '2022-11-24 16:58:04');
INSERT INTO `message` VALUES (135, 'cashjoin', '恭喜！您在竞拍【出售现金300元人民币】中胜出。获得【卡号：333334；\n卡密：XXXXXXX】', NULL, 0, 79, 1, '2022-11-24 16:58:04');
INSERT INTO `message` VALUES (137, 'cashjoin', '恭喜！您在竞拍【现金250先到先得】中胜出。获得【房东招揽\n房东振动真fwe\nfewff】', NULL, 0, 81, 1, '2022-11-24 16:58:04');
INSERT INTO `message` VALUES (138, 'cashjoin', '很遗憾，您在竞拍【现金250先到先得】中被淘汰，相关金币已解冻并退还至钱包。', NULL, 0, 60, 0, '2022-11-24 16:58:04');
INSERT INTO `message` VALUES (140, 'cashjoin', '很遗憾，您在竞拍【出888】中被淘汰，相关金币已解冻并退还至钱包。', NULL, 0, 80, 1, '2022-11-24 16:58:04');
INSERT INTO `message` VALUES (141, 'cashjoin', '恭喜！您在竞拍【测试是否过期】中胜出。获得【沣东镇】', NULL, 0, 82, 1, '2022-11-24 16:58:04');
INSERT INTO `message` VALUES (142, 'cashjoin', '恭喜！您在竞拍【1级】中胜出。获得【振动真】', NULL, 0, 73, 1, '2022-11-24 17:06:57');
INSERT INTO `message` VALUES (145, 'cashjoin', '很遗憾，您在竞拍【资深】中被淘汰，相关金币已解冻并退还至钱包。', NULL, 0, 74, 1, '2022-11-24 17:06:57');
INSERT INTO `message` VALUES (147, 'cashjoin', '很遗憾，您在竞拍【出售100元】中被淘汰，相关金币已解冻并退还至钱包。', NULL, 0, 78, 1, '2022-11-24 17:06:57');
INSERT INTO `message` VALUES (149, 'cashjoin', '很遗憾，您在竞拍【出售100元】中被淘汰，相关金币已解冻并退还至钱包。', NULL, 0, 77, 1, '2022-11-24 17:06:57');
INSERT INTO `message` VALUES (150, 'cashjoin', '很遗憾，您在竞拍【出售100元】中被淘汰，相关金币已解冻并退还至钱包。', NULL, 0, 72, 1, '2022-11-24 17:06:57');
INSERT INTO `message` VALUES (151, 'cashjoin', '很遗憾，您在竞拍【出售100元】中被淘汰，相关金币已解冻并退还至钱包。', NULL, 0, 74, 1, '2022-11-24 17:06:57');
INSERT INTO `message` VALUES (152, 'cashjoin', '很遗憾，您在竞拍【出售100元】中被淘汰，相关金币已解冻并退还至钱包。', NULL, 0, 71, 1, '2022-11-24 17:06:57');
INSERT INTO `message` VALUES (153, 'cashjoin', '恭喜！您在竞拍【4级杀手】中胜出。获得【沣东镇】', NULL, 0, 71, 1, '2022-11-24 17:06:57');
INSERT INTO `message` VALUES (155, 'cashjoin', '很遗憾，您在竞拍【4级杀手】中被淘汰，相关金币已解冻并退还至钱包。', NULL, 0, 73, 1, '2022-11-24 17:06:57');
INSERT INTO `message` VALUES (160, 'cashjoin', '恭喜！您在竞拍【出售现金300元人民币】中胜出。获得【卡号：333334；\n卡密：XXXXXXX】', NULL, 0, 79, 1, '2022-11-24 17:06:57');
INSERT INTO `message` VALUES (162, 'cashjoin', '恭喜！您在竞拍【现金250先到先得】中胜出。获得【房东招揽\n房东振动真fwe\nfewff】', NULL, 0, 81, 1, '2022-11-24 17:06:57');
INSERT INTO `message` VALUES (165, 'cashjoin', '很遗憾，您在竞拍【出888】中被淘汰，相关金币已解冻并退还至钱包。', NULL, 0, 80, 1, '2022-11-24 17:06:57');
INSERT INTO `message` VALUES (166, 'cashjoin', '恭喜！您在竞拍【测试是否过期】中胜出。获得【沣东镇】', NULL, 0, 82, 1, '2022-11-24 17:06:57');
INSERT INTO `message` VALUES (172, 'cashjoin', '恭喜！您在竞拍【出售50】中胜出。获得【魂牵梦萦】', NULL, 0, 78, 1, '2022-11-25 10:27:14');
INSERT INTO `message` VALUES (174, 'uninvit', '会员[29775664]向您发起了请求对TA的绑定解除。', NULL, 87, 60, 0, '2022-11-29 19:29:56');
INSERT INTO `message` VALUES (176, 'cashjoin', '恭喜！您在竞拍【1级】中胜出。获得【振动真】', NULL, 0, 73, 1, '2022-11-30 11:29:01');
INSERT INTO `message` VALUES (179, 'cashjoin', '很遗憾，您在竞拍【资深】中被淘汰，相关金币已解冻并退还至钱包。', NULL, 0, 74, 1, '2022-11-30 11:29:01');
INSERT INTO `message` VALUES (181, 'cashjoin', '很遗憾，您在竞拍【出售100元】中被淘汰，相关金币已解冻并退还至钱包。', NULL, 0, 78, 1, '2022-11-30 11:29:01');
INSERT INTO `message` VALUES (183, 'cashjoin', '很遗憾，您在竞拍【出售100元】中被淘汰，相关金币已解冻并退还至钱包。', NULL, 0, 77, 1, '2022-11-30 11:29:01');
INSERT INTO `message` VALUES (184, 'cashjoin', '很遗憾，您在竞拍【出售100元】中被淘汰，相关金币已解冻并退还至钱包。', NULL, 0, 72, 1, '2022-11-30 11:29:01');
INSERT INTO `message` VALUES (185, 'cashjoin', '很遗憾，您在竞拍【出售100元】中被淘汰，相关金币已解冻并退还至钱包。', NULL, 0, 74, 1, '2022-11-30 11:29:01');
INSERT INTO `message` VALUES (186, 'cashjoin', '很遗憾，您在竞拍【出售100元】中被淘汰，相关金币已解冻并退还至钱包。', NULL, 0, 71, 1, '2022-11-30 11:29:01');
INSERT INTO `message` VALUES (192, 'cashjoin', '很遗憾，您在竞拍【现金十元】中被淘汰，相关金币已解冻并退还至钱包。', NULL, 0, 94, 1, '2022-12-06 14:52:18');
INSERT INTO `message` VALUES (195, 'cashjoin', '恭喜！您在竞拍【现金十元】中胜出。获得【添加微信号cncn,卡密20221206105588】', NULL, 0, 86, 0, '2022-12-07 09:39:13');
INSERT INTO `message` VALUES (197, 'cashjoin', '很遗憾，您在竞拍【现金十元】中被淘汰，相关金币已解冻并退还至钱包。', NULL, 0, 94, 1, '2022-12-07 09:39:13');
INSERT INTO `message` VALUES (201, 'uninvit', '会员[79164123]向您发起了请求对TA的绑定解除。', NULL, 105, 88, 0, '2022-12-11 14:09:18');
INSERT INTO `message` VALUES (202, 'levelup', '恭喜！您的等级已提升，重新登录后生效。', NULL, 0, 88, 0, '2022-12-30 08:57:10');
INSERT INTO `message` VALUES (203, 'friendadd', '用户[复仇者联盟]向您发起好友申请', NULL, 0, 86, 0, '2023-01-13 18:20:42');
INSERT INTO `message` VALUES (204, 'friendadd', '用户[复仇者联盟]向您发起好友申请', NULL, 0, 106, 1, '2023-01-13 18:36:38');
INSERT INTO `message` VALUES (205, 'friendadd', '用户[复仇者联盟]向您发起好友申请', NULL, 0, 88, 0, '2023-01-13 18:36:46');
INSERT INTO `message` VALUES (206, 'friendadd', '用户[复仇者联盟]向您发起好友申请', NULL, 0, 89, 1, '2023-01-13 18:37:17');
INSERT INTO `message` VALUES (209, 'friendadd', '用户[复仇者联盟]向您发起好友申请', NULL, 0, 80, 1, '2023-01-16 20:29:24');
INSERT INTO `message` VALUES (210, 'friendadd', '用户[小船儿]向您发起好友申请', NULL, 0, 107, 0, '2023-02-21 23:38:17');
INSERT INTO `message` VALUES (211, 'levelup', '恭喜！您的等级已提升，重新登录后生效。', NULL, 0, 88, 0, '2023-03-29 23:51:53');
INSERT INTO `message` VALUES (212, 'levelup', '恭喜！您的等级已提升，重新登录后生效。', NULL, 0, 60, 0, '2023-04-07 14:26:07');
INSERT INTO `message` VALUES (213, 'friendadd', '用户[会员23901931]向您发起好友申请', NULL, 0, 88, 0, '2023-04-22 17:52:15');
INSERT INTO `message` VALUES (214, 'cashjoin', '很遗憾，您在竞拍【现金20元】中被淘汰，相关金币已解冻并退还至钱包。', NULL, 0, 88, 0, '2023-04-23 10:12:05');
INSERT INTO `message` VALUES (215, 'cashjoin', '很遗憾，您在竞拍【现金10元】中被淘汰，相关金币已解冻并退还至钱包。', NULL, 0, 60, 0, '2023-04-23 10:37:40');
INSERT INTO `message` VALUES (216, 'cashjoin', '很遗憾，您在竞拍【现金10元】中被淘汰，相关金币已解冻并退还至钱包。', NULL, 0, 88, 0, '2023-04-24 08:23:32');
INSERT INTO `message` VALUES (218, 'friendadd', '用户[会员61901648]向您发起好友申请', NULL, 0, 88, 0, '2023-04-24 12:48:55');
INSERT INTO `message` VALUES (219, 'cashjoin', '很遗憾，您在竞拍【现金10元】中被淘汰，相关金币已解冻并退还至钱包。', NULL, 0, 60, 1, '2023-04-25 14:25:09');
INSERT INTO `message` VALUES (221, 'cashjoin', '很遗憾，您在竞拍【现金10元】中被淘汰，相关金币已解冻并退还至钱包。', NULL, 0, 60, 1, '2023-04-25 14:25:09');
INSERT INTO `message` VALUES (222, 'cashjoin', '恭喜！您在竞拍【现金10元】中胜出。获得【卡密：123456789】', NULL, 0, 88, 0, '2023-04-25 14:48:17');
INSERT INTO `message` VALUES (223, 'cashjoin', '很遗憾，您在竞拍【现金10元】中被淘汰，相关金币已解冻并退还至钱包。', NULL, 0, 60, 1, '2023-04-25 14:48:17');
INSERT INTO `message` VALUES (225, 'cashjoin', '很遗憾，您在竞拍【现金10元】中被淘汰，相关金币已解冻并退还至钱包。', NULL, 0, 60, 1, '2023-04-25 14:48:17');
INSERT INTO `message` VALUES (226, 'cashjoin', '恭喜！您在竞拍【现金20元】中胜出。获得【1234512345】', NULL, 0, 86, 0, '2023-04-25 14:48:17');
INSERT INTO `message` VALUES (228, 'levelup', '恭喜！您的等级已提升，重新登录后生效。', NULL, 0, 88, 0, '2023-05-01 08:50:33');
INSERT INTO `message` VALUES (229, 'cashjoin', '恭喜！您在竞拍【现金99】中胜出。获得【嘿嘿嘿：XXXXXX】', NULL, 0, 86, 0, '2023-05-22 21:59:01');
INSERT INTO `message` VALUES (230, 'cashjoin', '恭喜！您在竞拍【88】中胜出。获得【XXXXX】', NULL, 0, 88, 0, '2023-05-22 21:59:01');
INSERT INTO `message` VALUES (231, 'cashjoin', '恭喜！您在竞拍【现金10元】中胜出。获得【123456789】', NULL, 0, 88, 0, '2023-05-22 21:59:01');
INSERT INTO `message` VALUES (232, 'levelup', '恭喜！您的等级已提升，重新登录后生效。', NULL, 0, 88, 0, '2023-06-10 00:48:16');
INSERT INTO `message` VALUES (233, 'levelup', '恭喜！您的等级已提升，重新登录后生效。', NULL, 0, 88, 0, '2023-08-19 10:44:58');
COMMIT;

-- ----------------------------
-- Table structure for pocket
-- ----------------------------
DROP TABLE IF EXISTS `pocket`;
CREATE TABLE `pocket` (
  `id` int NOT NULL AUTO_INCREMENT,
  `uid` int DEFAULT NULL,
  `cash` decimal(11,2) DEFAULT '0.00' COMMENT '当前现金',
  `cashfix` decimal(11,2) DEFAULT '0.00' COMMENT '冻结现金',
  `coin` int DEFAULT '0' COMMENT '当前金币',
  `coinfix` int DEFAULT '0' COMMENT '冻结金币',
  `point` int DEFAULT '0' COMMENT '积分',
  `res` int DEFAULT '0',
  `memo` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注说明',
  `status` tinyint DEFAULT '0' COMMENT '状态',
  `adduid` int DEFAULT NULL COMMENT '添加者ID',
  `edituid` int DEFAULT NULL COMMENT '最后编辑者ID',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `memid` (`uid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='会员钱包信息表';

-- ----------------------------
-- Records of pocket
-- ----------------------------
BEGIN;
INSERT INTO `pocket` VALUES (22, 60, 2.00, 0.00, 56469, -1056729, 20, 188142306, NULL, 1, NULL, NULL, '2022-11-24 15:43:33', NULL, NULL);
INSERT INTO `pocket` VALUES (23, 74, 0.00, 0.00, 10265, -265, 0, 0, NULL, 1, NULL, NULL, '2022-11-24 15:43:33', NULL, NULL);
INSERT INTO `pocket` VALUES (24, 78, 0.00, 0.00, 987788, 0, 0, 0, NULL, 1, NULL, NULL, '2022-11-24 15:43:33', NULL, NULL);
INSERT INTO `pocket` VALUES (25, 77, 0.00, 0.00, 18888, -8888, 0, 0, NULL, 1, NULL, NULL, '2022-11-24 15:43:33', NULL, NULL);
INSERT INTO `pocket` VALUES (26, 72, 0.00, 0.00, 5999, -999, 0, 0, NULL, 1, NULL, NULL, '2022-11-24 15:43:33', NULL, NULL);
INSERT INTO `pocket` VALUES (27, 71, 0.00, 0.00, 3099, -99, 0, 0, NULL, 1, NULL, NULL, '2022-11-24 15:43:33', NULL, NULL);
INSERT INTO `pocket` VALUES (28, 79, 0.00, 0.00, 1000, 0, 0, 0, NULL, 1, NULL, NULL, '2022-11-24 15:43:33', NULL, NULL);
INSERT INTO `pocket` VALUES (29, 81, 0.00, 0.00, 2000, 0, 0, 0, NULL, 1, NULL, NULL, '2022-11-24 15:43:33', NULL, NULL);
INSERT INTO `pocket` VALUES (30, 80, 0.00, 0.00, 4000, 0, 0, 0, NULL, 1, NULL, NULL, '2022-11-24 15:43:33', NULL, NULL);
INSERT INTO `pocket` VALUES (31, 82, 0.00, 0.00, 1100, 0, 0, 0, NULL, 1, NULL, NULL, '2022-11-24 15:43:33', NULL, NULL);
INSERT INTO `pocket` VALUES (32, 86, 0.00, 0.00, 99617, 0, 700, 55000, NULL, 1, NULL, NULL, '2022-11-28 07:55:38', NULL, NULL);
INSERT INTO `pocket` VALUES (33, 87, 0.00, 0.00, 60, 0, 0, 0, NULL, 1, NULL, NULL, '2022-11-29 19:24:59', NULL, NULL);
INSERT INTO `pocket` VALUES (34, 88, 2.00, 0.00, 1086, 0, 20, 1189500, NULL, 1, NULL, NULL, '2022-11-29 20:01:54', NULL, NULL);
INSERT INTO `pocket` VALUES (35, 89, 0.00, 0.00, 20, 0, 0, 0, NULL, 1, NULL, NULL, '2022-11-29 20:05:17', NULL, NULL);
INSERT INTO `pocket` VALUES (36, 73, 0.00, 0.00, 0, -8888, 0, 0, NULL, 1, NULL, NULL, '2022-11-30 11:29:01', NULL, NULL);
INSERT INTO `pocket` VALUES (37, 95, 0.00, 0.00, 20, 0, 0, 0, NULL, 1, NULL, NULL, '2022-12-06 12:37:17', NULL, NULL);
INSERT INTO `pocket` VALUES (38, 94, 0.00, 0.00, 49, -21, 0, 0, NULL, 1, NULL, NULL, '2022-12-06 12:37:58', NULL, NULL);
INSERT INTO `pocket` VALUES (39, 96, 0.00, 0.00, 20, 0, 0, 0, NULL, 1, NULL, NULL, '2022-12-06 12:41:57', NULL, NULL);
INSERT INTO `pocket` VALUES (40, 98, 0.00, 0.00, 20, 0, 0, 0, NULL, 1, NULL, NULL, '2022-12-08 08:38:56', NULL, NULL);
INSERT INTO `pocket` VALUES (41, 99, 0.00, 0.00, 20, 0, 0, 0, NULL, 1, NULL, NULL, '2022-12-08 14:55:23', NULL, NULL);
INSERT INTO `pocket` VALUES (42, 101, 0.00, 0.00, 20, 0, 0, 0, NULL, 1, NULL, NULL, '2022-12-10 09:55:09', NULL, NULL);
INSERT INTO `pocket` VALUES (43, 102, 0.00, 0.00, 420, 0, 0, 0, NULL, 1, NULL, NULL, '2022-12-10 12:33:04', NULL, NULL);
INSERT INTO `pocket` VALUES (44, 105, 0.00, 0.00, 20, 0, 0, 0, NULL, 1, NULL, NULL, '2022-12-11 13:46:35', NULL, NULL);
INSERT INTO `pocket` VALUES (45, 106, 0.00, 0.00, 20, 0, 0, 0, NULL, 1, NULL, NULL, '2023-01-09 19:07:41', NULL, NULL);
INSERT INTO `pocket` VALUES (46, 107, 0.00, 0.00, 60, 0, 0, 20000, NULL, 1, NULL, NULL, '2023-01-16 14:13:08', NULL, NULL);
INSERT INTO `pocket` VALUES (47, 108, 0.00, 0.00, 20, 0, 0, 0, NULL, 1, NULL, NULL, '2023-01-16 17:34:34', NULL, NULL);
INSERT INTO `pocket` VALUES (48, 114, 0.00, 0.00, 460, 0, 0, 230000, NULL, 1, NULL, NULL, '2023-04-21 11:03:48', NULL, NULL);
INSERT INTO `pocket` VALUES (49, 115, 0.00, 0.00, 20, 0, 0, 8000, NULL, 1, NULL, NULL, '2023-04-22 17:49:07', NULL, NULL);
INSERT INTO `pocket` VALUES (50, 116, 0.00, 0.00, 20, 0, 0, 10000, NULL, 1, NULL, NULL, '2023-04-26 21:18:51', NULL, NULL);
INSERT INTO `pocket` VALUES (51, 118, 0.00, 0.00, 20, 0, 0, 10000, NULL, 1, NULL, NULL, '2023-04-27 09:49:56', NULL, NULL);
INSERT INTO `pocket` VALUES (52, 0, 0.00, 0.00, 0, 0, 0, 0, NULL, 1, NULL, NULL, '2023-05-11 10:20:22', NULL, NULL);
INSERT INTO `pocket` VALUES (53, 122, 0.00, 0.00, 20, 0, 0, 10000, NULL, 1, NULL, NULL, '2023-05-30 08:32:20', NULL, NULL);
INSERT INTO `pocket` VALUES (54, 121, 0.00, 0.00, 20, 0, 0, 10000, NULL, 1, NULL, NULL, '2023-07-07 18:12:31', NULL, NULL);
INSERT INTO `pocket` VALUES (55, 124, 0.00, 0.00, 80, 0, 0, 30000, NULL, 1, NULL, NULL, '2023-08-02 12:45:28', NULL, NULL);
INSERT INTO `pocket` VALUES (56, 125, 0.00, 0.00, 20, 0, 0, 10000, NULL, 1, NULL, NULL, '2023-08-08 16:30:13', NULL, NULL);
INSERT INTO `pocket` VALUES (57, 126, 0.00, 0.00, 20, 0, 0, 10000, NULL, 1, NULL, NULL, '2023-08-09 22:07:13', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for pocket_ext
-- ----------------------------
DROP TABLE IF EXISTS `pocket_ext`;
CREATE TABLE `pocket_ext` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fid` int DEFAULT NULL COMMENT '所属扩展ID',
  `relid` int DEFAULT NULL COMMENT '所属相关ID',
  `val` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '字段值',
  `adduid` int DEFAULT NULL,
  `edituid` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fid` (`fid`) USING BTREE,
  KEY `relid` (`relid`) USING BTREE,
  KEY `adduid` (`adduid`) USING BTREE,
  KEY `val` (`val`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='扩展字段值存储表';

-- ----------------------------
-- Table structure for pocket_log_cash
-- ----------------------------
DROP TABLE IF EXISTS `pocket_log_cash`;
CREATE TABLE `pocket_log_cash` (
  `id` int NOT NULL AUTO_INCREMENT,
  `uid` int DEFAULT NULL COMMENT '会员ID',
  `numb` decimal(9,2) DEFAULT NULL COMMENT '金额',
  `tag` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '相关业务标签',
  `relid` int DEFAULT NULL COMMENT '相关ID',
  `tradeno` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '订单号',
  `status` tinyint(1) DEFAULT NULL COMMENT '支付状态',
  `adduid` int DEFAULT NULL COMMENT '操作者ID',
  `memo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注信息',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `uid` (`adduid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='现金日志变更记录表';

-- ----------------------------
-- Records of pocket_log_cash
-- ----------------------------
BEGIN;
INSERT INTO `pocket_log_cash` VALUES (1, 60, 1.00, 'recharge', 60, '1668988814', 1, 0, '4200001621202211216674897892', '2022-11-25 09:33:49');
INSERT INTO `pocket_log_cash` VALUES (2, 60, 1.00, 'recharge', 60, '1668988814', 1, 0, '4200001621202211216674897892', '2022-11-29 19:22:29');
INSERT INTO `pocket_log_cash` VALUES (3, 88, 1.00, 'recharge', 88, '1684388647', 1, 0, '4200001875202305186206479295', '2023-05-18 13:44:14');
INSERT INTO `pocket_log_cash` VALUES (4, 88, 1.00, 'recharge', 88, '1684750637', 1, 0, '4200001883202305228787071932', '2023-05-22 18:17:29');
COMMIT;

-- ----------------------------
-- Table structure for pocket_log_coin
-- ----------------------------
DROP TABLE IF EXISTS `pocket_log_coin`;
CREATE TABLE `pocket_log_coin` (
  `id` int NOT NULL AUTO_INCREMENT,
  `uid` int DEFAULT NULL COMMENT '会员ID',
  `numb` int DEFAULT NULL COMMENT '数量',
  `tag` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '相关业务标签',
  `relid` int DEFAULT NULL COMMENT '相关ID',
  `memo` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `adduid` int DEFAULT NULL COMMENT '操作者ID',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `uid` (`adduid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1106 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='金币日志变更记录表';

-- ----------------------------
-- Records of pocket_log_coin
-- ----------------------------
BEGIN;
INSERT INTO `pocket_log_coin` VALUES (210, 60, 60, 'qiandao', 60, NULL, 60, '2022-11-21 15:02:22');
INSERT INTO `pocket_log_coin` VALUES (211, 60, 20, 'invited', 77, NULL, 60, '2022-11-21 15:02:38');
INSERT INTO `pocket_log_coin` VALUES (212, 60, 20, 'invited', 83, NULL, 60, '2022-11-21 15:02:39');
INSERT INTO `pocket_log_coin` VALUES (213, 60, 60, 'qiandao', 60, NULL, 60, '2022-11-22 12:18:42');
INSERT INTO `pocket_log_coin` VALUES (214, 60, 120, 'invited', 60, NULL, 60, '2022-11-22 13:19:08');
INSERT INTO `pocket_log_coin` VALUES (215, 60, 20, 'invited', 77, NULL, 60, '2022-11-22 13:19:09');
INSERT INTO `pocket_log_coin` VALUES (216, 60, 48, 'invited', 84, NULL, 60, '2022-11-22 13:21:17');
INSERT INTO `pocket_log_coin` VALUES (217, 60, 48, 'invited', 83, NULL, 60, '2022-11-22 13:21:20');
INSERT INTO `pocket_log_coin` VALUES (218, 60, 48, 'invited', 85, NULL, 60, '2022-11-22 13:21:23');
INSERT INTO `pocket_log_coin` VALUES (219, 60, 120, 'qiandao', 60, NULL, 60, '2022-11-23 13:45:35');
INSERT INTO `pocket_log_coin` VALUES (220, 60, 48, 'invited', 84, NULL, 60, '2022-11-23 15:57:46');
INSERT INTO `pocket_log_coin` VALUES (221, 60, 48, 'invited', 77, NULL, 60, '2022-11-23 15:57:48');
INSERT INTO `pocket_log_coin` VALUES (222, 60, 48, 'invited', 60, NULL, 60, '2022-11-23 15:57:53');
INSERT INTO `pocket_log_coin` VALUES (223, 60, 48, 'invited', 83, NULL, 60, '2022-11-23 15:57:57');
INSERT INTO `pocket_log_coin` VALUES (224, 60, 120, 'qiandao', 60, NULL, 60, '2022-11-24 13:25:39');
INSERT INTO `pocket_log_coin` VALUES (225, 60, 56, 'invited', 77, NULL, 60, '2022-11-24 13:26:03');
INSERT INTO `pocket_log_coin` VALUES (226, 60, 56, 'invited', 83, NULL, 60, '2022-11-24 13:26:04');
INSERT INTO `pocket_log_coin` VALUES (227, 73, 8888, 'cashjoin', 73, NULL, 73, '2022-11-24 17:06:57');
INSERT INTO `pocket_log_coin` VALUES (228, 60, 200, 'cashjoin', 60, NULL, 60, '2022-11-24 17:06:57');
INSERT INTO `pocket_log_coin` VALUES (229, 60, 977789, 'cashjoin', 60, NULL, 60, '2022-11-24 17:06:57');
INSERT INTO `pocket_log_coin` VALUES (230, 71, 120000, 'cashjoin', 71, NULL, 71, '2022-11-24 17:06:57');
INSERT INTO `pocket_log_coin` VALUES (231, 60, 3, 'cashjoin', 60, NULL, 60, '2022-11-24 17:06:57');
INSERT INTO `pocket_log_coin` VALUES (232, 79, 2222, 'cashjoin', 79, NULL, 79, '2022-11-24 17:06:57');
INSERT INTO `pocket_log_coin` VALUES (233, 81, 77790, 'cashjoin', 81, NULL, 81, '2022-11-24 17:06:57');
INSERT INTO `pocket_log_coin` VALUES (234, 60, 889, 'cashjoin', 60, NULL, 60, '2022-11-24 17:06:57');
INSERT INTO `pocket_log_coin` VALUES (235, 82, 9999, 'cashjoin', 82, NULL, 82, '2022-11-24 17:06:57');
INSERT INTO `pocket_log_coin` VALUES (236, 60, -8100, 'levelup', 60, NULL, 0, '2022-11-25 09:15:41');
INSERT INTO `pocket_log_coin` VALUES (237, 60, 200, 'qiandao', 60, NULL, 0, '2022-11-25 09:17:08');
INSERT INTO `pocket_log_coin` VALUES (238, 60, -10000, 'levelup', 60, NULL, 0, '2022-11-25 09:17:18');
INSERT INTO `pocket_log_coin` VALUES (239, 60, 10, 'recharge', 60, NULL, 0, '2022-11-25 09:33:49');
INSERT INTO `pocket_log_coin` VALUES (240, 60, 210, 'cashjoin', 60, NULL, 0, '2022-11-25 09:42:45');
INSERT INTO `pocket_log_coin` VALUES (241, 60, 88, 'invited', 60, NULL, 0, '2022-11-25 09:57:42');
INSERT INTO `pocket_log_coin` VALUES (242, 60, 88, 'invited', 77, NULL, 0, '2022-11-25 09:57:43');
INSERT INTO `pocket_log_coin` VALUES (243, 60, 88, 'invited', 83, NULL, 0, '2022-11-25 09:57:45');
INSERT INTO `pocket_log_coin` VALUES (244, 60, 88, 'invited', 85, NULL, 0, '2022-11-25 09:59:17');
INSERT INTO `pocket_log_coin` VALUES (245, 60, 101, 'cashjoin', 60, NULL, 0, '2022-11-25 10:27:14');
INSERT INTO `pocket_log_coin` VALUES (246, 78, 106, 'cashjoin', 78, NULL, 0, '2022-11-25 10:27:14');
INSERT INTO `pocket_log_coin` VALUES (247, 60, 50, 'cashjoin', 60, NULL, 0, '2022-11-25 10:27:14');
INSERT INTO `pocket_log_coin` VALUES (248, 60, 220, 'qiandao', 60, NULL, 0, '2022-11-26 08:49:34');
INSERT INTO `pocket_log_coin` VALUES (249, 60, 88, 'invited', 60, NULL, 0, '2022-11-26 08:49:36');
INSERT INTO `pocket_log_coin` VALUES (250, 60, 88, 'invited', 77, NULL, 0, '2022-11-26 08:49:54');
INSERT INTO `pocket_log_coin` VALUES (251, 60, 56, 'invited', 85, NULL, 0, '2022-11-26 17:19:56');
INSERT INTO `pocket_log_coin` VALUES (252, 60, 220, 'qiandao', 60, NULL, 0, '2022-11-27 09:14:13');
INSERT INTO `pocket_log_coin` VALUES (253, 60, 88, 'invited', 60, NULL, 0, '2022-11-27 09:31:45');
INSERT INTO `pocket_log_coin` VALUES (254, 60, 88, 'invited', 83, NULL, 0, '2022-11-27 14:56:01');
INSERT INTO `pocket_log_coin` VALUES (255, 86, 20, 'qiandao', 86, NULL, 0, '2022-11-28 07:55:38');
INSERT INTO `pocket_log_coin` VALUES (256, 86, 10, 'manual', 86, '', 1, '2022-11-28 14:07:20');
INSERT INTO `pocket_log_coin` VALUES (257, 82, 1000, 'manual', 82, '', 1, '2022-11-28 14:34:30');
INSERT INTO `pocket_log_coin` VALUES (263, 60, 88, 'invited', 77, '', 0, '2022-11-28 19:26:36');
INSERT INTO `pocket_log_coin` VALUES (264, 60, 88, 'invited', 60, '', 0, '2022-11-28 19:26:37');
INSERT INTO `pocket_log_coin` VALUES (265, 60, 88, 'invited', 85, '', 0, '2022-11-28 19:26:38');
INSERT INTO `pocket_log_coin` VALUES (266, 60, 88, 'invited', 86, '', 0, '2022-11-28 19:26:55');
INSERT INTO `pocket_log_coin` VALUES (267, 60, 220, 'qiandao', 60, '', 0, '2022-11-28 19:26:58');
INSERT INTO `pocket_log_coin` VALUES (268, 60, 88, 'invited', 60, '', 0, '2022-11-29 10:17:52');
INSERT INTO `pocket_log_coin` VALUES (269, 60, 88, 'invited', 83, '', 0, '2022-11-29 10:17:53');
INSERT INTO `pocket_log_coin` VALUES (270, 60, 88, 'invited', 77, '', 0, '2022-11-29 10:17:54');
INSERT INTO `pocket_log_coin` VALUES (271, 60, 220, 'qiandao', 60, '', 0, '2022-11-29 14:12:27');
INSERT INTO `pocket_log_coin` VALUES (272, 86, 20, 'qiandao', 86, '', 0, '2022-11-29 14:47:23');
INSERT INTO `pocket_log_coin` VALUES (273, 60, 88, 'invited', 85, '', 0, '2022-11-29 15:28:17');
INSERT INTO `pocket_log_coin` VALUES (274, 60, 88, 'invited', 86, '', 0, '2022-11-29 15:31:08');
INSERT INTO `pocket_log_coin` VALUES (275, 60, 10, 'recharge', 60, '', 0, '2022-11-29 19:22:29');
INSERT INTO `pocket_log_coin` VALUES (276, 87, 20, 'qiandao', 87, '', 0, '2022-11-29 19:24:59');
INSERT INTO `pocket_log_coin` VALUES (277, 88, 20, 'qiandao', 88, '', 0, '2022-11-29 20:01:54');
INSERT INTO `pocket_log_coin` VALUES (278, 89, 20, 'qiandao', 89, '', 0, '2022-11-29 20:05:17');
INSERT INTO `pocket_log_coin` VALUES (279, 88, 8, 'invited', 89, '', 0, '2022-11-29 20:05:49');
INSERT INTO `pocket_log_coin` VALUES (280, 88, 8, 'invited', 88, '', 0, '2022-11-29 20:07:24');
INSERT INTO `pocket_log_coin` VALUES (281, 88, 8, 'invited', 90, '', 0, '2022-11-29 20:24:07');
INSERT INTO `pocket_log_coin` VALUES (282, 88, 8, 'invited', 91, '', 0, '2022-11-29 20:24:09');
INSERT INTO `pocket_log_coin` VALUES (283, 73, 8888, 'cashjoin', 73, '', 0, '2022-11-30 11:29:01');
INSERT INTO `pocket_log_coin` VALUES (284, 60, 200, 'cashjoin', 60, '', 0, '2022-11-30 11:29:01');
INSERT INTO `pocket_log_coin` VALUES (285, 60, 977789, 'cashjoin', 60, '', 0, '2022-11-30 11:29:01');
INSERT INTO `pocket_log_coin` VALUES (286, 88, 51, 'cashjoin', 88, '', 0, '2022-11-30 11:29:01');
INSERT INTO `pocket_log_coin` VALUES (287, 88, 8, 'invited', 88, '', 0, '2022-11-30 14:24:36');
INSERT INTO `pocket_log_coin` VALUES (288, 88, 8, 'invited', 90, '', 0, '2022-11-30 14:24:37');
INSERT INTO `pocket_log_coin` VALUES (289, 88, 8, 'invited', 91, '', 0, '2022-11-30 14:24:38');
INSERT INTO `pocket_log_coin` VALUES (290, 88, 20, 'qiandao', 88, '', 0, '2022-11-30 14:24:40');
INSERT INTO `pocket_log_coin` VALUES (291, 87, 20, 'qiandao', 87, '', 0, '2022-11-30 17:19:39');
INSERT INTO `pocket_log_coin` VALUES (292, 87, 20, 'qiandao', 87, '', 0, '2022-12-01 08:05:33');
INSERT INTO `pocket_log_coin` VALUES (293, 60, 88, 'invited', 83, '', 0, '2022-12-01 19:31:11');
INSERT INTO `pocket_log_coin` VALUES (294, 60, 88, 'invited', 87, '', 0, '2022-12-01 19:31:13');
INSERT INTO `pocket_log_coin` VALUES (295, 60, 88, 'invited', 86, '', 0, '2022-12-01 19:31:14');
INSERT INTO `pocket_log_coin` VALUES (296, 60, 88, 'invited', 85, '', 0, '2022-12-01 19:31:15');
INSERT INTO `pocket_log_coin` VALUES (297, 60, 220, 'qiandao', 60, '', 0, '2022-12-01 19:34:24');
INSERT INTO `pocket_log_coin` VALUES (298, 88, 20, 'qiandao', 88, '', 0, '2022-12-01 20:04:15');
INSERT INTO `pocket_log_coin` VALUES (299, 88, 8, 'invited', 88, '', 0, '2022-12-01 20:04:16');
INSERT INTO `pocket_log_coin` VALUES (300, 88, 8, 'invited', 90, '', 0, '2022-12-01 20:04:17');
INSERT INTO `pocket_log_coin` VALUES (301, 88, 8, 'invited', 91, '', 0, '2022-12-01 20:04:18');
INSERT INTO `pocket_log_coin` VALUES (302, 88, 20, 'qiandao', 88, '', 0, '2022-12-02 10:56:52');
INSERT INTO `pocket_log_coin` VALUES (303, 88, 8, 'invited', 88, '', 0, '2022-12-02 10:56:54');
INSERT INTO `pocket_log_coin` VALUES (304, 88, 8, 'invited', 90, '', 0, '2022-12-02 10:56:55');
INSERT INTO `pocket_log_coin` VALUES (305, 88, 8, 'invited', 91, '', 0, '2022-12-02 10:56:55');
INSERT INTO `pocket_log_coin` VALUES (306, 88, -100, 'levelup', 88, '', 0, '2022-12-02 10:57:00');
INSERT INTO `pocket_log_coin` VALUES (307, 60, 88, 'invited', 83, '', 0, '2022-12-02 13:31:29');
INSERT INTO `pocket_log_coin` VALUES (308, 86, 20, 'qiandao', 86, '', 0, '2022-12-03 17:19:31');
INSERT INTO `pocket_log_coin` VALUES (309, 88, 40, 'qiandao', 88, '', 0, '2022-12-03 20:22:55');
INSERT INTO `pocket_log_coin` VALUES (310, 88, 16, 'invited', 88, '', 0, '2022-12-03 20:22:59');
INSERT INTO `pocket_log_coin` VALUES (311, 88, 16, 'invited', 90, '', 0, '2022-12-03 20:23:11');
INSERT INTO `pocket_log_coin` VALUES (312, 88, 16, 'invited', 91, '', 0, '2022-12-03 20:23:37');
INSERT INTO `pocket_log_coin` VALUES (313, 60, 88, 'invited', 83, '', 0, '2022-12-03 20:32:20');
INSERT INTO `pocket_log_coin` VALUES (314, 60, 8, 'invited', 85, '', 0, '2022-12-03 20:37:21');
INSERT INTO `pocket_log_coin` VALUES (315, 60, 8, 'invited', 87, '', 0, '2022-12-03 20:37:25');
INSERT INTO `pocket_log_coin` VALUES (316, 60, 220, 'qiandao', 60, '', 0, '2022-12-03 20:37:30');
INSERT INTO `pocket_log_coin` VALUES (317, 88, 40, 'qiandao', 88, '', 0, '2022-12-06 10:18:44');
INSERT INTO `pocket_log_coin` VALUES (318, 88, 16, 'invited', 88, '', 0, '2022-12-06 10:18:53');
INSERT INTO `pocket_log_coin` VALUES (319, 88, 8, 'invited', 90, '', 0, '2022-12-06 10:19:03');
INSERT INTO `pocket_log_coin` VALUES (320, 88, 8, 'invited', 91, '', 0, '2022-12-06 10:19:09');
INSERT INTO `pocket_log_coin` VALUES (321, 60, 8, 'invited', 87, '', 0, '2022-12-06 10:47:18');
INSERT INTO `pocket_log_coin` VALUES (322, 60, 220, 'qiandao', 60, '', 0, '2022-12-06 10:47:20');
INSERT INTO `pocket_log_coin` VALUES (323, 86, 20, 'qiandao', 86, '', 0, '2022-12-06 10:50:11');
INSERT INTO `pocket_log_coin` VALUES (324, 95, 20, 'qiandao', 95, '', 0, '2022-12-06 12:37:17');
INSERT INTO `pocket_log_coin` VALUES (325, 94, 20, 'qiandao', 94, '', 0, '2022-12-06 12:37:58');
INSERT INTO `pocket_log_coin` VALUES (326, 94, 8, 'invited', 96, '', 0, '2022-12-06 12:41:55');
INSERT INTO `pocket_log_coin` VALUES (327, 96, 20, 'qiandao', 96, '', 0, '2022-12-06 12:41:57');
INSERT INTO `pocket_log_coin` VALUES (328, 60, 8, 'invited', 83, '', 0, '2022-12-06 13:48:45');
INSERT INTO `pocket_log_coin` VALUES (329, 60, 8, 'invited', 85, '', 0, '2022-12-06 13:48:46');
INSERT INTO `pocket_log_coin` VALUES (330, 78, 977894, 'manual', 78, 'ttt', 1, '2022-12-06 13:58:41');
INSERT INTO `pocket_log_coin` VALUES (331, 88, 8, 'invited', 94, '', 0, '2022-12-06 15:11:32');
INSERT INTO `pocket_log_coin` VALUES (332, 88, 8, 'invited', 95, '', 0, '2022-12-06 15:11:34');
INSERT INTO `pocket_log_coin` VALUES (333, 60, -100, 'cashjoin', 60, '', 0, '2022-12-07 09:39:13');
INSERT INTO `pocket_log_coin` VALUES (334, 86, -23, 'cashjoin', 86, '', 0, '2022-12-07 09:39:13');
INSERT INTO `pocket_log_coin` VALUES (335, 86, 20, 'qiandao', 86, '', 0, '2022-12-07 09:39:43');
INSERT INTO `pocket_log_coin` VALUES (336, 88, 40, 'qiandao', 88, '', 0, '2022-12-07 10:29:48');
INSERT INTO `pocket_log_coin` VALUES (337, 88, 16, 'invited', 88, '', 0, '2022-12-07 10:30:13');
INSERT INTO `pocket_log_coin` VALUES (338, 88, 8, 'invited', 90, '', 0, '2022-12-07 10:30:18');
INSERT INTO `pocket_log_coin` VALUES (339, 88, 8, 'invited', 91, '', 0, '2022-12-07 10:30:20');
INSERT INTO `pocket_log_coin` VALUES (340, 88, 8, 'invited', 94, '', 0, '2022-12-07 10:30:22');
INSERT INTO `pocket_log_coin` VALUES (341, 88, 8, 'invited', 97, '', 0, '2022-12-07 10:30:27');
INSERT INTO `pocket_log_coin` VALUES (342, 88, 40, 'qiandao', 88, '', 0, '2022-12-08 08:04:12');
INSERT INTO `pocket_log_coin` VALUES (343, 88, 16, 'invited', 88, '', 0, '2022-12-08 08:04:18');
INSERT INTO `pocket_log_coin` VALUES (344, 88, 8, 'invited', 90, '', 0, '2022-12-08 08:04:19');
INSERT INTO `pocket_log_coin` VALUES (345, 88, 8, 'invited', 91, '', 0, '2022-12-08 08:04:20');
INSERT INTO `pocket_log_coin` VALUES (346, 88, 8, 'invited', 94, '', 0, '2022-12-08 08:04:20');
INSERT INTO `pocket_log_coin` VALUES (347, 88, 8, 'invited', 95, '', 0, '2022-12-08 08:04:21');
INSERT INTO `pocket_log_coin` VALUES (348, 88, -400, 'levelup', 88, '', 0, '2022-12-08 08:04:34');
INSERT INTO `pocket_log_coin` VALUES (349, 98, 20, 'qiandao', 98, '', 0, '2022-12-08 08:38:56');
INSERT INTO `pocket_log_coin` VALUES (350, 86, 20, 'qiandao', 86, '', 0, '2022-12-08 14:53:16');
INSERT INTO `pocket_log_coin` VALUES (351, 99, 20, 'qiandao', 99, '', 0, '2022-12-08 14:55:23');
INSERT INTO `pocket_log_coin` VALUES (352, 60, 8, 'invited', 83, '', 0, '2022-12-08 14:59:41');
INSERT INTO `pocket_log_coin` VALUES (353, 60, 8, 'invited', 86, '', 0, '2022-12-08 14:59:45');
INSERT INTO `pocket_log_coin` VALUES (354, 88, 60, 'qiandao', 88, '', 0, '2022-12-10 09:41:13');
INSERT INTO `pocket_log_coin` VALUES (355, 88, 24, 'invited', 88, '', 0, '2022-12-10 09:41:23');
INSERT INTO `pocket_log_coin` VALUES (356, 88, 8, 'invited', 90, '', 0, '2022-12-10 09:41:26');
INSERT INTO `pocket_log_coin` VALUES (357, 88, 8, 'invited', 91, '', 0, '2022-12-10 09:41:26');
INSERT INTO `pocket_log_coin` VALUES (358, 88, 8, 'invited', 94, '', 0, '2022-12-10 09:41:27');
INSERT INTO `pocket_log_coin` VALUES (359, 88, 8, 'invited', 95, '', 0, '2022-12-10 09:43:10');
INSERT INTO `pocket_log_coin` VALUES (360, 101, 20, 'qiandao', 101, '', 0, '2022-12-10 09:55:09');
INSERT INTO `pocket_log_coin` VALUES (361, 60, 220, 'qiandao', 60, '', 0, '2022-12-10 11:13:27');
INSERT INTO `pocket_log_coin` VALUES (362, 102, 20, 'qiandao', 102, '', 0, '2022-12-10 12:33:04');
INSERT INTO `pocket_log_coin` VALUES (363, 105, 20, 'qiandao', 105, '', 0, '2022-12-11 13:46:35');
INSERT INTO `pocket_log_coin` VALUES (364, 88, 60, 'qiandao', 88, '', 0, '2022-12-14 13:32:51');
INSERT INTO `pocket_log_coin` VALUES (365, 88, 24, 'invited', 88, '', 0, '2022-12-14 13:33:29');
INSERT INTO `pocket_log_coin` VALUES (366, 88, 8, 'invited', 105, '', 0, '2022-12-14 13:33:33');
INSERT INTO `pocket_log_coin` VALUES (367, 88, 8, 'invited', 90, '', 0, '2022-12-14 13:33:45');
INSERT INTO `pocket_log_coin` VALUES (368, 88, 8, 'invited', 91, '', 0, '2022-12-14 13:33:46');
INSERT INTO `pocket_log_coin` VALUES (369, 88, 8, 'invited', 94, '', 0, '2022-12-14 13:33:47');
INSERT INTO `pocket_log_coin` VALUES (370, 88, 60, 'qiandao', 88, '', 0, '2022-12-16 15:04:56');
INSERT INTO `pocket_log_coin` VALUES (371, 88, 24, 'invited', 88, '', 0, '2022-12-16 15:04:59');
INSERT INTO `pocket_log_coin` VALUES (372, 88, 8, 'invited', 90, '', 0, '2022-12-16 15:05:04');
INSERT INTO `pocket_log_coin` VALUES (373, 88, 8, 'invited', 91, '', 0, '2022-12-16 15:05:05');
INSERT INTO `pocket_log_coin` VALUES (374, 88, 8, 'invited', 94, '', 0, '2022-12-16 15:05:07');
INSERT INTO `pocket_log_coin` VALUES (375, 88, 8, 'invited', 95, '', 0, '2022-12-16 15:05:09');
INSERT INTO `pocket_log_coin` VALUES (376, 88, 60, 'qiandao', 88, '', 0, '2022-12-17 14:31:39');
INSERT INTO `pocket_log_coin` VALUES (377, 88, 24, 'invited', 88, '', 0, '2022-12-17 14:31:42');
INSERT INTO `pocket_log_coin` VALUES (378, 88, 8, 'invited', 90, '', 0, '2022-12-17 14:31:42');
INSERT INTO `pocket_log_coin` VALUES (379, 88, 8, 'invited', 91, '', 0, '2022-12-17 14:31:43');
INSERT INTO `pocket_log_coin` VALUES (380, 88, 8, 'invited', 94, '', 0, '2022-12-17 14:31:44');
INSERT INTO `pocket_log_coin` VALUES (381, 88, 8, 'invited', 95, '', 0, '2022-12-17 14:31:45');
INSERT INTO `pocket_log_coin` VALUES (382, 88, 60, 'qiandao', 88, '', 0, '2022-12-24 10:20:48');
INSERT INTO `pocket_log_coin` VALUES (383, 88, 24, 'invited', 88, '', 0, '2022-12-24 10:21:49');
INSERT INTO `pocket_log_coin` VALUES (384, 88, 8, 'invited', 90, '', 0, '2022-12-24 10:21:52');
INSERT INTO `pocket_log_coin` VALUES (385, 88, 8, 'invited', 91, '', 0, '2022-12-24 10:21:53');
INSERT INTO `pocket_log_coin` VALUES (386, 88, 8, 'invited', 94, '', 0, '2022-12-24 10:21:59');
INSERT INTO `pocket_log_coin` VALUES (387, 88, 8, 'invited', 95, '', 0, '2022-12-24 10:22:01');
INSERT INTO `pocket_log_coin` VALUES (388, 88, 60, 'qiandao', 88, '', 0, '2022-12-25 18:29:15');
INSERT INTO `pocket_log_coin` VALUES (389, 88, 24, 'invited', 88, '', 0, '2022-12-25 18:29:19');
INSERT INTO `pocket_log_coin` VALUES (390, 88, 8, 'invited', 90, '', 0, '2022-12-25 18:29:26');
INSERT INTO `pocket_log_coin` VALUES (391, 88, 8, 'invited', 91, '', 0, '2022-12-25 18:29:27');
INSERT INTO `pocket_log_coin` VALUES (392, 88, 8, 'invited', 94, '', 0, '2022-12-25 18:29:28');
INSERT INTO `pocket_log_coin` VALUES (393, 88, 8, 'invited', 95, '', 0, '2022-12-25 18:29:28');
INSERT INTO `pocket_log_coin` VALUES (394, 60, 8, 'invited', 83, '', 0, '2022-12-29 12:55:36');
INSERT INTO `pocket_log_coin` VALUES (395, 60, 8, 'invited', 85, '', 0, '2022-12-29 12:55:37');
INSERT INTO `pocket_log_coin` VALUES (396, 60, 220, 'qiandao', 60, '', 0, '2022-12-29 12:55:39');
INSERT INTO `pocket_log_coin` VALUES (397, 88, 60, 'qiandao', 88, '', 0, '2022-12-29 16:44:28');
INSERT INTO `pocket_log_coin` VALUES (398, 88, 24, 'invited', 88, '', 0, '2022-12-29 16:44:30');
INSERT INTO `pocket_log_coin` VALUES (399, 88, 8, 'invited', 90, '', 0, '2022-12-29 16:44:31');
INSERT INTO `pocket_log_coin` VALUES (400, 88, 8, 'invited', 91, '', 0, '2022-12-29 16:44:33');
INSERT INTO `pocket_log_coin` VALUES (401, 88, 8, 'invited', 94, '', 0, '2022-12-29 16:44:34');
INSERT INTO `pocket_log_coin` VALUES (402, 88, 8, 'invited', 95, '', 0, '2022-12-29 16:44:35');
INSERT INTO `pocket_log_coin` VALUES (403, 88, 60, 'qiandao', 88, '', 0, '2022-12-30 08:56:57');
INSERT INTO `pocket_log_coin` VALUES (404, 88, 24, 'invited', 88, '', 0, '2022-12-30 08:57:00');
INSERT INTO `pocket_log_coin` VALUES (405, 88, 8, 'invited', 90, '', 0, '2022-12-30 08:57:02');
INSERT INTO `pocket_log_coin` VALUES (406, 88, 8, 'invited', 91, '', 0, '2022-12-30 08:57:03');
INSERT INTO `pocket_log_coin` VALUES (407, 88, 8, 'invited', 94, '', 0, '2022-12-30 08:57:04');
INSERT INTO `pocket_log_coin` VALUES (408, 88, 8, 'invited', 95, '', 0, '2022-12-30 08:57:05');
INSERT INTO `pocket_log_coin` VALUES (409, 88, -900, 'levelup', 88, '', 0, '2022-12-30 08:57:10');
INSERT INTO `pocket_log_coin` VALUES (410, 60, 8, 'invited', 83, '', 0, '2022-12-31 14:48:16');
INSERT INTO `pocket_log_coin` VALUES (411, 60, 8, 'invited', 85, '', 0, '2022-12-31 14:48:17');
INSERT INTO `pocket_log_coin` VALUES (412, 60, 8, 'invited', 86, '', 0, '2022-12-31 14:48:18');
INSERT INTO `pocket_log_coin` VALUES (413, 60, 8, 'invited', 87, '', 0, '2022-12-31 14:48:19');
INSERT INTO `pocket_log_coin` VALUES (414, 60, 8, 'invited', 92, '', 0, '2022-12-31 14:48:20');
INSERT INTO `pocket_log_coin` VALUES (415, 60, 220, 'qiandao', 60, '', 0, '2023-01-02 09:13:20');
INSERT INTO `pocket_log_coin` VALUES (416, 60, 220, 'qiandao', 60, '', 0, '2023-01-09 14:18:50');
INSERT INTO `pocket_log_coin` VALUES (417, 88, 80, 'qiandao', 88, '', 0, '2023-01-09 17:29:45');
INSERT INTO `pocket_log_coin` VALUES (418, 88, 32, 'invited', 88, '', 0, '2023-01-09 17:29:49');
INSERT INTO `pocket_log_coin` VALUES (419, 88, 8, 'invited', 90, '', 0, '2023-01-09 17:29:53');
INSERT INTO `pocket_log_coin` VALUES (420, 88, 8, 'invited', 91, '', 0, '2023-01-09 17:29:53');
INSERT INTO `pocket_log_coin` VALUES (421, 88, 8, 'invited', 94, '', 0, '2023-01-09 17:29:55');
INSERT INTO `pocket_log_coin` VALUES (422, 88, 8, 'invited', 95, '', 0, '2023-01-09 17:29:56');
INSERT INTO `pocket_log_coin` VALUES (423, 106, 20, 'qiandao', 106, '', 0, '2023-01-09 19:07:41');
INSERT INTO `pocket_log_coin` VALUES (424, 88, 80, 'qiandao', 88, '', 0, '2023-01-10 00:00:57');
INSERT INTO `pocket_log_coin` VALUES (425, 88, 32, 'invited', 88, '', 0, '2023-01-10 00:01:02');
INSERT INTO `pocket_log_coin` VALUES (426, 88, 8, 'invited', 90, '', 0, '2023-01-10 00:01:12');
INSERT INTO `pocket_log_coin` VALUES (427, 88, 8, 'invited', 91, '', 0, '2023-01-10 00:01:14');
INSERT INTO `pocket_log_coin` VALUES (428, 88, 8, 'invited', 94, '', 0, '2023-01-10 00:01:15');
INSERT INTO `pocket_log_coin` VALUES (429, 88, 8, 'invited', 95, '', 0, '2023-01-10 00:01:16');
INSERT INTO `pocket_log_coin` VALUES (430, 60, 8, 'invited', 83, '', 0, '2023-01-13 18:49:21');
INSERT INTO `pocket_log_coin` VALUES (431, 60, 8, 'invited', 85, '', 0, '2023-01-13 18:49:22');
INSERT INTO `pocket_log_coin` VALUES (432, 60, 8, 'invited', 86, '', 0, '2023-01-13 18:49:23');
INSERT INTO `pocket_log_coin` VALUES (433, 60, 220, 'qiandao', 60, '', 0, '2023-01-13 18:49:25');
INSERT INTO `pocket_log_coin` VALUES (434, 60, 220, 'qiandao', 60, '', 0, '2023-01-14 09:29:41');
INSERT INTO `pocket_log_coin` VALUES (435, 88, 80, 'qiandao', 88, '', 0, '2023-01-14 18:00:51');
INSERT INTO `pocket_log_coin` VALUES (436, 88, 32, 'invited', 88, '', 0, '2023-01-14 18:00:52');
INSERT INTO `pocket_log_coin` VALUES (437, 88, 8, 'invited', 90, '', 0, '2023-01-14 18:00:54');
INSERT INTO `pocket_log_coin` VALUES (438, 88, 8, 'invited', 91, '', 0, '2023-01-14 18:00:55');
INSERT INTO `pocket_log_coin` VALUES (439, 88, 8, 'invited', 94, '', 0, '2023-01-14 18:00:56');
INSERT INTO `pocket_log_coin` VALUES (440, 88, 8, 'invited', 95, '', 0, '2023-01-14 18:00:57');
INSERT INTO `pocket_log_coin` VALUES (441, 60, 8, 'invited', 83, '', 0, '2023-01-15 10:19:30');
INSERT INTO `pocket_log_coin` VALUES (442, 60, 220, 'qiandao', 60, '', 0, '2023-01-15 13:46:36');
INSERT INTO `pocket_log_coin` VALUES (443, 88, 80, 'qiandao', 88, '', 0, '2023-01-15 17:34:13');
INSERT INTO `pocket_log_coin` VALUES (444, 88, 32, 'invited', 88, '', 0, '2023-01-15 17:34:21');
INSERT INTO `pocket_log_coin` VALUES (445, 88, 8, 'invited', 90, '', 0, '2023-01-15 17:34:22');
INSERT INTO `pocket_log_coin` VALUES (446, 88, 8, 'invited', 91, '', 0, '2023-01-15 17:34:23');
INSERT INTO `pocket_log_coin` VALUES (447, 88, 8, 'invited', 94, '', 0, '2023-01-15 17:34:24');
INSERT INTO `pocket_log_coin` VALUES (448, 88, 8, 'invited', 95, '', 0, '2023-01-15 17:34:26');
INSERT INTO `pocket_log_coin` VALUES (449, 60, 220, 'qiandao', 60, '', 0, '2023-01-16 13:49:41');
INSERT INTO `pocket_log_coin` VALUES (450, 107, 20, 'qiandao', 107, '', 0, '2023-01-16 14:13:08');
INSERT INTO `pocket_log_coin` VALUES (451, 88, 80, 'qiandao', 88, '', 0, '2023-01-16 14:21:39');
INSERT INTO `pocket_log_coin` VALUES (452, 88, 32, 'invited', 88, '', 0, '2023-01-16 14:21:42');
INSERT INTO `pocket_log_coin` VALUES (453, 88, 8, 'invited', 90, '', 0, '2023-01-16 14:21:42');
INSERT INTO `pocket_log_coin` VALUES (454, 88, 8, 'invited', 91, '', 0, '2023-01-16 14:21:43');
INSERT INTO `pocket_log_coin` VALUES (455, 88, 8, 'invited', 94, '', 0, '2023-01-16 14:21:45');
INSERT INTO `pocket_log_coin` VALUES (456, 88, 8, 'invited', 95, '', 0, '2023-01-16 14:21:45');
INSERT INTO `pocket_log_coin` VALUES (457, 60, -12100, 'levelup', 60, '', 0, '2023-01-16 14:49:28');
INSERT INTO `pocket_log_coin` VALUES (458, 60, 8, 'invited', 87, '', 0, '2023-01-16 14:52:24');
INSERT INTO `pocket_log_coin` VALUES (459, 108, 20, 'qiandao', 108, '', 0, '2023-01-16 17:34:34');
INSERT INTO `pocket_log_coin` VALUES (460, 88, 80, 'qiandao', 88, '', 0, '2023-01-17 02:41:35');
INSERT INTO `pocket_log_coin` VALUES (461, 88, 32, 'invited', 88, '', 0, '2023-01-17 02:41:40');
INSERT INTO `pocket_log_coin` VALUES (462, 88, 8, 'invited', 90, '', 0, '2023-01-17 02:41:41');
INSERT INTO `pocket_log_coin` VALUES (463, 88, 8, 'invited', 91, '', 0, '2023-01-17 02:41:41');
INSERT INTO `pocket_log_coin` VALUES (464, 88, 8, 'invited', 94, '', 0, '2023-01-17 02:41:43');
INSERT INTO `pocket_log_coin` VALUES (465, 88, 8, 'invited', 95, '', 0, '2023-01-17 02:41:43');
INSERT INTO `pocket_log_coin` VALUES (466, 88, 80, 'qiandao', 88, '', 0, '2023-01-27 12:07:46');
INSERT INTO `pocket_log_coin` VALUES (467, 88, 32, 'invited', 88, '', 0, '2023-01-27 12:07:51');
INSERT INTO `pocket_log_coin` VALUES (468, 88, 8, 'invited', 90, '', 0, '2023-01-27 12:07:53');
INSERT INTO `pocket_log_coin` VALUES (469, 88, 8, 'invited', 91, '', 0, '2023-01-27 12:07:54');
INSERT INTO `pocket_log_coin` VALUES (470, 88, 8, 'invited', 94, '', 0, '2023-01-27 12:07:55');
INSERT INTO `pocket_log_coin` VALUES (471, 88, 8, 'invited', 95, '', 0, '2023-01-27 12:07:57');
INSERT INTO `pocket_log_coin` VALUES (472, 88, 80, 'qiandao', 88, '', 0, '2023-02-02 12:03:23');
INSERT INTO `pocket_log_coin` VALUES (473, 88, 32, 'invited', 88, '', 0, '2023-02-02 12:03:35');
INSERT INTO `pocket_log_coin` VALUES (474, 88, 8, 'invited', 90, '', 0, '2023-02-02 12:03:52');
INSERT INTO `pocket_log_coin` VALUES (475, 88, 8, 'invited', 91, '', 0, '2023-02-02 12:03:54');
INSERT INTO `pocket_log_coin` VALUES (476, 88, 8, 'invited', 94, '', 0, '2023-02-02 12:03:54');
INSERT INTO `pocket_log_coin` VALUES (477, 88, 8, 'invited', 95, '', 0, '2023-02-02 12:03:55');
INSERT INTO `pocket_log_coin` VALUES (478, 88, 80, 'qiandao', 88, '', 0, '2023-02-14 12:50:11');
INSERT INTO `pocket_log_coin` VALUES (479, 88, 32, 'invited', 88, '', 0, '2023-02-14 12:50:13');
INSERT INTO `pocket_log_coin` VALUES (480, 88, 8, 'invited', 90, '', 0, '2023-02-14 12:50:23');
INSERT INTO `pocket_log_coin` VALUES (481, 88, 8, 'invited', 91, '', 0, '2023-02-14 12:50:23');
INSERT INTO `pocket_log_coin` VALUES (482, 88, 8, 'invited', 94, '', 0, '2023-02-14 12:50:24');
INSERT INTO `pocket_log_coin` VALUES (483, 88, 8, 'invited', 95, '', 0, '2023-02-14 12:50:25');
INSERT INTO `pocket_log_coin` VALUES (484, 88, 80, 'qiandao', 88, '', 0, '2023-02-21 23:34:47');
INSERT INTO `pocket_log_coin` VALUES (485, 88, -900, 'levelup', 88, '', 0, '2023-02-21 23:34:54');
INSERT INTO `pocket_log_coin` VALUES (486, 88, 32, 'invited', 88, '', 0, '2023-02-21 23:34:58');
INSERT INTO `pocket_log_coin` VALUES (487, 88, 8, 'invited', 90, '', 0, '2023-02-21 23:35:02');
INSERT INTO `pocket_log_coin` VALUES (488, 88, 8, 'invited', 91, '', 0, '2023-02-21 23:35:03');
INSERT INTO `pocket_log_coin` VALUES (489, 88, 8, 'invited', 94, '', 0, '2023-02-21 23:35:04');
INSERT INTO `pocket_log_coin` VALUES (490, 88, 8, 'invited', 95, '', 0, '2023-02-21 23:35:06');
INSERT INTO `pocket_log_coin` VALUES (491, 88, 80, 'qiandao', 88, '', 0, '2023-02-23 08:11:58');
INSERT INTO `pocket_log_coin` VALUES (492, 88, 32, 'invited', 88, '', 0, '2023-02-23 08:12:03');
INSERT INTO `pocket_log_coin` VALUES (493, 88, 8, 'invited', 90, '', 0, '2023-02-23 08:12:05');
INSERT INTO `pocket_log_coin` VALUES (494, 88, 8, 'invited', 91, '', 0, '2023-02-23 08:12:07');
INSERT INTO `pocket_log_coin` VALUES (495, 88, 8, 'invited', 94, '', 0, '2023-02-23 08:12:09');
INSERT INTO `pocket_log_coin` VALUES (496, 88, 8, 'invited', 95, '', 0, '2023-02-23 08:12:10');
INSERT INTO `pocket_log_coin` VALUES (497, 88, 80, 'qiandao', 88, '', 0, '2023-02-28 07:43:30');
INSERT INTO `pocket_log_coin` VALUES (498, 88, 32, 'invited', 88, '', 0, '2023-02-28 07:43:38');
INSERT INTO `pocket_log_coin` VALUES (499, 88, 8, 'invited', 90, '', 0, '2023-02-28 07:43:46');
INSERT INTO `pocket_log_coin` VALUES (500, 88, 8, 'invited', 91, '', 0, '2023-02-28 07:43:47');
INSERT INTO `pocket_log_coin` VALUES (501, 88, 8, 'invited', 94, '', 0, '2023-02-28 07:43:47');
INSERT INTO `pocket_log_coin` VALUES (502, 88, 8, 'invited', 95, '', 0, '2023-02-28 07:43:49');
INSERT INTO `pocket_log_coin` VALUES (503, 88, 80, 'qiandao', 88, '', 0, '2023-03-02 14:16:47');
INSERT INTO `pocket_log_coin` VALUES (504, 88, 32, 'invited', 88, '', 0, '2023-03-02 14:16:48');
INSERT INTO `pocket_log_coin` VALUES (505, 88, 8, 'invited', 90, '', 0, '2023-03-02 14:16:49');
INSERT INTO `pocket_log_coin` VALUES (506, 88, 8, 'invited', 91, '', 0, '2023-03-02 14:16:50');
INSERT INTO `pocket_log_coin` VALUES (507, 88, 8, 'invited', 94, '', 0, '2023-03-02 14:16:50');
INSERT INTO `pocket_log_coin` VALUES (508, 88, 8, 'invited', 95, '', 0, '2023-03-02 14:16:52');
INSERT INTO `pocket_log_coin` VALUES (509, 88, -900, 'levelup', 88, '', 0, '2023-03-02 14:17:04');
INSERT INTO `pocket_log_coin` VALUES (510, 88, 80, 'qiandao', 88, '', 0, '2023-03-06 21:29:13');
INSERT INTO `pocket_log_coin` VALUES (511, 88, 80, 'qiandao', 88, '', 0, '2023-03-07 09:54:36');
INSERT INTO `pocket_log_coin` VALUES (512, 88, 32, 'invited', 88, '', 0, '2023-03-07 09:54:39');
INSERT INTO `pocket_log_coin` VALUES (513, 88, 8, 'invited', 90, '', 0, '2023-03-07 09:54:39');
INSERT INTO `pocket_log_coin` VALUES (514, 88, 8, 'invited', 91, '', 0, '2023-03-07 09:54:40');
INSERT INTO `pocket_log_coin` VALUES (515, 88, 8, 'invited', 94, '', 0, '2023-03-07 09:54:41');
INSERT INTO `pocket_log_coin` VALUES (516, 88, 8, 'invited', 95, '', 0, '2023-03-07 09:54:42');
INSERT INTO `pocket_log_coin` VALUES (517, 88, 80, 'qiandao', 88, '', 0, '2023-03-08 13:05:37');
INSERT INTO `pocket_log_coin` VALUES (518, 88, 32, 'invited', 88, '', 0, '2023-03-08 13:05:39');
INSERT INTO `pocket_log_coin` VALUES (519, 88, 8, 'invited', 90, '', 0, '2023-03-08 13:05:40');
INSERT INTO `pocket_log_coin` VALUES (520, 88, 8, 'invited', 91, '', 0, '2023-03-08 13:05:41');
INSERT INTO `pocket_log_coin` VALUES (521, 88, 8, 'invited', 94, '', 0, '2023-03-08 13:05:41');
INSERT INTO `pocket_log_coin` VALUES (522, 88, 8, 'invited', 95, '', 0, '2023-03-08 13:05:43');
INSERT INTO `pocket_log_coin` VALUES (523, 88, 80, 'qiandao', 88, '', 0, '2023-03-14 14:45:15');
INSERT INTO `pocket_log_coin` VALUES (524, 88, 32, 'invited', 88, '', 0, '2023-03-14 14:45:18');
INSERT INTO `pocket_log_coin` VALUES (525, 88, 8, 'invited', 90, '', 0, '2023-03-14 14:45:19');
INSERT INTO `pocket_log_coin` VALUES (526, 88, 8, 'invited', 91, '', 0, '2023-03-14 14:45:20');
INSERT INTO `pocket_log_coin` VALUES (527, 88, 8, 'invited', 94, '', 0, '2023-03-14 14:45:21');
INSERT INTO `pocket_log_coin` VALUES (528, 88, 8, 'invited', 95, '', 0, '2023-03-14 14:45:22');
INSERT INTO `pocket_log_coin` VALUES (529, 88, 80, 'qiandao', 88, '', 0, '2023-03-15 10:42:53');
INSERT INTO `pocket_log_coin` VALUES (530, 88, 32, 'invited', 88, '', 0, '2023-03-15 10:42:55');
INSERT INTO `pocket_log_coin` VALUES (531, 88, 8, 'invited', 90, '', 0, '2023-03-15 10:42:55');
INSERT INTO `pocket_log_coin` VALUES (532, 88, 8, 'invited', 91, '', 0, '2023-03-15 10:42:56');
INSERT INTO `pocket_log_coin` VALUES (533, 88, 8, 'invited', 94, '', 0, '2023-03-15 10:42:56');
INSERT INTO `pocket_log_coin` VALUES (534, 88, 8, 'invited', 95, '', 0, '2023-03-15 10:42:57');
INSERT INTO `pocket_log_coin` VALUES (535, 88, 80, 'qiandao', 88, '', 0, '2023-03-16 08:55:31');
INSERT INTO `pocket_log_coin` VALUES (536, 88, 32, 'invited', 88, '', 0, '2023-03-16 08:55:33');
INSERT INTO `pocket_log_coin` VALUES (537, 88, 8, 'invited', 90, '', 0, '2023-03-16 08:55:34');
INSERT INTO `pocket_log_coin` VALUES (538, 88, 8, 'invited', 91, '', 0, '2023-03-16 08:55:35');
INSERT INTO `pocket_log_coin` VALUES (539, 88, 8, 'invited', 94, '', 0, '2023-03-16 08:55:35');
INSERT INTO `pocket_log_coin` VALUES (540, 88, 8, 'invited', 95, '', 0, '2023-03-16 08:55:37');
INSERT INTO `pocket_log_coin` VALUES (541, 60, 240, 'qiandao', 60, '', 0, '2023-03-16 12:59:07');
INSERT INTO `pocket_log_coin` VALUES (542, 88, 80, 'qiandao', 88, '', 0, '2023-03-19 16:17:14');
INSERT INTO `pocket_log_coin` VALUES (543, 88, 32, 'invited', 88, '', 0, '2023-03-19 16:17:17');
INSERT INTO `pocket_log_coin` VALUES (544, 88, 8, 'invited', 90, '', 0, '2023-03-19 16:17:18');
INSERT INTO `pocket_log_coin` VALUES (545, 88, 8, 'invited', 91, '', 0, '2023-03-19 16:17:18');
INSERT INTO `pocket_log_coin` VALUES (546, 88, 8, 'invited', 94, '', 0, '2023-03-19 16:17:19');
INSERT INTO `pocket_log_coin` VALUES (547, 88, 8, 'invited', 95, '', 0, '2023-03-19 16:17:20');
INSERT INTO `pocket_log_coin` VALUES (548, 60, 240, 'qiandao', 60, '', 0, '2023-03-23 08:13:23');
INSERT INTO `pocket_log_coin` VALUES (549, 60, 240, 'qiandao', 60, '', 0, '2023-03-24 08:31:31');
INSERT INTO `pocket_log_coin` VALUES (550, 60, 8, 'invited', 83, '', 0, '2023-03-24 08:34:43');
INSERT INTO `pocket_log_coin` VALUES (551, 88, 80, 'qiandao', 88, '', 0, '2023-03-25 17:46:41');
INSERT INTO `pocket_log_coin` VALUES (552, 88, 32, 'invited', 88, '', 0, '2023-03-25 17:46:43');
INSERT INTO `pocket_log_coin` VALUES (553, 88, 8, 'invited', 90, '', 0, '2023-03-25 17:46:43');
INSERT INTO `pocket_log_coin` VALUES (554, 88, 8, 'invited', 91, '', 0, '2023-03-25 17:46:44');
INSERT INTO `pocket_log_coin` VALUES (555, 88, 8, 'invited', 94, '', 0, '2023-03-25 17:46:44');
INSERT INTO `pocket_log_coin` VALUES (556, 88, 8, 'invited', 95, '', 0, '2023-03-25 17:46:46');
INSERT INTO `pocket_log_coin` VALUES (557, 88, 80, 'qiandao', 88, '', 0, '2023-03-26 16:55:16');
INSERT INTO `pocket_log_coin` VALUES (558, 88, 32, 'invited', 88, '', 0, '2023-03-26 16:55:18');
INSERT INTO `pocket_log_coin` VALUES (559, 88, 8, 'invited', 90, '', 0, '2023-03-26 16:55:18');
INSERT INTO `pocket_log_coin` VALUES (560, 88, 8, 'invited', 91, '', 0, '2023-03-26 16:55:19');
INSERT INTO `pocket_log_coin` VALUES (561, 88, 8, 'invited', 94, '', 0, '2023-03-26 16:55:19');
INSERT INTO `pocket_log_coin` VALUES (562, 88, 8, 'invited', 95, '', 0, '2023-03-26 16:55:21');
INSERT INTO `pocket_log_coin` VALUES (563, 88, 80, 'qiandao', 88, '', 0, '2023-03-28 14:57:26');
INSERT INTO `pocket_log_coin` VALUES (564, 88, 32, 'invited', 88, '', 0, '2023-03-28 14:57:27');
INSERT INTO `pocket_log_coin` VALUES (565, 88, 8, 'invited', 90, '', 0, '2023-03-28 14:57:29');
INSERT INTO `pocket_log_coin` VALUES (566, 88, 8, 'invited', 91, '', 0, '2023-03-28 14:57:29');
INSERT INTO `pocket_log_coin` VALUES (567, 88, 8, 'invited', 94, '', 0, '2023-03-28 14:57:31');
INSERT INTO `pocket_log_coin` VALUES (568, 88, 8, 'invited', 95, '', 0, '2023-03-28 14:57:31');
INSERT INTO `pocket_log_coin` VALUES (569, 88, 80, 'qiandao', 88, '', 0, '2023-03-29 23:51:29');
INSERT INTO `pocket_log_coin` VALUES (570, 88, 32, 'invited', 88, '', 0, '2023-03-29 23:51:31');
INSERT INTO `pocket_log_coin` VALUES (571, 88, 8, 'invited', 90, '', 0, '2023-03-29 23:51:32');
INSERT INTO `pocket_log_coin` VALUES (572, 88, 8, 'invited', 91, '', 0, '2023-03-29 23:51:33');
INSERT INTO `pocket_log_coin` VALUES (573, 88, 8, 'invited', 94, '', 0, '2023-03-29 23:51:34');
INSERT INTO `pocket_log_coin` VALUES (574, 88, 8, 'invited', 95, '', 0, '2023-03-29 23:51:35');
INSERT INTO `pocket_log_coin` VALUES (575, 88, -1600, 'levelup', 88, '', 0, '2023-03-29 23:51:53');
INSERT INTO `pocket_log_coin` VALUES (576, 88, 100, 'qiandao', 88, '', 0, '2023-03-30 00:16:04');
INSERT INTO `pocket_log_coin` VALUES (577, 88, 40, 'invited', 88, '', 0, '2023-03-30 00:16:14');
INSERT INTO `pocket_log_coin` VALUES (578, 88, 8, 'invited', 90, '', 0, '2023-03-30 00:16:19');
INSERT INTO `pocket_log_coin` VALUES (579, 88, 8, 'invited', 91, '', 0, '2023-03-30 00:16:21');
INSERT INTO `pocket_log_coin` VALUES (580, 88, 8, 'invited', 94, '', 0, '2023-03-30 00:16:23');
INSERT INTO `pocket_log_coin` VALUES (581, 88, 8, 'invited', 95, '', 0, '2023-03-30 00:16:23');
INSERT INTO `pocket_log_coin` VALUES (582, 88, 100, 'qiandao', 88, '', 0, '2023-03-31 17:41:04');
INSERT INTO `pocket_log_coin` VALUES (583, 88, 40, 'invited', 88, '', 0, '2023-03-31 17:41:09');
INSERT INTO `pocket_log_coin` VALUES (584, 88, 8, 'invited', 90, '', 0, '2023-03-31 17:41:11');
INSERT INTO `pocket_log_coin` VALUES (585, 88, 8, 'invited', 91, '', 0, '2023-03-31 17:41:12');
INSERT INTO `pocket_log_coin` VALUES (586, 88, 8, 'invited', 94, '', 0, '2023-03-31 17:41:14');
INSERT INTO `pocket_log_coin` VALUES (587, 88, 8, 'invited', 95, '', 0, '2023-03-31 17:41:15');
INSERT INTO `pocket_log_coin` VALUES (588, 60, 240, 'qiandao', 60, '', 0, '2023-03-31 19:58:31');
INSERT INTO `pocket_log_coin` VALUES (589, 60, 8, 'invited', 85, '', 0, '2023-03-31 19:58:39');
INSERT INTO `pocket_log_coin` VALUES (590, 60, 8, 'invited', 86, '', 0, '2023-03-31 19:58:40');
INSERT INTO `pocket_log_coin` VALUES (591, 60, 8, 'invited', 87, '', 0, '2023-03-31 19:58:41');
INSERT INTO `pocket_log_coin` VALUES (592, 60, 8, 'invited', 92, '', 0, '2023-03-31 19:58:41');
INSERT INTO `pocket_log_coin` VALUES (593, 88, 100, 'qiandao', 88, '', 0, '2023-04-01 00:37:07');
INSERT INTO `pocket_log_coin` VALUES (594, 88, 40, 'invited', 88, '', 0, '2023-04-01 00:37:10');
INSERT INTO `pocket_log_coin` VALUES (595, 88, 8, 'invited', 90, '', 0, '2023-04-01 00:37:13');
INSERT INTO `pocket_log_coin` VALUES (596, 88, 8, 'invited', 91, '', 0, '2023-04-01 00:37:14');
INSERT INTO `pocket_log_coin` VALUES (597, 88, 8, 'invited', 94, '', 0, '2023-04-01 00:37:15');
INSERT INTO `pocket_log_coin` VALUES (598, 88, 8, 'invited', 95, '', 0, '2023-04-01 00:37:16');
INSERT INTO `pocket_log_coin` VALUES (599, 88, 100, 'qiandao', 88, '', 0, '2023-04-02 00:07:59');
INSERT INTO `pocket_log_coin` VALUES (600, 88, 40, 'invited', 88, '', 0, '2023-04-02 00:08:00');
INSERT INTO `pocket_log_coin` VALUES (601, 88, 8, 'invited', 90, '', 0, '2023-04-02 00:08:01');
INSERT INTO `pocket_log_coin` VALUES (602, 88, 8, 'invited', 91, '', 0, '2023-04-02 00:08:01');
INSERT INTO `pocket_log_coin` VALUES (603, 88, 8, 'invited', 94, '', 0, '2023-04-02 00:08:02');
INSERT INTO `pocket_log_coin` VALUES (604, 88, 8, 'invited', 95, '', 0, '2023-04-02 00:08:03');
INSERT INTO `pocket_log_coin` VALUES (605, 88, 100, 'qiandao', 88, '', 0, '2023-04-03 09:49:08');
INSERT INTO `pocket_log_coin` VALUES (606, 88, 40, 'invited', 88, '', 0, '2023-04-03 09:49:10');
INSERT INTO `pocket_log_coin` VALUES (607, 88, 8, 'invited', 90, '', 0, '2023-04-03 09:49:10');
INSERT INTO `pocket_log_coin` VALUES (608, 88, 8, 'invited', 91, '', 0, '2023-04-03 09:49:11');
INSERT INTO `pocket_log_coin` VALUES (609, 88, 8, 'invited', 94, '', 0, '2023-04-03 09:49:12');
INSERT INTO `pocket_log_coin` VALUES (610, 88, 8, 'invited', 95, '', 0, '2023-04-03 09:49:13');
INSERT INTO `pocket_log_coin` VALUES (611, 60, 240, 'qiandao', 60, '', 0, '2023-04-04 15:43:17');
INSERT INTO `pocket_log_coin` VALUES (612, 88, 100, 'qiandao', 88, '', 0, '2023-04-05 15:08:38');
INSERT INTO `pocket_log_coin` VALUES (613, 88, 40, 'invited', 88, '', 0, '2023-04-05 15:08:41');
INSERT INTO `pocket_log_coin` VALUES (614, 88, 8, 'invited', 90, '', 0, '2023-04-05 15:08:42');
INSERT INTO `pocket_log_coin` VALUES (615, 88, 8, 'invited', 91, '', 0, '2023-04-05 15:08:43');
INSERT INTO `pocket_log_coin` VALUES (616, 88, 8, 'invited', 94, '', 0, '2023-04-05 15:08:44');
INSERT INTO `pocket_log_coin` VALUES (617, 88, 8, 'invited', 95, '', 0, '2023-04-05 15:08:45');
INSERT INTO `pocket_log_coin` VALUES (618, 88, 100, 'qiandao', 88, '', 0, '2023-04-06 00:26:08');
INSERT INTO `pocket_log_coin` VALUES (619, 88, 40, 'invited', 88, '', 0, '2023-04-06 00:26:10');
INSERT INTO `pocket_log_coin` VALUES (620, 88, 8, 'invited', 90, '', 0, '2023-04-06 00:26:12');
INSERT INTO `pocket_log_coin` VALUES (621, 88, 8, 'invited', 91, '', 0, '2023-04-06 00:26:12');
INSERT INTO `pocket_log_coin` VALUES (622, 88, 8, 'invited', 94, '', 0, '2023-04-06 00:26:13');
INSERT INTO `pocket_log_coin` VALUES (623, 88, 8, 'invited', 95, '', 0, '2023-04-06 00:26:15');
INSERT INTO `pocket_log_coin` VALUES (624, 88, 100, 'qiandao', 88, '', 0, '2023-04-07 08:33:16');
INSERT INTO `pocket_log_coin` VALUES (625, 88, 40, 'invited', 88, '', 0, '2023-04-07 08:33:18');
INSERT INTO `pocket_log_coin` VALUES (626, 88, 8, 'invited', 90, '', 0, '2023-04-07 08:33:19');
INSERT INTO `pocket_log_coin` VALUES (627, 88, 8, 'invited', 91, '', 0, '2023-04-07 08:33:19');
INSERT INTO `pocket_log_coin` VALUES (628, 88, 8, 'invited', 94, '', 0, '2023-04-07 08:33:20');
INSERT INTO `pocket_log_coin` VALUES (629, 88, 8, 'invited', 95, '', 0, '2023-04-07 08:33:21');
INSERT INTO `pocket_log_coin` VALUES (630, 60, 240, 'qiandao', 60, '', 0, '2023-04-07 14:25:56');
INSERT INTO `pocket_log_coin` VALUES (631, 60, -14400, 'levelup', 60, '', 0, '2023-04-07 14:26:07');
INSERT INTO `pocket_log_coin` VALUES (632, 60, 8, 'invited', 85, '', 0, '2023-04-07 14:26:27');
INSERT INTO `pocket_log_coin` VALUES (633, 60, 8, 'invited', 86, '', 0, '2023-04-07 14:26:28');
INSERT INTO `pocket_log_coin` VALUES (634, 60, 8, 'invited', 87, '', 0, '2023-04-07 14:26:29');
INSERT INTO `pocket_log_coin` VALUES (635, 60, 8, 'invited', 92, '', 0, '2023-04-07 14:26:29');
INSERT INTO `pocket_log_coin` VALUES (636, 88, 100, 'qiandao', 88, '', 0, '2023-04-09 11:05:52');
INSERT INTO `pocket_log_coin` VALUES (637, 88, 40, 'invited', 88, '', 0, '2023-04-09 11:05:58');
INSERT INTO `pocket_log_coin` VALUES (638, 88, 8, 'invited', 90, '', 0, '2023-04-09 11:05:59');
INSERT INTO `pocket_log_coin` VALUES (639, 88, 8, 'invited', 91, '', 0, '2023-04-09 11:05:59');
INSERT INTO `pocket_log_coin` VALUES (640, 88, 8, 'invited', 94, '', 0, '2023-04-09 11:06:00');
INSERT INTO `pocket_log_coin` VALUES (641, 88, 8, 'invited', 95, '', 0, '2023-04-09 11:06:01');
INSERT INTO `pocket_log_coin` VALUES (642, 88, 100, 'qiandao', 88, '', 0, '2023-04-10 13:47:57');
INSERT INTO `pocket_log_coin` VALUES (643, 88, 40, 'invited', 88, '', 0, '2023-04-10 13:48:01');
INSERT INTO `pocket_log_coin` VALUES (644, 88, 8, 'invited', 90, '', 0, '2023-04-10 13:48:10');
INSERT INTO `pocket_log_coin` VALUES (645, 88, 8, 'invited', 90, '', 0, '2023-04-10 13:48:11');
INSERT INTO `pocket_log_coin` VALUES (646, 88, 8, 'invited', 90, '', 0, '2023-04-10 13:48:11');
INSERT INTO `pocket_log_coin` VALUES (647, 88, 8, 'invited', 91, '', 0, '2023-04-10 13:48:11');
INSERT INTO `pocket_log_coin` VALUES (648, 88, 8, 'invited', 90, '', 0, '2023-04-10 13:48:11');
INSERT INTO `pocket_log_coin` VALUES (649, 88, 8, 'invited', 90, '', 0, '2023-04-10 13:48:11');
INSERT INTO `pocket_log_coin` VALUES (650, 88, 8, 'invited', 91, '', 0, '2023-04-10 13:48:11');
INSERT INTO `pocket_log_coin` VALUES (651, 88, 8, 'invited', 90, '', 0, '2023-04-10 13:48:11');
INSERT INTO `pocket_log_coin` VALUES (652, 88, 8, 'invited', 90, '', 0, '2023-04-10 13:48:11');
INSERT INTO `pocket_log_coin` VALUES (653, 88, 100, 'qiandao', 88, '', 0, '2023-04-11 07:33:39');
INSERT INTO `pocket_log_coin` VALUES (654, 88, 40, 'invited', 88, '', 0, '2023-04-11 07:33:42');
INSERT INTO `pocket_log_coin` VALUES (655, 88, 8, 'invited', 90, '', 0, '2023-04-11 07:33:43');
INSERT INTO `pocket_log_coin` VALUES (656, 88, 8, 'invited', 91, '', 0, '2023-04-11 07:33:44');
INSERT INTO `pocket_log_coin` VALUES (657, 88, 8, 'invited', 94, '', 0, '2023-04-11 07:33:45');
INSERT INTO `pocket_log_coin` VALUES (658, 88, 8, 'invited', 95, '', 0, '2023-04-11 07:33:47');
INSERT INTO `pocket_log_coin` VALUES (659, 60, 260, 'qiandao', 60, '', 0, '2023-04-11 08:38:54');
INSERT INTO `pocket_log_coin` VALUES (660, 60, 8, 'invited', 85, '', 0, '2023-04-11 08:40:20');
INSERT INTO `pocket_log_coin` VALUES (661, 60, 8, 'invited', 87, '', 0, '2023-04-11 08:40:25');
INSERT INTO `pocket_log_coin` VALUES (662, 60, 8, 'invited', 86, '', 0, '2023-04-11 08:40:29');
INSERT INTO `pocket_log_coin` VALUES (663, 60, 8, 'invited', 92, '', 0, '2023-04-11 08:40:31');
INSERT INTO `pocket_log_coin` VALUES (664, 60, 260, 'qiandao', 60, '', 0, '2023-04-12 09:58:15');
INSERT INTO `pocket_log_coin` VALUES (665, 60, 260, 'qiandao', 60, '', 0, '2023-04-13 14:02:40');
INSERT INTO `pocket_log_coin` VALUES (666, 88, 100, 'qiandao', 88, '', 0, '2023-04-13 14:57:46');
INSERT INTO `pocket_log_coin` VALUES (667, 88, 40, 'invited', 88, '', 0, '2023-04-13 14:57:48');
INSERT INTO `pocket_log_coin` VALUES (668, 88, 8, 'invited', 90, '', 0, '2023-04-13 14:57:48');
INSERT INTO `pocket_log_coin` VALUES (669, 88, 8, 'invited', 91, '', 0, '2023-04-13 14:57:49');
INSERT INTO `pocket_log_coin` VALUES (670, 88, 8, 'invited', 94, '', 0, '2023-04-13 14:57:49');
INSERT INTO `pocket_log_coin` VALUES (671, 88, 8, 'invited', 95, '', 0, '2023-04-13 14:57:51');
INSERT INTO `pocket_log_coin` VALUES (672, 60, 260, 'qiandao', 60, '', 0, '2023-04-14 08:57:02');
INSERT INTO `pocket_log_coin` VALUES (673, 60, 260, 'qiandao', 60, '', 0, '2023-04-14 09:00:59');
INSERT INTO `pocket_log_coin` VALUES (674, 60, 260, 'qiandao', 60, '', 0, '2023-04-14 09:05:52');
INSERT INTO `pocket_log_coin` VALUES (675, 88, 100, 'qiandao', 88, '', 0, '2023-04-14 09:27:22');
INSERT INTO `pocket_log_coin` VALUES (676, 88, 40, 'invited', 88, '', 0, '2023-04-14 09:27:25');
INSERT INTO `pocket_log_coin` VALUES (677, 88, 8, 'invited', 90, '', 0, '2023-04-14 09:27:27');
INSERT INTO `pocket_log_coin` VALUES (678, 88, 8, 'invited', 91, '', 0, '2023-04-14 09:27:28');
INSERT INTO `pocket_log_coin` VALUES (679, 88, 8, 'invited', 94, '', 0, '2023-04-14 09:27:29');
INSERT INTO `pocket_log_coin` VALUES (680, 88, 8, 'invited', 95, '', 0, '2023-04-14 09:27:30');
INSERT INTO `pocket_log_coin` VALUES (681, 60, 260, 'qiandao', 60, '', 0, '2023-04-15 11:30:04');
INSERT INTO `pocket_log_coin` VALUES (682, 88, 100, 'qiandao', 88, '', 0, '2023-04-15 15:49:06');
INSERT INTO `pocket_log_coin` VALUES (683, 88, 40, 'invited', 88, '', 0, '2023-04-15 15:49:08');
INSERT INTO `pocket_log_coin` VALUES (684, 88, 8, 'invited', 90, '', 0, '2023-04-15 15:49:09');
INSERT INTO `pocket_log_coin` VALUES (685, 88, 8, 'invited', 91, '', 0, '2023-04-15 15:49:09');
INSERT INTO `pocket_log_coin` VALUES (686, 88, 8, 'invited', 94, '', 0, '2023-04-15 15:49:10');
INSERT INTO `pocket_log_coin` VALUES (687, 88, 8, 'invited', 95, '', 0, '2023-04-15 15:49:11');
INSERT INTO `pocket_log_coin` VALUES (688, 88, 100, 'qiandao', 88, '', 0, '2023-04-17 15:22:15');
INSERT INTO `pocket_log_coin` VALUES (689, 88, 40, 'invited', 88, '', 0, '2023-04-17 15:22:17');
INSERT INTO `pocket_log_coin` VALUES (690, 88, 8, 'invited', 90, '', 0, '2023-04-17 15:22:17');
INSERT INTO `pocket_log_coin` VALUES (691, 88, 8, 'invited', 91, '', 0, '2023-04-17 15:22:18');
INSERT INTO `pocket_log_coin` VALUES (692, 88, 8, 'invited', 94, '', 0, '2023-04-17 15:22:19');
INSERT INTO `pocket_log_coin` VALUES (693, 88, 8, 'invited', 95, '', 0, '2023-04-17 15:22:20');
INSERT INTO `pocket_log_coin` VALUES (694, 88, 100, 'qiandao', 88, '', 0, '2023-04-18 14:38:01');
INSERT INTO `pocket_log_coin` VALUES (695, 88, 40, 'invited', 88, '', 0, '2023-04-18 14:38:02');
INSERT INTO `pocket_log_coin` VALUES (696, 88, 8, 'invited', 90, '', 0, '2023-04-18 14:38:03');
INSERT INTO `pocket_log_coin` VALUES (697, 88, 8, 'invited', 91, '', 0, '2023-04-18 14:38:03');
INSERT INTO `pocket_log_coin` VALUES (698, 88, 8, 'invited', 94, '', 0, '2023-04-18 14:38:04');
INSERT INTO `pocket_log_coin` VALUES (699, 88, 8, 'invited', 95, '', 0, '2023-04-18 14:38:05');
INSERT INTO `pocket_log_coin` VALUES (700, 107, 20, 'qiandao', 107, '', 0, '2023-04-19 17:01:44');
INSERT INTO `pocket_log_coin` VALUES (701, 88, 100, 'qiandao', 88, '', 0, '2023-04-20 15:57:17');
INSERT INTO `pocket_log_coin` VALUES (702, 88, 40, 'invited', 88, '', 0, '2023-04-20 15:57:24');
INSERT INTO `pocket_log_coin` VALUES (703, 88, 8, 'invited', 90, '', 0, '2023-04-20 15:57:25');
INSERT INTO `pocket_log_coin` VALUES (704, 88, 8, 'invited', 91, '', 0, '2023-04-20 15:57:26');
INSERT INTO `pocket_log_coin` VALUES (705, 88, 8, 'invited', 94, '', 0, '2023-04-20 15:57:27');
INSERT INTO `pocket_log_coin` VALUES (706, 88, 8, 'invited', 95, '', 0, '2023-04-20 15:57:28');
INSERT INTO `pocket_log_coin` VALUES (707, 114, 20, 'qiandao', 114, '', 0, '2023-04-21 11:03:48');
INSERT INTO `pocket_log_coin` VALUES (708, 88, 100, 'qiandao', 88, '', 0, '2023-04-21 12:24:46');
INSERT INTO `pocket_log_coin` VALUES (709, 88, 40, 'invited', 88, '', 0, '2023-04-21 12:24:47');
INSERT INTO `pocket_log_coin` VALUES (710, 88, 8, 'invited', 90, '', 0, '2023-04-21 12:24:48');
INSERT INTO `pocket_log_coin` VALUES (711, 88, 8, 'invited', 91, '', 0, '2023-04-21 12:24:48');
INSERT INTO `pocket_log_coin` VALUES (712, 88, 8, 'invited', 94, '', 0, '2023-04-21 12:24:49');
INSERT INTO `pocket_log_coin` VALUES (713, 107, 20, 'qiandao', 107, '', 0, '2023-04-21 12:26:07');
INSERT INTO `pocket_log_coin` VALUES (714, 88, 8, 'invited', 95, '', 0, '2023-04-21 15:04:44');
INSERT INTO `pocket_log_coin` VALUES (715, 88, 100, 'qiandao', 88, '', 0, '2023-04-22 06:56:47');
INSERT INTO `pocket_log_coin` VALUES (716, 88, 40, 'invited', 88, '', 0, '2023-04-22 06:56:49');
INSERT INTO `pocket_log_coin` VALUES (717, 88, 8, 'invited', 90, '', 0, '2023-04-22 06:56:50');
INSERT INTO `pocket_log_coin` VALUES (718, 88, 8, 'invited', 91, '', 0, '2023-04-22 06:56:50');
INSERT INTO `pocket_log_coin` VALUES (719, 88, 8, 'invited', 94, '', 0, '2023-04-22 06:56:51');
INSERT INTO `pocket_log_coin` VALUES (720, 88, 8, 'invited', 95, '', 0, '2023-04-22 06:56:52');
INSERT INTO `pocket_log_coin` VALUES (721, 114, 20, 'qiandao', 114, '', 0, '2023-04-22 09:41:46');
INSERT INTO `pocket_log_coin` VALUES (722, 115, 20, 'qiandao', 115, '', 0, '2023-04-22 17:49:07');
INSERT INTO `pocket_log_coin` VALUES (723, 114, 20, 'qiandao', 114, '', 0, '2023-04-23 07:07:08');
INSERT INTO `pocket_log_coin` VALUES (724, 86, 100000, 'manual', 86, '', 1, '2023-04-23 10:11:56');
INSERT INTO `pocket_log_coin` VALUES (725, 88, 100, 'qiandao', 88, '', 0, '2023-04-23 10:37:01');
INSERT INTO `pocket_log_coin` VALUES (726, 88, 40, 'invited', 88, '', 0, '2023-04-23 10:37:13');
INSERT INTO `pocket_log_coin` VALUES (727, 88, 8, 'invited', 90, '', 0, '2023-04-23 10:37:13');
INSERT INTO `pocket_log_coin` VALUES (728, 88, 8, 'invited', 91, '', 0, '2023-04-23 10:37:14');
INSERT INTO `pocket_log_coin` VALUES (729, 88, 8, 'invited', 94, '', 0, '2023-04-23 10:37:14');
INSERT INTO `pocket_log_coin` VALUES (730, 88, 8, 'invited', 95, '', 0, '2023-04-23 10:37:15');
INSERT INTO `pocket_log_coin` VALUES (731, 86, 20, 'qiandao', 86, '', 0, '2023-04-23 13:54:23');
INSERT INTO `pocket_log_coin` VALUES (732, 88, 8, 'invited', 97, '', 0, '2023-04-24 01:14:46');
INSERT INTO `pocket_log_coin` VALUES (733, 88, 40, 'invited', 88, '', 0, '2023-04-24 01:14:48');
INSERT INTO `pocket_log_coin` VALUES (734, 88, 8, 'invited', 90, '', 0, '2023-04-24 01:14:49');
INSERT INTO `pocket_log_coin` VALUES (735, 88, 8, 'invited', 91, '', 0, '2023-04-24 01:14:49');
INSERT INTO `pocket_log_coin` VALUES (736, 88, 8, 'invited', 94, '', 0, '2023-04-24 01:14:50');
INSERT INTO `pocket_log_coin` VALUES (737, 88, 100, 'qiandao', 88, '', 0, '2023-04-24 01:15:15');
INSERT INTO `pocket_log_coin` VALUES (738, 60, 8, 'invited', 85, '', 0, '2023-04-24 08:24:25');
INSERT INTO `pocket_log_coin` VALUES (739, 114, 20, 'qiandao', 114, '', 0, '2023-04-24 12:48:00');
INSERT INTO `pocket_log_coin` VALUES (740, 88, 100, 'qiandao', 88, '', 0, '2023-04-25 00:34:47');
INSERT INTO `pocket_log_coin` VALUES (741, 88, 40, 'invited', 88, '', 0, '2023-04-25 00:38:31');
INSERT INTO `pocket_log_coin` VALUES (742, 88, 8, 'invited', 90, '', 0, '2023-04-25 00:38:33');
INSERT INTO `pocket_log_coin` VALUES (743, 88, 8, 'invited', 91, '', 0, '2023-04-25 00:38:34');
INSERT INTO `pocket_log_coin` VALUES (744, 88, 8, 'invited', 94, '', 0, '2023-04-25 00:38:34');
INSERT INTO `pocket_log_coin` VALUES (745, 88, 8, 'invited', 95, '', 0, '2023-04-25 00:38:35');
INSERT INTO `pocket_log_coin` VALUES (746, 114, 20, 'qiandao', 114, '', 0, '2023-04-25 13:10:08');
INSERT INTO `pocket_log_coin` VALUES (747, 88, -220, 'cashjoin', 88, '', 0, '2023-04-25 14:48:17');
INSERT INTO `pocket_log_coin` VALUES (748, 86, -600, 'cashjoin', 86, '', 0, '2023-04-25 14:48:17');
INSERT INTO `pocket_log_coin` VALUES (749, 114, 20, 'qiandao', 114, '', 0, '2023-04-26 14:06:13');
INSERT INTO `pocket_log_coin` VALUES (750, 88, 100, 'qiandao', 88, '', 0, '2023-04-26 20:15:42');
INSERT INTO `pocket_log_coin` VALUES (751, 88, 40, 'invited', 88, '', 0, '2023-04-26 20:15:43');
INSERT INTO `pocket_log_coin` VALUES (752, 88, 8, 'invited', 90, '', 0, '2023-04-26 20:15:44');
INSERT INTO `pocket_log_coin` VALUES (753, 88, 8, 'invited', 91, '', 0, '2023-04-26 20:15:45');
INSERT INTO `pocket_log_coin` VALUES (754, 88, 8, 'invited', 94, '', 0, '2023-04-26 20:15:46');
INSERT INTO `pocket_log_coin` VALUES (755, 88, 8, 'invited', 95, '', 0, '2023-04-26 20:15:47');
INSERT INTO `pocket_log_coin` VALUES (756, 116, 20, 'qiandao', 116, '', 0, '2023-04-26 21:18:51');
INSERT INTO `pocket_log_coin` VALUES (757, 118, 20, 'qiandao', 118, '', 0, '2023-04-27 09:49:56');
INSERT INTO `pocket_log_coin` VALUES (758, 114, 20, 'qiandao', 114, '', 0, '2023-04-27 11:23:42');
INSERT INTO `pocket_log_coin` VALUES (759, 88, 100, 'qiandao', 88, '', 0, '2023-04-27 16:21:56');
INSERT INTO `pocket_log_coin` VALUES (760, 88, 40, 'invited', 88, '', 0, '2023-04-27 16:21:58');
INSERT INTO `pocket_log_coin` VALUES (761, 88, 8, 'invited', 90, '', 0, '2023-04-27 16:22:00');
INSERT INTO `pocket_log_coin` VALUES (762, 88, 8, 'invited', 91, '', 0, '2023-04-27 16:22:00');
INSERT INTO `pocket_log_coin` VALUES (763, 88, 8, 'invited', 94, '', 0, '2023-04-27 16:22:02');
INSERT INTO `pocket_log_coin` VALUES (764, 88, 8, 'invited', 95, '', 0, '2023-04-27 16:22:03');
INSERT INTO `pocket_log_coin` VALUES (765, 88, 100, 'qiandao', 88, '', 0, '2023-04-28 02:25:48');
INSERT INTO `pocket_log_coin` VALUES (766, 88, 40, 'invited', 88, '', 0, '2023-04-28 02:25:50');
INSERT INTO `pocket_log_coin` VALUES (767, 88, 8, 'invited', 90, '', 0, '2023-04-28 02:25:51');
INSERT INTO `pocket_log_coin` VALUES (768, 88, 8, 'invited', 91, '', 0, '2023-04-28 02:25:52');
INSERT INTO `pocket_log_coin` VALUES (769, 88, 8, 'invited', 94, '', 0, '2023-04-28 02:25:53');
INSERT INTO `pocket_log_coin` VALUES (770, 88, 8, 'invited', 95, '', 0, '2023-04-28 02:25:54');
INSERT INTO `pocket_log_coin` VALUES (771, 114, 20, 'qiandao', 114, '', 0, '2023-04-28 11:58:03');
INSERT INTO `pocket_log_coin` VALUES (772, 88, 100, 'qiandao', 88, '', 0, '2023-04-29 00:47:19');
INSERT INTO `pocket_log_coin` VALUES (773, 88, 40, 'invited', 88, '', 0, '2023-04-29 00:47:21');
INSERT INTO `pocket_log_coin` VALUES (774, 88, 8, 'invited', 90, '', 0, '2023-04-29 00:47:23');
INSERT INTO `pocket_log_coin` VALUES (775, 88, 8, 'invited', 91, '', 0, '2023-04-29 00:47:24');
INSERT INTO `pocket_log_coin` VALUES (776, 88, 8, 'invited', 94, '', 0, '2023-04-29 00:47:24');
INSERT INTO `pocket_log_coin` VALUES (777, 88, 8, 'invited', 95, '', 0, '2023-04-29 00:47:26');
INSERT INTO `pocket_log_coin` VALUES (778, 114, 20, 'qiandao', 114, '', 0, '2023-04-29 05:32:42');
INSERT INTO `pocket_log_coin` VALUES (779, 88, 100, 'qiandao', 88, '', 0, '2023-04-30 14:13:24');
INSERT INTO `pocket_log_coin` VALUES (780, 88, 40, 'invited', 88, '', 0, '2023-04-30 14:13:26');
INSERT INTO `pocket_log_coin` VALUES (781, 88, 8, 'invited', 90, '', 0, '2023-04-30 14:13:26');
INSERT INTO `pocket_log_coin` VALUES (782, 88, 8, 'invited', 91, '', 0, '2023-04-30 14:13:27');
INSERT INTO `pocket_log_coin` VALUES (783, 88, 8, 'invited', 94, '', 0, '2023-04-30 14:13:27');
INSERT INTO `pocket_log_coin` VALUES (784, 88, 8, 'invited', 95, '', 0, '2023-04-30 14:13:28');
INSERT INTO `pocket_log_coin` VALUES (785, 88, 100, 'qiandao', 88, '', 0, '2023-05-01 08:49:54');
INSERT INTO `pocket_log_coin` VALUES (786, 88, 40, 'invited', 88, '', 0, '2023-05-01 08:49:58');
INSERT INTO `pocket_log_coin` VALUES (787, 88, 8, 'invited', 90, '', 0, '2023-05-01 08:49:59');
INSERT INTO `pocket_log_coin` VALUES (788, 88, 8, 'invited', 91, '', 0, '2023-05-01 08:49:59');
INSERT INTO `pocket_log_coin` VALUES (789, 88, 8, 'invited', 94, '', 0, '2023-05-01 08:50:00');
INSERT INTO `pocket_log_coin` VALUES (790, 88, 8, 'invited', 95, '', 0, '2023-05-01 08:50:01');
INSERT INTO `pocket_log_coin` VALUES (791, 88, -2500, 'levelup', 88, '', 0, '2023-05-01 08:50:33');
INSERT INTO `pocket_log_coin` VALUES (792, 88, 120, 'qiandao', 88, '', 0, '2023-05-02 01:34:57');
INSERT INTO `pocket_log_coin` VALUES (793, 88, 48, 'invited', 88, '', 0, '2023-05-02 01:35:02');
INSERT INTO `pocket_log_coin` VALUES (794, 88, 8, 'invited', 90, '', 0, '2023-05-02 01:35:14');
INSERT INTO `pocket_log_coin` VALUES (795, 88, 8, 'invited', 91, '', 0, '2023-05-02 01:35:15');
INSERT INTO `pocket_log_coin` VALUES (796, 88, 8, 'invited', 94, '', 0, '2023-05-02 01:35:17');
INSERT INTO `pocket_log_coin` VALUES (797, 88, 8, 'invited', 95, '', 0, '2023-05-02 01:35:18');
INSERT INTO `pocket_log_coin` VALUES (798, 114, 20, 'qiandao', 114, '', 0, '2023-05-03 15:05:50');
INSERT INTO `pocket_log_coin` VALUES (799, 88, 120, 'qiandao', 88, '', 0, '2023-05-03 18:09:57');
INSERT INTO `pocket_log_coin` VALUES (800, 88, 48, 'invited', 88, '', 0, '2023-05-03 18:10:00');
INSERT INTO `pocket_log_coin` VALUES (801, 88, 8, 'invited', 90, '', 0, '2023-05-03 18:10:01');
INSERT INTO `pocket_log_coin` VALUES (802, 88, 8, 'invited', 91, '', 0, '2023-05-03 18:10:02');
INSERT INTO `pocket_log_coin` VALUES (803, 88, 8, 'invited', 94, '', 0, '2023-05-03 18:10:02');
INSERT INTO `pocket_log_coin` VALUES (804, 88, 8, 'invited', 95, '', 0, '2023-05-03 18:10:03');
INSERT INTO `pocket_log_coin` VALUES (805, 88, 120, 'qiandao', 88, '', 0, '2023-05-04 00:48:34');
INSERT INTO `pocket_log_coin` VALUES (806, 88, 48, 'invited', 88, '', 0, '2023-05-04 00:48:38');
INSERT INTO `pocket_log_coin` VALUES (807, 88, 8, 'invited', 90, '', 0, '2023-05-04 00:48:39');
INSERT INTO `pocket_log_coin` VALUES (808, 88, 8, 'invited', 91, '', 0, '2023-05-04 00:48:40');
INSERT INTO `pocket_log_coin` VALUES (809, 88, 8, 'invited', 94, '', 0, '2023-05-04 00:48:40');
INSERT INTO `pocket_log_coin` VALUES (810, 88, 8, 'invited', 95, '', 0, '2023-05-04 00:48:42');
INSERT INTO `pocket_log_coin` VALUES (811, 114, 20, 'qiandao', 114, '', 0, '2023-05-05 01:40:12');
INSERT INTO `pocket_log_coin` VALUES (812, 88, 120, 'qiandao', 88, '', 0, '2023-05-05 06:31:50');
INSERT INTO `pocket_log_coin` VALUES (813, 88, 48, 'invited', 88, '', 0, '2023-05-05 06:31:53');
INSERT INTO `pocket_log_coin` VALUES (814, 88, 8, 'invited', 90, '', 0, '2023-05-05 06:31:53');
INSERT INTO `pocket_log_coin` VALUES (815, 88, 8, 'invited', 91, '', 0, '2023-05-05 06:31:54');
INSERT INTO `pocket_log_coin` VALUES (816, 88, 8, 'invited', 94, '', 0, '2023-05-05 06:31:54');
INSERT INTO `pocket_log_coin` VALUES (817, 88, 8, 'invited', 95, '', 0, '2023-05-05 06:31:56');
INSERT INTO `pocket_log_coin` VALUES (818, 86, 20, 'qiandao', 86, '', 0, '2023-05-05 12:59:10');
INSERT INTO `pocket_log_coin` VALUES (819, 88, 120, 'qiandao', 88, '', 0, '2023-05-06 10:10:58');
INSERT INTO `pocket_log_coin` VALUES (820, 88, 48, 'invited', 88, '', 0, '2023-05-06 10:10:59');
INSERT INTO `pocket_log_coin` VALUES (821, 88, 8, 'invited', 90, '', 0, '2023-05-06 10:11:00');
INSERT INTO `pocket_log_coin` VALUES (822, 88, 8, 'invited', 91, '', 0, '2023-05-06 10:11:01');
INSERT INTO `pocket_log_coin` VALUES (823, 88, 8, 'invited', 94, '', 0, '2023-05-06 10:11:02');
INSERT INTO `pocket_log_coin` VALUES (824, 88, 8, 'invited', 95, '', 0, '2023-05-06 10:11:02');
INSERT INTO `pocket_log_coin` VALUES (825, 88, 120, 'qiandao', 88, '', 0, '2023-05-07 03:34:19');
INSERT INTO `pocket_log_coin` VALUES (826, 88, 48, 'invited', 88, '', 0, '2023-05-07 03:34:22');
INSERT INTO `pocket_log_coin` VALUES (827, 88, 8, 'invited', 90, '', 0, '2023-05-07 03:34:22');
INSERT INTO `pocket_log_coin` VALUES (828, 88, 8, 'invited', 91, '', 0, '2023-05-07 03:34:23');
INSERT INTO `pocket_log_coin` VALUES (829, 88, 8, 'invited', 94, '', 0, '2023-05-07 03:34:24');
INSERT INTO `pocket_log_coin` VALUES (830, 88, 8, 'invited', 95, '', 0, '2023-05-07 03:34:25');
INSERT INTO `pocket_log_coin` VALUES (831, 114, 20, 'qiandao', 114, '', 0, '2023-05-07 06:35:29');
INSERT INTO `pocket_log_coin` VALUES (832, 88, 120, 'qiandao', 88, '', 0, '2023-05-08 01:39:51');
INSERT INTO `pocket_log_coin` VALUES (833, 88, 48, 'invited', 88, '', 0, '2023-05-08 01:39:54');
INSERT INTO `pocket_log_coin` VALUES (834, 88, 8, 'invited', 90, '', 0, '2023-05-08 01:39:57');
INSERT INTO `pocket_log_coin` VALUES (835, 88, 8, 'invited', 91, '', 0, '2023-05-08 01:39:58');
INSERT INTO `pocket_log_coin` VALUES (836, 88, 8, 'invited', 94, '', 0, '2023-05-08 01:39:58');
INSERT INTO `pocket_log_coin` VALUES (837, 88, 8, 'invited', 95, '', 0, '2023-05-08 01:40:00');
INSERT INTO `pocket_log_coin` VALUES (838, 114, 20, 'qiandao', 114, '', 0, '2023-05-08 15:28:22');
INSERT INTO `pocket_log_coin` VALUES (839, 88, 120, 'qiandao', 88, '', 0, '2023-05-09 07:20:19');
INSERT INTO `pocket_log_coin` VALUES (840, 88, 48, 'invited', 88, '', 0, '2023-05-09 07:20:21');
INSERT INTO `pocket_log_coin` VALUES (841, 88, 8, 'invited', 90, '', 0, '2023-05-09 07:20:22');
INSERT INTO `pocket_log_coin` VALUES (842, 88, 8, 'invited', 91, '', 0, '2023-05-09 07:20:23');
INSERT INTO `pocket_log_coin` VALUES (843, 88, 8, 'invited', 94, '', 0, '2023-05-09 07:20:24');
INSERT INTO `pocket_log_coin` VALUES (844, 88, 8, 'invited', 95, '', 0, '2023-05-09 07:20:25');
INSERT INTO `pocket_log_coin` VALUES (845, 114, 20, 'qiandao', 114, '', 0, '2023-05-10 07:02:37');
INSERT INTO `pocket_log_coin` VALUES (846, 88, 120, 'qiandao', 88, '', 0, '2023-05-10 09:40:13');
INSERT INTO `pocket_log_coin` VALUES (847, 88, 48, 'invited', 88, '', 0, '2023-05-10 09:40:15');
INSERT INTO `pocket_log_coin` VALUES (848, 88, 8, 'invited', 90, '', 0, '2023-05-10 09:40:15');
INSERT INTO `pocket_log_coin` VALUES (849, 88, 8, 'invited', 91, '', 0, '2023-05-10 09:40:16');
INSERT INTO `pocket_log_coin` VALUES (850, 88, 8, 'invited', 94, '', 0, '2023-05-10 09:40:17');
INSERT INTO `pocket_log_coin` VALUES (851, 88, 8, 'invited', 95, '', 0, '2023-05-10 09:40:18');
INSERT INTO `pocket_log_coin` VALUES (852, 88, 120, 'qiandao', 88, '', 0, '2023-05-11 00:35:46');
INSERT INTO `pocket_log_coin` VALUES (853, 88, 48, 'invited', 88, '', 0, '2023-05-11 00:35:48');
INSERT INTO `pocket_log_coin` VALUES (854, 88, 8, 'invited', 90, '', 0, '2023-05-11 00:35:49');
INSERT INTO `pocket_log_coin` VALUES (855, 88, 8, 'invited', 91, '', 0, '2023-05-11 00:35:49');
INSERT INTO `pocket_log_coin` VALUES (856, 88, 8, 'invited', 94, '', 0, '2023-05-11 00:35:50');
INSERT INTO `pocket_log_coin` VALUES (857, 88, 8, 'invited', 95, '', 0, '2023-05-11 00:35:51');
INSERT INTO `pocket_log_coin` VALUES (858, 86, 20, 'qiandao', 86, '', 0, '2023-05-11 09:52:46');
INSERT INTO `pocket_log_coin` VALUES (859, 88, 120, 'qiandao', 88, '', 0, '2023-05-12 11:58:03');
INSERT INTO `pocket_log_coin` VALUES (860, 88, 48, 'invited', 88, '', 0, '2023-05-12 11:58:11');
INSERT INTO `pocket_log_coin` VALUES (861, 88, 8, 'invited', 90, '', 0, '2023-05-12 11:58:12');
INSERT INTO `pocket_log_coin` VALUES (862, 88, 8, 'invited', 91, '', 0, '2023-05-12 11:58:12');
INSERT INTO `pocket_log_coin` VALUES (863, 88, 8, 'invited', 94, '', 0, '2023-05-12 11:58:13');
INSERT INTO `pocket_log_coin` VALUES (864, 88, 8, 'invited', 95, '', 0, '2023-05-12 11:58:15');
INSERT INTO `pocket_log_coin` VALUES (865, 88, 120, 'qiandao', 88, '', 0, '2023-05-13 09:54:29');
INSERT INTO `pocket_log_coin` VALUES (866, 88, 48, 'invited', 88, '', 0, '2023-05-13 09:54:32');
INSERT INTO `pocket_log_coin` VALUES (867, 88, 8, 'invited', 90, '', 0, '2023-05-13 09:54:41');
INSERT INTO `pocket_log_coin` VALUES (868, 88, 8, 'invited', 91, '', 0, '2023-05-13 09:54:41');
INSERT INTO `pocket_log_coin` VALUES (869, 88, 8, 'invited', 94, '', 0, '2023-05-13 09:54:43');
INSERT INTO `pocket_log_coin` VALUES (870, 88, 8, 'invited', 95, '', 0, '2023-05-13 09:54:44');
INSERT INTO `pocket_log_coin` VALUES (871, 88, 120, 'qiandao', 88, '', 0, '2023-05-14 00:59:52');
INSERT INTO `pocket_log_coin` VALUES (872, 88, 48, 'invited', 88, '', 0, '2023-05-14 00:59:55');
INSERT INTO `pocket_log_coin` VALUES (873, 88, 8, 'invited', 90, '', 0, '2023-05-14 00:59:56');
INSERT INTO `pocket_log_coin` VALUES (874, 88, 8, 'invited', 91, '', 0, '2023-05-14 00:59:56');
INSERT INTO `pocket_log_coin` VALUES (875, 88, 8, 'invited', 94, '', 0, '2023-05-14 00:59:57');
INSERT INTO `pocket_log_coin` VALUES (876, 88, 8, 'invited', 95, '', 0, '2023-05-14 00:59:58');
INSERT INTO `pocket_log_coin` VALUES (877, 88, 120, 'qiandao', 88, '', 0, '2023-05-15 09:41:29');
INSERT INTO `pocket_log_coin` VALUES (878, 88, 48, 'invited', 88, '', 0, '2023-05-15 09:41:32');
INSERT INTO `pocket_log_coin` VALUES (879, 88, 8, 'invited', 90, '', 0, '2023-05-15 09:41:34');
INSERT INTO `pocket_log_coin` VALUES (880, 88, 8, 'invited', 91, '', 0, '2023-05-15 09:41:35');
INSERT INTO `pocket_log_coin` VALUES (881, 88, 8, 'invited', 94, '', 0, '2023-05-15 09:41:35');
INSERT INTO `pocket_log_coin` VALUES (882, 88, 8, 'invited', 95, '', 0, '2023-05-15 09:41:37');
INSERT INTO `pocket_log_coin` VALUES (883, 88, 120, 'qiandao', 88, '', 0, '2023-05-17 14:47:48');
INSERT INTO `pocket_log_coin` VALUES (884, 88, 48, 'invited', 88, '', 0, '2023-05-17 14:47:50');
INSERT INTO `pocket_log_coin` VALUES (885, 88, 8, 'invited', 90, '', 0, '2023-05-17 14:47:50');
INSERT INTO `pocket_log_coin` VALUES (886, 88, 8, 'invited', 91, '', 0, '2023-05-17 14:47:51');
INSERT INTO `pocket_log_coin` VALUES (887, 88, 8, 'invited', 94, '', 0, '2023-05-17 14:47:51');
INSERT INTO `pocket_log_coin` VALUES (888, 88, 8, 'invited', 95, '', 0, '2023-05-17 14:47:52');
INSERT INTO `pocket_log_coin` VALUES (889, 88, 120, 'qiandao', 88, '', 0, '2023-05-18 10:26:07');
INSERT INTO `pocket_log_coin` VALUES (890, 88, 48, 'invited', 88, '', 0, '2023-05-18 10:26:08');
INSERT INTO `pocket_log_coin` VALUES (891, 88, 8, 'invited', 117, '', 0, '2023-05-18 10:26:08');
INSERT INTO `pocket_log_coin` VALUES (892, 88, 8, 'invited', 118, '', 0, '2023-05-18 10:26:10');
INSERT INTO `pocket_log_coin` VALUES (893, 86, 20, 'qiandao', 86, '', 0, '2023-05-18 10:52:27');
INSERT INTO `pocket_log_coin` VALUES (894, 88, 10, 'recharge', 88, '', 0, '2023-05-18 13:44:14');
INSERT INTO `pocket_log_coin` VALUES (895, 88, 120, 'qiandao', 88, '', 0, '2023-05-20 16:09:09');
INSERT INTO `pocket_log_coin` VALUES (896, 88, 48, 'invited', 88, '', 0, '2023-05-20 16:09:11');
INSERT INTO `pocket_log_coin` VALUES (897, 88, 8, 'invited', 117, '', 0, '2023-05-20 16:09:11');
INSERT INTO `pocket_log_coin` VALUES (898, 88, 8, 'invited', 118, '', 0, '2023-05-20 16:09:11');
INSERT INTO `pocket_log_coin` VALUES (899, 88, 120, 'qiandao', 88, '', 0, '2023-05-22 12:29:56');
INSERT INTO `pocket_log_coin` VALUES (900, 88, 48, 'invited', 88, '', 0, '2023-05-22 12:29:57');
INSERT INTO `pocket_log_coin` VALUES (901, 88, 8, 'invited', 117, '', 0, '2023-05-22 12:29:58');
INSERT INTO `pocket_log_coin` VALUES (902, 88, 8, 'invited', 118, '', 0, '2023-05-22 12:29:58');
INSERT INTO `pocket_log_coin` VALUES (903, 114, 20, 'qiandao', 114, '', 0, '2023-05-22 13:36:53');
INSERT INTO `pocket_log_coin` VALUES (904, 86, 20, 'qiandao', 86, '', 0, '2023-05-22 15:41:56');
INSERT INTO `pocket_log_coin` VALUES (905, 88, 10, 'recharge', 88, '', 0, '2023-05-22 18:17:29');
INSERT INTO `pocket_log_coin` VALUES (906, 86, -10, 'cashjoin', 86, '', 0, '2023-05-22 21:59:01');
INSERT INTO `pocket_log_coin` VALUES (907, 88, -11, 'cashjoin', 88, '', 0, '2023-05-22 21:59:01');
INSERT INTO `pocket_log_coin` VALUES (908, 88, -11, 'cashjoin', 88, '', 0, '2023-05-22 21:59:01');
INSERT INTO `pocket_log_coin` VALUES (909, 88, 120, 'qiandao', 88, '', 0, '2023-05-23 09:03:17');
INSERT INTO `pocket_log_coin` VALUES (910, 88, 48, 'invited', 88, '', 0, '2023-05-23 09:03:24');
INSERT INTO `pocket_log_coin` VALUES (911, 88, 8, 'invited', 117, '', 0, '2023-05-23 09:03:25');
INSERT INTO `pocket_log_coin` VALUES (912, 88, 8, 'invited', 118, '', 0, '2023-05-23 09:03:27');
INSERT INTO `pocket_log_coin` VALUES (913, 88, 120, 'qiandao', 88, '', 0, '2023-05-24 08:51:13');
INSERT INTO `pocket_log_coin` VALUES (914, 88, 48, 'invited', 88, '', 0, '2023-05-24 08:51:15');
INSERT INTO `pocket_log_coin` VALUES (915, 88, 8, 'invited', 117, '', 0, '2023-05-24 08:51:16');
INSERT INTO `pocket_log_coin` VALUES (916, 88, 8, 'invited', 118, '', 0, '2023-05-24 08:51:17');
INSERT INTO `pocket_log_coin` VALUES (917, 88, 120, 'qiandao', 88, '', 0, '2023-05-25 15:10:41');
INSERT INTO `pocket_log_coin` VALUES (918, 88, 48, 'invited', 88, '', 0, '2023-05-25 15:10:42');
INSERT INTO `pocket_log_coin` VALUES (919, 88, 8, 'invited', 117, '', 0, '2023-05-25 15:10:43');
INSERT INTO `pocket_log_coin` VALUES (920, 88, 8, 'invited', 118, '', 0, '2023-05-25 15:10:43');
INSERT INTO `pocket_log_coin` VALUES (921, 88, 120, 'qiandao', 88, '', 0, '2023-05-26 20:15:26');
INSERT INTO `pocket_log_coin` VALUES (922, 88, 48, 'invited', 88, '', 0, '2023-05-26 20:15:28');
INSERT INTO `pocket_log_coin` VALUES (923, 88, 8, 'invited', 117, '', 0, '2023-05-26 20:15:28');
INSERT INTO `pocket_log_coin` VALUES (924, 88, 8, 'invited', 118, '', 0, '2023-05-26 20:15:29');
INSERT INTO `pocket_log_coin` VALUES (925, 88, 120, 'qiandao', 88, '', 0, '2023-05-27 06:10:57');
INSERT INTO `pocket_log_coin` VALUES (926, 88, 48, 'invited', 88, '', 0, '2023-05-27 06:10:59');
INSERT INTO `pocket_log_coin` VALUES (927, 88, 8, 'invited', 117, '', 0, '2023-05-27 06:10:59');
INSERT INTO `pocket_log_coin` VALUES (928, 88, 8, 'invited', 118, '', 0, '2023-05-27 06:10:59');
INSERT INTO `pocket_log_coin` VALUES (929, 88, 120, 'qiandao', 88, '', 0, '2023-05-28 18:37:04');
INSERT INTO `pocket_log_coin` VALUES (930, 88, 48, 'invited', 88, '', 0, '2023-05-28 18:37:05');
INSERT INTO `pocket_log_coin` VALUES (931, 88, 8, 'invited', 117, '', 0, '2023-05-28 18:37:06');
INSERT INTO `pocket_log_coin` VALUES (932, 88, 8, 'invited', 118, '', 0, '2023-05-28 18:37:07');
INSERT INTO `pocket_log_coin` VALUES (933, 114, 20, 'qiandao', 114, '', 0, '2023-05-29 09:41:48');
INSERT INTO `pocket_log_coin` VALUES (934, 122, 20, 'qiandao', 122, '', 0, '2023-05-30 08:32:20');
INSERT INTO `pocket_log_coin` VALUES (935, 88, 120, 'qiandao', 88, '', 0, '2023-05-30 18:37:55');
INSERT INTO `pocket_log_coin` VALUES (936, 88, 48, 'invited', 88, '', 0, '2023-05-30 18:37:56');
INSERT INTO `pocket_log_coin` VALUES (937, 88, 8, 'invited', 117, '', 0, '2023-05-30 18:37:57');
INSERT INTO `pocket_log_coin` VALUES (938, 88, 8, 'invited', 118, '', 0, '2023-05-30 18:37:57');
INSERT INTO `pocket_log_coin` VALUES (939, 88, 120, 'qiandao', 88, '', 0, '2023-06-01 22:57:34');
INSERT INTO `pocket_log_coin` VALUES (940, 88, 48, 'invited', 88, '', 0, '2023-06-01 22:57:36');
INSERT INTO `pocket_log_coin` VALUES (941, 88, 8, 'invited', 117, '', 0, '2023-06-01 22:57:36');
INSERT INTO `pocket_log_coin` VALUES (942, 88, 8, 'invited', 118, '', 0, '2023-06-01 22:57:36');
INSERT INTO `pocket_log_coin` VALUES (943, 88, 120, 'qiandao', 88, '', 0, '2023-06-02 15:05:21');
INSERT INTO `pocket_log_coin` VALUES (944, 88, 48, 'invited', 88, '', 0, '2023-06-02 15:05:23');
INSERT INTO `pocket_log_coin` VALUES (945, 88, 8, 'invited', 117, '', 0, '2023-06-02 15:05:23');
INSERT INTO `pocket_log_coin` VALUES (946, 88, 8, 'invited', 118, '', 0, '2023-06-02 15:05:23');
INSERT INTO `pocket_log_coin` VALUES (947, 88, 120, 'qiandao', 88, '', 0, '2023-06-03 21:01:57');
INSERT INTO `pocket_log_coin` VALUES (948, 88, 48, 'invited', 88, '', 0, '2023-06-03 21:01:58');
INSERT INTO `pocket_log_coin` VALUES (949, 88, 8, 'invited', 117, '', 0, '2023-06-03 21:01:59');
INSERT INTO `pocket_log_coin` VALUES (950, 88, 8, 'invited', 118, '', 0, '2023-06-03 21:01:59');
INSERT INTO `pocket_log_coin` VALUES (951, 86, 20, 'qiandao', 86, '', 0, '2023-06-03 21:30:52');
INSERT INTO `pocket_log_coin` VALUES (952, 88, 120, 'qiandao', 88, '', 0, '2023-06-04 16:33:56');
INSERT INTO `pocket_log_coin` VALUES (953, 88, 48, 'invited', 88, '', 0, '2023-06-04 16:33:57');
INSERT INTO `pocket_log_coin` VALUES (954, 88, 8, 'invited', 117, '', 0, '2023-06-04 16:33:58');
INSERT INTO `pocket_log_coin` VALUES (955, 88, 8, 'invited', 118, '', 0, '2023-06-04 16:33:58');
INSERT INTO `pocket_log_coin` VALUES (956, 88, 120, 'qiandao', 88, '', 0, '2023-06-05 15:35:38');
INSERT INTO `pocket_log_coin` VALUES (957, 88, 48, 'invited', 88, '', 0, '2023-06-05 15:35:39');
INSERT INTO `pocket_log_coin` VALUES (958, 88, 8, 'invited', 117, '', 0, '2023-06-05 15:35:40');
INSERT INTO `pocket_log_coin` VALUES (959, 88, 8, 'invited', 118, '', 0, '2023-06-05 15:35:41');
INSERT INTO `pocket_log_coin` VALUES (960, 88, 120, 'qiandao', 88, '', 0, '2023-06-06 03:00:00');
INSERT INTO `pocket_log_coin` VALUES (961, 88, 48, 'invited', 88, '', 0, '2023-06-06 03:00:01');
INSERT INTO `pocket_log_coin` VALUES (962, 88, 8, 'invited', 117, '', 0, '2023-06-06 03:00:01');
INSERT INTO `pocket_log_coin` VALUES (963, 88, 8, 'invited', 118, '', 0, '2023-06-06 03:00:02');
INSERT INTO `pocket_log_coin` VALUES (964, 88, 120, 'qiandao', 88, '', 0, '2023-06-07 13:35:01');
INSERT INTO `pocket_log_coin` VALUES (965, 88, 48, 'invited', 88, '', 0, '2023-06-07 13:35:03');
INSERT INTO `pocket_log_coin` VALUES (966, 88, 8, 'invited', 117, '', 0, '2023-06-07 13:35:03');
INSERT INTO `pocket_log_coin` VALUES (967, 88, 8, 'invited', 118, '', 0, '2023-06-07 13:35:03');
INSERT INTO `pocket_log_coin` VALUES (968, 88, 120, 'qiandao', 88, '', 0, '2023-06-08 19:59:09');
INSERT INTO `pocket_log_coin` VALUES (969, 88, 48, 'invited', 88, '', 0, '2023-06-08 19:59:10');
INSERT INTO `pocket_log_coin` VALUES (970, 88, 8, 'invited', 117, '', 0, '2023-06-08 19:59:11');
INSERT INTO `pocket_log_coin` VALUES (971, 88, 8, 'invited', 118, '', 0, '2023-06-08 19:59:12');
INSERT INTO `pocket_log_coin` VALUES (972, 88, 120, 'qiandao', 88, '', 0, '2023-06-09 23:42:24');
INSERT INTO `pocket_log_coin` VALUES (973, 88, 48, 'invited', 88, '', 0, '2023-06-09 23:42:25');
INSERT INTO `pocket_log_coin` VALUES (974, 88, 8, 'invited', 117, '', 0, '2023-06-09 23:42:25');
INSERT INTO `pocket_log_coin` VALUES (975, 88, 8, 'invited', 118, '', 0, '2023-06-09 23:42:26');
INSERT INTO `pocket_log_coin` VALUES (976, 88, 120, 'qiandao', 88, '', 0, '2023-06-10 00:48:10');
INSERT INTO `pocket_log_coin` VALUES (977, 88, 48, 'invited', 88, '', 0, '2023-06-10 00:48:11');
INSERT INTO `pocket_log_coin` VALUES (978, 88, 8, 'invited', 117, '', 0, '2023-06-10 00:48:11');
INSERT INTO `pocket_log_coin` VALUES (979, 88, 8, 'invited', 118, '', 0, '2023-06-10 00:48:12');
INSERT INTO `pocket_log_coin` VALUES (980, 88, -3600, 'levelup', 88, '', 0, '2023-06-10 00:48:16');
INSERT INTO `pocket_log_coin` VALUES (981, 114, 20, 'qiandao', 114, '', 0, '2023-06-10 12:48:26');
INSERT INTO `pocket_log_coin` VALUES (982, 114, 20, 'qiandao', 114, '', 0, '2023-06-12 09:15:10');
INSERT INTO `pocket_log_coin` VALUES (983, 114, 20, 'qiandao', 114, '', 0, '2023-06-13 00:12:51');
INSERT INTO `pocket_log_coin` VALUES (984, 88, 140, 'qiandao', 88, '', 0, '2023-06-13 16:20:19');
INSERT INTO `pocket_log_coin` VALUES (985, 88, 56, 'invited', 88, '', 0, '2023-06-13 16:20:22');
INSERT INTO `pocket_log_coin` VALUES (986, 88, 8, 'invited', 117, '', 0, '2023-06-13 16:20:24');
INSERT INTO `pocket_log_coin` VALUES (987, 88, 8, 'invited', 118, '', 0, '2023-06-13 16:20:25');
INSERT INTO `pocket_log_coin` VALUES (988, 88, 140, 'qiandao', 88, '', 0, '2023-06-14 08:20:51');
INSERT INTO `pocket_log_coin` VALUES (989, 88, 56, 'invited', 88, '', 0, '2023-06-14 08:21:03');
INSERT INTO `pocket_log_coin` VALUES (990, 88, 8, 'invited', 117, '', 0, '2023-06-14 08:21:14');
INSERT INTO `pocket_log_coin` VALUES (991, 88, 8, 'invited', 118, '', 0, '2023-06-14 08:21:15');
INSERT INTO `pocket_log_coin` VALUES (992, 88, 140, 'qiandao', 88, '', 0, '2023-06-15 12:03:30');
INSERT INTO `pocket_log_coin` VALUES (993, 88, 56, 'invited', 88, '', 0, '2023-06-15 12:03:32');
INSERT INTO `pocket_log_coin` VALUES (994, 88, 8, 'invited', 117, '', 0, '2023-06-15 12:03:32');
INSERT INTO `pocket_log_coin` VALUES (995, 88, 8, 'invited', 118, '', 0, '2023-06-15 12:03:32');
INSERT INTO `pocket_log_coin` VALUES (996, 88, 140, 'qiandao', 88, '', 0, '2023-06-16 11:50:38');
INSERT INTO `pocket_log_coin` VALUES (997, 88, 56, 'invited', 88, '', 0, '2023-06-16 11:50:40');
INSERT INTO `pocket_log_coin` VALUES (998, 88, 8, 'invited', 117, '', 0, '2023-06-16 11:50:40');
INSERT INTO `pocket_log_coin` VALUES (999, 88, 8, 'invited', 118, '', 0, '2023-06-16 11:50:40');
INSERT INTO `pocket_log_coin` VALUES (1000, 114, 20, 'qiandao', 114, '', 0, '2023-06-17 08:42:22');
INSERT INTO `pocket_log_coin` VALUES (1001, 114, 20, 'qiandao', 114, '', 0, '2023-06-25 10:28:52');
INSERT INTO `pocket_log_coin` VALUES (1002, 88, 140, 'qiandao', 88, '', 0, '2023-06-26 15:12:19');
INSERT INTO `pocket_log_coin` VALUES (1003, 88, 56, 'invited', 88, '', 0, '2023-06-26 15:12:21');
INSERT INTO `pocket_log_coin` VALUES (1004, 88, 8, 'invited', 117, '', 0, '2023-06-26 15:12:22');
INSERT INTO `pocket_log_coin` VALUES (1005, 88, 8, 'invited', 118, '', 0, '2023-06-26 15:12:22');
INSERT INTO `pocket_log_coin` VALUES (1006, 88, 140, 'qiandao', 88, '', 0, '2023-07-03 11:23:21');
INSERT INTO `pocket_log_coin` VALUES (1007, 88, 56, 'invited', 88, '', 0, '2023-07-03 11:23:24');
INSERT INTO `pocket_log_coin` VALUES (1008, 88, 8, 'invited', 117, '', 0, '2023-07-03 11:23:25');
INSERT INTO `pocket_log_coin` VALUES (1009, 88, 8, 'invited', 118, '', 0, '2023-07-03 11:23:26');
INSERT INTO `pocket_log_coin` VALUES (1010, 88, 140, 'qiandao', 88, '', 0, '2023-07-06 08:34:05');
INSERT INTO `pocket_log_coin` VALUES (1011, 88, 56, 'invited', 88, '', 0, '2023-07-06 08:34:07');
INSERT INTO `pocket_log_coin` VALUES (1012, 88, 8, 'invited', 117, '', 0, '2023-07-06 08:34:07');
INSERT INTO `pocket_log_coin` VALUES (1013, 88, 8, 'invited', 118, '', 0, '2023-07-06 08:34:08');
INSERT INTO `pocket_log_coin` VALUES (1014, 114, 20, 'qiandao', 114, '', 0, '2023-07-07 15:07:14');
INSERT INTO `pocket_log_coin` VALUES (1015, 121, 20, 'qiandao', 121, '', 0, '2023-07-07 18:12:31');
INSERT INTO `pocket_log_coin` VALUES (1016, 88, 140, 'qiandao', 88, '', 0, '2023-07-08 09:40:03');
INSERT INTO `pocket_log_coin` VALUES (1017, 88, 56, 'invited', 88, '', 0, '2023-07-08 09:40:05');
INSERT INTO `pocket_log_coin` VALUES (1018, 88, 8, 'invited', 117, '', 0, '2023-07-08 09:40:06');
INSERT INTO `pocket_log_coin` VALUES (1019, 88, 8, 'invited', 118, '', 0, '2023-07-08 09:40:06');
INSERT INTO `pocket_log_coin` VALUES (1020, 88, 140, 'qiandao', 88, '', 0, '2023-07-09 14:23:58');
INSERT INTO `pocket_log_coin` VALUES (1021, 88, 56, 'invited', 88, '', 0, '2023-07-09 14:23:59');
INSERT INTO `pocket_log_coin` VALUES (1022, 88, 8, 'invited', 117, '', 0, '2023-07-09 14:24:00');
INSERT INTO `pocket_log_coin` VALUES (1023, 88, 8, 'invited', 118, '', 0, '2023-07-09 14:24:00');
INSERT INTO `pocket_log_coin` VALUES (1024, 88, 140, 'qiandao', 88, '', 0, '2023-07-10 09:34:47');
INSERT INTO `pocket_log_coin` VALUES (1025, 88, 56, 'invited', 88, '', 0, '2023-07-10 09:34:48');
INSERT INTO `pocket_log_coin` VALUES (1026, 88, 8, 'invited', 117, '', 0, '2023-07-10 09:34:49');
INSERT INTO `pocket_log_coin` VALUES (1027, 88, 8, 'invited', 118, '', 0, '2023-07-10 09:34:49');
INSERT INTO `pocket_log_coin` VALUES (1028, 88, 140, 'qiandao', 88, '', 0, '2023-07-11 17:39:00');
INSERT INTO `pocket_log_coin` VALUES (1029, 88, 56, 'invited', 88, '', 0, '2023-07-11 17:39:01');
INSERT INTO `pocket_log_coin` VALUES (1030, 88, 8, 'invited', 117, '', 0, '2023-07-11 17:39:01');
INSERT INTO `pocket_log_coin` VALUES (1031, 88, 8, 'invited', 118, '', 0, '2023-07-11 17:39:01');
INSERT INTO `pocket_log_coin` VALUES (1032, 88, 140, 'qiandao', 88, '', 0, '2023-07-13 20:36:25');
INSERT INTO `pocket_log_coin` VALUES (1033, 88, 56, 'invited', 88, '', 0, '2023-07-13 20:36:26');
INSERT INTO `pocket_log_coin` VALUES (1034, 88, 8, 'invited', 117, '', 0, '2023-07-13 20:36:27');
INSERT INTO `pocket_log_coin` VALUES (1035, 88, 8, 'invited', 118, '', 0, '2023-07-13 20:36:27');
INSERT INTO `pocket_log_coin` VALUES (1036, 88, 140, 'qiandao', 88, '', 0, '2023-07-14 14:48:33');
INSERT INTO `pocket_log_coin` VALUES (1037, 88, 56, 'invited', 88, '', 0, '2023-07-14 14:48:34');
INSERT INTO `pocket_log_coin` VALUES (1038, 88, 8, 'invited', 117, '', 0, '2023-07-14 14:48:34');
INSERT INTO `pocket_log_coin` VALUES (1039, 88, 8, 'invited', 118, '', 0, '2023-07-14 14:48:34');
INSERT INTO `pocket_log_coin` VALUES (1040, 88, 140, 'qiandao', 88, '', 0, '2023-07-17 23:24:12');
INSERT INTO `pocket_log_coin` VALUES (1041, 88, 56, 'invited', 88, '', 0, '2023-07-17 23:24:13');
INSERT INTO `pocket_log_coin` VALUES (1042, 88, 8, 'invited', 117, '', 0, '2023-07-17 23:24:13');
INSERT INTO `pocket_log_coin` VALUES (1043, 88, 8, 'invited', 118, '', 0, '2023-07-17 23:24:14');
INSERT INTO `pocket_log_coin` VALUES (1044, 88, 140, 'qiandao', 88, '', 0, '2023-07-18 17:07:29');
INSERT INTO `pocket_log_coin` VALUES (1045, 88, 56, 'invited', 88, '', 0, '2023-07-18 17:07:31');
INSERT INTO `pocket_log_coin` VALUES (1046, 88, 8, 'invited', 117, '', 0, '2023-07-18 17:07:31');
INSERT INTO `pocket_log_coin` VALUES (1047, 88, 8, 'invited', 118, '', 0, '2023-07-18 17:07:32');
INSERT INTO `pocket_log_coin` VALUES (1048, 88, 140, 'qiandao', 88, '', 0, '2023-07-20 00:40:16');
INSERT INTO `pocket_log_coin` VALUES (1049, 88, 56, 'invited', 88, '', 0, '2023-07-20 00:40:17');
INSERT INTO `pocket_log_coin` VALUES (1050, 88, 8, 'invited', 117, '', 0, '2023-07-20 00:40:17');
INSERT INTO `pocket_log_coin` VALUES (1051, 88, 8, 'invited', 118, '', 0, '2023-07-20 00:40:18');
INSERT INTO `pocket_log_coin` VALUES (1052, 88, 140, 'qiandao', 88, '', 0, '2023-07-22 14:14:02');
INSERT INTO `pocket_log_coin` VALUES (1053, 88, 56, 'invited', 88, '', 0, '2023-07-22 14:14:03');
INSERT INTO `pocket_log_coin` VALUES (1054, 88, 8, 'invited', 117, '', 0, '2023-07-22 14:14:03');
INSERT INTO `pocket_log_coin` VALUES (1055, 88, 8, 'invited', 118, '', 0, '2023-07-22 14:14:03');
INSERT INTO `pocket_log_coin` VALUES (1056, 88, 140, 'qiandao', 88, '', 0, '2023-07-23 00:36:54');
INSERT INTO `pocket_log_coin` VALUES (1057, 88, 56, 'invited', 88, '', 0, '2023-07-23 00:36:55');
INSERT INTO `pocket_log_coin` VALUES (1058, 88, 8, 'invited', 117, '', 0, '2023-07-23 00:36:55');
INSERT INTO `pocket_log_coin` VALUES (1059, 88, 8, 'invited', 118, '', 0, '2023-07-23 00:36:56');
INSERT INTO `pocket_log_coin` VALUES (1060, 88, 140, 'qiandao', 88, '', 0, '2023-07-26 03:36:02');
INSERT INTO `pocket_log_coin` VALUES (1061, 88, 56, 'invited', 88, '', 0, '2023-07-26 03:36:04');
INSERT INTO `pocket_log_coin` VALUES (1062, 88, 8, 'invited', 117, '', 0, '2023-07-26 03:36:04');
INSERT INTO `pocket_log_coin` VALUES (1063, 88, 8, 'invited', 118, '', 0, '2023-07-26 03:36:04');
INSERT INTO `pocket_log_coin` VALUES (1064, 88, 140, 'qiandao', 88, '', 0, '2023-08-01 23:35:27');
INSERT INTO `pocket_log_coin` VALUES (1065, 88, 56, 'invited', 88, '', 0, '2023-08-01 23:35:29');
INSERT INTO `pocket_log_coin` VALUES (1066, 88, 8, 'invited', 117, '', 0, '2023-08-01 23:35:30');
INSERT INTO `pocket_log_coin` VALUES (1067, 88, 8, 'invited', 118, '', 0, '2023-08-01 23:35:30');
INSERT INTO `pocket_log_coin` VALUES (1068, 124, 20, 'qiandao', 124, '', 0, '2023-08-02 12:45:28');
INSERT INTO `pocket_log_coin` VALUES (1069, 88, 140, 'qiandao', 88, '', 0, '2023-08-08 16:12:33');
INSERT INTO `pocket_log_coin` VALUES (1070, 124, 20, 'qiandao', 124, '', 0, '2023-08-08 16:24:57');
INSERT INTO `pocket_log_coin` VALUES (1071, 125, 20, 'qiandao', 125, '', 0, '2023-08-08 16:30:13');
INSERT INTO `pocket_log_coin` VALUES (1072, 124, 20, 'qiandao', 124, '', 0, '2023-08-09 07:10:19');
INSERT INTO `pocket_log_coin` VALUES (1073, 88, 140, 'qiandao', 88, '', 0, '2023-08-09 13:10:05');
INSERT INTO `pocket_log_coin` VALUES (1074, 88, 56, 'invited', 88, '', 0, '2023-08-09 13:12:48');
INSERT INTO `pocket_log_coin` VALUES (1075, 88, 8, 'invited', 117, '', 0, '2023-08-09 13:12:49');
INSERT INTO `pocket_log_coin` VALUES (1076, 88, 8, 'invited', 118, '', 0, '2023-08-09 13:12:49');
INSERT INTO `pocket_log_coin` VALUES (1077, 126, 20, 'qiandao', 126, '', 0, '2023-08-09 22:07:13');
INSERT INTO `pocket_log_coin` VALUES (1078, 88, 140, 'qiandao', 88, '', 0, '2023-08-15 16:39:06');
INSERT INTO `pocket_log_coin` VALUES (1079, 88, 56, 'invited', 88, '', 0, '2023-08-15 16:39:07');
INSERT INTO `pocket_log_coin` VALUES (1080, 88, 8, 'invited', 117, '', 0, '2023-08-15 16:39:08');
INSERT INTO `pocket_log_coin` VALUES (1081, 88, 8, 'invited', 118, '', 0, '2023-08-15 16:39:09');
INSERT INTO `pocket_log_coin` VALUES (1082, 88, 140, 'qiandao', 88, '', 0, '2023-08-16 23:27:53');
INSERT INTO `pocket_log_coin` VALUES (1083, 88, 56, 'invited', 88, '', 0, '2023-08-16 23:27:55');
INSERT INTO `pocket_log_coin` VALUES (1084, 88, 8, 'invited', 117, '', 0, '2023-08-16 23:27:55');
INSERT INTO `pocket_log_coin` VALUES (1085, 88, 8, 'invited', 118, '', 0, '2023-08-16 23:27:55');
INSERT INTO `pocket_log_coin` VALUES (1086, 88, 140, 'qiandao', 88, '', 0, '2023-08-19 10:44:51');
INSERT INTO `pocket_log_coin` VALUES (1087, 88, 56, 'invited', 88, '', 0, '2023-08-19 10:44:53');
INSERT INTO `pocket_log_coin` VALUES (1088, 88, 8, 'invited', 117, '', 0, '2023-08-19 10:44:53');
INSERT INTO `pocket_log_coin` VALUES (1089, 88, 8, 'invited', 118, '', 0, '2023-08-19 10:44:54');
INSERT INTO `pocket_log_coin` VALUES (1090, 88, -4900, 'levelup', 88, '', 0, '2023-08-19 10:44:58');
INSERT INTO `pocket_log_coin` VALUES (1091, 114, 20, 'qiandao', 114, '', 0, '2023-08-21 12:26:32');
INSERT INTO `pocket_log_coin` VALUES (1092, 88, 160, 'qiandao', 88, '', 0, '2023-08-22 11:09:15');
INSERT INTO `pocket_log_coin` VALUES (1093, 88, 64, 'invited', 88, '', 0, '2023-08-22 11:09:19');
INSERT INTO `pocket_log_coin` VALUES (1094, 88, 8, 'invited', 117, '', 0, '2023-08-22 11:09:21');
INSERT INTO `pocket_log_coin` VALUES (1095, 88, 8, 'invited', 118, '', 0, '2023-08-22 11:09:22');
INSERT INTO `pocket_log_coin` VALUES (1096, 88, 160, 'qiandao', 88, '', 0, '2023-09-03 22:38:01');
INSERT INTO `pocket_log_coin` VALUES (1097, 88, 64, 'invited', 88, '', 0, '2023-09-03 22:38:03');
INSERT INTO `pocket_log_coin` VALUES (1098, 88, 8, 'invited', 117, '', 0, '2023-09-03 22:38:04');
INSERT INTO `pocket_log_coin` VALUES (1099, 88, 8, 'invited', 118, '', 0, '2023-09-03 22:38:05');
INSERT INTO `pocket_log_coin` VALUES (1100, 88, 160, 'qiandao', 88, '', 0, '2023-09-05 10:29:34');
INSERT INTO `pocket_log_coin` VALUES (1101, 88, 64, 'invited', 88, '', 0, '2023-09-05 10:29:36');
INSERT INTO `pocket_log_coin` VALUES (1102, 88, 8, 'invited', 117, '', 0, '2023-09-05 10:29:36');
INSERT INTO `pocket_log_coin` VALUES (1103, 88, 8, 'invited', 118, '', 0, '2023-09-05 10:29:37');
INSERT INTO `pocket_log_coin` VALUES (1104, 88, 160, 'qiandao', 88, '', 0, '2023-09-10 22:35:30');
INSERT INTO `pocket_log_coin` VALUES (1105, 124, 20, 'qiandao', 124, '', 0, '2023-09-11 17:54:52');
COMMIT;

-- ----------------------------
-- Table structure for pocket_log_point
-- ----------------------------
DROP TABLE IF EXISTS `pocket_log_point`;
CREATE TABLE `pocket_log_point` (
  `id` int NOT NULL AUTO_INCREMENT,
  `uid` int DEFAULT NULL COMMENT '会员ID',
  `numb` int DEFAULT NULL COMMENT '数量',
  `tag` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '相关业务标签',
  `relid` int DEFAULT NULL COMMENT '相关ID',
  `memo` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `adduid` int DEFAULT NULL COMMENT '操作者ID',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `uid` (`adduid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='积分日志变更记录表';

-- ----------------------------
-- Records of pocket_log_point
-- ----------------------------
BEGIN;
INSERT INTO `pocket_log_point` VALUES (1, 60, 888, 'recharge', NULL, NULL, NULL, '2022-11-25 09:11:07');
INSERT INTO `pocket_log_point` VALUES (2, 60, 10, 'recharge', 60, NULL, 0, '2022-11-25 09:33:49');
INSERT INTO `pocket_log_point` VALUES (3, 86, 800, 'manual', 86, '加你800又如何', 1, '2022-11-28 14:18:30');
INSERT INTO `pocket_log_point` VALUES (4, 86, -100, 'manual', 86, '加多了，要减少', 1, '2022-11-28 14:19:24');
INSERT INTO `pocket_log_point` VALUES (5, 60, 10, 'recharge', 60, '', 0, '2022-11-29 19:22:29');
INSERT INTO `pocket_log_point` VALUES (6, 88, 10, 'recharge', 88, '', 0, '2023-05-18 13:44:14');
INSERT INTO `pocket_log_point` VALUES (7, 88, 10, 'recharge', 88, '', 0, '2023-05-22 18:17:29');
COMMIT;

-- ----------------------------
-- Table structure for pocket_log_res
-- ----------------------------
DROP TABLE IF EXISTS `pocket_log_res`;
CREATE TABLE `pocket_log_res` (
  `id` int NOT NULL AUTO_INCREMENT,
  `uid` int DEFAULT NULL COMMENT '会员ID',
  `numb` int DEFAULT NULL COMMENT '数量',
  `tag` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '相关业务标签',
  `relid` int DEFAULT NULL COMMENT '相关ID',
  `memo` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `adduid` int DEFAULT NULL COMMENT '操作者ID',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `uid` (`adduid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='资源日志变更记录表';

-- ----------------------------
-- Records of pocket_log_res
-- ----------------------------
BEGIN;
INSERT INTO `pocket_log_res` VALUES (1, 60, -10000000, 'manual', 60, '---', 1, '2023-04-14 13:58:06');
COMMIT;

-- ----------------------------
-- Table structure for section
-- ----------------------------
DROP TABLE IF EXISTS `section`;
CREATE TABLE `section` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '版块名称',
  `desc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '版块文件显示',
  `image` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '版块图片显示',
  `tourl` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '目标链接',
  `imagew` int DEFAULT '0' COMMENT '图片宽像素',
  `imageh` int DEFAULT '0' COMMENT '图片高像素',
  `thumb` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '图片缩略图，仅供后台',
  `bdate` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '开始生效日期',
  `edate` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '结束生效日期',
  `sort` int DEFAULT '0' COMMENT '排序字段',
  `status` tinyint DEFAULT '0' COMMENT '状态',
  `adduid` int DEFAULT NULL COMMENT '添加者ID',
  `edituid` int DEFAULT NULL COMMENT '最后编辑者ID',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='版块信息表';

-- ----------------------------
-- Records of section
-- ----------------------------
BEGIN;
INSERT INTO `section` VALUES (9, 'banner广告3', '第一条：符合国家政策法律。\n第二条：由松散的人民自由联合而成经济平台，不设任何组织。\n第三条：平台属于注册的所有人，一人一票。\n第四条：平台开放注册无门槛（以后因一人一票需要实名）\n第五条：管理决策团队由选举产生。\n第六条：平台运行管理考核市场化。\n第七条：利润分配由所有人共同决定通过。\n第八条：确保民主不被权力金钱左右，确保人人有选举与被选举权力。', 'attach/image/1669716726_1f1c51da341d1f56f4eb.jpeg', '', 640, 320, 'attach/thumb/1669716726_1f1c51da341d1f56f4eb.jpeg', NULL, NULL, 0, 1, 1, 56, '2022-11-11 10:43:21', '2023-04-22 20:55:08', NULL);
INSERT INTO `section` VALUES (10, 'banner广告1', NULL, 'attach/image/1669716756_a31b4b9c296553195460.png', '', 640, 320, 'attach/thumb/1669716756_a31b4b9c296553195460.png', NULL, NULL, 0, 1, 1, 1, '2022-11-11 13:59:06', '2022-12-06 14:51:04', NULL);
INSERT INTO `section` VALUES (11, 'banner广告2', NULL, 'attach/image/1669716796_b42883f1b5fec9f6ff48.png', 'http://yuyaoit.cn', 640, 320, 'attach/thumb/1669716796_b42883f1b5fec9f6ff48.png', NULL, NULL, 0, 1, 1, 1, '2022-11-11 13:59:36', '2022-12-06 14:51:47', NULL);
COMMIT;

-- ----------------------------
-- Table structure for section_ext
-- ----------------------------
DROP TABLE IF EXISTS `section_ext`;
CREATE TABLE `section_ext` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fid` int DEFAULT NULL COMMENT '所属扩展ID',
  `relid` int DEFAULT NULL COMMENT '所属相关ID',
  `val` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '字段值',
  `adduid` int DEFAULT NULL,
  `edituid` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fid` (`fid`) USING BTREE,
  KEY `relid` (`relid`) USING BTREE,
  KEY `adduid` (`adduid`) USING BTREE,
  KEY `val` (`val`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='扩展字段值存储表';

-- ----------------------------
-- Records of section_ext
-- ----------------------------
BEGIN;
INSERT INTO `section_ext` VALUES (1, 27, 7, 'home,detail', 1, 1, '2022-11-10 14:28:04', '2022-11-11 08:00:44', NULL);
INSERT INTO `section_ext` VALUES (2, 27, 6, 'comm,home', 1, 1, '2022-11-10 14:37:59', '2022-11-10 15:47:04', NULL);
INSERT INTO `section_ext` VALUES (3, 27, 1, 'comm', 1, NULL, '2022-11-11 10:04:30', '2022-11-11 10:04:30', NULL);
INSERT INTO `section_ext` VALUES (4, 27, 8, 'home', 1, NULL, '2022-11-11 10:31:51', '2022-11-11 10:31:51', NULL);
INSERT INTO `section_ext` VALUES (5, 27, 9, 'comm,home,list,detail', 1, 1, '2022-11-11 10:43:21', '2022-12-06 14:51:08', NULL);
INSERT INTO `section_ext` VALUES (6, 27, 10, 'home', 1, 1, '2022-11-11 13:59:06', '2022-12-06 14:51:04', NULL);
INSERT INTO `section_ext` VALUES (7, 27, 11, 'home', 1, 1, '2022-11-11 13:59:36', '2022-12-06 14:51:22', NULL);
INSERT INTO `section_ext` VALUES (8, 27, 12, 'comm,home,detail', 1, NULL, '2022-11-11 14:01:02', '2022-11-11 14:01:02', NULL);
INSERT INTO `section_ext` VALUES (9, 27, 13, 'list', 13, 1, '2022-11-11 14:05:52', '2022-11-24 16:01:46', NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_attach
-- ----------------------------
DROP TABLE IF EXISTS `sys_attach`;
CREATE TABLE `sys_attach` (
  `id` int NOT NULL AUTO_INCREMENT,
  `module` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '文件来源模块',
  `store` tinyint DEFAULT '0' COMMENT '存储方式0为本地',
  `url` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '访问路由地址',
  `thumb` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '缩略图URL，如果有的话',
  `type` tinyint DEFAULT '0' COMMENT '存储性质0为图片1为文件',
  `fileext` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '附件扩展类似',
  `filesize` int DEFAULT '0' COMMENT '附件大小',
  `filename` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '附件文件名',
  `usertype` tinyint(1) DEFAULT '0' COMMENT '用户类型:0为会员，1为后台帐号',
  `adduid` int DEFAULT NULL COMMENT '添加者ID',
  `edituid` int DEFAULT NULL COMMENT '最后编辑者ID',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `module` (`module`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='附件存储信息表';

-- ----------------------------
-- Records of sys_attach
-- ----------------------------
BEGIN;
INSERT INTO `sys_attach` VALUES (3, 'section', 0, 'attach/image/1668126140_ae2304563f1b5b36b420.jpeg', 'attach/thumb/1668126140_ae2304563f1b5b36b420.jpeg', 1, 'jpeg', 356932, '1668126140_ae2304563f1b5b36b420.jpeg', 1, 1, NULL, '2022-11-11 08:22:20', '2022-11-11 10:26:06', '2022-11-11 10:26:06');
INSERT INTO `sys_attach` VALUES (4, 'section', 0, 'attach/image/1668132254_39962351fc5613258388.jpg', 'attach/thumb/1668132254_39962351fc5613258388.jpg', 1, 'jpg', 450775, '1668132254_39962351fc5613258388.jpg', 1, 1, NULL, '2022-11-11 10:04:14', '2022-11-11 10:26:09', '2022-11-11 10:26:09');
INSERT INTO `sys_attach` VALUES (5, 'section', 0, 'attach/image/1668133596_13c08487a2bb1455720e.jpeg', 'attach/thumb/1668133596_13c08487a2bb1455720e.jpeg', 1, 'jpeg', 269409, '1668133596_13c08487a2bb1455720e.jpeg', 1, 1, NULL, '2022-11-11 10:26:36', '2022-11-29 20:40:28', '2022-11-29 20:40:28');
INSERT INTO `sys_attach` VALUES (6, 'section', 0, 'attach/image/1668133882_bef3eb41d4b02ac1753a.jpeg', 'attach/thumb/1668133882_bef3eb41d4b02ac1753a.jpeg', 1, 'jpeg', 356932, '1668133882_bef3eb41d4b02ac1753a.jpeg', 1, 1, NULL, '2022-11-11 10:31:23', '2022-11-29 20:40:32', '2022-11-29 20:40:32');
INSERT INTO `sys_attach` VALUES (7, 'section', 0, 'attach/image/1668134595_038d9ef400c349577d7c.jpeg', 'attach/thumb/1668134595_038d9ef400c349577d7c.jpeg', 1, 'jpeg', 269409, '1668134595_038d9ef400c349577d7c.jpeg', 1, 1, NULL, '2022-11-11 10:43:16', '2022-11-29 20:40:34', '2022-11-29 20:40:34');
INSERT INTO `sys_attach` VALUES (8, 'member', 0, 'attach/image/1668144692_fa34be28cce742e25342.jpg', 'attach/thumb/1668144692_fa34be28cce742e25342.jpg', 1, 'jpg', 450775, '1668144692_fa34be28cce742e25342.jpg', 1, 1, NULL, '2022-11-11 13:31:33', '2022-11-29 20:40:36', '2022-11-29 20:40:36');
INSERT INTO `sys_attach` VALUES (9, 'member', 0, 'attach/image/1668145094_96f346314339a74058a3.jpg', 'attach/thumb/1668145094_96f346314339a74058a3.jpg', 1, 'jpg', 2544, '1668145094_96f346314339a74058a3.jpg', 1, 1, NULL, '2022-11-11 13:38:15', '2022-11-29 20:40:37', '2022-11-29 20:40:37');
INSERT INTO `sys_attach` VALUES (10, 'sysuser', 0, 'attach/image/1668145438_21ed892bd46845044f1d.jpeg', 'attach/thumb/1668145438_21ed892bd46845044f1d.jpeg', 1, 'jpeg', 1562, '1668145438_21ed892bd46845044f1d.jpeg', 1, 1, NULL, '2022-11-11 13:43:58', '2022-11-11 13:54:36', '2022-11-11 13:54:36');
INSERT INTO `sys_attach` VALUES (11, 'section', 0, 'attach/image/1668146338_46eac4a5df10fe8a18cc.jpg', 'attach/thumb/1668146338_46eac4a5df10fe8a18cc.jpg', 1, 'jpg', 45427, '1668146338_46eac4a5df10fe8a18cc.jpg', 1, 1, NULL, '2022-11-11 13:58:59', '2022-11-29 20:40:40', '2022-11-29 20:40:40');
INSERT INTO `sys_attach` VALUES (12, 'section', 0, 'attach/image/1668146371_fbe966a61b241c97d102.png', 'attach/thumb/1668146371_fbe966a61b241c97d102.png', 1, 'png', 136447, '1668146371_fbe966a61b241c97d102.png', 1, 1, NULL, '2022-11-11 13:59:32', '2022-11-29 20:40:43', '2022-11-29 20:40:43');
INSERT INTO `sys_attach` VALUES (13, 'section', 0, 'attach/image/1668146452_f48c4a70d353a40929db.jpeg', 'attach/thumb/1668146452_f48c4a70d353a40929db.jpeg', 1, 'jpeg', 64754, '1668146452_f48c4a70d353a40929db.jpeg', 1, 1, NULL, '2022-11-11 14:00:53', '2022-11-29 20:40:45', '2022-11-29 20:40:45');
INSERT INTO `sys_attach` VALUES (14, 'section', 0, 'attach/image/1668146745_eb2a15b42f6f3dba5b1c.jpeg', 'attach/thumb/1668146745_eb2a15b42f6f3dba5b1c.jpeg', 1, 'jpeg', 51923, '1668146745_eb2a15b42f6f3dba5b1c.jpeg', 1, 13, NULL, '2022-11-11 14:05:46', '2022-11-29 20:40:47', '2022-11-29 20:40:47');
INSERT INTO `sys_attach` VALUES (15, 'sysuser', 0, 'attach/image/1668149311_366f3c082be2401a6e78.jpg', 'attach/thumb/1668149311_366f3c082be2401a6e78.jpg', 1, 'jpg', 2544, '1668149311_366f3c082be2401a6e78.jpg', 1, 13, NULL, '2022-11-11 14:48:31', '2022-11-29 20:40:49', '2022-11-29 20:40:49');
INSERT INTO `sys_attach` VALUES (16, 'sysuser', 0, 'attach/image/1668149811_b38751392fc7d08df1b9.jpeg', 'attach/thumb/1668149811_b38751392fc7d08df1b9.jpeg', 1, 'jpeg', 2376, '1668149811_b38751392fc7d08df1b9.jpeg', 1, 13, NULL, '2022-11-11 14:56:52', '2022-11-29 20:40:51', '2022-11-29 20:40:51');
INSERT INTO `sys_attach` VALUES (17, 'member', 0, 'attach/image/1668643304_58e017d4aeae1b412f85.jpg', 'attach/thumb/1668643304_58e017d4aeae1b412f85.jpg', 1, 'jpg', 218259, '1668643304_58e017d4aeae1b412f85.jpg', 0, 60, NULL, '2022-11-17 08:01:44', '2022-11-29 20:40:55', '2022-11-29 20:40:55');
INSERT INTO `sys_attach` VALUES (18, 'member', 0, 'attach/image/1668643382_254f55231d28e2763bda.jpg', 'attach/thumb/1668643382_254f55231d28e2763bda.jpg', 1, 'jpg', 218259, '1668643382_254f55231d28e2763bda.jpg', 0, 60, NULL, '2022-11-17 08:03:02', '2022-11-29 20:40:57', '2022-11-29 20:40:57');
INSERT INTO `sys_attach` VALUES (19, 'member', 0, 'attach/image/1668644401_b88b7e3bc71034d62f27.jpg', 'attach/thumb/1668644401_b88b7e3bc71034d62f27.jpg', 1, 'jpg', 218259, '1668644401_b88b7e3bc71034d62f27.jpg', 0, 60, NULL, '2022-11-17 08:20:01', '2022-11-29 20:41:14', '2022-11-29 20:41:14');
INSERT INTO `sys_attach` VALUES (20, 'member', 0, 'attach/image/1668644506_8492c977f42f3762cbfb.jpg', 'attach/thumb/1668644506_8492c977f42f3762cbfb.jpg', 1, 'jpg', 218259, '1668644506_8492c977f42f3762cbfb.jpg', 0, 60, NULL, '2022-11-17 08:21:46', '2022-11-29 20:41:12', '2022-11-29 20:41:12');
INSERT INTO `sys_attach` VALUES (21, 'member', 0, 'attach/image/1668644538_dfadb81391e067f957b8.jpeg', 'attach/thumb/1668644538_dfadb81391e067f957b8.jpeg', 1, 'jpeg', 498674, '1668644538_dfadb81391e067f957b8.jpeg', 0, 60, NULL, '2022-11-17 08:22:18', '2022-11-29 20:41:00', '2022-11-29 20:41:00');
INSERT INTO `sys_attach` VALUES (22, 'member', 0, 'attach/image/1668644653_97971504947706c87151.jpg', 'attach/thumb/1668644653_97971504947706c87151.jpg', 1, 'jpg', 218259, '1668644653_97971504947706c87151.jpg', 0, 60, NULL, '2022-11-17 08:24:14', '2022-11-29 20:41:10', '2022-11-29 20:41:10');
INSERT INTO `sys_attach` VALUES (23, 'member', 0, 'attach/image/1668644711_048e3f5d5ea251771f99.jpg', 'attach/thumb/1668644711_048e3f5d5ea251771f99.jpg', 1, 'jpg', 218259, '1668644711_048e3f5d5ea251771f99.jpg', 0, 60, NULL, '2022-11-17 08:25:11', '2022-11-29 20:41:08', '2022-11-29 20:41:08');
INSERT INTO `sys_attach` VALUES (24, 'member', 0, 'attach/image/1668644752_c597e2aeaa3df91745f3.jpg', 'attach/thumb/1668644752_c597e2aeaa3df91745f3.jpg', 1, 'jpg', 218259, '1668644752_c597e2aeaa3df91745f3.jpg', 0, 60, NULL, '2022-11-17 08:25:52', '2022-11-29 20:41:05', '2022-11-29 20:41:05');
INSERT INTO `sys_attach` VALUES (25, 'member', 0, 'attach/image/1668644790_31978a504dcdbed899e5.jpg', 'attach/thumb/1668644790_31978a504dcdbed899e5.jpg', 1, 'jpg', 218259, '1668644790_31978a504dcdbed899e5.jpg', 0, 60, NULL, '2022-11-17 08:26:30', '2022-11-29 20:41:04', '2022-11-29 20:41:04');
INSERT INTO `sys_attach` VALUES (26, 'member', 0, 'attach/image/1668644845_3e3fe0b8c2dba14d850a.jpg', 'attach/thumb/1668644845_3e3fe0b8c2dba14d850a.jpg', 1, 'jpg', 218259, '1668644845_3e3fe0b8c2dba14d850a.jpg', 0, 60, NULL, '2022-11-17 08:27:26', '2022-11-29 20:41:02', '2022-11-29 20:41:02');
INSERT INTO `sys_attach` VALUES (27, 'member', 0, 'attach/image/1668644967_b756a036f3cde0caa2b6.jpeg', 'attach/thumb/1668644967_b756a036f3cde0caa2b6.jpeg', 1, 'jpeg', 498674, '1668644967_b756a036f3cde0caa2b6.jpeg', 0, 60, NULL, '2022-11-17 08:29:27', '2022-11-29 20:41:29', '2022-11-29 20:41:29');
INSERT INTO `sys_attach` VALUES (28, 'member', 0, 'attach/image/1668645221_e78221f97251bd465fc5.jpeg', 'attach/thumb/1668645221_e78221f97251bd465fc5.jpeg', 1, 'jpeg', 498674, '1668645221_e78221f97251bd465fc5.jpeg', 0, 60, NULL, '2022-11-17 08:33:42', '2022-11-29 20:41:25', '2022-11-29 20:41:25');
INSERT INTO `sys_attach` VALUES (29, 'member', 0, 'attach/image/1668645435_be6253cfe49b541c6167.jpg', 'attach/thumb/1668645435_be6253cfe49b541c6167.jpg', 1, 'jpg', 218259, '1668645435_be6253cfe49b541c6167.jpg', 0, 60, NULL, '2022-11-17 08:37:15', '2022-11-29 20:41:23', '2022-11-29 20:41:23');
INSERT INTO `sys_attach` VALUES (30, 'member', 0, 'attach/image/1668645461_be385788e3c30ddcdfce.jpeg', 'attach/thumb/1668645461_be385788e3c30ddcdfce.jpeg', 1, 'jpeg', 498674, '1668645461_be385788e3c30ddcdfce.jpeg', 0, 60, NULL, '2022-11-17 08:37:41', '2022-11-29 20:41:21', '2022-11-29 20:41:21');
INSERT INTO `sys_attach` VALUES (31, 'member', 0, 'attach/image/1668646521_ed30713d84ec0b6c5a15.jpeg', 'attach/thumb/1668646521_ed30713d84ec0b6c5a15.jpeg', 1, 'jpeg', 287344, '1668646521_ed30713d84ec0b6c5a15.jpeg', 0, 60, NULL, '2022-11-17 08:55:21', '2022-11-29 20:41:19', '2022-11-29 20:41:19');
INSERT INTO `sys_attach` VALUES (32, 'member', 0, 'attach/image/1668647902_80ec1cfda2be4b32e979.jpeg', 'attach/thumb/1668647902_80ec1cfda2be4b32e979.jpeg', 1, 'jpeg', 498674, '1668647902_80ec1cfda2be4b32e979.jpeg', 0, 60, NULL, '2022-11-17 09:18:22', '2022-11-29 20:40:07', '2022-11-29 20:40:07');
INSERT INTO `sys_attach` VALUES (33, 'member', 0, 'attach/image/1668664822_8d1ebea922a4aa7cd431.jpg', 'attach/thumb/1668664822_8d1ebea922a4aa7cd431.jpg', 1, 'jpg', 218259, '1668664822_8d1ebea922a4aa7cd431.jpg', 0, 60, NULL, '2022-11-17 14:00:22', '2022-11-29 20:40:09', '2022-11-29 20:40:09');
INSERT INTO `sys_attach` VALUES (34, 'member', 0, 'attach/image/1668688800_0d5fcc8cf2b338822eb4.jpg', 'attach/thumb/1668688800_0d5fcc8cf2b338822eb4.jpg', 1, 'jpg', 218259, '1668688800_0d5fcc8cf2b338822eb4.jpg', 0, 60, NULL, '2022-11-17 20:40:00', '2022-11-29 20:40:11', '2022-11-29 20:40:11');
INSERT INTO `sys_attach` VALUES (35, 'member', 0, 'attach/image/1668688816_f2d6f2307926d86bff0b.jpeg', 'attach/thumb/1668688816_f2d6f2307926d86bff0b.jpeg', 1, 'jpeg', 498674, '1668688816_f2d6f2307926d86bff0b.jpeg', 0, 60, NULL, '2022-11-17 20:40:16', '2022-11-29 20:40:13', '2022-11-29 20:40:13');
INSERT INTO `sys_attach` VALUES (36, 'member', 0, 'attach/image/1669593631_52e4d8e7ef29363ba933.png', 'attach/thumb/1669593631_52e4d8e7ef29363ba933.png', 1, 'png', 36721, '1669593631_52e4d8e7ef29363ba933.png', 0, 86, NULL, '2022-11-28 08:00:31', '2022-11-29 20:40:15', '2022-11-29 20:40:15');
INSERT INTO `sys_attach` VALUES (37, 'section', 0, 'attach/image/1669716726_1f1c51da341d1f56f4eb.jpeg', 'attach/thumb/1669716726_1f1c51da341d1f56f4eb.jpeg', 1, 'jpeg', 64725, '1669716726_1f1c51da341d1f56f4eb.jpeg', 1, 56, NULL, '2022-11-29 18:12:06', '2022-11-29 18:12:06', NULL);
INSERT INTO `sys_attach` VALUES (38, 'section', 0, 'attach/image/1669716756_a31b4b9c296553195460.png', 'attach/thumb/1669716756_a31b4b9c296553195460.png', 1, 'png', 136447, '1669716756_a31b4b9c296553195460.png', 1, 56, NULL, '2022-11-29 18:12:36', '2022-11-29 18:12:36', NULL);
INSERT INTO `sys_attach` VALUES (39, 'section', 0, 'attach/image/1669716796_b42883f1b5fec9f6ff48.png', 'attach/thumb/1669716796_b42883f1b5fec9f6ff48.png', 1, 'png', 11676, '1669716796_b42883f1b5fec9f6ff48.png', 1, 56, NULL, '2022-11-29 18:13:16', '2022-11-29 18:13:16', NULL);
INSERT INTO `sys_attach` VALUES (40, 'member', 0, 'attach/image/1669723782_7f4cb93d9640ef46758a.jpg', 'attach/thumb/1669723782_7f4cb93d9640ef46758a.jpg', 1, 'jpg', 2064088, '1669723782_7f4cb93d9640ef46758a.jpg', 0, 89, NULL, '2022-11-29 20:09:43', '2022-11-29 20:09:43', NULL);
INSERT INTO `sys_attach` VALUES (41, 'member', 0, 'attach/image/1669724950_00c5b68364d0ab2206fd.jpg', 'attach/thumb/1669724950_00c5b68364d0ab2206fd.jpg', 1, 'jpg', 23231, '1669724950_00c5b68364d0ab2206fd.jpg', 0, 88, NULL, '2022-11-29 20:29:10', '2022-11-29 20:29:10', NULL);
INSERT INTO `sys_attach` VALUES (42, 'member', 0, 'attach/image/1669878309_81372f9a2c43bb1d0423.jpg', 'attach/thumb/1669878309_81372f9a2c43bb1d0423.jpg', 1, 'jpg', 2253, '1669878309_81372f9a2c43bb1d0423.jpg', 0, 87, NULL, '2022-12-01 15:05:09', '2022-12-01 15:05:09', NULL);
INSERT INTO `sys_attach` VALUES (43, 'chat', 0, 'attach/image/1673244826_4ae9ae3bcaa7fec08b5c.jpeg', 'attach/thumb/1673244826_4ae9ae3bcaa7fec08b5c.jpeg', 1, 'jpeg', 498150, '1673244826_4ae9ae3bcaa7fec08b5c.jpeg', 0, 60, NULL, '2023-01-09 14:13:46', '2023-01-09 14:13:46', NULL);
INSERT INTO `sys_attach` VALUES (44, 'chat', 0, 'attach/image/1673246745_da9f40f8b50bcec396fc.jpg', 'attach/thumb/1673246745_da9f40f8b50bcec396fc.jpg', 1, 'jpg', 93773, '1673246745_da9f40f8b50bcec396fc.jpg', 0, 106, NULL, '2023-01-09 14:45:45', '2023-01-09 14:45:45', NULL);
INSERT INTO `sys_attach` VALUES (45, 'chat', 0, 'attach/image/1673691482_b5cf0aa743ec2716def2.jpg', 'attach/thumb/1673691482_b5cf0aa743ec2716def2.jpg', 1, 'jpg', 102649, '1673691482_b5cf0aa743ec2716def2.jpg', 0, 88, NULL, '2023-01-14 18:18:02', '2023-01-14 18:18:02', NULL);
INSERT INTO `sys_attach` VALUES (46, 'chat', 0, 'attach/image/1673700444_42cd2e3227b7fba47459.jpg', 'attach/thumb/1673700444_42cd2e3227b7fba47459.jpg', 1, 'jpg', 107520, '1673700444_42cd2e3227b7fba47459.jpg', 0, 88, NULL, '2023-01-14 20:47:25', '2023-01-14 20:47:25', NULL);
INSERT INTO `sys_attach` VALUES (47, 'chat', 0, 'attach/image/1673850494_4480233bd927812f6c67.jpg', 'attach/thumb/1673850494_4480233bd927812f6c67.jpg', 1, 'jpg', 242431, '1673850494_4480233bd927812f6c67.jpg', 0, 88, NULL, '2023-01-16 14:28:15', '2023-01-16 14:28:15', NULL);
INSERT INTO `sys_attach` VALUES (48, 'chat', 0, 'attach/image/1682046876_8dd6c4e07dec36a9f5ed.jpg', 'attach/thumb/1682046876_8dd6c4e07dec36a9f5ed.jpg', 1, 'jpg', 246804, '1682046876_8dd6c4e07dec36a9f5ed.jpg', 0, 114, NULL, '2023-04-21 11:14:36', '2023-04-21 11:14:36', NULL);
INSERT INTO `sys_attach` VALUES (49, 'chat', 0, 'attach/image/1683420757_5525b27db5c0fa4b8b39.jpg', 'attach/thumb/1683420757_5525b27db5c0fa4b8b39.jpg', 1, 'jpg', 348687, '1683420757_5525b27db5c0fa4b8b39.jpg', 0, 88, NULL, '2023-05-07 08:52:37', '2023-05-07 08:52:37', NULL);
INSERT INTO `sys_attach` VALUES (50, 'chat', 0, 'attach/image/1691483370_70547efeb532365016a8.jpeg', 'attach/thumb/1691483370_70547efeb532365016a8.jpeg', 1, 'jpeg', 43883, '1691483370_70547efeb532365016a8.jpeg', 0, 125, NULL, '2023-08-08 16:29:30', '2023-08-08 16:29:30', NULL);
INSERT INTO `sys_attach` VALUES (51, 'chat', 0, 'attach/image/1691483475_8ba2c12310608d103786.jpeg', 'attach/thumb/1691483475_8ba2c12310608d103786.jpeg', 1, 'jpeg', 43883, '1691483475_8ba2c12310608d103786.jpeg', 0, 125, NULL, '2023-08-08 16:31:15', '2023-08-08 16:31:15', NULL);
INSERT INTO `sys_attach` VALUES (52, 'chat', 0, 'attach/image/1691483497_893ee14a442ff0093af6.jpg', 'attach/thumb/1691483497_893ee14a442ff0093af6.jpg', 1, 'jpg', 2970167, '1691483497_893ee14a442ff0093af6.jpg', 0, 125, NULL, '2023-08-08 16:31:37', '2023-08-08 16:31:37', NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `confkey` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `confval` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci,
  `confnote` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `memo` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `fieldtype` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT 'text' COMMENT '字段类型',
  `sort` int DEFAULT NULL COMMENT '排序,按数字大小排序',
  `tag` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` tinyint DEFAULT '1',
  `edituid` int DEFAULT NULL COMMENT '最后编辑者ID',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `tag` (`tag`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='通用参数配置表';

-- ----------------------------
-- Records of sys_config
-- ----------------------------
BEGIN;
INSERT INTO `sys_config` VALUES (37, 'tpl', 'mcenter/', '会员中心模版路径设置', '', 'text', -1, '9', 2, NULL, '2022-11-04 15:27:37', NULL, NULL);
INSERT INTO `sys_config` VALUES (39, 'comm', 'comm/', '公共调用资源路径设置', '', 'text', -3, '9', 2, NULL, '2022-11-04 15:27:37', NULL, NULL);
INSERT INTO `sys_config` VALUES (40, 'site_title', '金融说云直播软件', '网站标题', '', 'text', NULL, '1', 1, NULL, '2022-11-04 15:27:37', NULL, NULL);
INSERT INTO `sys_config` VALUES (41, 'site_keywords', '金融直播,讲师联盟,金融云直播软件,云直播室,金融直播,金融教育,视频直播,图文直播,喊单系统,直播营销系统。', '网站关键字', '', 'text', NULL, '1', 1, NULL, '2022-11-04 15:27:37', NULL, NULL);
INSERT INTO `sys_config` VALUES (42, 'site_desc', '专注服务于金融衍生品市场，为金融从业人士提供金融直播软件服务、信息技术服务、和数据服务的金融教育云软件。', '网站描述', '', 'textarea', NULL, '1', 1, NULL, '2022-11-04 15:27:37', NULL, NULL);
INSERT INTO `sys_config` VALUES (43, 'site_copyright', '金融说-云上的金融教育直播软件', '版权及备案信息', '', 'textarea', NULL, '1', 1, NULL, '2022-11-04 15:27:37', NULL, NULL);
INSERT INTO `sys_config` VALUES (45, 'site_logo', 'http://homepage.91mp.com/images/logo.png', '网站logo', '', 'img', NULL, '9', 1, NULL, '2022-11-04 15:27:37', NULL, NULL);
INSERT INTO `sys_config` VALUES (61, 'smtp_server', 'smtp.126.com', '系统消息SMTP服务器', '', 'text', NULL, '3', 1, NULL, '2022-11-04 15:27:37', NULL, NULL);
INSERT INTO `sys_config` VALUES (62, 'smtp_username', 'eyoung_91mp@126.com', '系统消息SMTP帐号', '', 'text', NULL, '3', 1, NULL, '2022-11-04 15:27:37', NULL, NULL);
INSERT INTO `sys_config` VALUES (63, 'smtp_passwd', 'EEEVCLOBLBWYGBLJ', '系统消息SMTP密码', '', 'text', NULL, '3', 1, NULL, '2022-11-04 15:27:37', NULL, NULL);
INSERT INTO `sys_config` VALUES (64, 'smtp_port', '25', '系统消息SMTP端口号', NULL, 'text', NULL, '3', 1, NULL, '2022-11-04 15:27:37', NULL, NULL);
INSERT INTO `sys_config` VALUES (72, 'appid', 'wxf9cfef5166d06286', '开发者ID(AppID)', NULL, 'text', 1, 'wxpay', 1, NULL, '2022-11-04 15:27:37', NULL, NULL);
INSERT INTO `sys_config` VALUES (96, 'appsecret', '72862dcd06f59da5d42720d3726acea9', '开发者密码', NULL, 'text', 2, 'wxpay', 1, NULL, '2022-11-04 15:27:37', NULL, NULL);
INSERT INTO `sys_config` VALUES (97, 'encodingaeskey', 'WC0BtvvpnZK5jGilq5ks95LRe1qOKEFIkxZi8uIOjmt', '消息加解密密钥', NULL, 'text', 3, 'wxpay', 1, NULL, '2022-11-18 15:53:40', NULL, NULL);
INSERT INTO `sys_config` VALUES (98, 'token', 'eyoung', '令牌(Token)', NULL, 'text', 4, 'wxpay', 1, NULL, '2022-11-19 17:06:55', NULL, NULL);
INSERT INTO `sys_config` VALUES (99, 'mch_id', '1351973601', '商户号', NULL, 'text', 5, 'wxpay', 1, NULL, '2022-11-19 17:07:00', NULL, NULL);
INSERT INTO `sys_config` VALUES (100, 'mch_key', 'yuyaoitshieyoungwangluodeyuminga', '商户号密钥', NULL, 'text', 6, 'wxpay', 1, NULL, '2022-11-19 17:07:09', NULL, NULL);
INSERT INTO `sys_config` VALUES (101, 'ssl_key', NULL, '商户支付证书key', NULL, 'text', 7, 'wxpay', 1, NULL, '2022-11-19 19:16:31', NULL, NULL);
INSERT INTO `sys_config` VALUES (102, 'ssl_cer', NULL, '商户支付证书cert', NULL, 'text', 8, 'wxpay', 1, NULL, '2022-11-19 19:16:35', NULL, NULL);
INSERT INTO `sys_config` VALUES (103, 'cache_path', NULL, '缓存目录(需可写)', NULL, 'text', 9, 'wxpay', 1, NULL, '2022-11-19 19:17:28', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict` (
  `fid` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '字段名',
  `code` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '字段码',
  `type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '字段类型',
  `setting` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '如配置多选、复选的初始值',
  `force` tinyint(1) DEFAULT '0' COMMENT '强制输入',
  `rule` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '验证规则配置',
  `info` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '字段说明',
  `view` tinyint(1) DEFAULT '1' COMMENT '是否可显示',
  `search` tinyint(1) DEFAULT NULL COMMENT '是否可搜索',
  `edit` tinyint(1) DEFAULT NULL COMMENT '是否可编辑',
  `sort` int DEFAULT NULL COMMENT '字段排序',
  `tname` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '扩展所属表',
  `adduid` int DEFAULT NULL COMMENT '添加者ID',
  `edituid` int DEFAULT NULL COMMENT '最后编辑者ID',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`fid`) USING BTREE,
  KEY `table` (`tname`) USING BTREE,
  KEY `sort` (`sort`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='扩展字段信息表';

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
BEGIN;
INSERT INTO `sys_dict` VALUES (27, '标签', 'tag', 'checkbox', '{\"comm\":\"\\u516c\\u5171\",\"home\":\"\\u9996\\u9875\",\"list\":\"\\u5217\\u8868\\u9875\",\"detail\":\"\\u8be6\\u7ec6\\u9875\"}', 0, NULL, '', 0, 0, 0, 0, 'section', 1, 1, '2022-11-10 13:32:31', '2022-12-06 14:51:38', NULL);
INSERT INTO `sys_dict` VALUES (29, '微信授权', 'openid', 'text', '', 0, '', '微信授权openid', 1, 0, 0, 0, 'member', 1, 1, '2022-11-16 13:31:18', '2022-12-09 08:26:27', NULL);
INSERT INTO `sys_dict` VALUES (33, '投票选项', 'voteitem', 'checkbox', '{\"1\":\"\\u540c\\u610f\",\"2\":\"\\u53cd\\u5bf9\",\"3\":\"\\u5e94\\u4fee\\u6539\",\"4\":\"\\u89c2\\u671b\"}', 1, NULL, '', 1, 1, 1, 0, 'custom_vote', 1, 1, '2022-11-23 10:45:52', '2022-11-23 10:50:28', NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '被操作的对象名',
  `route` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '请求路由',
  `module` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '关联模块',
  `actions` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '触发动作',
  `relid` int DEFAULT NULL COMMENT '相关ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '操作者姓名',
  `adduid` int DEFAULT NULL COMMENT '操作者ID',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `uid` (`adduid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=900 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='操作日志记录表';

-- ----------------------------
-- Records of sys_log
-- ----------------------------
BEGIN;
INSERT INTO `sys_log` VALUES (686, NULL, 'webadmin/sysuser/login', 'sysuser', 'login', NULL, '系统维护', 1, '2022-11-30 07:48:34');
INSERT INTO `sys_log` VALUES (687, NULL, 'webadmin/sysuser/login', 'sysuser', 'login', NULL, 'admin', 56, '2022-12-01 14:37:20');
INSERT INTO `sys_log` VALUES (688, '出售出售出售', 'webadmin/paimai/add', 'paimai', 'add', NULL, 'admin', 56, '2022-12-01 14:38:30');
INSERT INTO `sys_log` VALUES (689, NULL, 'webadmin/sysuser/login', 'sysuser', 'login', NULL, '系统维护', 1, '2022-12-02 08:23:59');
INSERT INTO `sys_log` VALUES (690, '联系方式', 'webadmin/sysdict/edit/28', 'sysdict', 'edit', 28, '系统维护', 1, '2022-12-02 13:39:18');
INSERT INTO `sys_log` VALUES (691, '联系方式', 'webadmin/sysdict/del', 'sysdict', 'del', 28, '系统维护', 1, '2022-12-02 13:39:47');
INSERT INTO `sys_log` VALUES (692, NULL, 'webadmin/sysuser/login', 'sysuser', 'login', NULL, '系统维护', 1, '2022-12-02 17:14:44');
INSERT INTO `sys_log` VALUES (693, NULL, 'webadmin/sysuser/login', 'sysuser', 'login', NULL, '系统维护', 1, '2022-12-03 10:17:15');
INSERT INTO `sys_log` VALUES (694, '会员72427039', 'webadmin/member/edit/84', 'member', 'edit', 84, '系统维护', 1, '2022-12-03 11:31:16');
INSERT INTO `sys_log` VALUES (695, NULL, 'webadmin/sysuser/login', 'sysuser', 'login', NULL, '系统维护', 1, '2022-12-03 20:38:26');
INSERT INTO `sys_log` VALUES (696, NULL, 'webadmin/sysuser/login', 'sysuser', 'login', NULL, '系统维护', 1, '2022-12-05 09:15:44');
INSERT INTO `sys_log` VALUES (697, NULL, 'webadmin/sysuser/login', 'sysuser', 'login', NULL, 'admin', 56, '2022-12-06 10:14:24');
INSERT INTO `sys_log` VALUES (698, '小船儿', 'webadmin/discuz/del', 'discuz', 'del', 41, 'admin', 56, '2022-12-06 10:18:27');
INSERT INTO `sys_log` VALUES (699, '一人一票规则', 'webadmin/vote/add', 'vote', 'add', NULL, 'admin', 56, '2022-12-06 10:26:25');
INSERT INTO `sys_log` VALUES (700, '一人一票规则', 'webadmin/vote/edit/16', 'vote', 'edit', 16, 'admin', 56, '2022-12-06 10:35:24');
INSERT INTO `sys_log` VALUES (701, '一人一票规则', 'webadmin/vote/edit/16', 'vote', 'edit', 16, 'admin', 56, '2022-12-06 10:37:41');
INSERT INTO `sys_log` VALUES (702, '规则', 'webadmin/vote/edit/16', 'vote', 'edit', 16, 'admin', 56, '2022-12-06 10:42:08');
INSERT INTO `sys_log` VALUES (703, '现金十元', 'webadmin/paimai/add', 'paimai', 'add', NULL, 'admin', 56, '2022-12-06 10:48:38');
INSERT INTO `sys_log` VALUES (704, '投票规则', 'webadmin/vote/edit/16', 'vote', 'edit', 16, 'admin', 56, '2022-12-06 10:51:05');
INSERT INTO `sys_log` VALUES (705, '投票规则', 'webadmin/vote/del', 'vote', 'del', 16, 'admin', 56, '2022-12-06 10:51:54');
INSERT INTO `sys_log` VALUES (706, '投票规则', 'webadmin/vote/add', 'vote', 'add', NULL, 'admin', 56, '2022-12-06 10:52:50');
INSERT INTO `sys_log` VALUES (707, '投票规则', 'webadmin/vote/edit/17', 'vote', 'edit', 17, 'admin', 56, '2022-12-06 10:53:41');
INSERT INTO `sys_log` VALUES (708, '现金十元', 'webadmin/paimai/edit/15', 'paimai', 'edit', 15, 'admin', 56, '2022-12-06 11:56:01');
INSERT INTO `sys_log` VALUES (709, NULL, 'webadmin/sysuser/login', 'sysuser', 'login', NULL, 'admin', 56, '2022-12-06 11:57:47');
INSERT INTO `sys_log` VALUES (710, NULL, 'webadmin/sysuser/login', 'sysuser', 'login', NULL, 'admin', 56, '2022-12-06 12:02:02');
INSERT INTO `sys_log` VALUES (711, '现金十元', 'webadmin/paimai/edit/15', 'paimai', 'edit', 15, 'admin', 56, '2022-12-06 12:02:22');
INSERT INTO `sys_log` VALUES (712, '现金十元', 'webadmin/paimai/edit/15', 'paimai', 'edit', 15, 'admin', 56, '2022-12-06 12:07:18');
INSERT INTO `sys_log` VALUES (713, '现金十元', 'webadmin/paimai/edit/15', 'paimai', 'edit', 15, 'admin', 56, '2022-12-06 12:07:33');
INSERT INTO `sys_log` VALUES (714, '现金十元', 'webadmin/paimai/edit/15', 'paimai', 'edit', 15, 'admin', 56, '2022-12-06 12:08:25');
INSERT INTO `sys_log` VALUES (715, '现金十元', 'webadmin/paimai/edit/15', 'paimai', 'edit', 15, 'admin', 56, '2022-12-06 12:08:43');
INSERT INTO `sys_log` VALUES (716, '现金十元', 'webadmin/paimai/edit/15', 'paimai', 'edit', 15, 'admin', 56, '2022-12-06 12:08:47');
INSERT INTO `sys_log` VALUES (717, NULL, 'webadmin/sysuser/login', 'sysuser', 'login', NULL, '系统维护', 1, '2022-12-06 13:57:35');
INSERT INTO `sys_log` VALUES (718, NULL, 'webadmin/pocket/edit/78', 'pocket', 'edit', 78, '系统维护', 1, '2022-12-06 13:58:41');
INSERT INTO `sys_log` VALUES (719, 'banner广告3', 'webadmin/section/edit/9', 'section', 'edit', 9, 'admin', 56, '2022-12-06 14:01:15');
INSERT INTO `sys_log` VALUES (720, 'banner广告3', 'webadmin/section/edit/9', 'section', 'edit', 9, 'admin', 56, '2022-12-06 14:03:16');
INSERT INTO `sys_log` VALUES (721, 'banner广告3', 'webadmin/section/edit/9', 'section', 'edit', 9, 'admin', 56, '2022-12-06 14:03:44');
INSERT INTO `sys_log` VALUES (722, 'banner广告2', 'webadmin/section/edit/11', 'section', 'edit', 11, '系统维护', 1, '2022-12-06 14:50:59');
INSERT INTO `sys_log` VALUES (723, 'banner广告1', 'webadmin/section/edit/10', 'section', 'edit', 10, '系统维护', 1, '2022-12-06 14:51:04');
INSERT INTO `sys_log` VALUES (724, 'banner广告3', 'webadmin/section/edit/9', 'section', 'edit', 9, '系统维护', 1, '2022-12-06 14:51:08');
INSERT INTO `sys_log` VALUES (725, 'banner广告2', 'webadmin/section/edit/11', 'section', 'edit', 11, '系统维护', 1, '2022-12-06 14:51:22');
INSERT INTO `sys_log` VALUES (726, '标签', 'webadmin/sysdict/edit/27', 'sysdict', 'edit', 27, '系统维护', 1, '2022-12-06 14:51:38');
INSERT INTO `sys_log` VALUES (727, 'banner广告2', 'webadmin/section/edit/11', 'section', 'edit', 11, '系统维护', 1, '2022-12-06 14:51:47');
INSERT INTO `sys_log` VALUES (728, NULL, 'webadmin/sysuser/login', 'sysuser', 'login', NULL, '系统维护', 1, '2022-12-06 19:41:56');
INSERT INTO `sys_log` VALUES (729, NULL, 'webadmin/sysuser/login', 'sysuser', 'login', NULL, '系统维护', 1, '2022-12-07 09:40:16');
INSERT INTO `sys_log` VALUES (730, NULL, 'webadmin/sysuser/login', 'sysuser', 'login', NULL, '系统维护', 1, '2022-12-07 15:14:32');
INSERT INTO `sys_log` VALUES (731, NULL, 'webadmin/sysuser/login', 'sysuser', 'login', NULL, '系统维护', 1, '2022-12-07 19:11:58');
INSERT INTO `sys_log` VALUES (732, NULL, 'webadmin/sysuser/login', 'sysuser', 'login', NULL, '系统维护', 1, '2022-12-08 18:09:27');
INSERT INTO `sys_log` VALUES (733, NULL, 'webadmin/sysuser/login', 'sysuser', 'login', NULL, '系统维护', 1, '2022-12-09 07:22:15');
INSERT INTO `sys_log` VALUES (734, '微信授权', 'webadmin/sysdict/edit/29', 'sysdict', 'edit', 29, '系统维护', 1, '2022-12-09 08:25:43');
INSERT INTO `sys_log` VALUES (735, '微信授权', 'webadmin/sysdict/edit/29', 'sysdict', 'edit', 29, '系统维护', 1, '2022-12-09 08:26:27');
INSERT INTO `sys_log` VALUES (736, NULL, 'webadmin/sysuser/login', 'sysuser', 'login', NULL, '系统维护', 1, '2022-12-09 16:25:02');
INSERT INTO `sys_log` VALUES (737, NULL, 'webadmin/sysuser/login', 'sysuser', 'login', NULL, '系统维护', 1, '2022-12-09 19:37:20');
INSERT INTO `sys_log` VALUES (738, NULL, 'webadmin/sysuser/login', 'sysuser', 'login', NULL, '系统维护', 1, '2022-12-10 09:06:36');
INSERT INTO `sys_log` VALUES (739, NULL, 'webadmin/sysuser/login', 'sysuser', 'login', NULL, '系统维护', 1, '2022-12-10 14:19:39');
INSERT INTO `sys_log` VALUES (740, NULL, 'webadmin/sysuser/login', 'sysuser', 'login', NULL, '系统维护', 1, '2022-12-10 17:11:33');
INSERT INTO `sys_log` VALUES (741, NULL, 'webadmin/sysuser/login', 'sysuser', 'login', NULL, '系统维护', 1, '2022-12-11 09:57:26');
INSERT INTO `sys_log` VALUES (742, NULL, 'webadmin/sysuser/login', 'sysuser', 'login', NULL, '系统维护', 1, '2022-12-11 14:25:29');
INSERT INTO `sys_log` VALUES (743, NULL, 'webadmin/sysuser/login', 'sysuser', 'login', NULL, '系统维护', 1, '2022-12-11 19:33:01');
INSERT INTO `sys_log` VALUES (744, NULL, 'webadmin/sysuser/login', 'sysuser', 'login', NULL, '系统维护', 1, '2022-12-12 07:25:06');
INSERT INTO `sys_log` VALUES (745, NULL, 'webadmin/sysuser/login', 'sysuser', 'login', NULL, '系统维护', 1, '2022-12-12 14:28:30');
INSERT INTO `sys_log` VALUES (746, NULL, 'webadmin/sysuser/login', 'sysuser', 'login', NULL, '系统维护', 1, '2022-12-12 20:55:44');
INSERT INTO `sys_log` VALUES (747, NULL, 'webadmin/sysuser/login', 'sysuser', 'login', NULL, '系统维护', 1, '2023-01-09 13:46:15');
INSERT INTO `sys_log` VALUES (748, '会员30770435', 'webadmin/chatcontent/del', 'chatcontent', 'del', 7, '系统维护', 1, '2023-01-09 13:48:22');
INSERT INTO `sys_log` VALUES (749, NULL, 'webadmin/chatcontent/del', 'chatcontent', 'del', 3, '系统维护', 1, '2023-01-09 13:48:26');
INSERT INTO `sys_log` VALUES (750, NULL, 'webadmin/chatcontent/del', 'chatcontent', 'del', 2, '系统维护', 1, '2023-01-09 13:48:28');
INSERT INTO `sys_log` VALUES (751, '成员组', 'webadmin/chatroom/edit/4', 'chatroom', 'edit', 4, '系统维护', 1, '2023-01-09 13:50:58');
INSERT INTO `sys_log` VALUES (752, '会员66835789', 'webadmin/chatcontent/del', 'chatcontent', 'del', 132, '系统维护', 1, '2023-01-09 13:57:45');
INSERT INTO `sys_log` VALUES (753, '第二二二二一', 'webadmin/chatroom/del', 'chatroom', 'del', 2, '系统维护', 1, '2023-01-09 14:00:29');
INSERT INTO `sys_log` VALUES (754, '第三世界2', 'webadmin/chatroom/del', 'chatroom', 'del', 3, '系统维护', 1, '2023-01-09 14:00:34');
INSERT INTO `sys_log` VALUES (755, '这个聊天室很可爱', 'webadmin/chatroom/edit/5', 'chatroom', 'edit', 5, '系统维护', 1, '2023-01-09 14:25:30');
INSERT INTO `sys_log` VALUES (756, '管理员', 'webadmin/sysrole/edit/13', 'sysrole', 'edit', 13, '系统维护', 1, '2023-01-09 14:25:49');
INSERT INTO `sys_log` VALUES (757, NULL, 'webadmin/sysuser/login', 'sysuser', 'login', NULL, 'admin', 56, '2023-01-09 14:25:59');
INSERT INTO `sys_log` VALUES (758, '复仇者联盟', 'webadmin/chatcontent/del', 'chatcontent', 'del', 61, 'admin', 56, '2023-01-09 14:26:13');
INSERT INTO `sys_log` VALUES (759, '复仇者联盟', 'webadmin/chatcontent/del', 'chatcontent', 'del', 59, 'admin', 56, '2023-01-09 14:26:19');
INSERT INTO `sys_log` VALUES (760, NULL, 'webadmin/sysuser/login', 'sysuser', 'login', NULL, '系统维护', 1, '2023-01-09 14:27:55');
INSERT INTO `sys_log` VALUES (761, '管理员', 'webadmin/sysrole/edit/13', 'sysrole', 'edit', 13, '系统维护', 1, '2023-01-09 14:28:04');
INSERT INTO `sys_log` VALUES (762, NULL, 'webadmin/sysuser/login', 'sysuser', 'login', NULL, 'admin', 56, '2023-01-09 14:28:14');
INSERT INTO `sys_log` VALUES (763, NULL, 'webadmin/sysuser/login', 'sysuser', 'login', NULL, '系统维护', 1, '2023-01-11 10:25:02');
INSERT INTO `sys_log` VALUES (764, NULL, 'webadmin/sysuser/login', 'sysuser', 'login', NULL, '系统维护', 1, '2023-01-13 18:15:00');
INSERT INTO `sys_log` VALUES (765, NULL, 'webadmin/sysuser/login', 'sysuser', 'login', NULL, '系统维护', 1, '2023-01-15 08:20:54');
INSERT INTO `sys_log` VALUES (766, NULL, 'webadmin/sysuser/login', 'sysuser', 'login', NULL, 'admin', 56, '2023-01-15 08:34:46');
INSERT INTO `sys_log` VALUES (767, NULL, 'webadmin/sysuser/login', 'sysuser', 'login', NULL, '系统维护', 1, '2023-01-15 08:47:16');
INSERT INTO `sys_log` VALUES (768, NULL, 'webadmin/sysuser/login', 'sysuser', 'login', NULL, 'admin', 56, '2023-01-16 16:48:42');
INSERT INTO `sys_log` VALUES (769, NULL, 'webadmin/sysuser/login', 'sysuser', 'login', NULL, '系统维护', 1, '2023-04-14 13:38:54');
INSERT INTO `sys_log` VALUES (770, NULL, 'webadmin/pocket/edit/60', 'pocket', 'edit', 60, '系统维护', 1, '2023-04-14 13:58:06');
INSERT INTO `sys_log` VALUES (771, NULL, 'webadmin/sysuser/login', 'sysuser', 'login', NULL, 'admin', 56, '2023-04-22 20:01:56');
INSERT INTO `sys_log` VALUES (772, '会员24840400', 'webadmin/member/del', 'member', 'del', 111, 'admin', 56, '2023-04-22 20:03:47');
INSERT INTO `sys_log` VALUES (773, '会员50713822', 'webadmin/member/del', 'member', 'del', 110, 'admin', 56, '2023-04-22 20:03:54');
INSERT INTO `sys_log` VALUES (774, '会员43686883', 'webadmin/member/del', 'member', 'del', 109, 'admin', 56, '2023-04-22 20:04:07');
INSERT INTO `sys_log` VALUES (775, '会员87231728', 'webadmin/member/del', 'member', 'del', 108, 'admin', 56, '2023-04-22 20:04:14');
INSERT INTO `sys_log` VALUES (776, '会员111222', 'webadmin/member/del', 'member', 'del', 106, 'admin', 56, '2023-04-22 20:04:24');
INSERT INTO `sys_log` VALUES (777, '会员84139522', 'webadmin/member/del', 'member', 'del', 99, 'admin', 56, '2023-04-22 20:05:04');
INSERT INTO `sys_log` VALUES (778, '会员35077561', 'webadmin/member/del', 'member', 'del', 100, 'admin', 56, '2023-04-22 20:05:10');
INSERT INTO `sys_log` VALUES (779, '冯立唯', 'webadmin/member/del', 'member', 'del', 98, 'admin', 56, '2023-04-22 20:05:16');
INSERT INTO `sys_log` VALUES (780, '会员79164123', 'webadmin/member/del', 'member', 'del', 105, 'admin', 56, '2023-04-22 20:06:58');
INSERT INTO `sys_log` VALUES (781, '会员14007679', 'webadmin/member/del', 'member', 'del', 104, 'admin', 56, '2023-04-22 20:07:04');
INSERT INTO `sys_log` VALUES (782, '会员69019288', 'webadmin/member/del', 'member', 'del', 103, 'admin', 56, '2023-04-22 20:07:08');
INSERT INTO `sys_log` VALUES (783, '会员91362660', 'webadmin/member/del', 'member', 'del', 102, 'admin', 56, '2023-04-22 20:07:12');
INSERT INTO `sys_log` VALUES (784, '会员26636409', 'webadmin/member/del', 'member', 'del', 93, 'admin', 56, '2023-04-22 20:07:30');
INSERT INTO `sys_log` VALUES (785, '会员20106463', 'webadmin/member/del', 'member', 'del', 92, 'admin', 56, '2023-04-22 20:07:33');
INSERT INTO `sys_log` VALUES (786, '会员50141377', 'webadmin/member/del', 'member', 'del', 91, 'admin', 56, '2023-04-22 20:07:36');
INSERT INTO `sys_log` VALUES (787, '会员20113827', 'webadmin/member/del', 'member', 'del', 90, 'admin', 56, '2023-04-22 20:07:39');
INSERT INTO `sys_log` VALUES (788, '会员66835789', 'webadmin/member/del', 'member', 'del', 89, 'admin', 56, '2023-04-22 20:07:49');
INSERT INTO `sys_log` VALUES (789, '我是谁？', 'webadmin/member/del', 'member', 'del', 87, 'admin', 56, '2023-04-22 20:07:56');
INSERT INTO `sys_log` VALUES (790, '会员9809351', 'webadmin/member/del', 'member', 'del', 85, 'admin', 56, '2023-04-22 20:08:07');
INSERT INTO `sys_log` VALUES (791, '会员72427039', 'webadmin/member/del', 'member', 'del', 84, 'admin', 56, '2023-04-22 20:08:11');
INSERT INTO `sys_log` VALUES (792, '用户46184239', 'webadmin/member/del', 'member', 'del', 75, 'admin', 56, '2023-04-22 20:08:20');
INSERT INTO `sys_log` VALUES (793, '用户84556376', 'webadmin/member/del', 'member', 'del', 74, 'admin', 56, '2023-04-22 20:08:24');
INSERT INTO `sys_log` VALUES (794, '用户55843569', 'webadmin/member/del', 'member', 'del', 73, 'admin', 56, '2023-04-22 20:08:27');
INSERT INTO `sys_log` VALUES (795, '用户71254868', 'webadmin/member/del', 'member', 'del', 72, 'admin', 56, '2023-04-22 20:08:30');
INSERT INTO `sys_log` VALUES (796, '用户7583829', 'webadmin/member/del', 'member', 'del', 71, 'admin', 56, '2023-04-22 20:08:33');
INSERT INTO `sys_log` VALUES (797, '用户45990660', 'webadmin/member/del', 'member', 'del', 70, 'admin', 56, '2023-04-22 20:08:36');
INSERT INTO `sys_log` VALUES (798, '用户64641337', 'webadmin/member/del', 'member', 'del', 69, 'admin', 56, '2023-04-22 20:08:39');
INSERT INTO `sys_log` VALUES (799, '用户76068731', 'webadmin/member/del', 'member', 'del', 68, 'admin', 56, '2023-04-22 20:08:43');
INSERT INTO `sys_log` VALUES (800, '用户33562474', 'webadmin/member/del', 'member', 'del', 67, 'admin', 56, '2023-04-22 20:08:46');
INSERT INTO `sys_log` VALUES (801, '用户714980', 'webadmin/member/del', 'member', 'del', 66, 'admin', 56, '2023-04-22 20:08:48');
INSERT INTO `sys_log` VALUES (802, '会员6892945', 'webadmin/member/del', 'member', 'del', 97, 'admin', 56, '2023-04-22 20:10:20');
INSERT INTO `sys_log` VALUES (803, '会员59692621', 'webadmin/member/del', 'member', 'del', 96, 'admin', 56, '2023-04-22 20:10:24');
INSERT INTO `sys_log` VALUES (804, '会员439818', 'webadmin/member/del', 'member', 'del', 95, 'admin', 56, '2023-04-22 20:10:27');
INSERT INTO `sys_log` VALUES (805, '冯立唯', 'webadmin/member/del', 'member', 'del', 94, 'admin', 56, '2023-04-22 20:10:31');
INSERT INTO `sys_log` VALUES (806, '复仇者联盟', 'webadmin/member/del', 'member', 'del', 60, 'admin', 56, '2023-04-22 20:10:39');
INSERT INTO `sys_log` VALUES (807, '用户123122', 'webadmin/member/del', 'member', 'del', 61, 'admin', 56, '2023-04-22 20:10:44');
INSERT INTO `sys_log` VALUES (808, '用户771776', 'webadmin/member/del', 'member', 'del', 65, 'admin', 56, '2023-04-22 20:10:51');
INSERT INTO `sys_log` VALUES (809, '用户3595417', 'webadmin/member/del', 'member', 'del', 76, 'admin', 56, '2023-04-22 20:10:54');
INSERT INTO `sys_log` VALUES (810, '会员14591117', 'webadmin/member/del', 'member', 'del', 77, 'admin', 56, '2023-04-22 20:10:56');
INSERT INTO `sys_log` VALUES (811, '会员66278722', 'webadmin/member/del', 'member', 'del', 78, 'admin', 56, '2023-04-22 20:10:59');
INSERT INTO `sys_log` VALUES (812, '会员18313734', 'webadmin/member/del', 'member', 'del', 79, 'admin', 56, '2023-04-22 20:11:01');
INSERT INTO `sys_log` VALUES (813, '会员30770435', 'webadmin/member/del', 'member', 'del', 80, 'admin', 56, '2023-04-22 20:11:04');
INSERT INTO `sys_log` VALUES (814, '会员92349465', 'webadmin/member/del', 'member', 'del', 81, 'admin', 56, '2023-04-22 20:11:06');
INSERT INTO `sys_log` VALUES (815, '会员22984401', 'webadmin/member/del', 'member', 'del', 83, 'admin', 56, '2023-04-22 20:11:24');
INSERT INTO `sys_log` VALUES (816, '会员27598159', 'webadmin/member/del', 'member', 'del', 82, 'admin', 56, '2023-04-22 20:11:27');
INSERT INTO `sys_log` VALUES (817, '让百姓拥有自己的经济力量', 'webadmin/chatroom/add', 'chatroom', 'add', 0, 'admin', 56, '2023-04-22 20:15:55');
INSERT INTO `sys_log` VALUES (818, '广告交友，百无禁忌', 'webadmin/chatroom/edit/1', 'chatroom', 'edit', 1, 'admin', 56, '2023-04-22 20:18:14');
INSERT INTO `sys_log` VALUES (819, '心理情感交流群', 'webadmin/chatroom/edit/5', 'chatroom', 'edit', 5, 'admin', 56, '2023-04-22 20:20:49');
INSERT INTO `sys_log` VALUES (820, '闲聊群', 'webadmin/chatroom/edit/4', 'chatroom', 'edit', 4, 'admin', 56, '2023-04-22 20:21:34');
INSERT INTO `sys_log` VALUES (821, '网站游戏交流群', 'webadmin/chatroom/add', 'chatroom', 'add', 0, 'admin', 56, '2023-04-22 20:22:44');
INSERT INTO `sys_log` VALUES (822, 'banner广告3', 'webadmin/section/edit/9', 'section', 'edit', 9, 'admin', 56, '2023-04-22 20:29:06');
INSERT INTO `sys_log` VALUES (823, 'banner广告3', 'webadmin/section/edit/9', 'section', 'edit', 9, 'admin', 56, '2023-04-22 20:30:27');
INSERT INTO `sys_log` VALUES (824, 'banner广告3', 'webadmin/section/edit/9', 'section', 'edit', 9, 'admin', 56, '2023-04-22 20:33:23');
INSERT INTO `sys_log` VALUES (825, '现金十元', 'webadmin/paimai/del', 'paimai', 'del', 15, 'admin', 56, '2023-04-22 20:35:01');
INSERT INTO `sys_log` VALUES (826, '出售出售出售', 'webadmin/paimai/del', 'paimai', 'del', 14, 'admin', 56, '2023-04-22 20:35:07');
INSERT INTO `sys_log` VALUES (827, 'test50', 'webadmin/paimai/del', 'paimai', 'del', 13, 'admin', 56, '2023-04-22 20:35:10');
INSERT INTO `sys_log` VALUES (828, '出售50', 'webadmin/paimai/del', 'paimai', 'del', 12, 'admin', 56, '2023-04-22 20:35:13');
INSERT INTO `sys_log` VALUES (829, '300Money出售', 'webadmin/paimai/del', 'paimai', 'del', 11, 'admin', 56, '2023-04-22 20:35:16');
INSERT INTO `sys_log` VALUES (830, 'money很多很多', 'webadmin/paimai/del', 'paimai', 'del', 10, 'admin', 56, '2023-04-22 20:35:22');
INSERT INTO `sys_log` VALUES (831, '测试是否过期', 'webadmin/paimai/del', 'paimai', 'del', 9, 'admin', 56, '2023-04-22 20:35:25');
INSERT INTO `sys_log` VALUES (832, '出888', 'webadmin/paimai/del', 'paimai', 'del', 8, 'admin', 56, '2023-04-22 20:35:28');
INSERT INTO `sys_log` VALUES (833, '现金250先到先得', 'webadmin/paimai/del', 'paimai', 'del', 7, 'admin', 56, '2023-04-22 20:35:30');
INSERT INTO `sys_log` VALUES (834, '出售现金300元人民币', 'webadmin/paimai/del', 'paimai', 'del', 6, 'admin', 56, '2023-04-22 20:35:34');
INSERT INTO `sys_log` VALUES (835, '现金10元', 'webadmin/paimai/add', 'paimai', 'add', NULL, 'admin', 56, '2023-04-22 20:36:58');
INSERT INTO `sys_log` VALUES (836, 'testtest', 'webadmin/paimai/del', 'paimai', 'del', 5, 'admin', 56, '2023-04-22 20:37:16');
INSERT INTO `sys_log` VALUES (837, '4级杀手', 'webadmin/paimai/del', 'paimai', 'del', 4, 'admin', 56, '2023-04-22 20:37:21');
INSERT INTO `sys_log` VALUES (838, '出售100元', 'webadmin/paimai/del', 'paimai', 'del', 3, 'admin', 56, '2023-04-22 20:37:24');
INSERT INTO `sys_log` VALUES (839, '资深', 'webadmin/paimai/del', 'paimai', 'del', 2, 'admin', 56, '2023-04-22 20:37:26');
INSERT INTO `sys_log` VALUES (840, '1级', 'webadmin/paimai/del', 'paimai', 'del', 1, 'admin', 56, '2023-04-22 20:37:28');
INSERT INTO `sys_log` VALUES (841, '现金20元', 'webadmin/paimai/add', 'paimai', 'add', NULL, 'admin', 56, '2023-04-22 20:38:50');
INSERT INTO `sys_log` VALUES (842, '冯立唯', 'webadmin/discuz/del', 'discuz', 'del', 58, 'admin', 56, '2023-04-22 20:39:33');
INSERT INTO `sys_log` VALUES (843, '冯立唯', 'webadmin/discuz/del', 'discuz', 'del', 57, 'admin', 56, '2023-04-22 20:39:37');
INSERT INTO `sys_log` VALUES (844, '', 'webadmin/discuz/del', 'discuz', 'del', 56, 'admin', 56, '2023-04-22 20:39:42');
INSERT INTO `sys_log` VALUES (845, '', 'webadmin/discuz/del', 'discuz', 'del', 52, 'admin', 56, '2023-04-22 20:39:47');
INSERT INTO `sys_log` VALUES (846, '小船儿', 'webadmin/discuz/del', 'discuz', 'del', 55, 'admin', 56, '2023-04-22 20:39:53');
INSERT INTO `sys_log` VALUES (847, '小船儿', 'webadmin/discuz/del', 'discuz', 'del', 54, 'admin', 56, '2023-04-22 20:39:56');
INSERT INTO `sys_log` VALUES (848, '小船儿', 'webadmin/discuz/del', 'discuz', 'del', 53, 'admin', 56, '2023-04-22 20:39:59');
INSERT INTO `sys_log` VALUES (849, '小船儿', 'webadmin/discuz/del', 'discuz', 'del', 51, 'admin', 56, '2023-04-22 20:40:02');
INSERT INTO `sys_log` VALUES (850, '世界第一等', 'webadmin/discuz/del', 'discuz', 'del', 50, 'admin', 56, '2023-04-22 20:40:05');
INSERT INTO `sys_log` VALUES (851, '世界第一等', 'webadmin/discuz/del', 'discuz', 'del', 49, 'admin', 56, '2023-04-22 20:40:08');
INSERT INTO `sys_log` VALUES (852, '', 'webadmin/discuz/del', 'discuz', 'del', 37, 'admin', 56, '2023-04-22 20:40:14');
INSERT INTO `sys_log` VALUES (853, '', 'webadmin/discuz/del', 'discuz', 'del', 36, 'admin', 56, '2023-04-22 20:40:17');
INSERT INTO `sys_log` VALUES (854, '', 'webadmin/discuz/del', 'discuz', 'del', 30, 'admin', 56, '2023-04-22 20:40:22');
INSERT INTO `sys_log` VALUES (855, '', 'webadmin/discuz/del', 'discuz', 'del', 29, 'admin', 56, '2023-04-22 20:40:26');
INSERT INTO `sys_log` VALUES (856, '', 'webadmin/discuz/del', 'discuz', 'del', 28, 'admin', 56, '2023-04-22 20:40:29');
INSERT INTO `sys_log` VALUES (857, '', 'webadmin/discuz/del', 'discuz', 'del', 13, 'admin', 56, '2023-04-22 20:40:54');
INSERT INTO `sys_log` VALUES (858, '', 'webadmin/discuz/del', 'discuz', 'del', 14, 'admin', 56, '2023-04-22 20:40:57');
INSERT INTO `sys_log` VALUES (859, '世界第一等', 'webadmin/discuz/del', 'discuz', 'del', 47, 'admin', 56, '2023-04-22 20:42:00');
INSERT INTO `sys_log` VALUES (860, '小船儿', 'webadmin/discuz/del', 'discuz', 'del', 44, 'admin', 56, '2023-04-22 20:42:03');
INSERT INTO `sys_log` VALUES (861, '', 'webadmin/discuz/del', 'discuz', 'del', 40, 'admin', 56, '2023-04-22 20:42:05');
INSERT INTO `sys_log` VALUES (862, '', 'webadmin/discuz/del', 'discuz', 'del', 39, 'admin', 56, '2023-04-22 20:42:07');
INSERT INTO `sys_log` VALUES (863, '', 'webadmin/discuz/del', 'discuz', 'del', 38, 'admin', 56, '2023-04-22 20:42:10');
INSERT INTO `sys_log` VALUES (864, '', 'webadmin/discuz/del', 'discuz', 'del', 10, 'admin', 56, '2023-04-22 20:42:33');
INSERT INTO `sys_log` VALUES (865, '关于讨论一下这个是需要房东真的萨沙', 'webadmin/discuz/del', 'discuz', 'del', 9, 'admin', 56, '2023-04-22 20:42:35');
INSERT INTO `sys_log` VALUES (866, '你是第几级杀手？', 'webadmin/discuz/del', 'discuz', 'del', 4, 'admin', 56, '2023-04-22 20:42:37');
INSERT INTO `sys_log` VALUES (867, '出售100元', 'webadmin/discuz/del', 'discuz', 'del', 3, 'admin', 56, '2023-04-22 20:42:39');
INSERT INTO `sys_log` VALUES (868, '调查一下看看22', 'webadmin/discuz/del', 'discuz', 'del', 1, 'admin', 56, '2023-04-22 20:42:41');
INSERT INTO `sys_log` VALUES (869, '世界第一等', 'webadmin/discuz/del', 'discuz', 'del', 27, 'admin', 56, '2023-04-22 20:42:47');
INSERT INTO `sys_log` VALUES (870, '世界第一等', 'webadmin/discuz/del', 'discuz', 'del', 26, 'admin', 56, '2023-04-22 20:42:49');
INSERT INTO `sys_log` VALUES (871, 'banner广告3', 'webadmin/section/edit/9', 'section', 'edit', 9, 'admin', 56, '2023-04-22 20:53:54');
INSERT INTO `sys_log` VALUES (872, 'banner广告3', 'webadmin/section/edit/9', 'section', 'edit', 9, 'admin', 56, '2023-04-22 20:55:08');
INSERT INTO `sys_log` VALUES (873, '现金20元', 'webadmin/paimai/edit/17', 'paimai', 'edit', 17, 'admin', 56, '2023-04-22 20:56:00');
INSERT INTO `sys_log` VALUES (874, NULL, 'webadmin/sysuser/login', 'sysuser', 'login', NULL, '系统维护', 1, '2023-04-22 21:03:21');
INSERT INTO `sys_log` VALUES (875, NULL, 'webadmin/sysuser/login', 'sysuser', 'login', NULL, '系统维护', 1, '2023-04-23 08:32:07');
INSERT INTO `sys_log` VALUES (876, '', 'webadmin/discuz/del', 'discuz', 'del', 46, '系统维护', 1, '2023-04-23 08:34:05');
INSERT INTO `sys_log` VALUES (877, '现金20元', 'webadmin/paimai/edit/17', 'paimai', 'edit', 17, '系统维护', 1, '2023-04-23 09:20:00');
INSERT INTO `sys_log` VALUES (878, '世界第一等', 'webadmin/member/edit/86', 'member', 'edit', 86, '系统维护', 1, '2023-04-23 10:10:37');
INSERT INTO `sys_log` VALUES (879, NULL, 'webadmin/pocket/edit/86', 'pocket', 'edit', 86, '系统维护', 1, '2023-04-23 10:11:56');
INSERT INTO `sys_log` VALUES (880, NULL, 'webadmin/sysuser/login', 'sysuser', 'login', NULL, '系统维护', 1, '2023-04-23 13:34:46');
INSERT INTO `sys_log` VALUES (881, NULL, 'webadmin/sysuser/login', 'sysuser', 'login', NULL, '系统维护', 1, '2023-04-25 14:56:10');
INSERT INTO `sys_log` VALUES (882, NULL, 'webadmin/sysuser/login', 'sysuser', 'login', NULL, '系统维护', 1, '2023-05-11 19:24:04');
INSERT INTO `sys_log` VALUES (883, NULL, 'webadmin/sysuser/login', 'sysuser', 'login', NULL, '系统维护', 1, '2023-05-18 09:34:12');
INSERT INTO `sys_log` VALUES (884, NULL, 'webadmin/sysuser/login', 'sysuser', 'login', NULL, '系统维护', 1, '2023-05-18 14:18:28');
INSERT INTO `sys_log` VALUES (885, NULL, 'webadmin/sysuser/login', 'sysuser', 'login', NULL, 'admin', 56, '2023-05-18 16:46:53');
INSERT INTO `sys_log` VALUES (886, '现金10元', 'webadmin/paimai/add', 'paimai', 'add', NULL, 'admin', 56, '2023-05-18 16:48:28');
INSERT INTO `sys_log` VALUES (887, '现金10元', 'webadmin/paimai/edit/18', 'paimai', 'edit', 18, 'admin', 56, '2023-05-18 17:00:08');
INSERT INTO `sys_log` VALUES (888, '闲聊群', 'webadmin/chatroom/del', 'chatroom', 'del', 4, 'admin', 56, '2023-05-18 17:01:36');
INSERT INTO `sys_log` VALUES (889, '心理情感交流群', 'webadmin/chatroom/del', 'chatroom', 'del', 5, 'admin', 56, '2023-05-18 17:01:49');
INSERT INTO `sys_log` VALUES (890, '心理咨询', 'webadmin/chatroom/add', 'chatroom', 'add', 0, 'admin', 56, '2023-05-18 17:03:21');
INSERT INTO `sys_log` VALUES (891, NULL, 'webadmin/sysuser/login', 'sysuser', 'login', NULL, '系统维护', 1, '2023-05-22 13:23:18');
INSERT INTO `sys_log` VALUES (892, '现金99', 'webadmin/paimai/add', 'paimai', 'add', NULL, '系统维护', 1, '2023-05-22 13:52:52');
INSERT INTO `sys_log` VALUES (893, '现金99', 'webadmin/paimai/edit/19', 'paimai', 'edit', 19, '系统维护', 1, '2023-05-22 14:00:23');
INSERT INTO `sys_log` VALUES (894, '88', 'webadmin/paimai/add', 'paimai', 'add', NULL, '系统维护', 1, '2023-05-22 14:01:09');
INSERT INTO `sys_log` VALUES (895, NULL, 'webadmin/sysuser/login', 'sysuser', 'login', NULL, 'admin', 56, '2023-05-22 18:11:30');
INSERT INTO `sys_log` VALUES (896, '现金10元', 'webadmin/paimai/add', 'paimai', 'add', NULL, 'admin', 56, '2023-05-22 18:12:35');
INSERT INTO `sys_log` VALUES (897, NULL, 'webadmin/sysuser/login', 'sysuser', 'login', NULL, 'admin', 56, '2023-05-23 12:27:31');
INSERT INTO `sys_log` VALUES (898, NULL, 'webadmin/sysuser/login', 'sysuser', 'login', NULL, '系统维护', 1, '2023-05-30 13:49:36');
INSERT INTO `sys_log` VALUES (899, NULL, 'webadmin/sysuser/login', 'sysuser', 'login', NULL, '系统维护', 1, '2023-06-05 08:45:04');
COMMIT;

-- ----------------------------
-- Table structure for sys_message
-- ----------------------------
DROP TABLE IF EXISTS `sys_message`;
CREATE TABLE `sys_message` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tag` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '业务标识',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '消息提示内容',
  `link` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '访问链接如果存在的话',
  `fromuid` int DEFAULT NULL COMMENT '触发者ID',
  `touid` int DEFAULT NULL COMMENT '接收者ID',
  `status` tinyint DEFAULT '1' COMMENT '消息状态',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `touid` (`touid`) USING BTREE,
  KEY `tag` (`tag`) USING BTREE,
  KEY `tag_2` (`tag`,`touid`) USING BTREE,
  KEY `tag_3` (`tag`,`fromuid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='消息记录表';

-- ----------------------------
-- Table structure for sys_module
-- ----------------------------
DROP TABLE IF EXISTS `sys_module`;
CREATE TABLE `sys_module` (
  `mid` int NOT NULL AUTO_INCREMENT,
  `pmid` int DEFAULT NULL COMMENT '所属父类ID',
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '菜单名称',
  `code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '功能编码标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'ICON图标标识',
  `actions` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '子功能配置',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '访问路径',
  `sort` int DEFAULT '0' COMMENT '字段排序',
  `status` tinyint DEFAULT '1',
  `adduid` int DEFAULT NULL COMMENT '添加者ID',
  `edituid` int DEFAULT NULL COMMENT '最后编辑者ID',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`mid`) USING BTREE,
  KEY `pmid` (`pmid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='模块菜单配置表';

-- ----------------------------
-- Records of sys_module
-- ----------------------------
BEGIN;
INSERT INTO `sys_module` VALUES (1, 0, '系统管理', '', 'layui-icon-set-sm', '', NULL, 0, 1, NULL, NULL, '2022-03-19 13:58:06', NULL, NULL);
INSERT INTO `sys_module` VALUES (2, 0, '会员管理', '', 'layui-icon-user', '', NULL, 1, 1, NULL, NULL, '2022-03-19 13:58:25', NULL, NULL);
INSERT INTO `sys_module` VALUES (3, 0, '内容管理', '', 'layui-icon-template-1', '', NULL, 2, 1, NULL, NULL, '2022-03-19 13:58:49', NULL, NULL);
INSERT INTO `sys_module` VALUES (9, 1, '系统帐号', 'sysuser', 'layui-icon-set-sm', 'index,add,edit,del,setmine,priv', NULL, 0, 1, NULL, NULL, '2022-03-19 14:06:31', NULL, NULL);
INSERT INTO `sys_module` VALUES (10, 1, '数据字典', 'sysdict', '', 'index,add,edit,del', NULL, 0, 1, NULL, NULL, '2022-03-19 14:07:31', NULL, NULL);
INSERT INTO `sys_module` VALUES (18, 1, '角色管理', 'sysrole', '', 'index,add,edit,del', NULL, 0, 1, NULL, NULL, '2022-03-19 14:33:34', NULL, NULL);
INSERT INTO `sys_module` VALUES (20, 1, '通用配置', 'sysconf', '', 'index,edit,del', NULL, -1, 0, NULL, NULL, '2022-03-19 21:37:20', NULL, NULL);
INSERT INTO `sys_module` VALUES (21, 2, '等级配置', 'level', NULL, 'index,add,edit,del', NULL, 0, 1, NULL, NULL, '2022-03-19 21:43:29', NULL, NULL);
INSERT INTO `sys_module` VALUES (22, 2, '会员信息', 'member', 'layui-icon-group', 'index,edit,del,priv', NULL, 0, 1, NULL, NULL, '2022-03-19 21:45:05', NULL, NULL);
INSERT INTO `sys_module` VALUES (23, 1, '系统日志', 'syslog', NULL, 'index,clear,priv', NULL, 0, 1, NULL, NULL, '2022-03-26 13:49:02', NULL, NULL);
INSERT INTO `sys_module` VALUES (24, 2, '会员钱包', 'pocket', NULL, 'index,edit,view', NULL, 0, 1, NULL, NULL, '2022-11-05 10:19:35', NULL, NULL);
INSERT INTO `sys_module` VALUES (25, 3, '版块管理', 'section', NULL, 'index,add,edit,del', NULL, 0, 1, NULL, NULL, '2022-11-10 10:26:49', NULL, NULL);
INSERT INTO `sys_module` VALUES (26, 1, '附件管理', 'sysattach', NULL, 'index,del,upimage,upfile,priv', NULL, 0, 1, NULL, NULL, '2022-11-10 20:23:25', NULL, NULL);
INSERT INTO `sys_module` VALUES (27, 3, '拍卖管理', 'paimai', NULL, 'index,add,edit,del,view', NULL, 0, 1, NULL, NULL, '2022-11-22 14:02:32', NULL, NULL);
INSERT INTO `sys_module` VALUES (28, 3, '投票管理', 'vote', NULL, 'index,add,edit,del,view', NULL, 0, 1, NULL, NULL, '2022-11-23 10:16:12', NULL, NULL);
INSERT INTO `sys_module` VALUES (29, 3, '留言管理', 'discuz', NULL, 'index,del,delm', NULL, 0, 1, NULL, NULL, '2022-11-29 08:41:32', NULL, NULL);
INSERT INTO `sys_module` VALUES (30, 0, '聊天管理', '', 'layui-icon-dialogue', '', NULL, 1, 1, NULL, NULL, '2023-01-09 10:50:28', NULL, NULL);
INSERT INTO `sys_module` VALUES (31, 30, '聊天室管理', 'chatroom', NULL, 'index,add,edit,del', NULL, 0, 1, NULL, NULL, '2023-01-09 10:56:35', NULL, NULL);
INSERT INTO `sys_module` VALUES (32, 30, '聊天内容管理', 'chatcontent', NULL, 'index,del,delm', NULL, 0, 1, NULL, NULL, '2023-01-09 10:57:45', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `rid` int NOT NULL AUTO_INCREMENT,
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '角色名',
  `modulelist` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '模块授权列表',
  `memo` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `adduid` int DEFAULT NULL COMMENT '添加者ID',
  `edituid` int DEFAULT NULL COMMENT '最后编辑者ID',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`rid`) USING BTREE,
  KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='角色信息表';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
BEGIN;
INSERT INTO `sys_role` VALUES (2, '组长', '{\"paimai\":{\"index\":1,\"add\":1,\"edit\":1,\"del\":1,\"view\":1}}', '测试后台帐号', NULL, 56, '2022-03-15 21:19:52', '2022-11-25 10:55:52', NULL);
INSERT INTO `sys_role` VALUES (13, '管理员', '{\"sysuser\":{\"index\":1,\"add\":1,\"edit\":1,\"del\":1,\"setmine\":1},\"sysrole\":{\"index\":1,\"add\":1,\"edit\":1,\"del\":1},\"member\":{\"index\":1,\"edit\":1,\"del\":1},\"syslog\":{\"index\":1,\"clear\":1},\"pocket\":{\"index\":1,\"edit\":1,\"view\":1},\"section\":{\"index\":1,\"add\":1,\"edit\":1,\"del\":1},\"attach\":{\"del\":1,\"upimage\":1,\"upfile\":1},\"paimai\":{\"index\":1,\"add\":1,\"edit\":1,\"del\":1,\"view\":1},\"vote\":{\"index\":1,\"add\":1,\"edit\":1,\"del\":1,\"view\":1},\"discuz\":{\"index\":1,\"del\":1},\"chatroom\":{\"index\":1,\"add\":1,\"edit\":1,\"del\":1},\"chatcontent\":{\"index\":1,\"del\":1,\"delm\":1}}', '', 1, 1, '2022-11-18 07:43:51', '2023-01-09 14:28:04', NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `uid` int NOT NULL AUTO_INCREMENT,
  `username` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '登录帐号',
  `passwd` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '登录密码',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '姓名',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '头像',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `rid` tinyint DEFAULT NULL COMMENT '系统角色',
  `status` tinyint DEFAULT '0' COMMENT '帐号状态',
  `adduid` int DEFAULT NULL COMMENT '添加者ID',
  `edituid` int DEFAULT NULL COMMENT '最后编辑者ID',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`uid`) USING BTREE,
  UNIQUE KEY `username` (`username`) USING BTREE,
  KEY `adduid` (`adduid`) USING BTREE,
  KEY `deleted_at` (`deleted_at`) USING BTREE,
  KEY `rid` (`rid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='帐号信息表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
BEGIN;
INSERT INTO `sys_user` VALUES (1, 'eyoung', '$2y$10$sV6wJmo5zSu03b4zZfxP.uOb3RpbSQbENXuH94jBpqbbqhqk51nym', '系统维护', '/images/0.png', 'fdsaf@fdasf.com', '11111111111', 1, 1, NULL, 1, '2022-03-17 09:37:00', '2022-11-16 21:30:18', NULL);
INSERT INTO `sys_user` VALUES (13, 'test1', '$2y$10$xtQrUKWD20BzNIJnvTDkcep8jyoG7IhffVLuf2Uqwj1uKzNmiDuWe', '测试帐号', 'attach/thumb/1668149811_b38751392fc7d08df1b9.jpeg', NULL, NULL, 2, 1, 13, 1, '2022-03-17 09:52:31', '2022-11-29 17:12:46', '2022-11-29 17:12:46');
INSERT INTO `sys_user` VALUES (14, 'test2', '4297f44b13955235245b2497399d7a93', '小李', '/images/12.png', '', '13888888888', 4, 1, NULL, 12, '2022-03-17 09:52:32', '2022-11-25 11:10:01', '2022-11-25 11:10:01');
INSERT INTO `sys_user` VALUES (17, 'test', '$2y$10$6FHRG9tQKfQ/afoy0QZ26.6dtdMLsXddEodfJaIg0wZkh6e.MY1Mi', '戴1旭', '/images/24.png', NULL, NULL, 2, 1, NULL, 1, '2022-03-18 14:37:52', '2022-11-25 11:09:50', '2022-11-25 11:09:50');
INSERT INTO `sys_user` VALUES (23, 'test14', '4297f44b13955235245b2497399d7a93', 'kjhkhjk', '/images/default.png', NULL, NULL, 7, 0, NULL, NULL, '2022-03-24 20:55:51', '2022-03-25 10:29:55', '2022-03-25 10:29:55');
INSERT INTO `sys_user` VALUES (24, 'test10', '4297f44b13955235245b2497399d7a93', '库里南', '/images/default.png', '', NULL, 4, 1, NULL, 12, '2022-03-24 21:03:44', '2022-11-25 11:09:47', '2022-11-25 11:09:47');
INSERT INTO `sys_user` VALUES (25, 'test144', '4297f44b13955235245b2497399d7a93', 'kjhkhjk', '/images/default.png', NULL, NULL, 4, 1, NULL, 17, '2022-03-24 21:04:54', '2022-04-01 10:21:32', '2022-04-01 10:21:32');
INSERT INTO `sys_user` VALUES (26, '22222', '$2y$10$pkzWtqYEBDFjxhqLbgybie6H8xZj4vFJdOzzI8BChXS8p/CoBq3Tu', '嗨皮', '/images/default.png', NULL, NULL, 3, 1, NULL, 1, '2022-03-24 21:10:53', '2022-11-25 11:09:44', '2022-11-25 11:09:44');
INSERT INTO `sys_user` VALUES (31, 'test23', '$2y$10$z2CqlEaXeQygfNC2Fq/JNeSAjsnmcrP234QI8sesdthsxzUOnZS8y', '阿二', '/images/default.png', '', '', 4, 1, NULL, 12, '2022-03-25 10:12:25', '2022-11-18 07:42:42', '2022-11-18 07:42:42');
INSERT INTO `sys_user` VALUES (32, 'test24', '4297f44b13955235245b2497399d7a93', '阿二', '/images/default.png', NULL, NULL, 4, 1, 13, 13, '2022-03-25 10:12:53', '2022-04-14 08:31:37', '2022-04-14 08:31:37');
INSERT INTO `sys_user` VALUES (33, 'test25', 'e10adc3949ba59abbe56e057f20f883e', '阿二', '/images/13.png', '', NULL, 4, 1, 13, 13, '2022-03-25 10:13:17', '2022-04-14 08:31:41', '2022-04-14 08:31:41');
INSERT INTO `sys_user` VALUES (34, 'test11', '4297f44b13955235245b2497399d7a93', '123123', '/images/1.png', NULL, NULL, 3, 1, 13, NULL, '2022-03-25 19:54:03', '2022-03-25 19:54:10', '2022-03-25 19:54:10');
INSERT INTO `sys_user` VALUES (35, 'test1_1', '4297f44b13955235245b2497399d7a93', '1111', '/images/default.png', '', NULL, 4, 1, 13, 13, '2022-03-26 07:47:36', '2022-04-10 21:21:09', '2022-04-10 21:21:09');
INSERT INTO `sys_user` VALUES (36, 'test1_11', '4297f44b13955235245b2497399d7a93', '一一一', '/images/default.png', NULL, NULL, 4, 1, 13, NULL, '2022-03-26 09:29:47', '2022-03-26 11:59:04', '2022-03-26 11:59:04');
INSERT INTO `sys_user` VALUES (37, 'test1_13', '4297f44b13955235245b2497399d7a93', '一三', '/images/default.png', '', NULL, 6, 1, 13, 13, '2022-03-26 09:31:46', '2022-04-06 15:48:24', '2022-04-06 15:48:24');
INSERT INTO `sys_user` VALUES (38, '1111', '4297f44b13955235245b2497399d7a93', '1221', '/images/default.png', NULL, NULL, 5, 1, 13, 14, '2022-03-27 08:52:58', '2022-04-06 15:48:22', '2022-04-06 15:48:22');
INSERT INTO `sys_user` VALUES (39, 'fdsaf', '4297f44b13955235245b2497399d7a93', '123123', '/images/default.png', '', NULL, 5, 1, 13, 12, '2022-03-27 08:55:25', '2022-04-01 10:19:07', '2022-04-01 10:19:07');
INSERT INTO `sys_user` VALUES (40, 'fsaf', '4297f44b13955235245b2497399d7a93', '123123', '/images/default.png', NULL, NULL, 5, 1, 13, 12, '2022-03-27 08:58:05', '2022-04-06 15:48:20', '2022-04-06 15:48:20');
INSERT INTO `sys_user` VALUES (41, 'ttte', '4297f44b13955235245b2497399d7a93', '大熊', '/images/40.png', '', NULL, 4, 1, 17, 12, '2022-03-27 16:35:36', '2022-11-18 07:42:45', '2022-11-18 07:42:45');
INSERT INTO `sys_user` VALUES (42, 'test12', '4297f44b13955235245b2497399d7a93', '小蜜蜂', '/images/39.png', '', '', 4, 1, 14, 12, '2022-03-27 19:39:45', '2022-11-18 07:42:48', '2022-11-18 07:42:48');
INSERT INTO `sys_user` VALUES (43, 'aaaa', '4297f44b13955235245b2497399d7a93', 'aaaaa', '/images/default.png', '', NULL, 4, 0, 12, NULL, '2022-04-01 09:27:24', '2022-04-01 09:40:21', '2022-04-01 09:40:21');
INSERT INTO `sys_user` VALUES (44, 'test1111', '$2y$10$Xg8zJEnEAdFx948lkBcnoO.2FBrCip3t6pDUxD/3.A0PhWqzgLMmm', '一一一一', '/images/default.png', '', '', 4, 0, 12, 44, '2022-04-06 10:35:51', '2022-11-18 07:42:50', '2022-11-18 07:42:50');
INSERT INTO `sys_user` VALUES (45, 'tafds', '$2y$10$cVpCzDTZtLLeD99LNmG0/OlgdxdTaG3kXiUdz4YwFUWjtlG3oaGxu', '魂牵梦萦', '/images/12.png', '', '', 4, 0, 12, 1, '2022-04-08 10:15:17', '2022-11-18 07:42:35', '2022-11-18 07:42:35');
INSERT INTO `sys_user` VALUES (46, 'tttt', '$2y$10$LTkpSOWdK4akETyeWakttOO3eAiovTSLIr7h7qaWvTSgCkrFPTct6', '索飞亚', '/images/21.png', '', '', 4, 1, 12, 12, '2022-04-11 14:30:11', '2022-05-06 08:17:58', '2022-05-06 08:17:58');
INSERT INTO `sys_user` VALUES (47, 'test3', '$2y$10$hP5w7JD3jxIMqcg1bhzV0eNkFQBWc05AD30EkdOYgUo0SkvrrSOwC', '阿三', '/images/38.png', '', NULL, 4, 1, 12, NULL, '2022-04-14 08:35:48', '2022-04-14 09:27:41', '2022-04-14 09:27:41');
INSERT INTO `sys_user` VALUES (48, 'ssss', '$2y$10$Qznwyo1PFZF5ulT/.cWP6OvBGiK5jY8xg9YtjHdu2oJ4usGPQaOI.', 'ssss', '/images/default.png', '', '', 4, 0, 12, 1, '2022-04-30 19:31:05', '2022-11-18 07:42:33', '2022-11-18 07:42:33');
INSERT INTO `sys_user` VALUES (49, 'jkljklj', '$2y$10$cRQ6L67PNpb7OnzFZzGrNu8dBTu.qh6PLebcoDQERFRomq6raliCa', 'ttt', '/images/default.png', '', '', 2, 0, 13, NULL, '2022-07-29 13:37:47', '2022-11-03 11:10:44', '2022-11-03 11:10:44');
INSERT INTO `sys_user` VALUES (50, 'ttt', '$2y$10$Y8rXOZO7YVtSe8ZymPU5qundADQ5FDyIZ.QAhiz9eH89emF5G1kSK', '么2', '/images/37.png', '', '', 11, 0, 1, 1, '2022-11-03 13:02:59', '2022-11-04 08:40:49', '2022-11-04 08:40:49');
INSERT INTO `sys_user` VALUES (51, '123', '$2y$10$CFykL6oASsXdMrO7BeoDN.Um2QfOPV5gtq61FGApJGrhNSaDjRITm', '12', '/images/default.png', '', '', 11, 0, 1, NULL, '2022-11-03 13:10:53', '2022-11-03 13:14:19', '2022-11-03 13:14:19');
INSERT INTO `sys_user` VALUES (52, '李三3', '$2y$10$6KAuuftXQh4rviLCyhI2q.hutERWaEpWx4EtTgcYFWIYs7JgB74F6', '李三3', '/images/24.png', '', '', 11, 1, 1, 1, '2022-11-03 13:16:51', '2022-11-18 07:42:37', '2022-11-18 07:42:37');
INSERT INTO `sys_user` VALUES (53, 'FFF', '$2y$10$tfQa8mzIOSMX1aDP9JzCW.Pyb27FJKjaM9Lb1Laev9W.EFnG.8UNa', 'FF22FF', '/images/default.png', NULL, NULL, 2, 1, 1, 1, '2022-11-03 14:20:14', '2022-11-18 07:42:31', '2022-11-18 07:42:31');
INSERT INTO `sys_user` VALUES (54, 'FFF4', '$2y$10$oWGJZPrIk5HVnkmqnp1PzOVtR54oC9OI9dy/EswjHajS2OXO1nqja', '444', '/images/default.png', '', '', 11, 1, 1, 1, '2022-11-03 14:21:01', '2022-11-04 10:52:38', '2022-11-04 10:52:38');
INSERT INTO `sys_user` VALUES (55, 'BBB', '$2y$10$5A2w7QeWHxTBDVBbANrd8.VqTlN40Dbovp5Qv1mr8I8EkQrI4nGZm', 'BB', '/images/default.png', NULL, NULL, 2, 0, 13, 1, '2022-11-04 08:50:29', '2022-11-18 07:42:28', '2022-11-18 07:42:28');
INSERT INTO `sys_user` VALUES (56, 'admin', '$2y$10$8r2g5uuTYi8O9wJFiIrCWOSf1AnsbW99lVKfPYvlEJmvv64sEpuJC', 'admin', '/images/24.png', '', '', 13, 1, 1, 56, '2022-11-18 07:44:15', '2022-11-18 07:56:33', NULL);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
