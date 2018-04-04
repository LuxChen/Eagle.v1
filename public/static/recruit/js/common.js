// JavaScript Document
$('#checked')
		.click(
				function() {
					var sMobile = $('.tel').val();
					if (checkmobile(sMobile) == false) {
						_alert('请输入正确的手机号码');
						return;
					}
					var checkcode = $('.checkcode').val();
					if (checkcode == '') {
						_alert('请输入验证码');
						return;
					}
					var che = $('#che').is(':checked');
					if (che != true) {
						_alert('请确定已阅读应聘者申明');
						return;
					}
					var go = $('input[name="go"]').val();
					var url = "/Recruit/Login/check";
					var data = $('form').serialize();
					$('#checked').attr('disable', true);
					$('#checked').css('background', '#ccc');
					$('#checked').val('验证中...');
					$.post(
									url,
									data,
									function(res) {
										_alert(res.info);
										if (res.status == true) {
											setTimeout(
													function() {
														if (go == 'uploadfile') {
															window.location.href = "/index.php/Recruit/Index/uploadfile";
														} else {
															window.location.href = "/index.php/Recruit/Index/myCenter";
														}

													}, 2000)
										} else {
											$('#checked')
													.attr('disable', false);
											$('#checked').css('background',
													'#009e41');
											$('#checked').val('验证');
										}

									})
				})
$('#sendcode').click(function() {
	var sMobile = $('.tel').val();
	if (checkmobile(sMobile) == false) {
		_alert('请输入正确的手机号码');
		return;
	} else {
		var url = "/recruit/api/send_sms";
		$.post(url, {
			phone : sMobile
		}, function(data) {
			if (data.status == true) {
				sendcode(sMobile);
			} else {
				_alert(data.info);
			}
		})
	}
})
function checkmobile(mobile) {
	return !!mobile.match(/^(0|86|17951)?(1[0-9][0-9])[0-9]{8}$/);
}
var t = 60;
function sendcode(tel) {
	var sc = $('#sendcode');
	if (t <= 0) {
		sc.attr('disabled', false);
		sc.css('background', '#009e41');
		sc.val('获取验证码');
		t = 60;
	} else {
		sc.attr('disabled', true);
		sc.css('background', '#ccc');
		sc.val('等待' + t + '秒');
		t--;
		setTimeout(function() {
			sendcode(tel)
		}, 1000)
	}
}

function _alert(str) {
	// 提示
	layer.open({
		content : str,
		skin : 'msg',
		time : 2
	// 2秒后自动关闭
	});
}
$('#a_notice').click(function() {
	$('.mask,.notice').show();
})
$('.mask,.closed').click(function() {
	$('.mask,.notice').hide();
})

$('.prev').click(function() {
	window.location.href = '/index.php/Recruit/Index/myCenter'
})

function btnStyle(status) {
	if (status == 0) {
		$('#save').attr('disable', true);
		$('#save').css('background', '#ccc');
		$('#save').val('保存中...');
	} else if (status == 1) {
		$('#save').attr('disable', false);
		$('#save').css('background', '#009e41');
		$('#save').val('保存');
	}
}

var vcity = {
	11 : "北京",
	12 : "天津",
	13 : "河北",
	14 : "山西",
	15 : "内蒙古",
	21 : "辽宁",
	22 : "吉林",
	23 : "黑龙江",
	31 : "上海",
	32 : "江苏",
	33 : "浙江",
	34 : "安徽",
	35 : "福建",
	36 : "江西",
	37 : "山东",
	41 : "河南",
	42 : "湖北",
	43 : "湖南",
	44 : "广东",
	45 : "广西",
	46 : "海南",
	50 : "重庆",
	51 : "四川",
	52 : "贵州",
	53 : "云南",
	54 : "西藏",
	61 : "陕西",
	62 : "甘肃",
	63 : "青海",
	64 : "宁夏",
	65 : "新疆",
	71 : "台湾",
	81 : "香港",
	82 : "澳门",
	91 : "国外"
};
checkCard = function(obj) {

	if (isCardNo(obj) === false) {
		return false;
	}
	// 检查省份
	if (checkProvince(obj) === false) {
		return false;
	}
	// 校验生日
	if (checkBirthday(obj) === false) {
		return false;
	}
	// 检验位的检测
	if (checkParity(obj) === false) {
		return false;
	}
	return true;
};
// 检查号码是否符合规范，包括长度，类型
isCardNo = function(obj) {
	// 身份证号码为15位或者18位，15位时全为数字，18位前17位为数字，最后一位是校验位，可能为数字或字符X
	var reg = /(^\d{15}$)|(^\d{17}(\d|X)$)/;
	if (reg.test(obj) === false) {
		return false;
	}
	return true;
};
// 取身份证前两位,校验省份
checkProvince = function(obj) {
	var province = obj.substr(0, 2);
	if (vcity[province] == undefined) {
		return false;
	}
	return true;
};
// 检查生日是否正确
checkBirthday = function(obj) {
	var len = obj.length;
	// 身份证15位时，次序为省（3位）市（3位）年（2位）月（2位）日（2位）校验位（3位），皆为数字
	if (len == '15') {
		var re_fifteen = /^(\d{6})(\d{2})(\d{2})(\d{2})(\d{3})$/;
		var arr_data = obj.match(re_fifteen);
		var year = arr_data[2];
		var month = arr_data[3];
		var day = arr_data[4];
		var birthday = new Date('19' + year + '/' + month + '/' + day);
		return verifyBirthday('19' + year, month, day, birthday);
	}
	// 身份证18位时，次序为省（3位）市（3位）年（4位）月（2位）日（2位）校验位（4位），校验位末尾可能为X
	if (len == '18') {
		var re_eighteen = /^(\d{6})(\d{4})(\d{2})(\d{2})(\d{3})([0-9]|X)$/;
		var arr_data = obj.match(re_eighteen);
		var year = arr_data[2];
		var month = arr_data[3];
		var day = arr_data[4];
		var birthday = new Date(year + '/' + month + '/' + day);
		return verifyBirthday(year, month, day, birthday);
	}
	return false;
};
// 校验日期
verifyBirthday = function(year, month, day, birthday) {
	var now = new Date();
	var now_year = now.getFullYear();
	// 年月日是否合理
	if (birthday.getFullYear() == year && (birthday.getMonth() + 1) == month
			&& birthday.getDate() == day) {
		// 判断年份的范围（3岁到100岁之间)
		var time = now_year - year;
		if (time >= 0 && time <= 130) {
			return true;
		}
		return false;
	}
	return false;
};
// 校验位的检测
checkParity = function(obj) {
	// 15位转18位
	obj = changeFivteenToEighteen(obj);
	var len = obj.length;
	if (len == '18') {
		var arrInt = new Array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8,
				4, 2);
		var arrCh = new Array('1', '0', 'X', '9', '8', '7', '6', '5', '4', '3',
				'2');
		var cardTemp = 0, i, valnum;
		for (i = 0; i < 17; i++) {
			cardTemp += obj.substr(i, 1) * arrInt[i];
		}
		valnum = arrCh[cardTemp % 11];
		if (valnum == obj.substr(17, 1)) {
			return true;
		}
		return false;
	}
	return false;
};
// 15位转18位身份证号
changeFivteenToEighteen = function(obj) {
	if (obj.length == '15') {
		var arrInt = new Array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8,
				4, 2);
		var arrCh = new Array('1', '0', 'X', '9', '8', '7', '6', '5', '4', '3',
				'2');
		var cardTemp = 0, i;
		obj = obj.substr(0, 6) + '19' + obj.substr(6, obj.length - 6);
		for (i = 0; i < 17; i++) {
			cardTemp += obj.substr(i, 1) * arrInt[i];
		}
		obj += arrCh[cardTemp % 11];
		return obj;
	}
	return obj;
};