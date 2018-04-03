<?php
namespace app\recruit\controller;

use \think\Controller;
use recruit\logic\RecruitLogic;
use think\Hook;
use \think\Db;
use \app\recruit\model\Recruit as RecruitModel;
class Api extends Controller
{
    public function getRecruit(){
        $telephone=I('request.phone');
        $recruit=new RecruitLogic();
        $info=$recruit->recruitInfo(array('Telephone'=>$telephone));
        $this->ajaxReturn($info,'JSON');
    }
    
    public function getRecruitList(){
        func_write_log(json_encode(I('request.')), 'sql');
        $data['StartTime']=I('request.StartTime');
        $data['EndTime']=I('request.EndTime');
        $data['Telephone']=I('request.telephone');
        $data['Station']=I('request.Station');
        $data['CName']=I('request.CName');
        $data['Status']=I('request.Status');
        $data['SmgStatus']=I('request.SmgStatus');
        $data['PageIndex']=I('request.PageIndex');
        $data['PageSize']=I('request.PageSize');
        $recruit=new RecruitLogic();
        $result=$recruit->getRecruitList($data);
        $this->ajaxReturn($result,'JSON');
    }
    
    public function updateRecruitStatus(){
        $where['Telephone']=I('request.telephone');
        $status = I('request.Status');
		$smgstatus = I('request.SmgStatus');
		if(isset($status) && $status !== "")
			$data['Status']=$status;
		if(isset($smgstatus) && $smgstatus !== "")
			$data['SmgStatus']=$smgstatus;
        $recruit=new RecruitLogic();
        $result=$recruit->updateRecruit($where,$data);
        $this->ajaxReturn($result,'JSON');
    }
    
    public function downfiles(){
        $Telephone=I('get.telephone');
        $recruit=new RecruitLogic();
        $info=$recruit->recruitInfo(array('Telephone'=>$Telephone));
        if(!$info){
            exit('参数错误');
        }
        $files=explode(';', $info['Files']);
        array_unshift($files,$info['HeaderImg']);
        if(!$files){
            exit('没有下载文件');
        }
        
        $filename = "./".$info['Telephone'].".zip";

        if(!file_exists($filename)){
            //重新生成文件
            $zip = new \ZipArchive();//使用本类，linux需开启zlib，windows需取消php_zip.dll前的注释
            if (($zip->open($filename, \ZIPARCHIVE::CREATE)!==TRUE)) {
                exit('无法打开文件，或者文件创建失败');
            }
            foreach( $files as $val){
                $val='./'.$val;
                if(file_exists($val)){
                    $zip->addFile( $val, basename($val));//第二个参数是放在压缩包中的文件名称，如果文件可能会有重复，就需要注意一下
                }
            }
            $zip->close();//关闭
        }
        if(!file_exists($filename)){
            exit("无法找到文件"); //即使创建，仍有可能失败。。。。
        }
        header("Cache-Control: public");
        header("Content-Description: File Transfer");
        header('Content-disposition: attachment; filename='.basename($filename)); //文件名
        header("Content-Type: application/zip"); //zip格式的
        header("Content-Transfer-Encoding: binary"); //告诉浏览器，这是二进制文件
        header('Content-Length: '. filesize($filename)); //告诉浏览器，文件大小
        @readfile($filename);
        @unlink($filename);
    }
    
    public function send_sms(){
        $post = $this->request->post();
    	$phonenumber =$post['phone'];
    	$data['code'] = rand(1000, 9999);
		$msgtxt = "陈水明". "您本次短信验证码为{$data['code']},请在30分钟内使用(仅在线上招聘登录使用，非本人操作请忽略)。";
// 	   	$info = send_sms ( $msgtxt, $phonenumber );
		$info = "result=2&errormessage='发送失败，检查原因'";
	    $this->checksmsinfo($info,'线上招聘',$msgtxt,$phonenumber,$data['code']);
    }
    
    function checksmsinfo($info,$type,$msg,$phonenumber,$code){
    	$subinfo = explode("&", $info);
    	$result = array('result'=>500,'errormessage'=>'发送失败！');
    	foreach ($subinfo as $sub){
    		$detail = explode("=",$sub);
    		if($detail && $detail[0] == 'description'){
    			continue;
    		}else{
    			$result[$detail[0]] = sizeof($detail) < 2 ? '':$detail[1];
    		}
    	}
    	if($result['result'] === "0"){
    		$result['errormessage'] = '';
    	}
    	else if($result['result'] === "6"){
    		$result['errormessage'] =  '号码不在规定的号段或为免打扰号码(包含系统黑名单号码)!';
    	}
    	else if($result['result'] === "28"){
    		$result['errormessage'] =  '短信发送失败，短息模板不匹配!';
    	}
    	else if($result['result'] === "32"){
    		$result['errormessage'] = '短信发送失败，超过每日发送限制条数!';
    	}else{
    		$result['errormessage'] = '发送失败，请联系管理员！';
    	}
    	$recruit_model = new RecruitModel();
    	$logdetail = array (
    			'type' =>$type,
    			'logtime' => date ( 'Y-m-d H:i:s' ),
    			'content' => $msg,
    			'tag' => $phonenumber,
    			'code' => $code,
    		    'returnmsg'=>$result['errormessage']
    	);
       Db::name('sms_log')->insert($logdetail);
       if($result['result'] != 0 ) {
                return $this->msgReturn(false,$result['errormessage']);
            }
      else {
                return $this->msgReturn(true,'验证码发送成功！');
      }
    }
    

    /**
     * ajax json返回重构
     * @param unknown $status
     * @param unknown $info
     * @param string $data  */
    public function msgReturn($status,$info,$data=''){
    	$array=array(
    			'status'=>$status,
    			'info'=>$info,
    			'data'=>$data
    	);
    	$this->ajaxReturn($array,'json');
    }
    /**
     * Ajax方式返回数据到客户端
     * @access protected
     * @param mixed $data 要返回的数据
     * @param String $type AJAX返回数据格式
     * @param int $json_option 传递给json_encode的option参数
     * @return void
     */
    protected function ajaxReturn($data,$type='',$json_option=0) {
    	if(empty($type)) $type  =   C('DEFAULT_AJAX_RETURN');
    	switch (strtoupper($type)){
    		case 'JSON' :
    			// 返回JSON数据格式到客户端 包含状态信息
    			header('Content-Type:application/json; charset=utf-8');
    			exit(json_encode($data,$json_option));
    		case 'XML'  :
    			// 返回xml格式数据
    			header('Content-Type:text/xml; charset=utf-8');
    			exit(xml_encode($data));
    		case 'JSONP':
    			// 返回JSON数据格式到客户端 包含状态信息
    			header('Content-Type:application/json; charset=utf-8');
    			$handler  =   isset($_GET[C('VAR_JSONP_HANDLER')]) ? $_GET[C('VAR_JSONP_HANDLER')] : C('DEFAULT_JSONP_HANDLER');
    			exit($handler.'('.json_encode($data,$json_option).');');
    		case 'EVAL' :
    			// 返回可执行的js脚本
    			header('Content-Type:text/html; charset=utf-8');
    			exit($data);
    		default     :
    			// 用于扩展其他返回格式数据
    			Hook::listen('ajax_return',$data);
    	}
    }
}

?>