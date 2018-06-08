<?php 
namespace app\properties\controller;
use app\admin\controller\Permissions;
use app\admin\model\Admin;
use \think\Db;
use \think\Session;
class Warehouse extends Permissions
{
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
	public function index() {
		$user = Db::name('admin')->where('id',Session::get('admin'))->find();
		$keyword =  $this->request->param ('k');
		$this->assign ( "title", '资产仓库' );
		$columns = "[ //表头
							        {field: 'sms_number', width: 90, title: '资产编号'}
							        ,{field: 'sms_sapnumber', title: '财务编号'}
							        ,{field: 'sc_name',  title: '类型'}
							        ,{field: 'sms_bname',  title: '品牌', sort: true, }
							        ,{field: 'sms_size',  title: '规格', sort: true, }
							        ,{field: 'sl_name', title: '归属地', sort: true, }
							        ,{field: 'sms_status', width: 90, title: '状态'  ,templet: function(d){
												if(d.sms_status == 1){
													return '<span style=\"color: #c00;\"> 在库</span>';
												}
												else
      											   return '<span style=\"color: green;\"> 使用中</span>';
      								 }}
// 							        ,{fixed: 'right',title:'操作', align:'center', toolbar: '#barDemo'}
							      ]";
		$export =  $this->request->param ('exportdata');
		$where = " sl.sl_name = '{$user['location']}'  ";
		if($keyword){
			$where .=" and (sms_main.sms_number  like '%" . $keyword . "%' or sms_main.sms_sapnumber  like '%" . $keyword . "%') ";
		}
		$count = Db::connect('db_23')->name ( 'sms_main' )->join('sms_local sl','sms_main.sms_local = sl.sl_id')->join('sms_category sc','sms_main.sms_cat_id = sc.sc_id')->where ( $where)->count ();
		if($export){
			if($count > 5000){
				echo '导出记录过多，请按条件进行过滤！';
				exit;
			}
			$properties =  Db::connect('db_23')->name ( 'sms_main' )->join('sms_local sl','sms_main.sms_local = sl.sl_id')->join('sms_category sc','sms_main.sms_cat_id = sc.sc_id')->where (  $where )->order ( 'sms_id desc' )->select ();
				
			$titles = array('资产编号','财务编号','类型','资产品牌','资产规格','资产归属');
			$fields = array('sms_number','sms_sapnumber','sc_name','sms_bname','sms_size','sl_name');
			export_toexcel ( $titles, $fields, $properties);
			exit;
		}
		$dataurl = '/Properties/warehouse/properties/'.$keyword;
		$this->assign ( "dataurl", $dataurl );
		$this->assign ( "columns", $columns );
		$this->assign ( "keyword",$keyword );
		return $this->fetch ();
	}
	function properties() {
		$user = Db::name('admin')->where('id',Session::get('admin'))->find();
		$get = $this->request->param ();
		$k =  explode('/', $this->request->pathinfo());
		$where = " sl.sl_name = '{$user['location']}'";
		if($k[3]){
			$where .=" and (sms_main.sms_number  like '%" . $k[3] . "%' or sms_main.sms_sapnumber  like '%" . $k[3] . "%') ";
		}
		$count = Db::connect('db_23')->name ( 'sms_main' )->join('sms_local sl','sms_main.sms_local = sl.sl_id')->join('sms_category sc','sms_main.sms_cat_id = sc.sc_id')->where ( $where)->count ();
		$limit = $get ['limit'] ? $get ['limit'] : 10;
		$start = $get ['page'] ? ($get ['page'] - 1) * $limit : 0;
		$properties =  Db::connect('db_23')->name ( 'sms_main' )->join('sms_local sl','sms_main.sms_local = sl.sl_id')->join('sms_category sc','sms_main.sms_cat_id = sc.sc_id')->where (  $where )->order ( 'sms_id desc' )->limit ( $start, $limit )->select ();
		$returnmsg = array (
				"code" => 0,
				'count' => $count,
				"data" => $properties
		);
		echo json_encode ( $returnmsg );
	}
	
	public function scraplist() {
		$user = Db::name('admin')->where('id',Session::get('admin'))->find();
		$keyword =  $this->request->param ('k');
		$this->assign ( "title", '资产历史' );
		$columns = "[ //表头
							        {field: 'sms_number', width: 90, title: '资产编号'}
							        ,{field: 'sms_sapnumber', title: '财务编号'}
							        ,{field: 'sc_name',  title: '类型'}
							        ,{field: 'sms_bname',  title: '品牌', sort: true, }
							        ,{field: 'sms_size',  title: '规格', sort: true, }
							        ,{field: 'sl_name', title: '归属地', sort: true, }
							      ]";
		$export =  $this->request->param ('exportdata');
		$where = " sl.sl_name = '{$user['location']}'  ";
		if($keyword){
			$where .=" and (sms_main_scrap.sms_number  like '%" . $keyword . "%' or sms_main_scrap.sms_sapnumber  like '%" . $keyword . "%') ";
		}
		$count = Db::connect('db_23')->name ( 'sms_main_scrap' )->join('sms_local sl','sms_main_scrap.sms_local = sl.sl_id')->join('sms_category sc','sms_main_scrap.sms_cat_id = sc.sc_id')->where ( $where)->count ();
		if($export){
			if($count > 5000){
				echo '导出记录过多，请按条件进行过滤！';
				exit;
			}
			$properties =  Db::connect('db_23')->name ( 'sms_main_scrap' )->join('sms_local sl','sms_main_scrap.sms_local = sl.sl_id')->join('sms_category sc','sms_main_scrap.sms_cat_id = sc.sc_id')->where (  $where )->order ( 'sms_id desc' )->select ();
				
			$titles = array('资产编号','财务编号','类型','品牌','规格','归属地');
			$fields = array('sms_number','sms_sapnumber','sc_name','sms_bname','sms_size','sl_name');
			export_toexcel ( $titles, $fields, $properties);
			exit;
		}
		$dataurl = '/Properties/warehouse/scrapdetails/'.$keyword;
		$this->assign ( "dataurl", $dataurl );
		$this->assign ( "columns", $columns );
		$this->assign ( "keyword",$keyword );
		return $this->fetch ();
	}
	function scrapdetails() {
		$user = Db::name('admin')->where('id',Session::get('admin'))->find();
		$get = $this->request->param ();
		$k =  explode('/', $this->request->pathinfo());
		$where = " sl.sl_name = '{$user['location']}'";
		if($k[3]){
			$where .=" and (sms_main_scrap.sms_number  like '%" . $k[3] . "%' or sms_main_scrap.sms_sapnumber  like '%" . $k[3] . "%') ";
		}
		$count = Db::connect('db_23')->name ( 'sms_main_scrap' )->join('sms_local sl','sms_main_scrap.sms_local = sl.sl_id')->join('sms_category sc','sms_main_scrap.sms_cat_id = sc.sc_id')->where ( $where)->count ();
		$limit = $get ['limit'] ? $get ['limit'] : 10;
		$start = $get ['page'] ? ($get ['page'] - 1) * $limit : 0;
		$properties =  Db::connect('db_23')->name ( 'sms_main_scrap' )->join('sms_local sl','sms_main_scrap.sms_local = sl.sl_id')->join('sms_category sc','sms_main_scrap.sms_cat_id = sc.sc_id')->where (  $where )->order ( 'sms_id desc' )->limit ( $start, $limit )->select ();
		$returnmsg = array (
				"code" => 0,
				'count' => $count,
				"data" => $properties
		);
		echo json_encode ( $returnmsg );
	}
	
	function waitinglist(){
		$user = Db::name('admin')->where('id',Session::get('admin'))->find();
		$keyword =  $this->request->param ('k');
		$this->assign ( "title", '资产仓库' );
		$columns = "[ //表头
							        {field: 'sms_number', width: 90, title: '资产编号'}
							        ,{field: 'sms_sapnumber', title: '财务编号'}
							        ,{field: 'sms_bname', title: '品牌', sort: true, }
							        ,{field: 'sms_size', title: '规格', sort: true, }
							        ,{field: 'reg_itname', title: '申请人', sort: true, }
							        ,{field: 'reg_time', title: '申请日期', sort: true, }
							        ,{field: 'injob_time', title: '入职日期', sort: true, }
							        ,{field: 'so_itname', title: '装机人', sort: true, }
							        ,{field: 'sl_name', width: 90, title: '归属地', sort: true, }
								    ,{field: 'so_status', width: 90, title: '状态'  ,templet: function(d){
												if(d.so_status== 6){
													return '<span style=\"color: #c00;\"> 装机完成</span>';
												}
												else
      											   return '<span style=\"color: green;\">准备中 </span>';
      								 }}
// 							        ,{fixed: 'right',title:'操作', align:'center', toolbar: '#barDemo'}
							      ]";
		$export =  $this->request->param ('exportdata');
		$where = "  so_status in (1,6) and sl.sl_name = '{$user['location']}'  ";
		if($keyword){
			$where .=" and (sr.sms_number like '%" . $keyword . "%' or sr.reg_itname  like '%" . $keyword . "%') ";
		}
		$count = Db::connect('db_23')->name ( 'staff_sms_oa_register sr' )->join('sms_main sm','sr.sms_number = sm.sms_number')->join('sms_local sl','sm.sms_local = sl.sl_id')->where (  $where )->count ();
		if($export){
			if($count > 5000){
				echo '导出记录过多，请按条件进行过滤！';
				exit;
			}
			$properties =  Db::connect('db_23')->name ( 'staff_sms_oa_register sr' )->join('sms_main sm','sr.sms_number = sm.sms_number')->join('sms_local sl','sm.sms_local = sl.sl_id')->where (  $where )->order ( 'so_id desc' )->select ();
		
			$titles = array('资产编号', '财务编号', '品牌', '申请人', '申请日期','入职日期', '装机人', '资产归属');
			$fields = array('sms_number','sms_sapnumber','sms_bname','sms_size','reg_itname','reg_time', 'injob_time','so_itname', 'sl_name');
			export_toexcel ( $titles, $fields, $properties);
			exit;
		}
		$dataurl = '/Properties/warehouse/waitingdetails/'.$keyword;
		$this->assign ( "dataurl", $dataurl );
		$this->assign ( "currentpage", " ( 入职分配 ) <a href='waitinglist_a' class='layui-btn layui-btn-xs layui-bg-blue '>领用分配</a>" );
		$this->assign ( "columns", $columns );
		$this->assign ( "keyword",$keyword );
		return $this->fetch();
	}

	function waitingdetails() {
		$user = Db::name('admin')->where('id',Session::get('admin'))->find();
		$get = $this->request->param ();
		$k =  explode('/', $this->request->pathinfo());
		$where = "  so_status in (1,6) and sl.sl_name = '{$user['location']}'  ";
		if($k[3]){
			$where .=" and (sr.sms_number  like '%" . $k[3] . "%' or sr.reg_itname  like '%" . $k[3] . "%') ";
		}
		$count = Db::connect('db_23')->name ( 'staff_sms_oa_register sr' )->join('sms_main sm','sr.sms_number = sm.sms_number')->join('sms_local sl','sm.sms_local = sl.sl_id')->where (  $where )->count ();
		$limit = $get ['limit'] ? $get ['limit'] : 10;
		$start = $get ['page'] ? ($get ['page'] - 1) * $limit : 0;
	    $properties =  Db::connect('db_23')->name ( 'staff_sms_oa_register sr' )->join('sms_main sm','sr.sms_number = sm.sms_number')->join('sms_local sl','sm.sms_local = sl.sl_id')->where (  $where )->order ( 'so_id desc' )->limit ( $start, $limit )->select ();
// 		foreach($properties as &$property){
// 			$property['sms_status'] = $property['sms_status'] == 1 ? '在库':'使用中';
// 		}
		$returnmsg = array (
				"code" => 0,
				'count' => $count,
				"data" => $properties
		);
		echo json_encode ( $returnmsg );
	}
	
	function waitinglist_a(){
		$user = Db::name('admin')->where('id',Session::get('admin'))->find();
		$keyword =  $this->request->param ('k');
		$this->assign ( "title", '资产仓库' );
		$columns = "[ //表头
							        {field: 'oa_number', title: 'OA编号'}
							        ,{field: 'sms_number_4', title: '主机'}
							        ,{field: 'sms_number_8', title: '显示器'}
							        ,{field: 'sms_number_11', title: '一体机'}
							        ,{field: 'sms_number_19', title: '笔记本'}
							      ]";
		$export =  $this->request->param ('exportdata');
// 		$where = "  status in (1,3) and sl.sl_name = '{$user['location']}'  ";
		$where = "  status in (1,3) ";
		if($keyword){
			$where .=" and (sr.oa_number like '%" . $keyword . "%' or sr.sms_number_4  like '%" . $keyword . "%' or sr.sms_number_8  like '%" . $keyword . "%' or sr.sms_number_11  like '%" . $keyword . "%' or sr.sms_number_19  like '%" . $keyword . "%') ";
		}
		$count = Db::connect('db_23')->name ( 'staff_sms_oa sr' )->where (  $where )->count ();
		if($export){
			if($count > 5000){
				echo '导出记录过多，请按条件进行过滤！';
				exit;
			}
			$properties =  Db::connect('db_23')->name ( 'staff_sms_oa sr' )->where (  $where )->order ( 'so_id desc' )->select ();
		
			$titles = array('OA编号','主机','显示器','一体机','笔记本');
			$fields = array('oa_number','sms_number_4','sms_number_8','sms_number_11','sms_number_19');
			export_toexcel ( $titles, $fields, $properties);
			exit;
		}
		$dataurl = '/Properties/warehouse/waitingdetails_a/'.$keyword;
		$this->assign ( "dataurl", $dataurl );
		$this->assign ( "columns", $columns );
		$this->assign ( "keyword",$keyword );
		$this->assign ( "currentpage", " ( 领用分配 ) <a href='waitinglist' class='layui-btn layui-btn-xs layui-bg-blue '>入职分配</a>" );
		return $this->fetch('waitinglist');
	}

	function waitingdetails_a() {
		$user = Db::name('admin')->where('id',Session::get('admin'))->find();
		$get = $this->request->param ();
		$k =  explode('/', $this->request->pathinfo());
// 		$where = "  so_status in (1,6) and sl.sl_name = '{$user['location']}'  ";
		$where = "  status in (1,3) ";
		if($k[3]){
			$where .=" and (sr.oa_number like '%" . $k[3] . "%' or sr.sms_number_4  like '%" . $k[3] . "%' or sr.sms_number_8  like '%" . $k[3] . "%' or sr.sms_number_11  like '%" . $k[3] . "%' or sr.sms_number_19  like '%" . $k[3] . "%') ";
		}
		$count = Db::connect('db_23')->name ( 'staff_sms_oa sr' )->where (  $where )->count ();
		$limit = $get ['limit'] ? $get ['limit'] : 10;
		$start = $get ['page'] ? ($get ['page'] - 1) * $limit : 0;
		$properties =  Db::connect('db_23')->name ( 'staff_sms_oa sr' )->where (  $where )->order ( 'so_id desc' )->limit ( $start, $limit )->select ();
		foreach($properties as &$property){
// 			$property['sms_status'] = $property['sms_status'] == 1 ? '在库':'使用中';
		}
		$returnmsg = array (
				"code" => 0,
				'count' => $count,
				"data" => $properties
		);
		echo json_encode ( $returnmsg );
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
}