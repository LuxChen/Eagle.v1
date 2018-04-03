<?php
namespace app\recruit\controller;

use app\recruit\logic\Recruit as RecruitLogic;
use app\recruit\logic\Smg as SmgLogic;
use \think\Db;
use app\index\model\Station;
use app\index\model\Staff;
class Index extends Base{
    public $RecruitId;
    public function _initialize(){
        parent::_initialize();
        $this->RecruitId=cookie('RecruitId');
        $this->checklogin();
    }
    /**
     * 我的
     *   */
    public function mycenter(){
        $recruit=new RecruitLogic();
        $info=$recruit->recruitInfo(array('Id'=>$this->RecruitId));
        if(!($info['Station'])){
            $smg=new SmgLogic();
            $station = new Station();
            $station=$station->where('status!=2')->select();
            $stationlist=array();
            foreach ($station as $val){
            	$stationlist[$val->belongto][] = $val;
            }
            foreach ($stationlist as $k => $v){
            	$s[] = array('belongto'=>$k,'stations'=>$v);
            }
            $this->assign('station',$s);
//             $this->assign("percent_a",0);
//             $this->assign("percent_b",0);
//             $this->assign("percent_c",0);
//             $this->assign("percent_d",0);
//             $this->assign("Status",0);
            return $this->fetch('choosestation');
            exit;
        }
        $a=$a_b=$b=$c=$d=0;
        $info_base=array(
            'CName'=>$info['CName'],//必填
            'EName'=>$info['EName'],
            'Station'=>$info['Station'],//必填
            'Gender'=>$info['Gender'],//必填
            'Nation'=>$info['Nation'],//必填
            'CardId'=>$info['CardId'],//必填
            'Telephone'=>$info['Telephone'],//必填
            'Email'=>$info['Email'],//必填
            'Domicile'=>$info['Domicile'],//必填
            'IsMarry'=>$info['IsMarry'],//必填
            'IsHealthy'=>$info['IsHealthy'],//必填
            'IsIllegal'=>$info['IsIllegal'],//必填
            'Party'=>$info['Party'],//必填
            'LivePcc'=>$info['LivePcc'],//必填
            'LiveAddress'=>$info['LiveAddress'],//必填
            'HeaderImg'=>$info['HeaderImg'],
            'ResPcc'=>$info['ResPcc'],//必填
            'ResAddress'=>$info['ResAddress'],//必填
            'ContactName'=>$info['ContactName'],//必填
            'ContactShip'=>$info['ContactShip'],//必填
            'ContactTel'=>$info['ContactTel'],//必填
            'Language'=>$info['Language'],
            'LangLevel'=>$info['LangLevel'],
            'Source'=>$info['Source'],//必填
            'Professional'=>$info['Professional'],
            'EntryTime'=>$info['EntryTime'],//必填
            'IsFriend'=>$info['IsFriend']
        );
        if($info['IsFriend']=='有'){
            $info_base['FriendInfo']=$info['FriendInfo'];
        }
        if($info['AddPartyTime']=='共产党员'){
            $info_base['AddPartyTime']=$info['AddPartyTime'];
        }
        if($info['Source']=='推荐'||$info['Source']=='其他'){
            $info_base['SourceResult']=$info['SourceResult'];
        }
        $t_a=count($info_base);
        foreach ($info_base as $val){
            if($val){
                $a++;
            }
        }
        $percent_a=round(($a*100)/$t_a);
        $this->assign("percent_a", $percent_a);
        $info_base_b=array(
            'CName'=>$info['CName'],//必填
            'Station'=>$info['Station'],//必填
            'Gender'=>$info['Gender'],//必填
//             'Nation'=>$info['Nation'],//必填
            'CardId'=>$info['CardId'],//必填
            'Telephone'=>$info['Telephone'],//必填
            'Email'=>$info['Email'],//必填
//             'Domicile'=>$info['Domicile'],//必填
            'IsMarry'=>$info['IsMarry'],//必填
//             'IsHealthy'=>$info['IsHealthy'],//必填
//             'IsIllegal'=>$info['IsIllegal'],//必填
//             'Party'=>$info['Party'],//必填
            'LivePcc'=>$info['LivePcc'],//必填
            'LiveAddress'=>$info['LiveAddress'],//必填
//             'ResPcc'=>$info['ResPcc'],//必填
//             'ResAddress'=>$info['ResAddress'],//必填
//             'ContactName'=>$info['ContactName'],//必填
//             'ContactShip'=>$info['ContactShip'],//必填
//             'ContactTel'=>$info['ContactTel'],//必填
//             'Source'=>$info['Source'],//必填
//             'Professional'=>$info['Professional'],
//             'EntryTime'=>$info['EntryTime'],//必填
        );
        $t_a_b=count($info_base_b);
        foreach ($info_base_b as $val){
            if($val){
                $a_b++;
            }
        }
        $percent_a_b=round(($a_b*100)/$t_a_b);
        $this->assign("percent_a_b",$percent_a_b);
        $info_family=$info['FamilyInfo'] ? $info['FamilyInfo'] : array();
        $t_b=count($info_family) ? count($info_family) : 1;
        foreach ($info_family as $val){
            if($val){
                $b++;
            }
        }
       $percent_b=round(($b*100)/$t_b);
       $this->assign("percent_b",$percent_b);
        $info_learn=$info['Education'];
        $t_c=count($info_learn) ? count($info_learn) : 1;
        foreach ($info_learn as $val){
            if($val){
                $c++;
            }
        }
        $percent_c=round(($c*100)/$t_c);
        $this->assign('percent_c',$percent_c);
        
        $info_work=array(
            'WorkExp'=>$info['WorkExp'],
//             'Subsidy'=>$info['Subsidy'],
//             'Q_Award'=>$info['Q_Award'],
//             'Y_Award'=>$info['Y_Award'],
            'Income'=>$info['Income'],
            'E_Salary'=>$info['E_Salary'],
            'Agreement'=>$info['Agreement'],
        );
        $t_d=count($info_work);
        foreach ($info_work as $val){
            if($val){
                $d++;
            }
        }
        $percent_d=round(($d*100)/$t_d);
        $this->assign('percent_d',$percent_d);
        $Status=$info['Status'];
        if($percent_a_b==100&&$percent_b==100&&$percent_c==100&&$percent_d==100&&$info['Status']==0){
            $recruit->updateRecruit(array('Id'=>$this->RecruitId), array('Status'=>1));
            $Status=1;
        }
        $this->assign('Status',$Status);
        $this->assign('Files',$info['Files']);
        $this->assign('ContactName',$info['ContactName']);
        return $this->fetch();
    }
    /**
     * 基础信息
     *   */
    public function baseinfo(){
        $recruit=new RecruitLogic();
        $info=$recruit->recruitInfo(array('Id'=>$this->RecruitId));
        $this->assign('info',$info);
        $stationid=$info['Station']?$info['Station']:$this->request->param('station');
        if(!$stationid){
            $this->error('请选择应聘职位');
        }
        $station = new Station();
        $smg=new SmgLogic();
        $stationinfo=$station->where('id',$stationid)->find();
        if($stationinfo->status == 2){
            $this->redirect('Recruit/Index/myCenter');exit;
        }
        $this->assign('station',$stationinfo);
        return $this->fetch();
    }
    /**
     * 完善资料 
     *   */
    public function finishInfo(){
        $recruit=new RecruitLogic();
        $info=$recruit->recruitInfo(array('Id'=>$this->RecruitId));
        $this->assign('info',$info);
        $smg=new SmgLogic();
        $station = new Station();
        $stationinfo= $station->find();
        $this->assign('station',$stationinfo);
        return $this->fetch();
    }
    /**
     * 家庭情况  */
    public function familyinfo(){
        $recruit=new RecruitLogic();
        $info=$recruit->recruitInfo(array('Id'=>$this->RecruitId));
        $this->assign('info',$info['FamilyInfo']);
        $this->assign('length',count($info['FamilyInfo']));
        return $this->fetch();
    }
    /**
     * 学习经历  */
    public function learninfo(){
        $recruit=new RecruitLogic();
        $info=$recruit->recruitInfo(array('Id'=>$this->RecruitId));
        $this->assign('info',$info['Education']);
        $this->assign('length',count($info['Education']));
        return $this->fetch();
    }
    /**
     * 工作经历页面  */
    public function jobinfo(){
        $recruit=new RecruitLogic();
        $info=$recruit->recruitInfo(array('Id'=>$this->RecruitId));
        $this->assign('info',$info);
        $this->assign('length',count($info['WorkExp']));
        return $this->fetch();
    }
    /**
     * 上传资料页面  */
    public function uploadfile(){
        $recruit=new RecruitLogic();
        $info=$recruit->recruitInfo(array('Id'=>$this->RecruitId));
        if($info['Status']!=3){
            $this->error('无效页面');
        }
        $this->assign('files',$info['Files']?explode(';', $info['Files']):null);
        return $this->fetch();
    }
    public function save(){
    	$post = $this->request->post();
        if(isset($_POST['Station'])){
            $data['Station']=$post['Station'];
        }
        if(isset($_POST['CName'])){
            $data['CName']=$post['CName'];
        }
        if(isset($_POST['EName'])){
            $data['EName']=$post['EName'];
        }
        if(isset($_POST['Telephone'])){
            $data['Telephone']=$post['Telephone'];
        }
        if(isset($_POST['CardId'])){
            $data['CardId']=$post['CardId'];
        }
        if(isset($_POST['Nation'])){
            $data['Nation']=$post['Nation'];
        }
        if(isset($_POST['Gender'])){
            $data['Gender']=$post['Gender'];
        }
        if(isset($_POST['Email'])){
            $data['Email']=$post['Email'];
        }
        if(isset($_POST['Domicile'])){
            $data['Domicile']=$post['Domicile'];
        }
        
        if(isset($_POST['IsMarry'])){
            $data['IsMarry']=$post['IsMarry'];
        }
        
        if(isset($_POST['Party'])){
            $data['Party']=$post['Party'];
            if($post['Party']=='共产党员'){
                $data['AddPartyTime']=$post['AddPartyTime'];
            }
        }
        if(isset($_POST['IsHealthy'])){
            $data['IsHealthy']=$post['IsHealthy'];
        }
        
        if(isset($_POST['IsIllegal'])){
            $data['IsIllegal']=$post['IsIllegal'];
        }
        
        if(isset($_POST['LivePcc'])){
            $data['LivePcc']=$post['LivePcc'];
        }
        
        if(isset($_POST['LivePcc_val'])){
            $data['LivePcc_val']=$post['LivePcc_val'];
        }
        
        if(isset($_POST['LiveAddress'])){
            $data['LiveAddress']=$post['LiveAddress'];
        }
        
        if(isset($_POST['ResPcc'])){
            $data['ResPcc']=$post['ResPcc'];
        }
        
        if(isset($_POST['ResPcc_val'])){
            $data['ResPcc_val']=$post['ResPcc_val'];
        }
        
        if(isset($_POST['ResAddress'])){
            $data['ResAddress']=$post['ResAddress'];
        }
        
        if(isset($_POST['HeaderImg'])){
            $data['HeaderImg']=$post['HeaderImg'];
        }
        
        if(isset($_POST['ContactName'])){
            $data['ContactName']=$post['ContactName'];
        }
        
        if(isset($_POST['ContactShip'])){
            $data['ContactShip']=$post['ContactShip'];
        }
        
        if(isset($_POST['ContactTel'])){
            $data['ContactTel']=$post['ContactTel'];
        }
        //IsFriend
        if(isset($_POST['IsFriend'])){
            $IsFriend=$post['IsFriend'];
            $data['IsFriend']=$IsFriend;
            if($IsFriend=='有'){
                $fnames=$post['FName'];
                $fships=$post['FShip'];
                $FriendInfo=array();
                foreach ($fnames as $key=>$val){
                    $FriendInfo[]=array(
                        'FName'=>$val,
                        'FShip'=>$fships[$key]
                    );
                }
                $data['FriendInfo']=serialize($FriendInfo);
            }else{
                $data['FriendInfo']=null;
            }
        }
        
        if(isset($_POST['Language'])){
            $data['Language']=$post['Language'];
        }
        
        if(isset($_POST['LangLevel'])){
            $data['LangLevel']=$post['LangLevel'];
        }
        //Source
        
        if(isset($_POST['Source'])){
            $Source=$post['Source'];
            $data['Source']=$Source;
            if($Source=='推荐'||$Source=='其他'){
                $data['SourceResult']=$post['SourceResult'];
            }else{
                $data['SourceResult']=null;
            }
        }
        //Professional
        if(isset($_POST['Professional'])){
            $data['Professional']=$post['Professional'];
        }
        //EntryTime
        if(isset($_POST['EntryTime'])){
            $data['EntryTime']=$post['EntryTime'];
        }
        if(isset($_POST['Interest'])){
            $data['Interest']=$post['Interest'];
        }
        
        if(isset($_POST['UName'])&&isset($_POST['UShip'])){
            $UName=$post['UName'];
            $UShip=$post['UShip'];
            $UCompany=$post['UCompany'];
            $FamilyInfo=array();
            foreach ($UName as $key=>$val){
                $FamilyInfo[]=array(
                    'UName'=>$val,
                    'UShip'=>$UShip[$key],
                    'UCompany'=>$UCompany[$key]
                );
            }
            $data['FamilyInfo']=serialize($FamilyInfo);
        }
        //family
        //learninfo
        $StartTime=array_key_exists('StartTime', $post) ? $post['StartTime'] : null;
        $EndTime=array_key_exists('EndTime', $post) ? $post['EndTime'] : null;
        $SchoolName = array_key_exists('SchoolName', $post) ? $post['SchoolName'] : null;
        $Major=array_key_exists('Major', $post) ? $post['Major'] : null;
        $IsDiploma=array_key_exists('IsDiploma', $post) ? $post['IsDiploma'] : null;
        $EduRecord=array_key_exists('EduRecord', $post) ? $post['EduRecord'] : null;
        if($StartTime&&$EndTime&&$SchoolName&&$Major&&$IsDiploma&&$EduRecord){
            $Education=array();
            foreach ($StartTime as $key=>$val){
                $Education[]=array(
                    'StartTime'=>$val,
                    'EndTime'=>$EndTime[$key],
                    'SchoolName'=>$SchoolName[$key],
                    'Major'=>$Major[$key],
                    'IsDiploma'=>$IsDiploma[$key],
                    'EduRecord'=>$EduRecord[$key],
                );
            }
            $data['Education']=serialize($Education);
        }
        
        // WorkExp
        $EntryTime=array_key_exists('EntryTime', $post) ? $post['EntryTime'] : null;
        $QuitTime=array_key_exists('QuitTime', $post) ? $post['QuitTime'] : null;
        $Company=array_key_exists('Company', $post) ? $post['QuitTime'] : null;
        $Position=array_key_exists('Position', $post) ? $post['Position'] : null;
        $Reason=array_key_exists('Reason', $post) ? $post['Reason'] : null;
        $ContactUser=array_key_exists('ContactUser', $post) ? $post['ContactUser'] : null;
        $ContactTel=array_key_exists('ContactTel', $post) ? $post['ContactTel'] : null;
        $Duty=array_key_exists('Duty', $post) ? $post['Duty'] : null;
        if($EntryTime&&$QuitTime&&$Company&&$Position&&$Reason&&$ContactUser&&$ContactTel&&$Duty){
            $WorkExp=array();
            foreach ($EntryTime as $key=>$val){
                $WorkExp[]=array(
                    'EntryTime'=>$val,
                    'QuitTime'=>$QuitTime[$key],
                    'Company'=>$Company[$key],
                    'Position'=>$Position[$key],
                    'Reason'=>$Reason[$key],
                    'ContactUser'=>$ContactUser[$key],
                    'ContactTel'=>$ContactTel[$key],
                    'Duty'=>$Duty[$key],
                );
            }
            $data['WorkExp']=serialize($WorkExp);
        }
        
        if(isset($_POST['WorkTime'])){
            $data['WorkTime']=$post['WorkTime'];
        }
        
        if(isset($_POST['SubsidyAmount'])){
            $data['SubsidyAmount']=$post['SubsidyAmount'];
        }
        
        if(isset($_POST['Subsidy'])){
            $data['Subsidy']=implode(',', $post['Subsidy']);
        }
        
        if(isset($_POST['M_Salary'])){
            $data['M_Salary']=$post['M_Salary'];
        }
        
        if(isset($_POST['Q_Award'])){
            $data['Q_Award']=$post['Q_Award'];
        }
        
        if(isset($_POST['Y_Award'])){
            $data['Y_Award']=$post['Y_Award'];
        }
        
        if(isset($_POST['Income'])){
            $data['Income']=$post['Income'];
        }
        
        if(isset($_POST['E_Salary'])){
            $data['E_Salary']=$post['E_Salary'];
        }
        
        if(isset($_POST['Agreement'])){
            $data['Agreement']=$post['Agreement'];
        }
        if(isset($_POST['Files'])){
            $data['Files']=implode(';', $post['Files']);
        }
        $recruit=new RecruitLogic();
        $where['Id']=$this->RecruitId;
        $result=$recruit->updateRecruit($where, $data);
        if($result){
           $returnmsg = array (
		         'status'=>true,
		         'info'=>'保存成功'
		    );
        }else{
           $returnmsg = array (
		            'status'=>false,
		            'info'=>'保存失败'
				);
        }
        header('Content-Type:application/json; charset=utf-8');
		 exit(json_encode($returnmsg,0));
    }
    
    /**
     * 检查登录  */
    public function checklogin(){
        if(!cookie('RecruitId')){
            $this->redirect('Recruit/Login/index');
            exit;
        }else{
            $recruit=new RecruitLogic();
            $info=$recruit->recruitInfo(array('Id'=>cookie('RecruitId'),'Status'=>array('gt',-1)));
            if(!$info){
                cookie('RecruitId',null);
                $this->redirect('Recruit/Login/index');
                exit;
            }else{
                if($info['Status']==0){
                    $smg=new SmgLogic();
                    $station = new Station();
                    $stationinfo=$station->where(array('id'=>$info['Station']))->find();
                    if($stationinfo && $stationinfo->status==2){
                        $recruit->updateRecruit(array('Id'=>$info['Id']), array('Station'=>null));
                    }
                }
                
            }
            
            
        }
    }
    
}