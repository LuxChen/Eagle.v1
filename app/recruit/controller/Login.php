<?php
namespace app\recruit\controller;

use app\ recruit\logic\Recruit as RecruitLogic;
use \think\Hook;
class Login extends Base
{
    public function _initialize(){
        parent::_initialize();
        $cookie=cookie('RecruitId');
        if($cookie){
            $this->redirect('Recruit/Index/myCenter');
            exit;
        }
    }
    public function index(){
        $_GET['from'] = '';
        $_GET['go'] = '';
        return $this->fetch();
    }
    
    public function check(){
        $Phone=$this->request->param('Phone');
        $CheckCode=$this->request->param('CheckCode');
        $from=$this->request->param('from');
        $res=$this->CheckCode($Phone, $CheckCode);
        if($res['status']==false){
            $this->msgReturn($res['status'], $res['info']);
        }
        $recruit=new RecruitLogic();
        $res=$recruit->checkrecruit($Phone,$from);
        $this->msgReturn($res['status'], $res['info']);
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
    
    public function CheckCode($Phone,$Code){
    	$db=new DbAccess('sms_log');
    	$where['Telephone']=$Phone;
    	$where['SendStatus']=1;
    	$order='Id Desc';
    	$sms_log=$db->find($where,$order);
    	if($sms_log['Code']!=$Code){
//     		return array('status'=>false,'info'=>'验证码错误');
    	}
    	$sendtime=strtotime($sms_log['SendTime']);
    	if(time()-$sendtime>1800){
//     		return array('status'=>false,'info'=>'验证码已过期');
    	}
    	return array('status'=>true,'info'=>'验证通过');
    }
}

?>