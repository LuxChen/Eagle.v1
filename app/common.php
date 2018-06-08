<?php
// +----------------------------------------------------------------------
// | Tplay [ WE ONLY DO WHAT IS NECESSARY ]
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://tplay.pengyichen.com All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: 听雨 < 389625819@qq.com >
// +----------------------------------------------------------------------

// 应用公共文件

/**
 * 根据附件表的id返回url地址
 * 
 * @param [type] $id
 *        	[description]
 * @return [type] [description]
 */
function geturl($id) {
	if ($id) {
		$geturl = \think\Db::name ( "attachment" )->where ( [ 
				'id' => $id 
		] )->find ();
		if ($geturl ['status'] == 1) {
			// 审核通过
			return $geturl ['filepath'];
		} elseif ($geturl ['status'] == 0) {
			// 待审核
			return '/uploads/xitong/beiyong1.jpg';
		} else {
			// 不通过
			return '/uploads/xitong/beiyong2.jpg';
		}
	}
	return false;
}

/**
 * [SendMail 邮件发送]
 * 
 * @param [type] $address
 *        	[description]
 * @param [type] $title
 *        	[description]
 * @param [type] $message
 *        	[description]
 * @param [type] $from
 *        	[description]
 * @param [type] $fromname
 *        	[description]
 * @param [type] $smtp
 *        	[description]
 * @param [type] $username
 *        	[description]
 * @param [type] $password
 *        	[description]
 */
function SendMail($address) {
	vendor ( 'phpmailer.PHPMailerAutoload' );
	// vendor('PHPMailer.class#PHPMailer');
	$mail = new \PHPMailer ();
	// 设置PHPMailer使用SMTP服务器发送Email
	$mail->IsSMTP ();
	// 设置邮件的字符编码，若不指定，则为'UTF-8'
	$mail->CharSet = 'UTF-8';
	// 添加收件人地址，可以多次使用来添加多个收件人
	$mail->AddAddress ( $address );
	
	$data = \think\Db::name ( 'emailconfig' )->where ( 'email', 'email' )->find ();
	$title = $data ['title'];
	$message = $data ['content'];
	$from = $data ['from_email'];
	$fromname = $data ['from_name'];
	$smtp = $data ['smtp'];
	$username = $data ['username'];
	$password = $data ['password'];
	// 设置邮件正文
	$mail->Body = $message;
	// 设置邮件头的From字段。
	$mail->From = $from;
	// 设置发件人名字
	$mail->FromName = $fromname;
	// 设置邮件标题
	$mail->Subject = $title;
	// 设置SMTP服务器。
	$mail->Host = $smtp;
	// 设置为"需要验证" ThinkPHP 的config方法读取配置文件
	$mail->SMTPAuth = true;
	// 设置html发送格式
	$mail->isHTML ( true );
	// 设置用户名和密码。
	$mail->Username = $username;
	$mail->Password = $password;
	// 发送邮件。
	return ($mail->Send ());
}

/**
 * 阿里大鱼短信发送
 * 
 * @param [type] $appkey
 *        	[description]
 * @param [type] $secretKey
 *        	[description]
 * @param [type] $type
 *        	[description]
 * @param [type] $name
 *        	[description]
 * @param [type] $param
 *        	[description]
 * @param [type] $phone
 *        	[description]
 * @param [type] $code
 *        	[description]
 * @param [type] $data
 *        	[description]
 */
function SendSms($param, $phone) {
	// 配置信息
	import ( 'dayu.top.TopClient' );
	import ( 'dayu.top.TopLogger' );
	import ( 'dayu.top.request.AlibabaAliqinFcSmsNumSendRequest' );
	import ( 'dayu.top.ResultSet' );
	import ( 'dayu.top.RequestCheckUtil' );
	
	// 获取短信配置
	$data = \think\Db::name ( 'smsconfig' )->where ( 'sms', 'sms' )->find ();
	$appkey = $data ['appkey'];
	$secretkey = $data ['secretkey'];
	$type = $data ['type'];
	$name = $data ['name'];
	$code = $data ['code'];
	
	$c = new \TopClient ();
	$c->appkey = $appkey;
	$c->secretKey = $secretkey;
	
	$req = new \AlibabaAliqinFcSmsNumSendRequest ();
	// 公共回传参数，在“消息返回”中会透传回该参数。非必须
	$req->setExtend ( "" );
	// 短信类型，传入值请填写normal
	$req->setSmsType ( $type );
	// 短信签名，传入的短信签名必须是在阿里大于“管理中心-验证码/短信通知/推广短信-配置短信签名”中的可用签名。
	$req->setSmsFreeSignName ( $name );
	// 短信模板变量，传参规则{"key":"value"}，key的名字须和申请模板中的变量名一致，多个变量之间以逗号隔开。
	$req->setSmsParam ( $param );
	// 短信接收号码。支持单个或多个手机号码，传入号码为11位手机号码，不能加0或+86。群发短信需传入多个号码，以英文逗号分隔，一次调用最多传入200个号码。
	$req->setRecNum ( $phone );
	// 短信模板ID，传入的模板必须是在阿里大于“管理中心-短信模板管理”中的可用模板。
	$req->setSmsTemplateCode ( $code );
	// 发送
	
	$resp = $c->execute ( $req );
}

/**
 * 联通短信发送
 * 
 * @param string $msg        	
 * @param integer $phonenumber        	
 * @return mixed
 */
function send_sms($msg, $phonenumber) {
	$msg = mb_convert_encoding ( $msg, "gbk", "UTF-8" );
	$timeout = 5;
	$url = "http://smsapi.ums86.com:8888/sms/Api/Send.do";
	// $post_data = array("SpCode"=>"003031","LoginName"=>"WZ_SM_PI","Password"=>"SM9527","MessageContent"=> $mes ,"UserNumber"=>"18049987585","SerialNumber"=>"31345678901234567899","ScheduleTime"=>"","f"=>"1");
	$post_data = "SpCode=003031&LoginName=WZ_SM_PI&Password=SM9527&MessageContent=" . $msg . "&UserNumber=" . $phonenumber . "&SerialNumber=31345678901234562311&ScheduleTime=&f=1";
	
	// $contents = mb_convert_encoding($contents, "UTF-8", "gb2312");
	$useragent = "Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1312.56 Safari/537.17";
	// 初始化
	$ch = curl_init ();
	// 设置抓取的url
	$header = array (
			"content-type: application/x-www-form-urlencoded; charset=gb2312" 
	);
	curl_setopt ( $ch, CURLOPT_URL, $url );
	// 设置头文件的信息作为数据流输出
	// curl_setopt($ch, CURLOPT_URL, "https://oapi.dingtalk.com/" . $url . "?access_token=" . $aToken);
	curl_setopt ( $ch, CURLOPT_HTTPHEADER, $header );
	curl_setopt ( $ch, CURLOPT_RETURNTRANSFER, 1 );
	curl_setopt ( $ch, CURLOPT_SSLVERSION, 3 );
	curl_setopt ( $ch, CURLOPT_USERAGENT, $useragent );
	curl_setopt ( $ch, CURLOPT_SSL_VERIFYPEER, FALSE ); // https请求 不验证证书和hosts
	curl_setopt ( $ch, CURLOPT_SSL_VERIFYHOST, FALSE );
	curl_setopt ( $ch, CURLOPT_CONNECTTIMEOUT, $timeout );
	curl_setopt ( $ch, CURLOPT_POST, true );
	curl_setopt ( $ch, CURLOPT_POSTFIELDS, $post_data );
	$file_contents = curl_exec ( $ch );
	// print_r($ch);
	curl_close ( $ch );
	return $file_contents;
}
/**
 * 导出Excel
 * 
 * @param unknown $titles        	
 * @param unknown $fields        	
 * @param array $datas        	
 */
function export_toexcel($titles, $fields, $datas = array()) {
// 	require_once __DIR__ . '/../vendor/autoload.php';
	$spreadsheet = new \PhpOffice\PhpSpreadsheet\Spreadsheet ();
	
	$col = 1;
	foreach ( $titles as $title ) {
		$sheet = $spreadsheet->getActiveSheet ();
		$sheet->setCellValueByColumnAndRow ( $col, 1, $title );
		$col ++;
	}
	$row = 2;
	if ($datas) {
		foreach ( $datas as $data ) {
			$col = 1;
			// print_r($data);
			foreach ( $fields as $field ) {
				$sheet = $spreadsheet->getActiveSheet ();
				$sheet->setCellValueByColumnAndRow ( $col, $row, $data[$field] );
				$col ++;
			}
			
			$row ++;
		}
	}
	header ( 'Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' );
	header ( 'Content-Disposition: attachment;filename="SystemExport.xlsx"' );
	header ( 'Cache-Control: max-age=0' );
	$writer = new \PhpOffice\PhpSpreadsheet\Writer\Xlsx ( $spreadsheet );
	$writer->save ( 'php://output' );
}
/**
 * 替换手机号码中间四位数字
 * 
 * @param [type] $str
 *        	[description]
 * @return [type] [description]
 */
function hide_phone($str) {
	$resstr = substr_replace ( $str, '****', 3, 4 );
	return $resstr;
}