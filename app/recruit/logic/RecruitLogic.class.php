<?php
namespace Recruit\Logic;

use Recruit\Model\RecruitModel;
use Think\Model;
class RecruitLogic
{
    public function getRecruit($data){
        $recruit_model=new RecruitModel();
        $recruit_info=$recruit_model->getRecruit(array('Telephone'=>$data['Telephone']));
        if(!$recruit_info){
            $recruit_new=$recruit_model->addRecruit($data);
            $recruit_info=$recruit_model->getRecruit(array('Telephone'=>$data['Telephone']));
        }
        return $recruit_info;
    }
    
    public function getRecruitList($data){
        $recruit_model=new RecruitModel();
        $result=$recruit_model->getReCruitList($data);
        foreach ($result['data'] as $key=>$val){
            if($val){
                $result['data'][$key]['FamilyInfo']=$val['FamilyInfo']?unserialize($val['FamilyInfo']):null;
                $result['data'][$key]['FriendInfo']=$val['FriendInfo']?unserialize($val['FriendInfo']):null;
                $result['data'][$key]['Education']=$val['Education']?unserialize($val['Education']):null;
                $result['data'][$key]['WorkExp']=$val['WorkExp']?unserialize($val['WorkExp']):null;
            }
        }
        return $result;
    }
    public function recruitInfo($where){
        $recruit_model=new RecruitModel();
        $recruit_info=$recruit_model->getRecruit($where);
        if($recruit_info){
            $recruit_info['FamilyInfo']=$recruit_info['FamilyInfo']?unserialize($recruit_info['FamilyInfo']):null;
            $recruit_info['FriendInfo']=$recruit_info['FriendInfo']?unserialize($recruit_info['FriendInfo']):null;
            $recruit_info['Education']=$recruit_info['Education']?unserialize($recruit_info['Education']):null;
            $recruit_info['WorkExp']=$recruit_info['WorkExp']?unserialize($recruit_info['WorkExp']):null;
        }
        
        return $recruit_info;
    }
    
    public function updateRecruit($where,$data){
        $recruit_model=new RecruitModel();
        $res=$recruit_model->updateRecruit($data, $where);
        return $res;
    }
    
    public function checkrecruit($phone,$from){
        $recruitinfo=$this->recruitInfo(array('Telephone'=>$phone,'Status'=>array('neq',-1)));
        if($recruitinfo){
            cookie('RecruitId',$recruitinfo['Id'],C('COOKIE_TIME'));
            return array('status'=>true,'info'=>'验证成功');
        }else{
            //smg查找
            $smg=new SmgLogic();
            $getinfo=$smg->api_get_memberinfo($phone);
            if($getinfo['status']==true){
                $data['Telephone']=$getinfo['data']['telnumber'];
                $data['CName']=$getinfo['data']['name'];
                if($getinfo['data']['gender']){
                    $data['Gender']=$getinfo['data']['gender'];
                }
                if($getinfo['data']['station']){
                    $data['Station']=$getinfo['data']['station'];
                }
                $data['Come']='Smg';
                $data['SmgStatus']=1;
            }else{
                $data['Telephone']=$phone;
                $data['Come']=$from?$from:'未知';
            }
            $recruit_model=new RecruitModel();
            $res=$recruit_model->addRecruit($data);
            if($res){
                $recruitinfo=$this->recruitInfo(array('Telephone'=>$phone,'Status'=>array('neq',-1)));
                cookie('RecruitId',$recruitinfo['Id'],C('COOKIE_TIME'));
                return array('status'=>true,'info'=>'验证成功');
            }else{
                return array('status'=>false,'info'=>'服务器繁忙');
            }
        }
    }
}

?>