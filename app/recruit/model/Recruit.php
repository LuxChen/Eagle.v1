<?php
namespace app\recruit\model;

use \think\Model;
use \app\recruit\controller\DbAccess;
use \think\Db;
use app\index\model\Station;
class Recruit extends Model
{
    public $tableName='recruit';
    /**
     * 创建应聘信息
     * @param 数据 $data  */
    public function addRecruit($data){
        $data['Id']=uniqid();
        $db=new DbAccess($this->tableName);
        if(array_key_exists('Station', $data) && $data['Station']){
        	$smodel = new Station();
        	$station = $smodel->where(array('name'=>$data['Station']))->find();
        	$data['Station'] = $station->id;
        }
        $result=$db->add($data);
        return $result;
    }
    /**
     * 获取应聘信息
     * @param 查询条件 $where  */
    public function getRecruit($where){
//         func_write_log('获取应聘信息查询条件:'.json_encode($where), 'recruit');
        $db=new DbAccess($this->tableName);
        $info=$db->find($where);
//         func_write_log('执行sql语句:'.$db->getSql(), 'recruit');
//         func_write_log('获取应聘信息返回结果:'.json_encode($info), 'recruit');
        return $info;
    }
    
    /**
     * 修改应聘信息
     * @param 修改数据 $data
     * @param 应聘Id $RecruitId
     * @return boolean  */
    public function updateRecruit($data,$where){
        //$where['Id']=$RecruitId;
//         func_write_log('修改应聘信息条件:'.$where['Id'], 'recruit');
//         if(isset($data['Status'])){
//             $data['ModifyTime']=date('Y-m-d H:i:s');
//         }else{
//             $data['UpdateTime']=date('Y-m-d H:i:s');
//         }
        
//         func_write_log('修改应聘数据:'.json_encode($data), 'recruit');
        $db=new DbAccess($this->tableName);
        $result=$db->update($where, $data);
//         func_write_log('执行sql语句:'.$db->getSql(), 'recruit');
//         func_write_log('修改应聘信息返回结果:'.json_encode($result), 'recruit');
        return $result;
    }
    
    
    function get_record($tablename,$where=""){
    	date_default_timezone_set("PRC");
    	if ($where) {
    		$this->db->where($where);
    	}
    	$this->db->from($tablename);
    	$query = $this->db->get();
    	 
    	return $query->row();
    }
    
    function get_records($tablename,$where="",$limit=0,$start=0,$orderby=''){
    	date_default_timezone_set("PRC");
    	if ($where) {
    		$this->db->where($where);
    	}
    	$this->db->from($tablename);
    	if($limit)
    		$this->db->limit($limit,$start);
    		if($orderby)
    			$this->db->order_by($orderby);
    			$query = $this->db->get();
    			 
    			return $query->result();
    }
    
    function update_record($tablename,$data,$where=""){
    	date_default_timezone_set("PRC");
    	if($where){
    		$this->db->where($where);
    	}
    	else{
    		$this->db->where('id', $data['id']);
    	}
    	if ($this->db->update($tablename, $data)) {
    		return 1;
    	} else {
    		return '更新失败';
    	}
    }
    
    function record_add($tablename,$data) {
             if(false == Db::name($tablename)->insert($data)) {
                return $this->error('提交失败');
            } else {
                return $this->success('提交成功','admin/webconfig/index');
            }
    }
}

?>