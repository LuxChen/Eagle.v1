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

//recruit模块公共函数
/**
 * 判断客户端是移动端还是pc端
 */
function isMobile()
{
	// 如果有HTTP_X_WAP_PROFILE则一定是移动设备
	if (isset($_SERVER['HTTP_X_WAP_PROFILE'])) {
		return true;
	}
	// 如果via信息含有wap则一定是移动设备,部分服务商会屏蔽该信息
	if (isset($_SERVER['HTTP_VIA'])) {
		// 找不到为flase,否则为true
		return stristr($_SERVER['HTTP_VIA'], "wap") ? true : false;
	}
	// 脑残法，判断手机发送的客户端标志,兼容性有待提高
	if (isset($_SERVER['HTTP_USER_AGENT'])) {
		$clientkeywords = array(
				'nokia',
				'sony',
				'ericsson',
				'mot',
				'samsung',
				'htc',
				'sgh',
				'lg',
				'sharp',
				'sie-',
				'philips',
				'panasonic',
				'alcatel',
				'lenovo',
				'iphone',
				'ipod',
				'blackberry',
				'meizu',
				'android',
				'netfront',
				'symbian',
				'ucweb',
				'windowsce',
				'palm',
				'operamini',
				'operamobi',
				'openwave',
				'nexusone',
				'cldc',
				'midp',
				'wap',
				'mobile'
		);
		// 从HTTP_USER_AGENT中查找手机浏览器的关键字
		if (preg_match("/(" . implode('|', $clientkeywords) . ")/i", strtolower($_SERVER['HTTP_USER_AGENT']))) {
			return true;
		}
	}
	// 协议法，因为有可能不准确，放到最后判断
	if (isset($_SERVER['HTTP_ACCEPT'])) {
		// 如果只支持wml并且不支持html那一定是移动设备
		// 如果支持wml和html但是wml在html之前则是移动设备
		if ((strpos($_SERVER['HTTP_ACCEPT'], 'vnd.wap.wml') !== false) && (strpos($_SERVER['HTTP_ACCEPT'], 'text/html') === false || (strpos($_SERVER['HTTP_ACCEPT'], 'vnd.wap.wml') < strpos($_SERVER['HTTP_ACCEPT'], 'text/html')))) {
			return true;
		}
	}
	return false;
}

/**
 * 异常日志
 * @param  [type] $data [description]
 * @return [type]       [description]
 */
function addlog($operation_id='',$errormsg="")
{
	//获取网站配置
	$web_config = \think\Db::name('webconfig')->where('web','web')->find();
	if($web_config['is_log'] == 1) {
		$data['operation_id'] = $operation_id;
		$data['admin_id'] = \think\Session::get('admin');//管理员id
		$request = \think\Request::instance();
		$data['ip'] = $request->ip();//操作ip
		$data['create_time'] = time();//操作时间
		$url['module'] = $request->module();
		$url['controller'] = $request->controller();
		$url['function'] = $request->action();
		//获取url参数
		$parameter = $request->path() ? $request->path() : null;
		//将字符串转化为数组
		$parameter = explode('/',$parameter);
		//剔除url中的模块、控制器和方法
		foreach ($parameter as $key => $value) {
			if($value != $url['module'] and $value != $url['controller'] and $value != $url['function']) {
				$param[] = $value;
			}
		}

		if(isset($param) and !empty($param)) {
			//确定有参数
			$string = '';
			foreach ($param as $key => $value) {
				//奇数为参数的参数名，偶数为参数的值
				if($key%2 !== 0) {
					//过滤只有一个参数和最后一个参数的情况
					if(count($param) > 2 and $key < count($param)-1) {
						$string.=$value.'&';
					} else {
						$string.=$value;
					}
				} else {
					$string.=$value.'=';
				}
			}
		} else {
			//ajax请求方式，传递的参数path()接收不到，所以只能param()
			$string = [];
			$param = $request->param();
			foreach ($param as $key => $value) {
				if(!is_array($value)) {
					//这里过滤掉值为数组的参数
					$string[] = $key.'='.$value;
				}
			}
			$string = implode('&',$string);
		}
		$data['admin_menu_id'] = empty(\think\Db::name('admin_menu')->where($url)->where('parameter',$string)->value('id')) ? \think\Db::name('admin_menu')->where($url)->value('id') : \think\Db::name('admin_menu')->where($url)->where('parameter',$string)->value('id');
		$data['errormsg'] = $errormsg ? substr($errormsg, 0,100) : '';
		//return $data;
		\think\Db::name('func_error_log')->insert($data);
	} else {
		//关闭了日志
		return true;
	}
}

/**
 * curl get
 * @param unknown $url  */
function curl_get($url)
{
	// 初始化
	$ch = curl_init();
	curl_setopt($ch, CURLOPT_URL, $url);
	// 执行后不直接打印出来
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
	curl_setopt($ch, CURLOPT_HEADER, false);
	// 跳过证书检查
	curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
	// 不从证书中检查SSL加密算法是否存在
	curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
	// 执行并获取HTML文档内容
	$output = curl_exec($ch);
	// 释放curl句柄
	$errorno=curl_errno($ch);
	curl_close($ch);
	if($errorno){
		$res=$errorno;
	}else{
		$res=$output;
	}
	return $res;
}