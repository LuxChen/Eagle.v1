/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50714
Source Host           : localhost:3306
Source Database       : test

Target Server Type    : MYSQL
Target Server Version : 50714
File Encoding         : 65001

Date: 2018-06-08 10:51:36
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for eagle_admin
-- ----------------------------
DROP TABLE IF EXISTS `eagle_admin`;
CREATE TABLE `eagle_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nickname` varchar(20) DEFAULT NULL COMMENT '昵称',
  `name` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `thumb` int(11) NOT NULL DEFAULT '1' COMMENT '管理员头像',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `update_time` int(11) NOT NULL COMMENT '修改时间',
  `login_time` int(11) DEFAULT NULL COMMENT '最后登录时间',
  `login_ip` varchar(100) DEFAULT NULL COMMENT '最后登录ip',
  `admin_cate_id` int(2) NOT NULL DEFAULT '1' COMMENT '管理员分组',
  `location` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`) USING BTREE,
  KEY `admin_cate_id` (`admin_cate_id`) USING BTREE,
  KEY `nickname` (`nickname`) USING BTREE,
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of eagle_admin
-- ----------------------------
INSERT INTO `eagle_admin` VALUES ('1', 'Eagle123123', 'admin', '22cdd09fd9c474b270d8daf7f7ea86dc', '3', '1510885948', '1522288463', '1528186740', '0.0.0.0', '1', '上海');
INSERT INTO `eagle_admin` VALUES ('16', '123', 'test', '5a7055f7a337bfd84b2c82a4363a3d52', '4', '1522291089', '1522291089', '1528186359', '0.0.0.0', '20', null);
INSERT INTO `eagle_admin` VALUES ('17', 'normaluser', 'normal', '22cdd09fd9c474b270d8daf7f7ea86dc', '1', '1528075243', '1528075243', '1528075360', '0.0.0.0', '20', '上海');

-- ----------------------------
-- Table structure for eagle_admin_cate
-- ----------------------------
DROP TABLE IF EXISTS `eagle_admin_cate`;
CREATE TABLE `eagle_admin_cate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `permissions` text COMMENT '权限菜单',
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `desc` text COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `id` (`id`) USING BTREE,
  KEY `name` (`name`) USING BTREE,
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of eagle_admin_cate
-- ----------------------------
INSERT INTO `eagle_admin_cate` VALUES ('1', '超级管理员', '1,2,3,51,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,63,64,65,66,67,68,54,55,56,57,58,59,60,62,61,69,70,71', '0', '1528272739', '超级管理员，拥有最高权限！');
INSERT INTO `eagle_admin_cate` VALUES ('20', '普通管理员', '63,64,65,66,60,62', '1522291033', '1528186324', '');

-- ----------------------------
-- Table structure for eagle_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `eagle_admin_log`;
CREATE TABLE `eagle_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_menu_id` int(11) NOT NULL COMMENT '操作菜单id',
  `admin_id` int(11) DEFAULT NULL COMMENT '操作者id',
  `ip` varchar(100) DEFAULT NULL COMMENT '操作ip',
  `operation_id` varchar(200) DEFAULT NULL COMMENT '操作关联id',
  `create_time` int(11) NOT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`),
  KEY `id` (`id`) USING BTREE,
  KEY `admin_id` (`admin_id`) USING BTREE,
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=101 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of eagle_admin_log
-- ----------------------------
INSERT INTO `eagle_admin_log` VALUES ('1', '50', '1', '10.80.63.9', '', '1520489659');
INSERT INTO `eagle_admin_log` VALUES ('2', '4', '1', '10.80.63.9', '52', '1520489876');
INSERT INTO `eagle_admin_log` VALUES ('3', '4', '1', '10.80.63.9', '52', '1520489939');
INSERT INTO `eagle_admin_log` VALUES ('4', '4', '1', '10.80.63.9', '52', '1520490001');
INSERT INTO `eagle_admin_log` VALUES ('5', '4', '1', '10.80.63.9', '52', '1520490044');
INSERT INTO `eagle_admin_log` VALUES ('6', '4', '1', '10.80.63.9', '52', '1520490074');
INSERT INTO `eagle_admin_log` VALUES ('7', '28', '1', '10.80.63.9', '1', '1520490129');
INSERT INTO `eagle_admin_log` VALUES ('8', '50', '1', '10.80.63.9', '', '1520557667');
INSERT INTO `eagle_admin_log` VALUES ('9', '50', '1', '10.80.63.9', '', '1520577051');
INSERT INTO `eagle_admin_log` VALUES ('10', '50', '1', '10.80.63.9', '', '1520817160');
INSERT INTO `eagle_admin_log` VALUES ('11', '4', '1', '10.80.63.9', '53', '1520818482');
INSERT INTO `eagle_admin_log` VALUES ('12', '4', '1', '10.80.63.9', '53', '1520818598');
INSERT INTO `eagle_admin_log` VALUES ('13', '28', '1', '10.80.63.9', '1', '1520819400');
INSERT INTO `eagle_admin_log` VALUES ('14', '4', '1', '10.80.63.9', '54', '1520821800');
INSERT INTO `eagle_admin_log` VALUES ('15', '4', '1', '10.80.63.9', '54', '1520821839');
INSERT INTO `eagle_admin_log` VALUES ('16', '28', '1', '10.80.63.9', '1', '1520823093');
INSERT INTO `eagle_admin_log` VALUES ('17', '50', '1', '10.80.63.9', '', '1520823155');
INSERT INTO `eagle_admin_log` VALUES ('18', '11', '1', '10.80.63.9', '', '1520825787');
INSERT INTO `eagle_admin_log` VALUES ('19', '50', '1', '10.80.63.9', '', '1521017242');
INSERT INTO `eagle_admin_log` VALUES ('20', '50', '1', '10.80.63.9', '', '1521020627');
INSERT INTO `eagle_admin_log` VALUES ('21', '8', '1', '10.80.63.9', '', '1521020671');
INSERT INTO `eagle_admin_log` VALUES ('22', '50', '1', '10.80.63.9', '', '1521020685');
INSERT INTO `eagle_admin_log` VALUES ('23', '49', '1', '10.80.63.9', '2', '1521020745');
INSERT INTO `eagle_admin_log` VALUES ('24', '7', '1', '10.80.63.9', '1', '1521020749');
INSERT INTO `eagle_admin_log` VALUES ('25', '50', '1', '10.80.63.9', '', '1521078348');
INSERT INTO `eagle_admin_log` VALUES ('26', '50', '1', '10.80.63.9', '', '1521162170');
INSERT INTO `eagle_admin_log` VALUES ('27', '50', '1', '10.80.63.9', '', '1521184996');
INSERT INTO `eagle_admin_log` VALUES ('28', '50', '1', '10.80.63.9', '', '1521190052');
INSERT INTO `eagle_admin_log` VALUES ('29', '50', '1', '10.80.63.9', '', '1521190602');
INSERT INTO `eagle_admin_log` VALUES ('30', '50', '1', '10.80.63.9', '', '1521191803');
INSERT INTO `eagle_admin_log` VALUES ('31', '60', '1', '10.80.63.9', '', '1521191917');
INSERT INTO `eagle_admin_log` VALUES ('32', '50', '1', '10.80.63.9', '', '1521594923');
INSERT INTO `eagle_admin_log` VALUES ('33', '5', '1', '10.80.63.9', '53', '1522230037');
INSERT INTO `eagle_admin_log` VALUES ('34', '7', '1', '0.0.0.0', '1', '1522288463');
INSERT INTO `eagle_admin_log` VALUES ('35', '4', '1', '0.0.0.0', '52', '1522288864');
INSERT INTO `eagle_admin_log` VALUES ('36', '4', '1', '0.0.0.0', '54', '1522290451');
INSERT INTO `eagle_admin_log` VALUES ('37', '4', '1', '0.0.0.0', '52', '1522290567');
INSERT INTO `eagle_admin_log` VALUES ('38', '28', '1', '0.0.0.0', '20', '1522291033');
INSERT INTO `eagle_admin_log` VALUES ('39', '49', '1', '0.0.0.0', '4', '1522291071');
INSERT INTO `eagle_admin_log` VALUES ('40', '25', '1', '0.0.0.0', '16', '1522291089');
INSERT INTO `eagle_admin_log` VALUES ('41', '50', '16', '0.0.0.0', '', '1522291112');
INSERT INTO `eagle_admin_log` VALUES ('42', '50', '1', '0.0.0.0', '', '1522291232');
INSERT INTO `eagle_admin_log` VALUES ('43', '4', '1', '0.0.0.0', '50', '1522291301');
INSERT INTO `eagle_admin_log` VALUES ('44', '4', '1', '0.0.0.0', '60', '1522291317');
INSERT INTO `eagle_admin_log` VALUES ('45', '50', '16', '0.0.0.0', '', '1522291335');
INSERT INTO `eagle_admin_log` VALUES ('46', '50', '1', '0.0.0.0', '', '1522291836');
INSERT INTO `eagle_admin_log` VALUES ('47', '28', '1', '0.0.0.0', '20', '1522291869');
INSERT INTO `eagle_admin_log` VALUES ('48', '4', '1', '0.0.0.0', '60', '1522291960');
INSERT INTO `eagle_admin_log` VALUES ('49', '4', '1', '0.0.0.0', '60', '1522292273');
INSERT INTO `eagle_admin_log` VALUES ('50', '4', '1', '0.0.0.0', '62', '1522292335');
INSERT INTO `eagle_admin_log` VALUES ('51', '28', '1', '0.0.0.0', '20', '1522292346');
INSERT INTO `eagle_admin_log` VALUES ('52', '4', '1', '0.0.0.0', '54', '1522292925');
INSERT INTO `eagle_admin_log` VALUES ('53', '28', '1', '0.0.0.0', '1', '1527661268');
INSERT INTO `eagle_admin_log` VALUES ('54', '4', '1', '0.0.0.0', '63', '1527662841');
INSERT INTO `eagle_admin_log` VALUES ('55', '4', '1', '0.0.0.0', '64', '1527668972');
INSERT INTO `eagle_admin_log` VALUES ('56', '28', '1', '0.0.0.0', '1', '1527668999');
INSERT INTO `eagle_admin_log` VALUES ('57', '4', '1', '0.0.0.0', '64', '1527669043');
INSERT INTO `eagle_admin_log` VALUES ('58', '4', '1', '0.0.0.0', '63', '1527669614');
INSERT INTO `eagle_admin_log` VALUES ('59', '4', '1', '0.0.0.0', '64', '1527670522');
INSERT INTO `eagle_admin_log` VALUES ('60', '28', '1', '0.0.0.0', '1', '1527730439');
INSERT INTO `eagle_admin_log` VALUES ('61', '25', '1', '0.0.0.0', '17', '1528075243');
INSERT INTO `eagle_admin_log` VALUES ('62', '50', '17', '0.0.0.0', '', '1528075335');
INSERT INTO `eagle_admin_log` VALUES ('63', '28', '1', '0.0.0.0', '20', '1528075510');
INSERT INTO `eagle_admin_log` VALUES ('64', '4', '1', '0.0.0.0', '65', '1528160971');
INSERT INTO `eagle_admin_log` VALUES ('65', '28', '1', '0.0.0.0', '1', '1528161001');
INSERT INTO `eagle_admin_log` VALUES ('66', '4', '1', '0.0.0.0', '66', '1528163681');
INSERT INTO `eagle_admin_log` VALUES ('67', '28', '1', '0.0.0.0', '1', '1528163705');
INSERT INTO `eagle_admin_log` VALUES ('68', '4', '1', '0.0.0.0', '1', '1528183288');
INSERT INTO `eagle_admin_log` VALUES ('69', '4', '1', '0.0.0.0', '2', '1528183316');
INSERT INTO `eagle_admin_log` VALUES ('70', '28', '1', '0.0.0.0', '1', '1528183375');
INSERT INTO `eagle_admin_log` VALUES ('71', '4', '1', '0.0.0.0', '3', '1528183405');
INSERT INTO `eagle_admin_log` VALUES ('72', '28', '1', '0.0.0.0', '1', '1528183443');
INSERT INTO `eagle_admin_log` VALUES ('73', '50', '1', '0.0.0.0', '', '1528183551');
INSERT INTO `eagle_admin_log` VALUES ('74', '4', '1', '0.0.0.0', '9', '1528183609');
INSERT INTO `eagle_admin_log` VALUES ('75', '4', '1', '0.0.0.0', '15', '1528183630');
INSERT INTO `eagle_admin_log` VALUES ('76', '4', '1', '0.0.0.0', '27', '1528183642');
INSERT INTO `eagle_admin_log` VALUES ('77', '4', '1', '0.0.0.0', '41', '1528183670');
INSERT INTO `eagle_admin_log` VALUES ('78', '4', '1', '0.0.0.0', '12', '1528183679');
INSERT INTO `eagle_admin_log` VALUES ('79', '50', '1', '0.0.0.0', '', '1528184034');
INSERT INTO `eagle_admin_log` VALUES ('80', '4', '1', '0.0.0.0', '27', '1528184317');
INSERT INTO `eagle_admin_log` VALUES ('81', '28', '1', '0.0.0.0', '1', '1528185046');
INSERT INTO `eagle_admin_log` VALUES ('82', '50', '1', '0.0.0.0', '', '1528185743');
INSERT INTO `eagle_admin_log` VALUES ('83', '4', '1', '0.0.0.0', '1', '1528186105');
INSERT INTO `eagle_admin_log` VALUES ('84', '4', '1', '0.0.0.0', '1', '1528186145');
INSERT INTO `eagle_admin_log` VALUES ('85', '28', '1', '0.0.0.0', '20', '1528186324');
INSERT INTO `eagle_admin_log` VALUES ('86', '50', '1', '0.0.0.0', '', '1528186740');
INSERT INTO `eagle_admin_log` VALUES ('87', '4', '1', '0.0.0.0', '67', '1528247875');
INSERT INTO `eagle_admin_log` VALUES ('88', '28', '1', '0.0.0.0', '1', '1528249048');
INSERT INTO `eagle_admin_log` VALUES ('89', '4', '1', '0.0.0.0', '68', '1528267918');
INSERT INTO `eagle_admin_log` VALUES ('90', '28', '1', '0.0.0.0', '1', '1528267955');
INSERT INTO `eagle_admin_log` VALUES ('91', '4', '1', '0.0.0.0', '69', '1528272444');
INSERT INTO `eagle_admin_log` VALUES ('92', '4', '1', '0.0.0.0', '70', '1528272632');
INSERT INTO `eagle_admin_log` VALUES ('93', '4', '1', '0.0.0.0', '71', '1528272725');
INSERT INTO `eagle_admin_log` VALUES ('94', '28', '1', '0.0.0.0', '1', '1528272739');
INSERT INTO `eagle_admin_log` VALUES ('95', '4', '1', '0.0.0.0', '70', '1528337217');
INSERT INTO `eagle_admin_log` VALUES ('96', '4', '1', '0.0.0.0', '71', '1528337256');
INSERT INTO `eagle_admin_log` VALUES ('97', '4', '1', '0.0.0.0', '70', '1528337275');
INSERT INTO `eagle_admin_log` VALUES ('98', '4', '1', '0.0.0.0', '70', '1528337375');
INSERT INTO `eagle_admin_log` VALUES ('99', '4', '1', '0.0.0.0', '71', '1528337394');
INSERT INTO `eagle_admin_log` VALUES ('100', '4', '1', '0.0.0.0', '71', '1528337978');

-- ----------------------------
-- Table structure for eagle_admin_menu
-- ----------------------------
DROP TABLE IF EXISTS `eagle_admin_menu`;
CREATE TABLE `eagle_admin_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `module` varchar(50) NOT NULL COMMENT '模块',
  `controller` varchar(100) NOT NULL COMMENT '控制器',
  `function` varchar(100) NOT NULL COMMENT '方法',
  `parameter` varchar(50) DEFAULT NULL COMMENT '参数',
  `description` varchar(250) DEFAULT NULL COMMENT '描述',
  `is_display` int(1) NOT NULL DEFAULT '1' COMMENT '1显示在左侧菜单2只作为节点',
  `type` int(1) NOT NULL DEFAULT '1' COMMENT '1权限节点2普通节点',
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT '上级菜单0为顶级菜单',
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `icon` varchar(100) DEFAULT NULL COMMENT '图标',
  `is_open` int(1) NOT NULL DEFAULT '0' COMMENT '0默认闭合1默认展开',
  `orders` int(11) NOT NULL DEFAULT '0' COMMENT '排序值，越小越靠前',
  PRIMARY KEY (`id`),
  KEY `id` (`id`) USING BTREE,
  KEY `module` (`module`) USING BTREE,
  KEY `controller` (`controller`) USING BTREE,
  KEY `function` (`function`) USING BTREE,
  KEY `is_display` (`is_display`) USING BTREE,
  KEY `type` (`type`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=72 DEFAULT CHARSET=utf8 COMMENT='系统菜单表';

-- ----------------------------
-- Records of eagle_admin_menu
-- ----------------------------
INSERT INTO `eagle_admin_menu` VALUES ('1', '系统', '', '', '', '', '系统设置。', '2', '1', '0', '0', '1528186145', 'fa fa-cog', '1', '0');
INSERT INTO `eagle_admin_menu` VALUES ('2', '菜单', '', '', '', '', '菜单管理。', '1', '1', '1', '0', '1528183316', 'fa fa-paw', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('51', '系统菜单排序', 'admin', 'menu', 'orders', '', '系统菜单排序。', '2', '1', '3', '1517562047', '1517562047', '', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('3', '系统菜单', 'admin', 'menu', 'index', '', '系统菜单管理', '1', '1', '2', '0', '1528183405', 'fa fa-share-alt', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('4', '新增/修改系统菜单', 'admin', 'menu', 'publish', '', '新增/修改系统菜单.', '2', '1', '3', '1516948769', '1516948769', '', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('5', '删除系统菜单', 'admin', 'menu', 'delete', '', '删除系统菜单。', '2', '1', '3', '1516948857', '1516948857', '', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('6', '个人', '', '', '', '', '个人信息管理。', '1', '1', '1', '1516949308', '1517021986', 'fa fa-user', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('7', '个人信息', 'admin', 'admin', 'personal', '', '个人信息修改。', '1', '1', '6', '1516949435', '1516949435', 'fa fa-user', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('8', '修改密码', 'admin', 'admin', 'editpassword', '', '管理员修改个人密码。', '1', '1', '6', '1516949702', '1517619887', 'fa fa-unlock-alt', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('9', '设置', '', '', '', '', '系统相关设置。', '1', '1', '1', '1516949853', '1528183609', 'fa fa-cog', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('10', '网站设置', 'admin', 'webconfig', 'index', '', '网站相关设置首页。', '1', '1', '9', '1516949994', '1516949994', 'fa fa-bullseye', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('11', '修改网站设置', 'admin', 'webconfig', 'publish', '', '修改网站设置。', '2', '1', '10', '1516950047', '1516950047', '', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('12', '邮件设置', 'admin', 'emailconfig', 'index', '', '邮件配置首页。', '1', '1', '9', '1516950129', '1528183679', 'fa fa-envelope', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('13', '修改邮件设置', 'admin', 'emailconfig', 'publish', '', '修改邮件设置。', '2', '1', '12', '1516950215', '1516950215', '', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('14', '发送测试邮件', 'admin', 'emailconfig', 'mailto', '', '发送测试邮件。', '2', '1', '12', '1516950295', '1516950295', '', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('15', '短信设置', 'admin', 'smsconfig', 'index', '', '短信设置首页。', '1', '1', '9', '1516950394', '1528183630', 'fa fa-comments', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('16', '修改短信设置', 'admin', 'smsconfig', 'publish', '', '修改短信设置。', '2', '1', '15', '1516950447', '1516950447', '', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('17', '发送测试短信', 'admin', 'smsconfig', 'smsto', '', '发送测试短信。', '2', '1', '15', '1516950483', '1516950483', '', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('18', 'URL 设置', 'admin', 'urlsconfig', 'index', '', 'url 设置。', '1', '1', '9', '1516950738', '1516950804', 'fa fa-code-fork', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('19', '新增/修改url设置', 'admin', 'urlsconfig', 'publish', '', '新增/修改url设置。', '2', '1', '18', '1516950850', '1516950850', '', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('20', '启用/禁用url美化', 'admin', 'urlsconfig', 'status', '', '启用/禁用url美化。', '2', '1', '18', '1516950909', '1516950909', '', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('21', ' 删除url美化规则', 'admin', 'urlsconfig', 'delete', '', ' 删除url美化规则。', '2', '1', '18', '1516950941', '1516950941', '', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('22', '会员', '', '', '', '', '会员管理。', '2', '1', '0', '1516950991', '1517015810', 'fa fa-users', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('23', '管理员', '', '', '', '', '系统管理员管理。', '1', '1', '22', '1516951071', '1517015819', 'fa fa-user', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('24', '管理员', 'admin', 'admin', 'index', '', '系统管理员列表。', '1', '1', '23', '1516951163', '1516951163', 'fa fa-user', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('25', '新增/修改管理员', 'admin', 'admin', 'publish', '', '新增/修改系统管理员。', '1', '1', '24', '1516951224', '1516951224', '', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('26', '删除管理员', 'admin', 'admin', 'delete', '', '删除管理员。', '1', '1', '24', '1516951253', '1516951253', '', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('27', '权限组', 'admin', 'admin', 'admincate', '', '权限分组。', '1', '1', '23', '1516951353', '1528184317', 'fa fa-dot-circle-o', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('28', '新增/修改权限组', 'admin', 'admin', 'admincatepublish', '', '新增/修改权限组。', '1', '1', '27', '1516951483', '1516951483', '', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('29', '删除权限组', 'admin', 'admin', 'admincatedelete', '', '删除权限组。', '1', '1', '27', '1516951515', '1516951515', '', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('30', '操作日志', 'admin', 'admin', 'log', '', '系统管理员操作日志。', '1', '1', '23', '1516951754', '1517018196', 'fa-pencil', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('31', '内容', '', '', '', '', '内容管理。', '2', '1', '0', '1516952262', '1517015835', 'fa fa-th-large', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('32', '文章', '', '', '', '', '文章相关管理。', '1', '1', '31', '1516952698', '1517015846', 'fa fa-bookmark', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('33', '分类', 'admin', 'articlecate', 'index', '', '文章分类管理。', '1', '1', '32', '1516952856', '1516952856', 'fa fa-tag', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('34', '新增/修改文章分类', 'admin', 'articlecate', 'publish', '', '新增/修改文章分类。', '2', '1', '33', '1516952896', '1516952896', '', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('35', '删除文章分类', 'admin', 'articlecate', 'delete', '', '删除文章分类。', '2', '1', '33', '1516952942', '1516952942', '', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('36', '文章', 'admin', 'article', 'index', '', '文章管理。', '1', '1', '32', '1516953011', '1516953028', 'fa fa-bookmark', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('37', '新增/修改文章', 'admin', 'article', 'publish', '', '新增/修改文章。', '2', '1', '36', '1516953056', '1516953056', '', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('38', '审核/拒绝文章', 'admin', 'article', 'status', '', '审核/拒绝文章。', '2', '1', '36', '1516953113', '1516953113', '', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('39', '置顶/取消置顶文章', 'admin', 'article', 'is_top', '', '置顶/取消置顶文章。', '2', '1', '36', '1516953162', '1516953162', '', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('40', '删除文章', 'admin', 'article', 'delete', '', '删除文章。', '2', '1', '36', '1516953183', '1516953183', '', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('41', '附件', 'admin', 'attachment', 'index', '', '附件管理。', '1', '1', '31', '1516953306', '1528183670', 'fa fa-cube', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('42', '附件审核', 'admin', 'attachment', 'audit', '', '附件审核。', '2', '1', '41', '1516953359', '1516953440', '', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('43', '附件上传', 'admin', 'attachment', 'upload', '', '附件上传。', '2', '1', '41', '1516953392', '1516953392', '', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('44', '附件下载', 'admin', 'attachment', 'download', '', '附件下载。', '2', '1', '41', '1516953430', '1516953430', '', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('45', '附件删除', 'admin', 'attachment', 'delete', '', '附件删除。', '2', '1', '41', '1516953477', '1516953477', '', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('46', '留言', 'admin', 'tomessages', 'index', '', '留言管理。', '1', '1', '31', '1516953526', '1516953526', 'fa fa-comments', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('47', '留言处理', 'admin', 'tomessages', 'mark', '', '留言处理。', '2', '1', '46', '1516953605', '1516953605', '', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('48', '留言删除', 'admin', 'tomessages', 'delete', '', '留言删除。', '2', '1', '46', '1516953648', '1516953648', '', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('49', '图片上传', 'admin', 'common', 'upload', '', '图片上传。', '2', '1', '0', '1516954491', '1516954491', '', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('50', '管理员登录', 'admin', 'common', 'login', '', '管理员登录。', '2', '1', '0', '1516954517', '1522291301', '', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('63', '资产管理', '', '', '', '', '管理资产模块', '1', '1', '0', '1527662841', '1527669614', 'fa fa-television', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('62', '用户首页', 'index', 'index', 'index', '', '', '1', '1', '60', '1522292335', '1522292335', '', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('54', '线上招聘', 'index', 'index', 'index', '', '线上招聘模块', '2', '1', '0', '1520821800', '1522292925', 'fa fa-group ', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('55', '应聘人员列表', 'index', 'index', 'applicantlist', '', '人员列表', '1', '1', '54', '1520818482', '1520818598', 'fa fa-bars', '0', '2');
INSERT INTO `eagle_admin_menu` VALUES ('56', '意向人员列表', 'index', 'index', 'potentialmemberlist', null, null, '1', '1', '54', '1520818482', '1520818482', 'fa fa-users', '0', '3');
INSERT INTO `eagle_admin_menu` VALUES ('57', '待入职人员列表', 'index', 'index', 'auditmemberlist', null, null, '1', '1', '54', '1520818482', '1520818482', 'fa fa-user-secret ', '0', '4');
INSERT INTO `eagle_admin_menu` VALUES ('58', '预入职人员列表', 'index', 'index', 'prejoinstafflist', null, null, '1', '1', '54', '1520818482', '1520818482', 'fa fa-user-plus', '0', '5');
INSERT INTO `eagle_admin_menu` VALUES ('59', '招聘岗位列表', 'index', 'index', 'stationlist', null, null, '1', '1', '54', '1520818482', '1520818482', 'fa fa-anchor', '0', '1');
INSERT INTO `eagle_admin_menu` VALUES ('60', '用户登录', 'index', 'common', 'login', '', '用户登录。', '2', '1', '0', '1516954517', '1522292273', '', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('61', '个人信息修改', 'index', 'index', 'personal', '', '个人信息修改', '2', '1', '0', '1516954517', '1516954517', '', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('64', '资产仓库', 'Properties', 'warehouse', 'index', '', '', '1', '1', '63', '1527668972', '1527670522', 'fa fa-first-order', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('65', '用户资产', 'properties', 'userproperties', 'index', '', '', '1', '1', '63', '1528160971', '1528160971', 'fa fa-gg', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('66', '待出库资产', 'properties', 'warehouse', 'waitinglist', '', '', '1', '1', '63', '1528163681', '1528163681', ' fa fa-list-ol', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('67', '报废资产', 'properties', 'warehouse', 'scraplist', '', '报废资产列表', '1', '1', '63', '1528247875', '1528247875', 'fa fa-database', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('68', '资产历史', 'properties', 'userproperties', 'propertyhistory', '', '', '1', '1', '63', '1528267918', '1528267918', ' fa fa-retweet', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('69', '日志管理', 'Logconsole', 'Logconsole', '', '', '日志管理', '1', '1', '0', '1528272444', '1528272444', ' fa fa-file-text', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('70', '操作日志', 'Properties', 'Log', 'adminlog', '', '操作日志', '1', '1', '69', '1528272632', '1528337375', ' fa fa-paste', '0', '0');
INSERT INTO `eagle_admin_menu` VALUES ('71', '资产日志', 'Properties', 'Log', 'plog', '', '资产日志', '1', '1', '69', '1528272725', '1528337978', 'fa fa-files-o', '0', '0');

-- ----------------------------
-- Table structure for eagle_article
-- ----------------------------
DROP TABLE IF EXISTS `eagle_article`;
CREATE TABLE `eagle_article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `tag` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `article_cate_id` int(11) NOT NULL,
  `thumb` int(11) DEFAULT NULL,
  `content` text,
  `admin_id` int(11) NOT NULL,
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `edit_admin_id` int(11) NOT NULL COMMENT '最后修改人',
  `status` int(1) NOT NULL DEFAULT '0' COMMENT '0待审核1已审核',
  `is_top` int(1) NOT NULL DEFAULT '0' COMMENT '1置顶0普通',
  PRIMARY KEY (`id`),
  KEY `id` (`id`) USING BTREE,
  KEY `status` (`status`) USING BTREE,
  KEY `is_top` (`is_top`) USING BTREE,
  KEY `article_cate_id` (`article_cate_id`) USING BTREE,
  KEY `admin_id` (`admin_id`) USING BTREE,
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of eagle_article
-- ----------------------------

-- ----------------------------
-- Table structure for eagle_article_cate
-- ----------------------------
DROP TABLE IF EXISTS `eagle_article_cate`;
CREATE TABLE `eagle_article_cate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `tag` varchar(250) DEFAULT NULL COMMENT '关键词',
  `description` varchar(250) DEFAULT NULL,
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `pid` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `id` (`id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of eagle_article_cate
-- ----------------------------

-- ----------------------------
-- Table structure for eagle_attachment
-- ----------------------------
DROP TABLE IF EXISTS `eagle_attachment`;
CREATE TABLE `eagle_attachment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `module` char(15) NOT NULL DEFAULT '' COMMENT '所属模块',
  `filename` char(50) NOT NULL DEFAULT '' COMMENT '文件名',
  `filepath` char(200) NOT NULL DEFAULT '' COMMENT '文件路径+文件名',
  `filesize` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  `fileext` char(10) NOT NULL DEFAULT '' COMMENT '文件后缀',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '会员ID',
  `uploadip` char(15) NOT NULL DEFAULT '' COMMENT '上传IP',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0未审核1已审核-1不通过',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0',
  `admin_id` int(11) NOT NULL COMMENT '审核者id',
  `audit_time` int(11) NOT NULL COMMENT '审核时间',
  `use` varchar(200) DEFAULT NULL COMMENT '用处',
  `download` int(11) NOT NULL DEFAULT '0' COMMENT '下载量',
  PRIMARY KEY (`id`),
  KEY `id` (`id`) USING BTREE,
  KEY `status` (`status`) USING BTREE,
  KEY `filename` (`filename`) USING BTREE,
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='附件表';

-- ----------------------------
-- Records of eagle_attachment
-- ----------------------------
INSERT INTO `eagle_attachment` VALUES ('1', 'admin', '79811855a6c06de53047471c4ff82a36.jpg', '\\uploads\\admin\\admin_thumb\\20180104\\79811855a6c06de53047471c4ff82a36.jpg', '13781', 'jpg', '1', '127.0.0.1', '1', '1515046060', '1', '1515046060', 'admin_thumb', '0');
INSERT INTO `eagle_attachment` VALUES ('2', 'admin', '7ccec808401cbc3ba720fca9d6c6d640.jpg', '\\uploads\\admin\\admin_thumb\\20180314\\7ccec808401cbc3ba720fca9d6c6d640.jpg', '150549', 'jpg', '1', '10.80.63.9', '1', '1521020745', '1', '1521020745', 'admin_thumb', '0');
INSERT INTO `eagle_attachment` VALUES ('3', 'admin', 'e7eb2f73abaa315dcf8b5eb78b7e81c3.png', '\\uploads\\index\\admin_thumb\\20180329\\e7eb2f73abaa315dcf8b5eb78b7e81c3.png', '50988', 'png', '1', '0.0.0.0', '1', '1522288461', '1', '1522288461', 'admin_thumb', '0');
INSERT INTO `eagle_attachment` VALUES ('4', 'admin', 'dd00147062b7a33e434d68bc0a727547.png', '\\uploads\\admin\\admin_thumb\\20180329\\dd00147062b7a33e434d68bc0a727547.png', '68004', 'png', '1', '0.0.0.0', '1', '1522291070', '1', '1522291070', 'admin_thumb', '0');

-- ----------------------------
-- Table structure for eagle_campusrecruit
-- ----------------------------
DROP TABLE IF EXISTS `eagle_campusrecruit`;
CREATE TABLE `eagle_campusrecruit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `CName` varchar(60) DEFAULT NULL COMMENT '中文名',
  `TCompany` varchar(60) DEFAULT NULL COMMENT '应聘公司',
  `TStation` varchar(60) DEFAULT NULL COMMENT '应聘职位',
  `TWstation` varchar(12) DEFAULT NULL COMMENT '期望工作地点',
  `Gender` varchar(6) DEFAULT NULL COMMENT '性别',
  `Age` int(3) DEFAULT NULL COMMENT '年龄',
  `Headerimg` varchar(100) DEFAULT NULL COMMENT '头像照片路径',
  `Nation` varchar(30) DEFAULT NULL COMMENT '民族',
  `Jiguan` varchar(30) DEFAULT NULL COMMENT '籍贯',
  `Computerlevel` varchar(30) DEFAULT NULL COMMENT '计算机水平',
  `Enlevel` varchar(30) DEFAULT NULL COMMENT '英语水平',
  `Zzmm` varchar(30) DEFAULT NULL COMMENT '政治面貌',
  `Height` int(3) DEFAULT NULL COMMENT '身高',
  `Weight` int(3) DEFAULT NULL COMMENT '体重',
  `Idcard` varchar(60) DEFAULT NULL COMMENT '身份证号',
  `Telephone` varchar(16) DEFAULT NULL COMMENT '电话号码',
  `Email` varchar(60) DEFAULT NULL COMMENT '电子邮箱',
  `Maddress` varchar(120) DEFAULT NULL COMMENT '通信地址',
  `Isapplied` varchar(2) DEFAULT '0' COMMENT '是否网上已申请',
  `Relativename` varchar(30) DEFAULT NULL,
  `Hasrelative` varchar(12) DEFAULT '0' COMMENT '是否有亲属在公司',
  `Fromother` varchar(30) DEFAULT NULL,
  `Fromwhere` varchar(30) DEFAULT NULL COMMENT '从何处得知森马招聘信息',
  `Extrareward` varchar(120) DEFAULT NULL COMMENT '其他获奖情况',
  `Hobby` varchar(60) DEFAULT NULL COMMENT '个人爱好及特长',
  `Question1` varchar(240) DEFAULT NULL COMMENT '开放提问1',
  `Question2` varchar(240) DEFAULT NULL COMMENT '开放提问2',
  `Question3` varchar(180) DEFAULT NULL COMMENT '开放提问3',
  `Firstys` varchar(10) DEFAULT NULL COMMENT '第一年期望年薪',
  `Fdetail` varchar(120) DEFAULT NULL COMMENT '年薪描述',
  `Status` int(2) DEFAULT NULL COMMENT '记录状态',
  `createdtime` datetime DEFAULT NULL,
  `updatedby` varchar(20) DEFAULT NULL,
  `FamilyInfo` text,
  `Education` text,
  `WorkExp` text,
  `Come` varchar(30) DEFAULT NULL,
  `Rate` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of eagle_campusrecruit
-- ----------------------------
INSERT INTO `eagle_campusrecruit` VALUES ('35', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '17621510870', null, null, '0', null, '0', null, null, null, null, null, null, null, null, null, null, '2017-11-29 10:58:37', null, null, null, null, '未知', null);
INSERT INTO `eagle_campusrecruit` VALUES ('36', null, null, '[\"1\"]', '1', null, null, null, null, null, null, null, null, null, null, null, '15107113799', null, null, '0', null, '0', null, null, null, null, null, null, null, null, null, null, '2017-11-29 16:55:50', null, null, null, null, '未知', null);
INSERT INTO `eagle_campusrecruit` VALUES ('37', '刘丹', null, '[\"7\"]', '1', '男', '22', '/uploads/images/recruit/201712/05/20171205112623-SVP.jpeg', '汉族', '河南省信阳市新县', '', '四级', '共青团员', '178', '65', '411523199502173818', '17638183093', '1663408479@qq.com', '河南省郑州市金水区~河南农业大学', '0', '', '0', '', '[\"8\"]', '英语四级证书\r\n国家助学金\r\n蓝桥杯省赛三等奖', '喜欢网络文学，健身，偶尔玩fps游戏', '应该说是最好的朋友，有两位，他们是从小学到初中再到高中的同学，三个人一起经历过从童年到少年再到青年，直至以后，这就是我们之间的友谊', '大学第一年没有社会经验，做兼职被遇到不诚信的人，发生矛盾', '程序开发工程师应该是一份严谨细心的工作，在程序开发过程遇见错误是很正常的，查找不足修改程序是细心冷静才能做的更好，此外程序开发也讲究团队合作，思路的涌现等', '8万左右', '还不清楚贵公司的工资制度，希望了解之后再说', '1', '2017-12-05 11:22:27', null, 'a:2:{i:0;a:4:{s:10:\"MemberShip\";s:6:\"父亲\";s:10:\"MemberName\";s:9:\"刘宏亮\";s:13:\"MemberCompany\";s:0:\"\";s:13:\"MemberAddress\";s:24:\"河南省信阳市新县\";}i:1;a:4:{s:10:\"MemberShip\";s:6:\"母亲\";s:10:\"MemberName\";s:9:\"游安玲\";s:13:\"MemberCompany\";s:0:\"\";s:13:\"MemberAddress\";s:0:\"\";}}', 'a:1:{i:0;a:5:{s:9:\"EduPeriod\";s:11:\"14.9～18.7\";s:10:\"SchoolName\";s:18:\"河南农业大学\";s:5:\"Major\";s:38:\"计算机科学与技术(软件技术)\";s:9:\"EduRecord\";s:6:\"本科\";s:7:\"Ranking\";s:6:\"前15%\";}}', 'a:1:{i:0;a:3:{s:12:\"SocialPeriod\";s:12:\"14.10～16.6\";s:10:\"SocialName\";s:45:\"河南农业大学信管学院志愿者协会\";s:7:\"MainJob\";s:27:\"参加学院志愿者活动\";}}', '未知', 'chocolate');
INSERT INTO `eagle_campusrecruit` VALUES ('34', null, null, '[\"1\"]', '1', null, null, null, null, null, null, null, null, null, null, null, '13961809027', null, null, '0', null, '0', null, null, null, null, null, null, null, null, null, null, '2017-11-29 10:57:35', null, null, null, null, '未知', null);
INSERT INTO `eagle_campusrecruit` VALUES ('38', null, null, '[\"7\"]', '1', null, null, null, null, null, null, null, null, null, null, null, '18721196118', null, null, '0', null, '0', null, null, null, null, null, null, null, null, null, null, '2018-02-28 17:56:26', null, null, null, null, '未知', null);
INSERT INTO `eagle_campusrecruit` VALUES ('39', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '15802155906', null, null, '0', null, '0', null, null, null, null, null, null, null, null, null, null, '2018-03-01 09:20:35', null, null, null, null, '未知', null);
INSERT INTO `eagle_campusrecruit` VALUES ('31', null, null, '[\"1\"]', '1', null, null, null, null, null, null, null, null, null, null, null, '18502193593', null, null, '0', null, '0', null, null, null, null, null, null, null, null, null, null, '2017-09-26 11:50:58', null, null, null, null, '未知', null);
INSERT INTO `eagle_campusrecruit` VALUES ('32', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '13738565358', null, null, '0', null, '0', null, null, null, null, null, null, null, null, null, null, '2017-09-26 19:06:39', null, null, null, null, '未知', null);
INSERT INTO `eagle_campusrecruit` VALUES ('33', '林云自', null, '[\"2\"]', '1', '男', '33', '/uploads/images/recruit/201709/27/20170927144905-4kb.jpeg', '汉族', '苍南', '', '', '群众', '0', '0', '330327198410270214', '13671584737', '278656415@qq.com', '~', '0', '', '0', '', '\"\"', '无', '无', '无', '无', '无', '10', '', '2', '2017-09-27 14:47:27', null, 'a:1:{i:0;a:4:{s:10:\"MemberShip\";s:6:\"母亲\";s:10:\"MemberName\";s:9:\"陈黄女\";s:13:\"MemberCompany\";s:0:\"\";s:13:\"MemberAddress\";s:0:\"\";}}', 'a:1:{i:0;a:5:{s:9:\"EduPeriod\";s:0:\"\";s:10:\"SchoolName\";s:15:\"浙江林学院\";s:5:\"Major\";s:0:\"\";s:9:\"EduRecord\";s:0:\"\";s:7:\"Ranking\";s:0:\"\";}}', 'a:1:{i:0;a:3:{s:12:\"SocialPeriod\";s:5:\"07~08\";s:10:\"SocialName\";s:0:\"\";s:7:\"MainJob\";s:0:\"\";}}', '未知', '');
INSERT INTO `eagle_campusrecruit` VALUES ('29', null, null, '[\"1\",\"2\"]', '3', null, null, null, null, null, null, null, null, null, null, null, '15800747350', null, null, '0', null, '0', null, null, null, null, null, null, null, null, null, null, '2017-09-18 14:08:15', null, null, null, null, '未知', null);
INSERT INTO `eagle_campusrecruit` VALUES ('30', null, null, '[\"1\"]', '1', null, null, null, null, null, null, null, null, null, null, null, '13761211716', null, null, '0', null, '0', null, null, null, null, null, null, null, null, null, null, '2017-09-18 14:10:56', null, null, null, null, '未知', null);

-- ----------------------------
-- Table structure for eagle_emailconfig
-- ----------------------------
DROP TABLE IF EXISTS `eagle_emailconfig`;
CREATE TABLE `eagle_emailconfig` (
  `email` varchar(5) NOT NULL COMMENT '邮箱配置标识',
  `from_email` varchar(50) NOT NULL COMMENT '邮件来源也就是邮件地址',
  `from_name` varchar(50) NOT NULL,
  `smtp` varchar(50) NOT NULL COMMENT '邮箱smtp服务器',
  `username` varchar(100) NOT NULL COMMENT '邮箱账号',
  `password` varchar(100) NOT NULL COMMENT '邮箱密码',
  `title` varchar(200) NOT NULL COMMENT '邮件标题',
  `content` text NOT NULL COMMENT '邮件模板',
  KEY `email` (`email`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of eagle_emailconfig
-- ----------------------------
INSERT INTO `eagle_emailconfig` VALUES ('email', '', '', '', '', '', '', '');

-- ----------------------------
-- Table structure for eagle_func_error_log
-- ----------------------------
DROP TABLE IF EXISTS `eagle_func_error_log`;
CREATE TABLE `eagle_func_error_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) DEFAULT NULL COMMENT '操作者id',
  `admin_menu_id` int(11) DEFAULT NULL COMMENT '操作菜单id',
  `ip` varchar(100) DEFAULT NULL COMMENT '操作ip',
  `errormsg` varchar(200) DEFAULT NULL,
  `operation_id` varchar(200) DEFAULT NULL COMMENT '操作关联id',
  `create_time` int(11) NOT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`),
  KEY `id` (`id`) USING BTREE,
  KEY `admin_id` (`admin_id`) USING BTREE,
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of eagle_func_error_log
-- ----------------------------
INSERT INTO `eagle_func_error_log` VALUES ('1', '1', '60', '10.80.63.9', null, '', '1521192027');
INSERT INTO `eagle_func_error_log` VALUES ('2', null, null, '0.0.0.0', 'method not exist:think\\db\\Query->add', 'db_error', '1522140306');
INSERT INTO `eagle_func_error_log` VALUES ('3', null, null, '0.0.0.0', 'method not exist:think\\db\\Query->save', 'db_error', '1522140411');
INSERT INTO `eagle_func_error_log` VALUES ('4', null, null, '0.0.0.0', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'薪资岗位12\' for column \'Station\' ', 'db_error', '1522140426');
INSERT INTO `eagle_func_error_log` VALUES ('5', null, null, '0.0.0.0', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'薪资岗位12\' for column \'Station\' ', 'db_error', '1522140426');
INSERT INTO `eagle_func_error_log` VALUES ('6', null, null, '0.0.0.0', 'SQLSTATE[HY000]: General error: 1366 Incorrect integer value: \'薪资岗位12\' for column \'Station\' ', 'db_error', '1522140426');
INSERT INTO `eagle_func_error_log` VALUES ('7', null, null, '0.0.0.0', '', 'db_error-fields not exists:[UpdateTime]', '1522140941');
INSERT INTO `eagle_func_error_log` VALUES ('8', null, null, '0.0.0.0', '', 'db_error-fields not exists:[UpdateTime]', '1522142348');
INSERT INTO `eagle_func_error_log` VALUES ('9', null, null, '0.0.0.0', '', 'db_error-fields not exists:[UpdateTime]', '1522142528');
INSERT INTO `eagle_func_error_log` VALUES ('10', null, null, '0.0.0.0', '', 'db_error-fields not exists:[UpdateTime]', '1522142545');
INSERT INTO `eagle_func_error_log` VALUES ('11', null, null, '0.0.0.0', '', 'db_error-fields not exists:[UpdateTime]', '1522142554');

-- ----------------------------
-- Table structure for eagle_messages
-- ----------------------------
DROP TABLE IF EXISTS `eagle_messages`;
CREATE TABLE `eagle_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` int(11) NOT NULL,
  `ip` varchar(50) NOT NULL,
  `is_look` int(1) NOT NULL DEFAULT '0' COMMENT '0未读1已读',
  `message` text NOT NULL,
  `update_time` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`) USING BTREE,
  KEY `is_look` (`is_look`) USING BTREE,
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of eagle_messages
-- ----------------------------

-- ----------------------------
-- Table structure for eagle_potentialmembers
-- ----------------------------
DROP TABLE IF EXISTS `eagle_potentialmembers`;
CREATE TABLE `eagle_potentialmembers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) CHARACTER SET utf8 DEFAULT NULL,
  `itname` varchar(30) CHARACTER SET utf8 DEFAULT NULL,
  `datestr` varchar(30) CHARACTER SET utf8 DEFAULT NULL,
  `gender` varchar(6) CHARACTER SET utf8 DEFAULT NULL,
  `age` int(3) DEFAULT NULL,
  `telnumber` varchar(32) CHARACTER SET utf8 DEFAULT NULL,
  `workyear` int(2) DEFAULT NULL,
  `localaddress` varchar(30) CHARACTER SET utf8 DEFAULT NULL,
  `eg` varchar(30) CHARACTER SET utf8 DEFAULT NULL,
  `dept` varchar(60) CHARACTER SET utf8 DEFAULT NULL,
  `station` varchar(60) CHARACTER SET utf8 DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `createdby` varchar(60) CHARACTER SET utf8 DEFAULT NULL,
  `create_time` varchar(30) CHARACTER SET utf8 DEFAULT NULL,
  `updatedby` varchar(30) CHARACTER SET utf8 DEFAULT NULL,
  `update_time` varchar(30) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=512 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of eagle_potentialmembers
-- ----------------------------

-- ----------------------------
-- Table structure for eagle_recruit
-- ----------------------------
DROP TABLE IF EXISTS `eagle_recruit`;
CREATE TABLE `eagle_recruit` (
  `Id` varchar(30) NOT NULL,
  `CName` varchar(50) DEFAULT NULL COMMENT '中文名',
  `EName` varchar(50) DEFAULT NULL COMMENT '英文名',
  `Station` varchar(30) DEFAULT NULL COMMENT '岗位',
  `Gender` varchar(4) DEFAULT NULL COMMENT '性别  1 男  0 女',
  `Nation` varchar(50) DEFAULT NULL COMMENT '名族',
  `CardId` varchar(18) DEFAULT NULL COMMENT '身份证号',
  `Telephone` varchar(15) DEFAULT NULL COMMENT '手机号码',
  `Email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `Domicile` varchar(10) DEFAULT NULL COMMENT '户籍性质  农业/非农业',
  `IsMarry` varchar(10) DEFAULT NULL COMMENT '婚否    1已婚 2未婚 3离异',
  `IsHealthy` varchar(30) DEFAULT NULL COMMENT '健康状况',
  `IsIllegal` varchar(4) DEFAULT NULL COMMENT '是否违法',
  `Party` varchar(30) DEFAULT NULL COMMENT '政治面貌 1共产党员 2预备党员 3群众 4民主党派',
  `AddPartyTime` date DEFAULT NULL COMMENT '入党时间',
  `LivePcc` varchar(100) DEFAULT NULL COMMENT '现居身份',
  `LivePcc_val` varchar(30) DEFAULT NULL COMMENT '现居城市',
  `LiveAddress` varchar(100) DEFAULT NULL COMMENT '现居详细地址',
  `ResPcc` varchar(30) DEFAULT NULL COMMENT '户口所在省份',
  `ResPcc_val` varchar(30) DEFAULT NULL COMMENT '户口所在城市',
  `ResAddress` varchar(100) DEFAULT NULL COMMENT '户口所在详细地址',
  `HeaderImg` varchar(100) DEFAULT NULL COMMENT '免冠照片地址',
  `ContactName` varchar(50) DEFAULT NULL COMMENT '紧急联络人姓名',
  `ContactShip` varchar(20) DEFAULT NULL COMMENT '紧急联络人关系',
  `ContactTel` varchar(20) DEFAULT NULL COMMENT '紧急联络人电话',
  `Language` varchar(30) DEFAULT NULL COMMENT '外语语种',
  `LangLevel` varchar(10) DEFAULT NULL COMMENT '外语能力   1了解 2熟练 3精通',
  `Source` varchar(50) DEFAULT NULL COMMENT '招聘渠道 1:51job 2:智联招聘 3:公司官网 4:猎聘网 5:微信 6内部推荐 7其他',
  `SourceResult` varchar(30) DEFAULT NULL COMMENT '推荐人/其他来源',
  `Professional` varchar(50) DEFAULT NULL COMMENT '专业证书',
  `EntryTime` date DEFAULT NULL COMMENT '可到岗时间',
  `Interest` varchar(300) DEFAULT NULL COMMENT '兴趣爱好 逗号分隔',
  `FamilyInfo` text COMMENT '家庭情况 数组序列化  姓名：UName 关系：Ship 单位：Company 联系方式：Tel ',
  `IsFriend` varchar(4) DEFAULT NULL COMMENT '亲友  1有 0无',
  `FriendInfo` text COMMENT '亲友信息 数组序列化 姓名：Name 关系：Ship',
  `Education` text CHARACTER SET utf8mb4 COMMENT '学习情况 数组序列化  入校年月StartTime 离校年月EndTime 学校名称SchoolName 专业Major 有无毕业证 IsDiploma（1：有 0 无） 学历EduRecord',
  `WorkExp` text COMMENT '工作经历 数组序列化 入职时间EntryTime 离职时间QuitTime 工作单位Company 职位Position 离职原因Reason 证明人及电话：Contact  职责Duty',
  `WorkTime` varchar(30) DEFAULT NULL COMMENT '工作时间制',
  `Subsidy` varchar(100) DEFAULT NULL COMMENT '补贴',
  `SubsidyAmount` varchar(8) DEFAULT NULL COMMENT '补贴金额',
  `M_Salary` varchar(8) DEFAULT NULL COMMENT '月薪',
  `Q_Award` varchar(8) DEFAULT NULL COMMENT '季度奖金',
  `Y_Award` varchar(8) DEFAULT NULL COMMENT '年终奖',
  `Income` varchar(9) DEFAULT NULL COMMENT '年总收入',
  `E_Salary` varchar(9) DEFAULT NULL COMMENT '期望年薪',
  `Agreement` varchar(50) DEFAULT NULL COMMENT '协议',
  `Come` varchar(20) DEFAULT NULL COMMENT '来源',
  `create_time` varchar(30) DEFAULT NULL COMMENT '创建时间',
  `update_time` varchar(0) DEFAULT NULL COMMENT '修改时间',
  `Status` int(1) DEFAULT '0' COMMENT '招聘状态',
  `Files` text,
  `SmgStatus` int(1) DEFAULT '0' COMMENT 'smg状态 0默认1选中',
  `ModifyTime` datetime DEFAULT NULL COMMENT '状态修改时间',
  `admin_id` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of eagle_recruit
-- ----------------------------
INSERT INTO `eagle_recruit` VALUES ('5abb216aa56bf', 'test', 'etes', null, '男', null, '421125199002011356', '17621510870', 'etet@skjdfk.com', null, '单身', null, null, null, null, '北京市北京市东城区', '0,0,0', '234', null, null, null, '/uploads/images/recruit/201803/28/20180328130732-464.jpeg', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '未知', null, null, '0', null, '0', null, null);

-- ----------------------------
-- Table structure for eagle_smsconfig
-- ----------------------------
DROP TABLE IF EXISTS `eagle_smsconfig`;
CREATE TABLE `eagle_smsconfig` (
  `sms` varchar(10) NOT NULL DEFAULT 'sms' COMMENT '标识',
  `appkey` varchar(200) NOT NULL,
  `secretkey` varchar(200) NOT NULL,
  `type` varchar(100) DEFAULT 'normal' COMMENT '短信类型',
  `name` varchar(100) NOT NULL COMMENT '短信签名',
  `code` varchar(100) NOT NULL COMMENT '短信模板ID',
  `content` text NOT NULL COMMENT '短信默认模板',
  KEY `sms` (`sms`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of eagle_smsconfig
-- ----------------------------
INSERT INTO `eagle_smsconfig` VALUES ('sms', '', '', '', '', '', '');
INSERT INTO `eagle_smsconfig` VALUES ('lt', '003031', '31345678901234562311', 'normal', 'WZ_SM_PI', 'SM9527', 'c');

-- ----------------------------
-- Table structure for eagle_sms_log
-- ----------------------------
DROP TABLE IF EXISTS `eagle_sms_log`;
CREATE TABLE `eagle_sms_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(30) CHARACTER SET utf8 DEFAULT NULL,
  `content` varchar(600) CHARACTER SET utf8 DEFAULT NULL,
  `code` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `tag` varchar(30) CHARACTER SET utf8 DEFAULT NULL,
  `logtime` datetime DEFAULT NULL,
  `returnmsg` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=102 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of eagle_sms_log
-- ----------------------------
INSERT INTO `eagle_sms_log` VALUES ('84', '线上招聘', '陈水明您本次短信验证码为1681,请在30分钟内使用(仅在线上招聘登录使用，非本人操作请忽略)。', null, '17621510870', '2018-03-12 17:24:02', null);
INSERT INTO `eagle_sms_log` VALUES ('85', '线上招聘', '陈水明您本次短信验证码为1914,请在30分钟内使用(仅在线上招聘登录使用，非本人操作请忽略)。', null, '17621510870', '2018-03-12 17:25:51', null);
INSERT INTO `eagle_sms_log` VALUES ('86', '线上招聘', '陈水明您本次短信验证码为3808,请在30分钟内使用(仅在线上招聘登录使用，非本人操作请忽略)。', null, '17621510870', '2018-03-19 09:40:36', null);
INSERT INTO `eagle_sms_log` VALUES ('87', '线上招聘', '陈水明您本次短信验证码为3238,请在30分钟内使用(仅在线上招聘登录使用，非本人操作请忽略)。', null, '17621510870', '2018-03-19 09:45:31', null);
INSERT INTO `eagle_sms_log` VALUES ('88', '线上招聘', '陈水明您本次短信验证码为9039,请在30分钟内使用(仅在线上招聘登录使用，非本人操作请忽略)。', null, '17621510870', '2018-03-19 09:50:25', null);
INSERT INTO `eagle_sms_log` VALUES ('89', '线上招聘', '陈水明您本次短信验证码为7838,请在30分钟内使用(仅在线上招聘登录使用，非本人操作请忽略)。', null, '17621510870', '2018-03-19 09:50:40', null);
INSERT INTO `eagle_sms_log` VALUES ('90', '线上招聘', '陈水明您本次短信验证码为6777,请在30分钟内使用(仅在线上招聘登录使用，非本人操作请忽略)。', null, '17621510870', '2018-03-19 09:51:53', '');
INSERT INTO `eagle_sms_log` VALUES ('91', '线上招聘', '陈水明您本次短信验证码为7535,请在30分钟内使用(仅在线上招聘登录使用，非本人操作请忽略)。', null, '17621510870', '2018-03-19 10:01:03', '');
INSERT INTO `eagle_sms_log` VALUES ('92', '线上招聘', '陈水明您本次短信验证码为7478,请在30分钟内使用(仅在线上招聘登录使用，非本人操作请忽略)。', '7478', '17621510870', '2018-03-19 11:30:20', '');
INSERT INTO `eagle_sms_log` VALUES ('93', '线上招聘', '陈水明您本次短信验证码为4513,请在30分钟内使用(仅在线上招聘登录使用，非本人操作请忽略)。', '4513', '17621510870', '2018-03-19 11:32:28', '发送失败，请联系管理员！');
INSERT INTO `eagle_sms_log` VALUES ('94', '线上招聘', '陈水明您本次短信验证码为3507,请在30分钟内使用(仅在线上招聘登录使用，非本人操作请忽略)。', '3507', '17621510870', '2018-03-19 11:33:36', '发送失败，请联系管理员！');
INSERT INTO `eagle_sms_log` VALUES ('95', '线上招聘', '陈水明您本次短信验证码为9580,请在30分钟内使用(仅在线上招聘登录使用，非本人操作请忽略)。', '9580', '17621510870', '2018-03-19 14:15:29', '发送失败，请联系管理员！');
INSERT INTO `eagle_sms_log` VALUES ('96', '线上招聘', '陈水明您本次短信验证码为2360,请在30分钟内使用(仅在线上招聘登录使用，非本人操作请忽略)。', '2360', '17621510870', '2018-03-21 09:46:15', '发送失败，请联系管理员！');
INSERT INTO `eagle_sms_log` VALUES ('97', 'offer提醒', '贾小兰您好,您的offer已经发送至您jiaxiaolan123@163.com的邮箱,请注意查收!并打开以下地址及时上传相关资料,报到时请携带证件原件。谢谢！http://hr.semirapp.com/index.php/Recruit/Login/index', '', '15201931736', '2018-03-21 09:47:49', '');
INSERT INTO `eagle_sms_log` VALUES ('98', 'offer提醒', '贾小兰您好,您的offer已经发送至您jiaxiaolan123@163.com的邮箱,请注意查收!并打开以下地址及时上传相关资料,报到时请携带证件原件。谢谢！http://hr.semirapp.com/index.php/Recruit/Login/index', '', '15201931736', '2018-03-21 09:48:09', '');
INSERT INTO `eagle_sms_log` VALUES ('99', 'offer提醒', '贾小兰您好,您的offer已经发送至您jiaxiaolan123@163.com的邮箱,请注意查收!并打开以下地址及时上传相关资料,报到时请携带证件原件。谢谢！http://hr.semirapp.com/index.php/Recruit/Login/index', '', '15201931736', '2018-03-21 09:48:18', '');
INSERT INTO `eagle_sms_log` VALUES ('100', 'offer提醒', '贾小兰您好,您的offer已经发送至您jiaxiaolan123@163.com的邮箱,请注意查收!并打开以下地址及时上传相关资料,报到时请携带证件原件。谢谢！http://hr.semirapp.com/index.php/Recruit/Login/index', '', '15201931736', '2018-03-21 09:48:26', '');
INSERT INTO `eagle_sms_log` VALUES ('101', 'offer提醒', '贾小兰您好,您的offer已经发送至您jiaxiaolan123@163.com的邮箱,请注意查收!并打开以下地址及时上传相关资料,报到时请携带证件原件。谢谢！http://hr.semirapp.com/index.php/Recruit/Login/index', '', '15201931736', '2018-03-21 09:51:31', '');

-- ----------------------------
-- Table structure for eagle_staff
-- ----------------------------
DROP TABLE IF EXISTS `eagle_staff`;
CREATE TABLE `eagle_staff` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `cname` varchar(20) NOT NULL DEFAULT '',
  `location` varchar(20) DEFAULT '上海',
  `del_show` int(11) NOT NULL DEFAULT '0',
  `surname` char(20) DEFAULT NULL,
  `firstname` char(20) DEFAULT NULL,
  `itname` varchar(30) NOT NULL DEFAULT '',
  `station` varchar(100) DEFAULT NULL,
  `jobnumber` varchar(20) DEFAULT NULL,
  `username` varchar(30) DEFAULT NULL,
  `email` varchar(50) NOT NULL DEFAULT '',
  `gender` int(11) NOT NULL DEFAULT '1',
  `password` varchar(20) DEFAULT NULL,
  `rootid` int(11) NOT NULL DEFAULT '0',
  `enabled` int(11) NOT NULL DEFAULT '0',
  `dept` varchar(50) NOT NULL DEFAULT '',
  `oftel` varchar(20) DEFAULT NULL,
  `mobtel` varchar(20) DEFAULT NULL,
  `ip1` int(11) NOT NULL DEFAULT '10',
  `runtype` varchar(20) DEFAULT NULL,
  `create_time` varchar(20) DEFAULT NULL,
  `update_time` varchar(20) DEFAULT NULL,
  `appstore` varchar(50) DEFAULT NULL,
  `system_id` varchar(50) NOT NULL DEFAULT '1,2,3,4',
  `deptlist` varchar(100) DEFAULT NULL,
  `port_number` varchar(12) DEFAULT NULL,
  `deptleader` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `itname_index` (`itname`) USING BTREE,
  KEY `psc_index` (`jobnumber`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=6132 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of eagle_staff
-- ----------------------------
INSERT INTO `eagle_staff` VALUES ('6131', '束凡', '上海', '0', null, null, 'shufan', '3', '1', null, '', '0', null, '0', '1', '', null, '18202783049', '10', null, '1521782321', '1521782321', null, '1,2,3,4', null, null, null);

-- ----------------------------
-- Table structure for eagle_station
-- ----------------------------
DROP TABLE IF EXISTS `eagle_station`;
CREATE TABLE `eagle_station` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) CHARACTER SET utf8 NOT NULL,
  `belongto` varchar(60) CHARACTER SET utf8 DEFAULT NULL,
  `ordernum` int(11) DEFAULT NULL,
  `createdby` varchar(60) CHARACTER SET utf8 DEFAULT NULL,
  `createdtime` datetime DEFAULT NULL,
  `status` int(2) DEFAULT '1',
  `update_time` int(32) DEFAULT NULL,
  `create_time` int(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=270 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of eagle_station
-- ----------------------------
INSERT INTO `eagle_station` VALUES ('2', '无名岗位', null, null, null, '2017-08-31 16:31:22', '1', null, null);
INSERT INTO `eagle_station` VALUES ('3', '测试岗位sefsd', 'SEMIR', null, 'chenshuiming', '2017-09-07 16:33:35', '1', null, null);
INSERT INTO `eagle_station` VALUES ('4', 'TE', 'SEMIR', null, 'chenshuiming', '2017-09-08 13:29:22', '1', null, null);
INSERT INTO `eagle_station` VALUES ('5', 'DFSDF', '森马', null, 'chenshuiming', '2017-09-18 17:34:30', '1', null, null);
INSERT INTO `eagle_station` VALUES ('6', '渠道管理工作人员', '森马', null, 'chenshuiming', '2017-09-26 13:35:18', '1', null, null);
INSERT INTO `eagle_station` VALUES ('7', '薪资岗位12', '森马', null, 'chenshuiming', '2017-09-26 14:20:54', '2', null, null);
INSERT INTO `eagle_station` VALUES ('8', '平凡岗位', '森马', null, 'chenshuiming', '2017-09-26 14:21:57', '1', null, null);
INSERT INTO `eagle_station` VALUES ('9', '不一样的岗位', '森马', null, 'chenshuiming', '2017-09-26 14:23:11', '1', null, null);
INSERT INTO `eagle_station` VALUES ('10', 'test', '森马', null, 'noname', '2017-10-17 14:17:06', '1', '1521182449', null);
INSERT INTO `eagle_station` VALUES ('11', '测试', '森马', null, 'sixiang', '2017-10-19 14:49:22', '1', null, null);
INSERT INTO `eagle_station` VALUES ('12', 'AVC', '森马', null, 'sss', '2017-10-19 15:05:17', '1', null, null);
INSERT INTO `eagle_station` VALUES ('13', 'sdfdsfds', '森马', null, 'rzzy', '2017-10-19 15:21:18', '2', null, null);
INSERT INTO `eagle_station` VALUES ('14', '测试', '股份', null, 'chenshuiming', '2017-11-02 13:48:55', '2', null, null);
INSERT INTO `eagle_station` VALUES ('15', '测试', '股份', null, 'chenshuiming', '2017-11-02 13:49:06', '1', null, null);
INSERT INTO `eagle_station` VALUES ('16', '尺寸', '股份', null, 'chenshuiming', '2017-11-02 13:50:01', '2', null, null);
INSERT INTO `eagle_station` VALUES ('17', 'ABC', '股份', null, 'chenshuiming', '2017-11-09 17:46:45', '1', null, null);
INSERT INTO `eagle_station` VALUES ('18', 'DFSDF', '森马', null, 'chenshuiming', '2017-09-18 17:34:30', '1', null, null);
INSERT INTO `eagle_station` VALUES ('19', '测试1', '森马', null, 'sixiang', null, '1', null, null);
INSERT INTO `eagle_station` VALUES ('20', '测试1', '森马', null, 'sixiang', null, '1', null, null);
INSERT INTO `eagle_station` VALUES ('21', '测试1', '森马', null, 'sixiang', null, '1', null, null);
INSERT INTO `eagle_station` VALUES ('22', '测试1', '森马', null, 'sixiang', null, '1', null, null);
INSERT INTO `eagle_station` VALUES ('23', '测试1', '森马', null, 'sixiang', null, '1', null, null);
INSERT INTO `eagle_station` VALUES ('24', '测试1', '森马', null, 'sixiang', null, '1', null, null);
INSERT INTO `eagle_station` VALUES ('25', '测试1', '森马', null, 'sixiang', null, '1', null, null);
INSERT INTO `eagle_station` VALUES ('26', '测试1', '森马', null, 'sixiang', null, '1', null, null);
INSERT INTO `eagle_station` VALUES ('27', '测试1', '森马', null, 'sixiang', null, '1', null, null);
INSERT INTO `eagle_station` VALUES ('28', '测试1', '森马', null, 'sixiang', null, '1', null, null);
INSERT INTO `eagle_station` VALUES ('29', '测试1', '森马', null, 'sixiang', null, '1', null, null);
INSERT INTO `eagle_station` VALUES ('30', '测试1', '森马', null, 'sixiang', null, '1', null, null);
INSERT INTO `eagle_station` VALUES ('31', '南山总监', '股份', null, 'chenshuiming', '2017-11-14 10:09:05', '1', null, null);
INSERT INTO `eagle_station` VALUES ('32', '江南', null, null, null, null, '1', '1521182767', '1521182767');
INSERT INTO `eagle_station` VALUES ('33', '虎贲', null, null, 'admin', null, '1', '1521182989', '1521182989');
INSERT INTO `eagle_station` VALUES ('34', '僵硬', null, null, '超级管理员', null, '1', '1521183418', '1521183418');
INSERT INTO `eagle_station` VALUES ('35', 'SDFJKSDJ', 'SDKFJDSK', null, '16', null, '1', '1522401110', '1522401110');
INSERT INTO `eagle_station` VALUES ('36', 'GDFGF', 'DFGFDG', null, '16', null, '1', '1522401130', '1522401130');
INSERT INTO `eagle_station` VALUES ('37', 'DSFDS', 'DFD', null, '16', null, '1', '1522401227', '1522401227');
INSERT INTO `eagle_station` VALUES ('38', 'ETRE', 'ETRE', null, '16', null, '1', '1522401254', '1522401254');
INSERT INTO `eagle_station` VALUES ('269', '数据分析专员', '女装MINETTE', '0', 'dingdan', '2018-06-01 15:40:53', '1', null, null);
INSERT INTO `eagle_station` VALUES ('268', '成衣采购专员', '女装minette', '0', 'dingdan', '2018-06-01 09:29:50', '1', null, null);

-- ----------------------------
-- Table structure for eagle_urlconfig
-- ----------------------------
DROP TABLE IF EXISTS `eagle_urlconfig`;
CREATE TABLE `eagle_urlconfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `aliases` varchar(200) NOT NULL COMMENT '想要设置的别名',
  `url` varchar(200) NOT NULL COMMENT '原url结构',
  `desc` text COMMENT '备注',
  `status` int(1) NOT NULL DEFAULT '1' COMMENT '0禁用1使用',
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`) USING BTREE,
  KEY `status` (`status`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of eagle_urlconfig
-- ----------------------------
INSERT INTO `eagle_urlconfig` VALUES ('1', 'admin_login', 'admin/common/login', '后台登录地址。', '0', '1517621629', '1517621629');

-- ----------------------------
-- Table structure for eagle_user_log
-- ----------------------------
DROP TABLE IF EXISTS `eagle_user_log`;
CREATE TABLE `eagle_user_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_menu_id` int(11) DEFAULT NULL COMMENT '操作菜单id',
  `admin_id` int(11) DEFAULT NULL COMMENT '操作者id',
  `ip` varchar(100) DEFAULT NULL COMMENT '操作ip',
  `operation_id` varchar(200) DEFAULT NULL COMMENT '操作关联id',
  `create_time` int(11) NOT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`),
  KEY `id` (`id`) USING BTREE,
  KEY `admin_id` (`admin_id`) USING BTREE,
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of eagle_user_log
-- ----------------------------
INSERT INTO `eagle_user_log` VALUES ('1', '60', '1', '10.80.63.9', '', '1521192027');
INSERT INTO `eagle_user_log` VALUES ('2', '60', '1', '10.80.63.9', '', '1521456858');
INSERT INTO `eagle_user_log` VALUES ('3', '60', '1', '10.80.63.9', '', '1521513601');
INSERT INTO `eagle_user_log` VALUES ('4', '60', '1', '0.0.0.0', '', '1521533807');
INSERT INTO `eagle_user_log` VALUES ('5', null, '1', '10.80.63.9', 'db_error', '1521537047');
INSERT INTO `eagle_user_log` VALUES ('6', null, '1', '10.80.63.9', 'db_error', '1521537261');
INSERT INTO `eagle_user_log` VALUES ('7', null, '1', '10.80.63.9', 'db_error', '1521537361');
INSERT INTO `eagle_user_log` VALUES ('8', null, '1', '10.80.63.9', 'db_error', '1521537577');
INSERT INTO `eagle_user_log` VALUES ('9', null, '1', '10.80.63.9', 'db_error', '1521537664');
INSERT INTO `eagle_user_log` VALUES ('10', null, '1', '10.80.63.9', 'db_error', '1521537681');
INSERT INTO `eagle_user_log` VALUES ('11', '60', '1', '10.80.63.9', '', '1521618178');
INSERT INTO `eagle_user_log` VALUES ('12', '60', '1', '10.80.63.9', '', '1521619962');
INSERT INTO `eagle_user_log` VALUES ('13', '60', '1', '10.80.63.9', '', '1521681043');
INSERT INTO `eagle_user_log` VALUES ('14', '60', '1', '10.80.63.9', '', '1521685969');
INSERT INTO `eagle_user_log` VALUES ('15', '60', '1', '10.80.63.9', '', '1521766907');
INSERT INTO `eagle_user_log` VALUES ('16', '60', '1', '10.80.63.9', '', '1521796520');
INSERT INTO `eagle_user_log` VALUES ('17', '60', '1', '10.80.63.9', '', '1522031800');
INSERT INTO `eagle_user_log` VALUES ('18', '60', '1', '10.80.63.9', '', '1522035102');
INSERT INTO `eagle_user_log` VALUES ('19', '60', '1', '0.0.0.0', '', '1522129369');
INSERT INTO `eagle_user_log` VALUES ('20', '60', '1', '10.80.63.9', '', '1522229627');
INSERT INTO `eagle_user_log` VALUES ('21', '60', '1', '0.0.0.0', '', '1522287593');
INSERT INTO `eagle_user_log` VALUES ('22', '60', '1', '0.0.0.0', '', '1522287893');
INSERT INTO `eagle_user_log` VALUES ('23', null, '1', '0.0.0.0', '3', '1522288461');
INSERT INTO `eagle_user_log` VALUES ('24', '60', '16', '0.0.0.0', '', '1522291161');
INSERT INTO `eagle_user_log` VALUES ('25', '60', '16', '0.0.0.0', '', '1522291684');
INSERT INTO `eagle_user_log` VALUES ('26', '60', '16', '0.0.0.0', '', '1522291912');
INSERT INTO `eagle_user_log` VALUES ('27', null, '16', '0.0.0.0', '', '1522291981');
INSERT INTO `eagle_user_log` VALUES ('28', null, '16', '0.0.0.0', '', '1522292113');
INSERT INTO `eagle_user_log` VALUES ('29', '60', '16', '0.0.0.0', '', '1522292380');
INSERT INTO `eagle_user_log` VALUES ('30', '60', '1', '0.0.0.0', '', '1522399802');
INSERT INTO `eagle_user_log` VALUES ('31', '60', '16', '0.0.0.0', '', '1522400114');
INSERT INTO `eagle_user_log` VALUES ('32', '60', '16', '0.0.0.0', '', '1522402990');
INSERT INTO `eagle_user_log` VALUES ('33', '60', '16', '10.80.63.9', '', '1522808684');
INSERT INTO `eagle_user_log` VALUES ('34', '60', '16', '0.0.0.0', '', '1527570877');
INSERT INTO `eagle_user_log` VALUES ('35', '60', '1', '0.0.0.0', '', '1527571150');
INSERT INTO `eagle_user_log` VALUES ('36', '60', '1', '0.0.0.0', '', '1527668774');
INSERT INTO `eagle_user_log` VALUES ('37', '60', '17', '0.0.0.0', '', '1528075360');
INSERT INTO `eagle_user_log` VALUES ('38', '60', '1', '0.0.0.0', '', '1528075413');
INSERT INTO `eagle_user_log` VALUES ('39', '60', '16', '0.0.0.0', '', '1528183504');
INSERT INTO `eagle_user_log` VALUES ('40', '60', '16', '0.0.0.0', '', '1528186359');

-- ----------------------------
-- Table structure for eagle_webconfig
-- ----------------------------
DROP TABLE IF EXISTS `eagle_webconfig`;
CREATE TABLE `eagle_webconfig` (
  `web` varchar(20) NOT NULL COMMENT '网站配置标识',
  `name` varchar(200) NOT NULL COMMENT '网站名称',
  `keywords` text COMMENT '关键词',
  `desc` text COMMENT '描述',
  `is_log` int(1) NOT NULL DEFAULT '1' COMMENT '1开启日志0关闭',
  `file_type` varchar(200) DEFAULT NULL COMMENT '允许上传的类型',
  `file_size` bigint(20) DEFAULT NULL COMMENT '允许上传的最大值',
  `statistics` text COMMENT '统计代码',
  `black_ip` text COMMENT 'ip黑名单',
  `url_suffix` varchar(20) DEFAULT NULL COMMENT 'url伪静态后缀',
  `col_size` int(3) DEFAULT '20',
  KEY `web` (`web`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of eagle_webconfig
-- ----------------------------
INSERT INTO `eagle_webconfig` VALUES ('web', 'Eagle后台管理框架', 'Eagle,后台管理,thinkphp5,layui', 'TplayEagle是一款基于ThinkPHP5.0.12 + layui2.2.45 + ECharts + Mysql开发的后台管理框架，集成了一般应用所必须的基础性功能，为开发者节省大量的时间。', '1', 'jpg,png,gif,mp4,zip,jpeg', '500', '', '', null, '20');
