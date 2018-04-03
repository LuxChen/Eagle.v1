<?php
namespace app\recruit\controller;
use \think\Model;
use \think\Db;
/**
 *@description 自定义数据库操作
 *@author smadmin
 *@date 2017年8月1日
 * Semir内部开发，未经授权请勿转载
 */
class DbAccess
{
    public $tablename;
    public function __construct($tablename){
        $this->tablename=$tablename;
    }
    /**
     * 单条数据查询
     * @param 查询条件 $where
     * @param 排序 $order
     * @param 显示字段 $field  */
    public function find($where,$order='',$field=''){
        try {
            $result=DB::name($this->tablename)->where($where)->order($order)->field($field)->find();
        }catch (\Exception $e){
            $result=false;
        }
        return $result;
    }
    
    /**
     * 单表查询
     * @param 查询条件 $where
     * @param 排序 $order
     * @param 查询字段 $field  */
    public function where($where,$order='',$field=''){
        try {
            $list=DB::name($this->tablename)->where($where)->order($order)->field($field)->select();
        }catch (\Exception $e){
            addlog('db_error',$e->getMessage());
            $result=false;
        }
        return $list;
    }
    /**
     * 查询记录数
     * @param 查询条件 $where  */
    public function getcount($where){
        try {
            $count=DB::name($this->tablename)->where($where)->count();
        }catch (\Exception $e){
            addlog('db_error',$e->getMessage());
            $count=false;
        }
        return $count;
    }
    /**
     * 查询数据
     * @param 查询条件 $where
     * @param 查询字段 $field
     * @param 排序 $order
     * @param 开始条数 $start
     * @param 显示条数 $limit
     * @param 分组 $group
     * @return 数据  */
    public function getList($where,$field='',$order='',$start='',$limit='',$group=''){
        try{
            if($start!=''){
                $List=DB::name($this->tablename)->where($where)->order($order)->field($field)->limit($start,$limit)->group($group)->select();
            }else{
                $List=DB::name($this->tablename)->where($where)->order($order)->field($field)->limit($limit)->group($group)->select();
            }
        }catch (\Exception $e){
            addlog('db_error',$e->getMessage());
            $List=false;
        }
        return $List;
    }
    /**
     * 分页查询
     * @param unknown $pageQuery
     * @param unknown $field  */
    public function query($pageQuery, $field){
        $where = $pageQuery->queryTmpl;
        $order = $pageQuery->orderBy;
        $pageIndex = $pageQuery->pageIndex * $pageQuery->pageSize;
        $pageSize = $pageQuery->pageSize;
        $listvo['total']=$this->getcount($where);
        $listvo['data']=$this->getList($where,$field,$order,$pageIndex,$pageSize);
        return $listvo;
    }
    /**
     * 多表组合查询
     * @param 查询条件 $where
     * @param 排序 $order
     * @param 查询字段 $field
     * @param 开始条数 $start
     * @param 显示条数 $limit
     * @param 分组 $group
     * @param 关联语句 $join  */
    public function getjoinlist($where,$order='',$field='',$start='',$limit='',$group='',$join){
        try {
            if($limit){
                $list=DB::name($this->tablename)
                    ->join($join)
                    ->where($where)
                    ->order($order)
                    ->field($field)
                    ->limit($start,$limit)
                    ->group($group)
                    ->select();
            }else{
                $list=DB::name($this->tablename)
                    ->join($join)
                    ->where($where)
                    ->order($order)
                    ->field($field)
                    ->limit($limit)
                    ->group($group)
                    ->select();
            }
        }catch (\Exception $e){
            addlog('db_error',$e->getMessage());
            $List=false;
        }
        return $list;
    }
    /**
     * 关联查询返回记录条数
     * @param 查询条件 $where
     * @param 关联语句 $join  */
    public function getJoincount($where,$join){
        try {
            $count=DB::name($this->tablename)->join($join)->where($where)->count();
        }catch (\Exception $e){
            $count=$e->getMessage();
        }
        return $count;
    }
    
    /**
     * 数据库添加数据
     * @param 数据 $data  */
    public function add($data){
        try {
            $result=DB::name($this->tablename)->insert($data);
        }catch (\Exception $e){
            addlog('db_error',$e->getMessage());
            $result=false;
        }
        return $result;
    }
    /**
     * 批量添加
     * @param 多数据数组 $dataList  */
    public function addAll($dataList){
        try {
            $result=DB::name($this->tablename)->addAll($dataList);
        }catch (\Exception $e){
            addlog('db_error',$e->getMessage());
            $result=false;
        }
        return $result;
    }
    
    /**
     * 修改
     * @param 修改条件 $where
     * @param 修改数据 $data  */
    public function update($where,$data){
        try {
            $result=DB::name($this->tablename)->where($where)->update($data);
        }catch (\Exception $e){
            addlog('db_error-'.substr($e->getMessage(),0,100));
            $result=false;
        }
        return $result;
    }
    /**
     * 根据条件删除记录
     * @param 删除条件 $where  */
    public function delete($where){
        try {
            $result=DB::name($this->tablename)->where($where)->delete();
        }catch (\Exception $e){
            addlog('db_error',$e->getMessage());
            $result=false;
        }
        return $result;
    }
    /**
     * 获取执行的sql语句
     *   */
    public function getSql(){
        $sql=M()->_sql();
        return $sql;
    }
}

?>