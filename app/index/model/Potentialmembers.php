<?php
namespace app\index\model;

use \think\Model;
use app\admin\model\Admin;
use \think\Session;
/**
 * 
 * @author Lux.Chen
 * on 2018年3月16日下午2:24:25
 */
class Potentialmembers extends Model{
   function get_potentialmemberslist($start,$limit,$keyword){
        $thismodel = new Potentialmembers();
    	$amodel = new Admin();
    	$user = $amodel->admincate()->where('id',Session::get('admin'))->find();
    	$rolename =  $user['name'];
   		if(strpos($rolename,'_') > 0){
   			$rarray = explode("_", $rolename);
   			$company = $rarray[0];
   		}
   		else{
   			$company = '股份';
   		}
   		$target_role = $company.'_人资';
   		$target_role1 = $company.'_入职专员';
   		$usernamelist = $thismodel->query("SELECT name  from eagle_admin where admin_cate_id in (select id from eagle_admin_cate where name in ('{$target_role}','{$target_role1}'))");
   	$condition = '';
   	if($keyword){
   		$condition = "(name like '%".$keyword."%'";
   		$condition .= " or  telnumber  like '%".$keyword."%'";
   		$condition .= " or  station  like '%".$keyword."%')";
   		$thismodel->where($condition);
   	}
   	$thismodel->where("status != 3 and status != 11 and status != 7");
   	if($usernamelist){
   		$userlist[]  = Session::get('Admin');
   		foreach ($usernamelist as $val){
   			$userlist[] = $val->username;
   		}
   		$thismodel->where_in('createdby',$userlist);
   	}
   	else{
   	    $thismodel->where(array('createdby'=>Session::get('Admin')));
   	}
   	$thismodel->order('status  asc');
    if($limit){
        $thismodel->limit($limit,$start);
    }
    $data = $thismodel->select();
 	return $data;
   }
}