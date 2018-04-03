<?php
namespace app\recruit\logic;

class Smg
{
    const API_DOMIAN='http://10.90.18.23';
    
    public function api_get_memberinfo($telephone){
        $url=SmgLogic::API_DOMIAN.'/index.php/xmlrpc_api/apioa/potentialmemberinfo/'.$telephone;
        $res=curl_get($url);
        if (!$res){
            $arr=array('status'=>false,'msg'=>'网络连接错误,错误代码:'.$res['errorno']);
        }else{
            $data=json_decode($res,true);
            if(!$data){
                $arr=array('status'=>false,'msg'=>'没有关于您的信息');
            }else{
                $arr=array('status'=>true,'msg'=>'参数正确,信息匹配','data'=>$data);
            }
        }
        return $arr;
    }
    public function api_get_station(){
        $url=self::API_DOMIAN.'/index.php/xmlrpc_api/apioa/stationlist';
        $res=curl_get($url);
        if (!$res){
            $arr=array('status'=>false,'msg'=>'网络连接错误,错误代码:'.$res['errorno']);
        }else{
            $data=json_decode($res,true);
            if(!$data){
                $arr=array('status'=>false,'msg'=>'没有关于信息');
            }else{
                $arr=array('status'=>true,'msg'=>'参数正确,信息匹配','data'=>$data);
            }
        }
        return $arr;
    }
}

?>