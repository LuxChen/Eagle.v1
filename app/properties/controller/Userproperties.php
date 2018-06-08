<?php
namespace  app\properties\controller;
use app\admin\controller\Permissions;
use app\admin\model\Admin;
use \think\Db;
use \think\Session;
class Userproperties extends Permissions{
	var $rolename = '';
	function _initialize() {
		parent::_initialize ();
		$amodel = new Admin ();
		$user = $amodel->admincate ()->where ( 'id', Session::get ( 'admin' ) )->find ();
		$menu = Db::name ( 'admin_menu' )->where ( [
				'is_display' => 1,
		] )->order ( 'orders asc' )->select ();
	
		// 删除不在当前角色权限里的菜单，实现隐藏
		$admin_cate = Session::get ( 'admin_cate_id' );
		$permissions = Db::name ( 'admin_cate' )->where ( [
				'id' => $admin_cate
		] )->value ( 'permissions' );
		$permissions = explode ( ',', $permissions );
	
		foreach ( $menu as $k => $val ) {
			if ($val ['type'] == 1 and $val ['is_display'] == 1 and ! in_array ( $val ['id'], $permissions )) {
				unset ( $menu [$k] );
			}
		}
	
		// 添加url
		foreach ( $menu as $key => $value ) {
			if (empty ( $value ['parameter'] )) {
				$url = url ( $value ['module'] . '/' . $value ['controller'] . '/' . $value ['function'] );
			} else {
				$url = url ( $value ['module'] . '/' . $value ['controller'] . '/' . $value ['function'], $value ['parameter'] );
			}
			$menu [$key] ['url'] = $url;
		}
		$menus = $this->menulist ( $menu );
		$cookie = Db::name('admin')->where('id',Session::get('admin'))->find();
		$this->assign('cookie',$cookie);
		$this->assign ( 'menu', $menus );
		$this->assign ( 'sub_menu', '' );
		$this->assign ( 'title', 'Eagle 主页' );
	}
	
	protected function menulist($menu) {
		$menus = array ();
		// 先找出顶级菜单
		foreach ( $menu as $k => $val ) {
			if ($val ['pid'] == 0) {
				$menus [$k] = $val;
				$menus [$k]['list'] = array();
			}
		}
		// 通过顶级菜单找到下属的子菜单
		foreach ( $menus as $k => $val ) {
			foreach ( $menu as $key => $value ) {
				if ($value ['pid'] == $val ['id']) {
					$menus [$k] ['list'] [] = $value;
				}
			}
		}
		// 三级菜单
		foreach ( $menus as $k => $val ) {
			if (isset ( $val ['list'] )) {
				foreach ( $val ['list'] as $ks => $vals ) {
					foreach ( $menu as $key => $value ) {
						if ($value ['pid'] == $vals ['id']) {
							$menus [$k] ['list'] [$ks] ['list'] [] = $value;
						}
					}
				}
			}
		} // dump($menus);die;
		return $menus;
	}
	
	public function index() {
		$user = Db::name('admin')->where('id',Session::get('admin'))->find();
		$keyword =  $this->request->param ('k');
		$this->assign ( "title", '用户资产' );
		$columns = "[ //表头
							        {field: 'sms_number', width: 90,title: '资产编号'}
							        ,{field: 'sms_sapnumber', width: 90, title: '财务编号'}
							        ,{field: 'sc_name', width: 90, title: '类型'}
							        ,{field: 'sms_size', title: '规格', sort: true, }
							        ,{field: 'itname', width: 90, title: '使用人', sort: true, }
							        ,{field: 'sms_ip', width: 90, title: 'IP', sort: true, }
							        ,{field: 'dept_id', width: 90,title: '使用部门', }
							        ,{field: 'sl_name', width: 90, title: '资产归属', }
							        ,{field: 'so_itname', width: 90, title: '装机人', }
							        ,{field: 'op_user', width: 90, title: '出库人', }
							        ,{field: 'lingqu_itname', width: 90, title: '领取人', }
// 							        ,{fixed: 'right',title:'操作', align:'center', toolbar: '#barDemo'}
							      ]";
		$export =  $this->request->param ('exportdata');
		$where = " sm_status = 1 and  sl.sl_name = '{$user['location']}'  ";
		if($keyword){
			$where .=" and (sms_main.sms_number  like '%" . $keyword . "%' or sms_main.sms_sapnumber  like '%" . $keyword . "%' or staff_sms.itname  like '%" . $keyword . "%') ";
		}
		$count = Db::connect('db_23')->name ( 'staff_sms' )->join('sms_main','staff_sms.sms_number = sms_main.sms_number')->join('sms_local sl','sms_main.sms_local = sl.sl_id')->join('sms_category sc','sms_main.sms_cat_id = sc.sc_id')->where ( $where)->count ();
		
		$dataurl = '/Properties/userproperties/detailslist/'.$keyword;
		$this->assign ( "keyword",$keyword);
		$this->assign ( "dataurl",$dataurl);
		$this->assign ( "columns",$columns );
		return $this->fetch();
	}
	
	public  function detailslist(){
		$user = Db::name('admin')->where('id',Session::get('admin'))->find();
		$get = $this->request->param ();
		$k =  explode('/', $this->request->pathinfo());
		$where = " sm_status = 1 and sl.sl_name = '{$user['location']}'";
		if($k[3]){
			$where .=" and (sms_main.sms_number  like '%" . $k[3] . "%' or sms_main.sms_sapnumber  like '%" . $k[3] . "%' or staff_sms.itname  like '%" . $k[3] . "%') ";
		}
		$count = Db::connect('db_23')->name ( 'staff_sms' )->join('sms_main','staff_sms.sms_number = sms_main.sms_number')->join('sms_local sl','sms_main.sms_local = sl.sl_id')->join('sms_category sc','sms_main.sms_cat_id = sc.sc_id')->where ( $where)->count ();
		$limit = $get ['limit'] ? $get ['limit'] : 10;
		$start = $get ['page'] ? ($get ['page'] - 1) * $limit : 0;
		$properties =  Db::connect('db_23')->name ( 'staff_sms' )->join('sms_main','staff_sms.sms_number = sms_main.sms_number')->join('sms_local sl','sms_main.sms_local = sl.sl_id')->join('sms_category sc','sms_main.sms_cat_id = sc.sc_id')->where ( $where)->order ( 'sm_id desc' )->limit ( $start, $limit )->select ();
		foreach($properties as &$property){
			$property['sms_status'] = $property['sms_status'] == 1 ? '在库':'使用中';
		}
		$returnmsg = array (
				"code" => 0,
				'count' => $count,
				"data" => $properties
		);
		echo json_encode ( $returnmsg );
	}
	public function propertyhistory() {
		$user = Db::name('admin')->where('id',Session::get('admin'))->find();
		$keyword =  $this->request->param ('k');
		$this->assign ( "title", '资产历史' );
		$columns = "[ //表头
							        {field: 'sms_number', width: 90,title: '资产编号'}
							        ,{field: 'sms_sapnumber', width: 90, title: '财务编号'}
							        ,{field: 'sc_name', width: 90, title: '类型'}
							        ,{field: 'sms_size', width: 90,title: '规格', sort: true, }
								    ,{field: 'sm_type', width: 90, title: '状态'  ,templet: function(d){
												if(d.sm_type== 1){
													return '<span > 领用</span>';
												}
												else
      											   return '<span >借用 </span>';
      								 }}
							        ,{field: 'itname', width: 90, title: '使用人', sort: true, }
							        ,{field: 'sms_ip', width: 90, title: 'IP', sort: true, }
							        ,{field: 'deptName', width: 90,title: '使用部门', }
							        ,{field: 'sl_name', width: 90, title: '资产归属', }
							        ,{field: 'so_itname', width: 90, title: '装机人', }
							        ,{field: 'op_user', width: 90, title: '出库人', }
							        ,{field: 'lingqu_itname', width: 90, title: '领取人', }
							        ,{field: 'use_time', width: 90, title: '领用时间', }
							        ,{field: 'return_time', width: 90, title: '归还时间', }
							      ]";
		$export =  $this->request->param ('exportdata');
		$where = "staff_sms.sm_status = 2 and sl.sl_name = '{$user['location']}'  ";
		if($keyword){
			$where .=" and (sms_main.sms_number  like '%" . $keyword . "%' or staff_sms.itname  like '%" . $keyword . "%') ";
		}
		$count = Db::connect('db_23')->name ( 'staff_sms' )->join('sms_main','staff_sms.sms_number = sms_main.sms_number')->join('sms_local sl','sms_main.sms_local = sl.sl_id')->join('sms_category sc','sms_main.sms_cat_id = sc.sc_id')->join('staff_dept sd','sd.id = staff_sms.dept_id')->where ( $where)->count ();
		
		$dataurl = '/Properties/userproperties/historydetails/'.$keyword;
		$this->assign ( "keyword",$keyword);
		$this->assign ( "dataurl",$dataurl);
		$this->assign ( "columns",$columns );
		return $this->fetch();
	}
	
	public  function historydetails(){
		$user = Db::name('admin')->where('id',Session::get('admin'))->find();
		$get = $this->request->param ();
		$k =  explode('/', $this->request->pathinfo());
		$where = "staff_sms.sm_status = 2 and sl.sl_name = '{$user['location']}'";
		if($k[3]){
			$where .=" and (sms_main.sms_number  like '%" . $k[3] . "%' or  staff_sms.itname like '%" . $k[3] . "%') ";
		}
		$count = Db::connect('db_23')->name ( 'staff_sms' )->join('sms_main','staff_sms.sms_number = sms_main.sms_number')->join('sms_local sl','sms_main.sms_local = sl.sl_id')->join('sms_category sc','sms_main.sms_cat_id = sc.sc_id')->join('staff_dept sd','sd.id = staff_sms.dept_id','left')->where ( $where)->count ();
		$limit = $get ['limit'] ? $get ['limit'] : 10;
		$start = $get ['page'] ? ($get ['page'] - 1) * $limit : 0;
		$properties =  Db::connect('db_23')->name ( 'staff_sms' )->join('sms_main','staff_sms.sms_number = sms_main.sms_number')->join('sms_local sl','sms_main.sms_local = sl.sl_id')->join('staff_dept sd','sd.id = staff_sms.dept_id','left')->join('sms_category sc','sms_main.sms_cat_id = sc.sc_id')->where ( $where)->order ( 'sm_id desc' )->limit ( $start, $limit )->select ();
		$returnmsg = array (
				"code" => 0,
				'count' => $count,
				"data" => $properties
		);
		echo json_encode ( $returnmsg );
	}
}