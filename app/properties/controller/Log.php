<?php 
namespace app\properties\controller;
use app\admin\controller\Permissions;
use app\admin\model\Admin;
use \think\Db;
use \think\Session;
class Log extends Permissions
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
	public function adminlog() {
		$user = Db::name('admin')->where('id',Session::get('admin'))->find();
		$keyword =  $this->request->param ('k');
		$this->assign ( "title", '操作日志' );
		$columns = "[ //表头
							        {field: 'ul_username', width: 90, title: '操作用户'}
							        ,{field: 'ul_time', title: '操作时间'}
							        ,{field: 'ul_model',  title: '操作类型', sort: true,}
							        ,{field: 'ul_title',  title: '操作说明' }
							        ,{field: 'ul_function',  title: '操作参数'}
							      ]";
		$export =  $this->request->param ('exportdata');
		$where = " ul_model not like '资产%'";
// 		$where = " sl.sl_name = '{$user['location']}'  ";
		if($keyword){
			$where .=" and (ul_username  like '%" . $keyword . "%' or ul_model  like '%" . $keyword . "%') ";
		}
		$count = Db::connect('db_23')->name ( 'user_log' )->where ( $where)->count ();
		if($export){
			if($count > 5000){
				echo '导出记录过多，请按条件进行过滤！';
				exit;
			}
			$properties =   Db::connect('db_23')->name ( 'user_log' )->where ( $where)->order ( 'ul_id desc' )->select ();
				
			$titles = array('操作用户','操作时间','操作类型','操作说明','操作参数');
			$fields = array('ul_username','ul_time','ul_model','ul_title','ul_function');
			export_toexcel ( $titles, $fields, $properties);
			exit;
		}
		$dataurl = '/Properties/log/details/'.$keyword;
		$this->assign ( "dataurl", $dataurl );
		$this->assign ( "columns", $columns );
		$this->assign ( "keyword",$keyword );
		return $this->fetch ();
	}
	
	function details() {
		$user = Db::name('admin')->where('id',Session::get('admin'))->find();
		$get = $this->request->param ();
		$k =  explode('/', $this->request->pathinfo());
// 		$where = " sl.sl_name = '{$user['location']}'";
		$where =  " ul_model not like '资产%'";
		if($k[3]){
			$where .=" and (ul_username  like '%" . $k[3] . "%' or ul_model  like '%" . $k[3] . "%') ";
		}
		$count = Db::connect('db_23')->name ( 'user_log' )->where ( $where)->count ();
		$limit = $get ['limit'] ? $get ['limit'] : 10;
		$start = $get ['page'] ? ($get ['page'] - 1) * $limit : 0;
					$properties =   Db::connect('db_23')->name ( 'user_log' )->where ( $where)->order ( 'ul_id desc' )->limit ( $start, $limit )->select ();
		$returnmsg = array (
				"code" => 0,
				'count' => $count,
				"data" => $properties
		);
		echo json_encode ( $returnmsg );
	}
	
	public function plog() {
		$user = Db::name('admin')->where('id',Session::get('admin'))->find();
		$keyword =  $this->request->param ('k');
		$this->assign ( "title", '操作日志' );
		$columns = "[ //表头
							        {field: 'ul_username', width: 90, title: '操作用户'}
							        ,{field: 'ul_time', title: '操作时间'}
							        ,{field: 'ul_model',  title: '操作类型', sort: true,}
							        ,{field: 'ul_title',  title: '操作说明' }
							        ,{field: 'ul_function',  title: '操作参数'}
							      ]";
		$export =  $this->request->param ('exportdata');
		$where = " ul_model  like '资产%'";
		// 		$where = " sl.sl_name = '{$user['location']}'  ";
		if($keyword){
			$where .=" and (ul_username  like '%" . $keyword . "%' or ul_model  like '%" . $keyword . "%') ";
		}
		$count = Db::connect('db_23')->name ( 'user_log' )->where ( $where)->count ();
		if($export){
			if($count > 5000){
				echo '导出记录过多，请按条件进行过滤！';
				exit;
			}
			$properties =   Db::connect('db_23')->name ( 'user_log' )->where ( $where)->order ( 'ul_id desc' )->select ();
	
			$titles = array('操作用户','操作时间','操作类型','操作说明','操作参数');
			$fields = array('ul_username','ul_time','ul_model','ul_title','ul_function');
			export_toexcel ( $titles, $fields, $properties);
			exit;
		}
		$dataurl = '/Properties/log/details_p/'.$keyword;
		$this->assign ( "dataurl", $dataurl );
		$this->assign ( "columns", $columns );
		$this->assign ( "keyword",$keyword );
		return $this->fetch ();
	}
	
	function details_p() {
		$user = Db::name('admin')->where('id',Session::get('admin'))->find();
		$get = $this->request->param ();
		$k =  explode('/', $this->request->pathinfo());
		// 		$where = " sl.sl_name = '{$user['location']}'";
		$where =  " ul_model  like '资产%'";
		if($k[3]){
			$where .=" and (ul_username  like '%" . $k[3] . "%' or ul_model  like '%" . $k[3] . "%') ";
		}
		$count = Db::connect('db_23')->name ( 'user_log' )->where ( $where)->count ();
		$limit = $get ['limit'] ? $get ['limit'] : 10;
		$start = $get ['page'] ? ($get ['page'] - 1) * $limit : 0;
		$properties =   Db::connect('db_23')->name ( 'user_log' )->where ( $where)->order ( 'ul_id desc' )->limit ( $start, $limit )->select ();
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