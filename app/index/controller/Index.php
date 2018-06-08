<?php

namespace app\index\controller;

use \think\Db;
use \think\Session;
use app\index\model\Station;
use app\index\model\Staff;
use app\admin\model\Admin;
use app\recruit\model\Recruit;
use app\index\model\Potentialmembers;
use app\recruit\Controller\Api;

class Index extends Permissions {
	var $rolename = '';
	function _initialize() {
		parent::_initialize ();
		$amodel = new Admin ();
		$user = $amodel->admincate ()->where ( 'id', Session::get ( 'admin' ) )->find ();
		$menu = Db::name ( 'admin_menu' )->where ( [ 
				'is_display' => 1
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
		return $this->fetch ();
		// return '<style type="text/css">*{ padding: 0; margin: 0; } div{ padding: 4px 48px;} a{color:#2E5CD5;cursor: pointer;text-decoration: none} a:hover{text-decoration:underline; } body{ background: #fff; font-family: "Century Gothic","Microsoft yahei"; color: #333;font-size:18px;} h1{ font-size: 100px; font-weight: normal; margin-bottom: 12px; } p{ line-height: 1.6em; font-size: 42px }</style><div style="padding: 24px 48px;"> <h1>:)</h1><p> Tplay<br/><span style="font-size:30px">为开发者量身定制的高速度开发后台管理框架</span></p><span style="font-size:22px;"><br>【重要】【重要】【重要】Tplay后台管理框架目前没有开发index前台模块，请严格按照安装包中的安装说明进行安装！！';
	}

	public function home() {
		$this->stationlist ();
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
	
	/**
	 * 个人资料修改，属于无权限操作，仅能修改昵称和头像，后续可增加其他字段
	 */
	public function personal() {
		$this->assign ( 'title', ' 个人信息修改' );
		// 获取管理员id
		$id = Session::get ( 'admin' );
		$model = new Admin ();
		if ($id > 0) {
			// 是修改操作
			if ($this->request->isPost ()) {
				// 是提交操作
				$post = $this->request->post ();
				// 验证昵称是否存在
				$nickname = $model->where ( [ 
						'nickname' => $post ['nickname'],
						'id' => [ 
								'neq',
								$post ['id'] 
						] 
				] )->select ();
				if (! empty ( $nickname )) {
					return $this->error ( '提交失败：该昵称已被占用' );
				}
				if (false == $model->allowField ( true )->save ( $post, [ 
						'id' => $id 
				] )) {
					return $this->error ( '修改失败' );
				} else {
					addlog ( $model->id ); // 写入日志
					return $this->success ( '修改个人信息成功', 'admin/admin/personal' );
				}
			} else {
				// 非提交操作
				$info ['admin'] = $model->where ( 'id', $id )->find ();
				$this->assign ( 'info', $info );
				return $this->fetch ();
			}
		} else {
			return $this->error ( 'id不正确' );
		}
	}
	function stationlist() {
		// $start = $this->uri->segment(4,0);
		// $username = $this->dx_auth->get_username();
		// $limit = 15;
		// $data = $this->staff_model->get_stationlist('',$start,$limit);
		// $this->load->library ( 'pagination' );
		// $config ['base_url'] = site_url ( 'staff/staff/stationlist/');
		// $countsql = "select count(id) as numrow from stationlist where status != 2 ";
		// $total = $this->db->query($countsql)->row();
		// $config ['total_rows'] = $total->numrow;
		// $config ['per_page'] = $limit;
		// $config ['uri_segment'] = 4;
		// $this->pagination->initialize ( $config );
		// $links = $this->pagination->create_links ();
		// $this->cismarty->assign ( "links", $links );
		// $this->cismarty->assign ( "data",$data);
		// $this->cismarty->assign ( "uname",$username);
		// $this->cismarty->display ( 'default/staff/stationlist.tpl' );
		$this->assign ( "title", '招聘岗位列表' );
		$columns = "[ //表头
							        {field: 'name', title: '目前在招聘的岗位'}
							        ,{field: 'createdby', title: '创建人', sort: true}
							        ,{field: 'belongto', title: '类型'} 
							        ,{field: 'create_time', title: '新建时间', sort: true, }
							        ,{fixed: 'right',title:'操作', align:'center', toolbar: '#barDemo'}
							      ]";
		$dataurl = '/index/index/stations/';
		$this->assign ( "dataurl", $dataurl );
		$this->assign ( "columns", $columns );
		return $this->fetch ();
	}
	function stations() {
		$get = $this->request->param ();
		$limit = $get ['limit'] ? $get ['limit'] : 10;
		$start = $get ['page'] ? ($get ['page'] - 1) * $limit : 0;
		
		$count = Db::name ( 'station' )->where ( 'status != 2')->count ();
		$stations = Db::name ( 'station' )->where (  'status != 2' )->order ( 'id desc' )->limit ( $start, $limit )->select ();
		foreach($stations as &$station){
			 $station['create_time'] = date('Y-m-d H:i:s',$station['create_time']);
			 $creator = Db::name('admin')->where(array('id'=>$station['createdby']))->find();
			 $station['createdby'] = $creator['name'];
		}
		$returnmsg = array (
				"code" => 0,
				'count' => $count,
				"data" => $stations 
		);
		echo json_encode ( $returnmsg );
	}
	function stationlist_add() {
		return $this->fetch ();
	}
	function stationlist_add_do() {
		$data ['belongto'] = strtoupper ( trim ( $this->request->param ( 'type' ) ) );
		$data ['name'] = strtoupper ( trim ( $this->request->param ( 'name' ) ) );
		$smodel = new Station ();
		$station = $smodel->where ( array (
				"name" => $data ['name'] 
		) )->find ();
		if ($station) {
			// echo '该岗位已经存在，请勿重复建立！';
			$smodel->update ( array (
					'id' => $station->id,
					'status' => 1,
					'createdby' => Session::get ( 'admin' ) 
			) );
		} else {
			$data ['createdby'] = Session::get ( 'admin' );
			$smodel->save ( $data );
		}
		$this->success ( '修改成功', 'stationlist', '', 1 );
	}
	
	/**
	 * 应聘人员列表
	 */
	function applicantlist() {
		$start = $this->request->param ( 'start' ) ? 0 : $this->request->param ( 'start' );
		$limit = 10;
		$pageindex = $start / $limit;
		$amodel = new Admin ();
		if (strpos ( $this->rolename, '_' ) > 0) {
			$rarray = explode ( "_", $this->rolename );
			$belongto = $rarray [0];
		} else {
			$belongto = '股份';
		}
		$stations = Db::name ( 'station' )->where ([])->order ( 'id desc' )->limit ( $start, $limit )->select ();
		$s_condition = array ();
		foreach ( $stations as $station ) {
			$s_condition [] = $station ['id'];
		}
		if ($s_condition) {
			$post_data ['Station'] = $s_condition;
		}
		$post_data ['Station'] [] = - 1;
		$s_condition = implode ( ',', $s_condition );
		$keyword = $this->request->param ( 'keyword' );
		$memberlist = Db::name ( 'recruit' )->where ([])->order ( 'id desc' )->limit ( $start, $limit )->select ();
		$stationlist = array (
				'' => '未知' 
		);
		foreach ( $stations as $station ) {
			$stationlist [$station ['id']] = $station ['name'];
		}
		$this->assign ( "stationlist", $stationlist );
		$this->assign ( "keyword", $keyword );
		$this->assign ( "title", '招聘岗位列表' );
		$columns = "[ //表头
							        {field: 'CName', title: '姓名', sort: true}
							        ,{field: 'Telephone', title: '手机号'}
							        ,{field: 'Station', title: '岗位', sort: true, }
							        ,{fixed: 'right',title:'操作', align:'center', toolbar: '#barDemo'}
							      ]";
		$dataurl = '/index/index/applicants?keyword='.$keyword;
		$this->assign ( "dataurl", $dataurl );
		$this->assign ( "columns", $columns );
		return $this->fetch ();
	}
	public function applicants() {
	    $station = new Station();
		$get = $this->request->param ();
		$limit = $get ['limit'] ? $get ['limit'] : 10;
		$start = $get ['page'] ? ($get ['page'] - 1) * $limit : 0;
		$keyword =  $get['keyword'];
		$where = "status <= 1 and (cname like '%$keyword%' or telephone like '%$keyword%')" ;
		$count = Db::name ( 'recruit' )->where ($where)->count ();
		$members = Db::name ( 'recruit' )->where ($where)->order ( 'id desc' )->limit ( $start, $limit )->select ();
		foreach ($members as &$member){
		    $st = $station->where(array('id'=>$member['Station']))->find();
            if($st)
		      $member['Station'] = $st->name;
		}
		$returnmsg = array (
				"code" => 0,
				'count' => $count,
				"data" => $members 
		);
		echo json_encode ( $returnmsg );
	}
	
	/**
	 * 意向人员列表
	 */
	function potentialmemberlist() {
		$keyword = $this->request->param ( 'keyword' );
		$export = $this->request->param ( 'exportdata' );
		$amodel = new Admin ();
		$user = $amodel->admincate ()->where ( 'id', Session::get ( 'admin' ) )->find ();
		$this->rolename = $user ['name'];
		$recruit = new Recruit ();
		$ptm = new Potentialmembers ();
		if ($export) {
			$mlist = $ptm->get_potentialmemberslist ( 0, 0, $keyword );
			foreach ( $mlist as $pm ) {
				$pd = $recruit->where ( 'Telephone', $pm->telnumber )->find ();
				if ($pd) {
					$pd->FamilyInfo = $pd->FamilyInfo ? unserialize ( $pd->FamilyInfo ) : null;
					$pd->FriendInfo = $pd->FriendInfo ? unserialize ( $pd->FriendInfo ) : null;
					$pd->Education = $pd->Education ? unserialize ( $pd->Education ) : null;
					$pd->WorkExp = $pd->WorkExp ? unserialize ( $pd->WorkExp ) : null;
					$datas [] = $pd;
				} else {
					// $tempdata = new stdClass ();
					// $tempdata->CName = $pm->name;
					// $tempdata->Telephone = $pm->telnumber;
					// $tempdata->FamilyInfo = null;
					// $tempdata->FriendInfo = null;
					// $tempdata->Education = null;
					// $tempdata->WorkExp = null;
					// $datas [] = $tempdata;
				}
			}
			$fields = array (
					"CName",
					"Gender",
					"EName",
					"Telephone",
					"Station",
					"Nation",
					"CardId",
					"Email",
					"Domicile",
					"IsMarry",
					"Party",
					"AddPartyTime",
					"LivePcc",
					"LiveAddress",
					"ResPcc",
					"ResAddress",
					"ContactName",
					"ContactShip",
					"ContactTel",
					"Language",
					"LangLevel",
					"Source",
					"SourceResult",
					"Professional",
					"EntryTime",
					"Interest",
					"Subsidy",
					"SubsidyAmount",
					"WorkTime",
					"M_Salary",
					"Q_Award",
					"Y_Award",
					"Income",
					"E_Salary",
					"Agreement" 
			);
			$titles = array (
					"姓名",
					"性别",
					"英文名",
					"手机号",
					"所在岗位",
					"民族",
					"身份证号",
					"邮箱",
					"户籍性质",
					"是否结婚",
					"政治面貌",
					"入党时间",
					"现居地（省市县）",
					"现居详细地址",
					"户口所在地（省市县）",
					"户口所在详细地址",
					"紧急联络人姓名",
					"紧急联络人关系",
					"紧急联络人电话",
					"外语语种",
					"外语能力",
					"招聘渠道",
					"推荐人或者其他来源",
					"专业证书",
					"可到岗时间",
					"个性与爱好",
					"补贴类型",
					"补贴金额",
					"工作时间制",
					"月薪",
					"季度奖",
					"年终奖",
					"年收入",
					"期望年薪",
					"与原公司是否签订竞业限制、保护商业机密之类的协议" 
			);
			foreach ( $datas as &$dt ) {
				$cnum = 1;
				if ($dt->FamilyInfo && sizeof ( $dt->FamilyInfo ) > 0) {
					foreach ( $dt->FamilyInfo as $val ) {
						$titles [] = '家庭成员姓名' . $cnum;
						$titles [] = '家庭成员关系' . $cnum;
						$titles [] = '家庭成员工作单位' . $cnum;
						$un = 'UName' . $cnum;
						$us = 'UShip' . $cnum;
						$uc = 'UCompany' . $cnum;
						$fields [] = $un;
						$fields [] = $us;
						$fields [] = $uc;
						$dt->$un = $val ['UName'];
						$dt->$us = $val ['UShip'];
						$dt->$uc = $val ['UCompany'];
						$cnum ++;
					}
				}
				$cnum = 1;
				if ($dt->FriendInfo && sizeof ( $dt->FriendInfo ) > 0) {
					foreach ( $dt->FriendInfo as $val ) {
						$titles [] = '亲友姓名' . $cnum;
						$titles [] = '亲友关系' . $cnum;
						$fn = 'FName' . $cnum;
						$fs = 'FShip' . $cnum;
						$fields [] = $fn;
						$fields [] = $fs;
						$dt->$fn = $val ['FName'];
						$dt->$fs = $val ['FShip'];
						$cnum ++;
					}
				}
				$cnum = 1;
				if ($dt->Education && sizeof ( $dt->Education ) > 0) {
					foreach ( $dt->Education as $val ) {
						$titles [] = '入校年月' . $cnum;
						$titles [] = '离校年月' . $cnum;
						$titles [] = '学校名称' . $cnum;
						$titles [] = '专业' . $cnum;
						$titles [] = '有无毕业证书' . $cnum;
						$titles [] = '学历' . $cnum;
						$st = 'StartTime' . $cnum;
						$et = 'EndTime' . $cnum;
						$sn = 'SchoolName' . $cnum;
						$mj = 'Major' . $cnum;
						$id = 'IsDiploma' . $cnum;
						$er = 'EduRecord' . $cnum;
						$fields [] = $st;
						$fields [] = $et;
						$fields [] = $sn;
						$fields [] = $mj;
						$fields [] = $id;
						$fields [] = $er;
						$dt->$st = $val ['StartTime'];
						$dt->$et = $val ['EndTime'];
						$dt->$sn = $val ['SchoolName'];
						$dt->$mj = $val ['Major'];
						$dt->$id = $val ['IsDiploma'];
						$dt->$er = $val ['EduRecord'];
						$cnum ++;
					}
				}
				$cnum = 1;
				if ($dt->WorkExp && sizeof ( $dt->WorkExp ) > 0) {
					foreach ( $dt->WorkExp as $val ) {
						$titles [] = '入职时间' . $cnum;
						$titles [] = '离职时间' . $cnum;
						$titles [] = '工作单位' . $cnum;
						$titles [] = '职位' . $cnum;
						$titles [] = '离职原因' . $cnum;
						$titles [] = '证明人' . $cnum;
						$titles [] = '联系方式' . $cnum;
						$titles [] = '职责' . $cnum;
						$et = 'EntryTime' . $cnum;
						$qt = 'QuitTime' . $cnum;
						$cp = 'Company' . $cnum;
						$pi = 'Position' . $cnum;
						$ra = 'Reason' . $cnum;
						$cu = 'ContactUser' . $cnum;
						$ct = 'ContactTel' . $cnum;
						$dy = 'Duty' . $cnum;
						$fields [] = $et;
						$fields [] = $qt;
						$fields [] = $cp;
						$fields [] = $pi;
						$fields [] = $ra;
						$fields [] = $cu;
						$fields [] = $ct;
						$fields [] = $dy;
						$dt->$et = $val ['EntryTime'];
						$dt->$qt = $val ['QuitTime'];
						$dt->$cp = $val ['Company'];
						$dt->$pi = $val ['Position'];
						$dt->$ra = $val ['Reason'];
						$dt->$cu = $val ['ContactUser'];
						$dt->$ct = $val ['ContactTel'];
						$dt->$dy = $val ['Duty'];
						$cnum ++;
					}
				}
			}
			export_toexcel ( $titles, $fields, $datas );
			exit ();
		}
		$this->assign ( "title", '意向人员列表' );
		$columns = "[ //表头
							        {field: 'id', title: 'ID', sort: true, fixed: 'left'}
							        ,{field: 'name', title: '姓名', sort: true}
							        ,{field: 'telnumber', title: '手机号', sort: true, }
							        ,{field: 'itname', title: '登陆名'}
							        ,{field: 'station', title: '岗位', sort: true, }
							        ,{field: 'datestr', title: '面试时间', sort: true, }
							        ,{fixed: 'right',title:'操作',width:500, align:'center', toolbar: '#barDemo'}
							      ]";
		$dataurl = '/index/index/potentialmembers';
		$this->assign ( "keyword", '' );
		$this->assign ( "dataurl", $dataurl );
		$this->assign ( "columns", $columns );
		return $this->fetch ();
	}
	public function potentialmembers() {
		$amodel = new Admin ();
		$user = $amodel->admincate ()->where ( 'id', Session::get ( 'admin' ) )->find ();
		$get = $this->request->param ();
		$limit = $get ['limit'] ? $get ['limit'] : 10;
		$start = $get ['page'] ? ($get ['page'] - 1) * $limit : 0;
		$where = "status = 6";
		$count = Db::name ( 'potentialmembers' )->where ( $where )->count ();
		$members = Db::name ( 'potentialmembers' )->where ( $where )->order ( 'status asc' )->limit ( $start, $limit )->select ();
		$returnmsg = array (
				"code" => 0,
				'count' => $count,
				"data" => $members 
		);
		echo json_encode ( $returnmsg );
	}
	/**
	 * 意向人员列表
	 */
	function auditmemberlist() {
		$keyword = $this->request->param ( 'keyword' );
		$export = $this->request->param ( 'exportdata' );
		$amodel = new Admin ();
		$user = $amodel->admincate ()->where ( 'id', Session::get ( 'admin' ) )->find ();
		$this->rolename = $user ['name'];
		$recruit = new Recruit ();
		$ptm = new Potentialmembers ();
		if ($export) {
			$mlist = $ptm->get_potentialmemberslist ( 0, 0, $keyword );
			foreach ( $mlist as $pm ) {
				$pd = $recruit->where ( 'Telephone', $pm->telnumber )->find ();
				if ($pd) {
					$pd->FamilyInfo = $pd->FamilyInfo ? unserialize ( $pd->FamilyInfo ) : null;
					$pd->FriendInfo = $pd->FriendInfo ? unserialize ( $pd->FriendInfo ) : null;
					$pd->Education = $pd->Education ? unserialize ( $pd->Education ) : null;
					$pd->WorkExp = $pd->WorkExp ? unserialize ( $pd->WorkExp ) : null;
					$datas [] = $pd;
				} else {
					// $tempdata = new stdClass ();
					// $tempdata->CName = $pm->name;
					// $tempdata->Telephone = $pm->telnumber;
					// $tempdata->FamilyInfo = null;
					// $tempdata->FriendInfo = null;
					// $tempdata->Education = null;
					// $tempdata->WorkExp = null;
					// $datas [] = $tempdata;
				}
			}
			$fields = array (
					"CName",
					"Gender",
					"EName",
					"Telephone",
					"Station",
					"Nation",
					"CardId",
					"Email",
					"Domicile",
					"IsMarry",
					"Party",
					"AddPartyTime",
					"LivePcc",
					"LiveAddress",
					"ResPcc",
					"ResAddress",
					"ContactName",
					"ContactShip",
					"ContactTel",
					"Language",
					"LangLevel",
					"Source",
					"SourceResult",
					"Professional",
					"EntryTime",
					"Interest",
					"Subsidy",
					"SubsidyAmount",
					"WorkTime",
					"M_Salary",
					"Q_Award",
					"Y_Award",
					"Income",
					"E_Salary",
					"Agreement" 
			);
			$titles = array (
					"姓名",
					"性别",
					"英文名",
					"手机号",
					"所在岗位",
					"民族",
					"身份证号",
					"邮箱",
					"户籍性质",
					"是否结婚",
					"政治面貌",
					"入党时间",
					"现居地（省市县）",
					"现居详细地址",
					"户口所在地（省市县）",
					"户口所在详细地址",
					"紧急联络人姓名",
					"紧急联络人关系",
					"紧急联络人电话",
					"外语语种",
					"外语能力",
					"招聘渠道",
					"推荐人或者其他来源",
					"专业证书",
					"可到岗时间",
					"个性与爱好",
					"补贴类型",
					"补贴金额",
					"工作时间制",
					"月薪",
					"季度奖",
					"年终奖",
					"年收入",
					"期望年薪",
					"与原公司是否签订竞业限制、保护商业机密之类的协议" 
			);
			foreach ( $datas as &$dt ) {
				$cnum = 1;
				if ($dt->FamilyInfo && sizeof ( $dt->FamilyInfo ) > 0) {
					foreach ( $dt->FamilyInfo as $val ) {
						$titles [] = '家庭成员姓名' . $cnum;
						$titles [] = '家庭成员关系' . $cnum;
						$titles [] = '家庭成员工作单位' . $cnum;
						$un = 'UName' . $cnum;
						$us = 'UShip' . $cnum;
						$uc = 'UCompany' . $cnum;
						$fields [] = $un;
						$fields [] = $us;
						$fields [] = $uc;
						$dt->$un = $val ['UName'];
						$dt->$us = $val ['UShip'];
						$dt->$uc = $val ['UCompany'];
						$cnum ++;
					}
				}
				$cnum = 1;
				if ($dt->FriendInfo && sizeof ( $dt->FriendInfo ) > 0) {
					foreach ( $dt->FriendInfo as $val ) {
						$titles [] = '亲友姓名' . $cnum;
						$titles [] = '亲友关系' . $cnum;
						$fn = 'FName' . $cnum;
						$fs = 'FShip' . $cnum;
						$fields [] = $fn;
						$fields [] = $fs;
						$dt->$fn = $val ['FName'];
						$dt->$fs = $val ['FShip'];
						$cnum ++;
					}
				}
				$cnum = 1;
				if ($dt->Education && sizeof ( $dt->Education ) > 0) {
					foreach ( $dt->Education as $val ) {
						$titles [] = '入校年月' . $cnum;
						$titles [] = '离校年月' . $cnum;
						$titles [] = '学校名称' . $cnum;
						$titles [] = '专业' . $cnum;
						$titles [] = '有无毕业证书' . $cnum;
						$titles [] = '学历' . $cnum;
						$st = 'StartTime' . $cnum;
						$et = 'EndTime' . $cnum;
						$sn = 'SchoolName' . $cnum;
						$mj = 'Major' . $cnum;
						$id = 'IsDiploma' . $cnum;
						$er = 'EduRecord' . $cnum;
						$fields [] = $st;
						$fields [] = $et;
						$fields [] = $sn;
						$fields [] = $mj;
						$fields [] = $id;
						$fields [] = $er;
						$dt->$st = $val ['StartTime'];
						$dt->$et = $val ['EndTime'];
						$dt->$sn = $val ['SchoolName'];
						$dt->$mj = $val ['Major'];
						$dt->$id = $val ['IsDiploma'];
						$dt->$er = $val ['EduRecord'];
						$cnum ++;
					}
				}
				$cnum = 1;
				if ($dt->WorkExp && sizeof ( $dt->WorkExp ) > 0) {
					foreach ( $dt->WorkExp as $val ) {
						$titles [] = '入职时间' . $cnum;
						$titles [] = '离职时间' . $cnum;
						$titles [] = '工作单位' . $cnum;
						$titles [] = '职位' . $cnum;
						$titles [] = '离职原因' . $cnum;
						$titles [] = '证明人' . $cnum;
						$titles [] = '联系方式' . $cnum;
						$titles [] = '职责' . $cnum;
						$et = 'EntryTime' . $cnum;
						$qt = 'QuitTime' . $cnum;
						$cp = 'Company' . $cnum;
						$pi = 'Position' . $cnum;
						$ra = 'Reason' . $cnum;
						$cu = 'ContactUser' . $cnum;
						$ct = 'ContactTel' . $cnum;
						$dy = 'Duty' . $cnum;
						$fields [] = $et;
						$fields [] = $qt;
						$fields [] = $cp;
						$fields [] = $pi;
						$fields [] = $ra;
						$fields [] = $cu;
						$fields [] = $ct;
						$fields [] = $dy;
						$dt->$et = $val ['EntryTime'];
						$dt->$qt = $val ['QuitTime'];
						$dt->$cp = $val ['Company'];
						$dt->$pi = $val ['Position'];
						$dt->$ra = $val ['Reason'];
						$dt->$cu = $val ['ContactUser'];
						$dt->$ct = $val ['ContactTel'];
						$dt->$dy = $val ['Duty'];
						$cnum ++;
					}
				}
			}
			export_toexcel ( $titles, $fields, $datas );
			exit ();
		}
		$this->assign ( "title", '意向人员列表' );
		$columns = "[ //表头
				  				    {field: 'id', title: 'ID',  sort: true, fixed: 'left'}
							        ,{field: 'name', title: '姓名', sort: true}
							        ,{field: 'telnumber', title: '手机号', sort: true, }
							        ,{field: 'itname', title: '登陆名'}
							        ,{field: 'station', title: '岗位', sort: true, }
							        ,{field: 'datestr', title: '面试时间', sort: true, }
							        ,{fixed: 'right',title:'操作',width:500, align:'center', toolbar: '#barDemo'}
							      ]";
		$dataurl = '/index/index/auditmembers';
		$this->assign ( "keyword", '' );
		$this->assign ( "dataurl", $dataurl );
		$this->assign ( "columns", $columns );
		return $this->fetch ();
	}
	public function auditmembers() {
		$amodel = new Admin ();
		$user = $amodel->admincate ()->where ( 'id', Session::get ( 'admin' ) )->find ();
		$get = $this->request->param ();
		$limit = $get ['limit'] ? $get ['limit'] : 10;
		$start = $get ['page'] ? ($get ['page'] - 1) * $limit : 0;
		$where = "status = 7";
		$count = Db::name ( 'potentialmembers' )->where ( $where )->count ();
		$members = Db::name ( 'potentialmembers' )->where ( $where )->order ( 'status asc' )->limit ( $start, $limit )->select ();
		$returnmsg = array (
				"code" => 0,
				'count' => $count,
				"data" => $members 
		);
		echo json_encode ( $returnmsg );
	}
	/**
	 * 发送面试通知
	 */
	function staffcontactinfo() {
		$id = $this->request->param ( 'id' );
		if (! $id) {
			echo '请选择发送对象！';
			exit ();
		}
		$ptm = new Potentialmembers ();
		$memberinfo = $ptm->where ( "id = " . $id )->find ();
		$name = $memberinfo->name;
		$phonenumber = $memberinfo->telnumber;
		$data ['updatedby'] = Session::get ( 'admin' );
		// $contactinfo = $this->staff_model->get_staff_address(array(
		// 'itname' => $data['updatedby']
		// ));
		// $contactnum = $contactinfo->sa_code . '-' . $contactinfo->sa_tel;
		$contactnum = '888888';
		// $contactperson = $this->staff_model->get_staff_by(array(
		// 'itname' => $data['updatedby']
		// ));
		// $contactpname = $contactperson->cname;
		$contactpname = '未知';
		$link = "http://localhost/Recruit/Login/index";
		$amodel = new Admin ();
		$user = $amodel->admincate ()->where ( 'id', Session::get ( 'admin' ) )->find ();
		if (strpos ( $this->rolename, '_' ) > 0) {
			$belongto = strtoupper ( explode ( '_', $this->rolename ) [0] );
		} else {
			$belongto = '森马';
		}
		if ($belongto == '巴拉') {
			$address = "上海市××××××";
		} elseif ($belongto == '女装') {
			$address = "上海市××××××";
		} else {
			$address = "上海市××××××";
		}
		$datingtime = date ( 'Y-m-d 10:00', time () );
		$this->assign ( 'pid', $id );
		$this->assign ( 'datingtime', $datingtime );
		$this->assign ( 'address', $address );
		$this->assign ( 'contactname', $contactpname );
		$this->assign ( 'contactphone', $contactnum );
		$this->assign ( 'employeename', $name );
		$this->assign ( 'employeephone', $phonenumber );
		return $this->fetch ();
	}
	function resumeprint() {
		$telnumber = $this->request->param ( 'telnumber' );
		if (! $telnumber) {
			echo 'error!';
			exit ();
		}
		$content = Db::name ( 'recruit' )->where ( array (
				'Telephone' => $telnumber 
		) )->find ();
		if ($content) {
			$content ['FamilyInfo'] = $content ['FamilyInfo'] ? unserialize ( $content ['FamilyInfo'] ) : null;
			$content ['FriendInfo'] = $content ['FriendInfo'] ? unserialize ( $content ['FriendInfo'] ) : null;
			$content ['Education'] = $content ['Education'] ? unserialize ( $content ['Education'] ) : null;
			$content ['WorkExp'] = $content ['WorkExp'] ? unserialize ( $content ['WorkExp'] ) : null;
		}
		$this->assign ( 'basicinfo', $content );
		$finfo ['UName'] = '';
		$finfo ['UShip'] = '';
		$finfo ['UCompany'] = '';
		$rinfo ['FName'] = '';
		$rinfo ['FShip'] = '';
		$einfo ['StartTime'] = '';
		$einfo ['EndTime'] = '';
		$einfo ['SchoolName'] = '';
		$einfo ['Major'] = '';
		$einfo ['IsDiploma'] = '';
		$einfo ['EduRecord'] = '';
		$winfo ['EntryTime'] = '';
		$winfo ['QuitTime'] = '';
		$winfo ['Company'] = '';
		$winfo ['Position'] = '';
		$winfo ['Reason'] = '';
		$winfo ['ContactUser'] = '';
		$winfo ['ContactTel'] = '';
		$this->assign ( 'fmember1', $content ['FamilyInfo'] ? $content ['FamilyInfo'] [0] : $finfo );
		$this->assign ( 'fmember2', $content ['FamilyInfo'] && count ( $content ['FamilyInfo'] ) > 1 ? $content ['FamilyInfo'] [1] : $finfo );
		$this->assign ( 'fmember3', $content ['FamilyInfo'] && count ( $content ['FamilyInfo'] ) > 2 ? $content ['FamilyInfo'] [2] : $finfo );
		$this->assign ( 'fmember4', $content ['FamilyInfo'] && count ( $content ['FamilyInfo'] ) > 3 ? $content ['FamilyInfo'] [3] : $finfo );
		$this->assign ( 'frmember1', $content ['FriendInfo'] ? $content ['FriendInfo'] [0] : $rinfo );
		$this->assign ( 'frmember2', $content ['FriendInfo'] && count ( $content ['FriendInfo'] ) > 1 ? $content ['FriendInfo'] [1] : $rinfo );
		$this->assign ( 'eduinfo1', $content ['Education'] ? $content ['Education'] [0] : $einfo );
		$this->assign ( 'eduinfo2', $content ['Education'] && count ( $content ['Education'] ) > 1 ? $content ['Education'] [1] : $einfo );
		$this->assign ( 'eduinfo3', $content ['Education'] && count ( $content ['Education'] ) > 2 ? $content ['Education'] [2] : $einfo );
		$this->assign ( 'workexp1', $content ['WorkExp'] ? $content ['WorkExp'] [0] : $winfo );
		$this->assign ( 'workexp2', $content ['WorkExp'] && count ( $content ['WorkExp'] ) > 1 ? $content ['WorkExp'] [1] : $winfo );
		$this->assign ( 'workexp3', $content ['WorkExp'] && count ( $content ['WorkExp'] ) > 2 ? $content ['WorkExp'] [2] : $winfo );
		$this->assign ( 'workexp4', $content ['WorkExp'] && count ( $content ['WorkExp'] ) > 3 ? $content ['WorkExp'] [3] : $winfo );
		$this->assign ( 'workexp5', $content ['WorkExp'] && count ( $content ['WorkExp'] ) > 4 ? $content ['WorkExp'] [4] : $winfo );
		return $this->fetch ();
	}
	
	/**
	 * 添加意向人员
	 */
	function addmembertopotential() {
		$id = $this->request->param ( 'id' );
		if (! $id) {
			echo 'error!';
			exit ();
		} else {
			$pinfo = Db::name ( 'recruit' )->where ( array('id'=>$id) )->find ();
			if ($pinfo) {
				$data ['name'] = $pinfo ['CName'];
				$data ['telnumber'] = $pinfo ['Telephone'];
				$data ['status'] = 6;
				if ($pinfo ['Station']) {
					$station = Db::name ( 'station' )->where ( 'id = ' . $pinfo ['Station'] )->find ();
					$data ['station'] = $station ['name'];
				} else {
					$data ['station'] = '未知';
				}
				$data ['createdby'] = Session::get ( 'admin' );
				$ptm = new Potentialmembers ();
				$ptm->save ( $data );
				$recruit = new Recruit ();
				$where ['id'] = $id;
				$recruit->updateRecruit ( array ('Status' => 2) ,$where);
			}
		}
		echo 'ok';
	}
	
	/**
	 * Offer提醒
	 */
	function checkoffer() {
		$api = new Api ();
		$telnumber = $this->request->param ( 'telnumber' );
		$recruit = new Recruit ();
		$pinfo = $recruit->where ( 'Telephone', $telnumber )->find ();
		if ($pinfo) {
			$msg = $pinfo->CName . '您好,您的offer已经发送至您' . $pinfo->Email . '的邮箱,请注意查收!并打开以下地址及时上传相关资料,报到时请携带证件原件。谢谢！http://hr.semirapp.com/index.php/Recruit/Login/index';
			// $info = send_sms($msg,$telnumber);
			$info = 'result=0';
			$result = $api->checksmsinfo ( $info, 'offer提醒', $msg, $telnumber, '' );
			if ($result ['errormessage']) {
				echo $result ['errormessage'];
			} else {
				echo 1;
				// 更新状态
				$recruit->update ( array (
						'Status' => 3 
				), $where ['telephone'] = $telnumber );
			}
		}
	}
	
	/**
	 * 附件下载
	 */
	function attdownload() {
		$telnumber = $this->request->param ( 'telnumber' );
		$recruit = new Recruit ();
		$pinfo = $recruit->where ( 'Telephone', $telnumber )->find ();
		if ($pinfo && $pinfo->Files) {
			echo site_url . '/Recruit/Api/downfiles/?telephone=' . $telnumber;
		} else {
			echo 0;
		}
	}
	
	/**
	 * 人员加入预入职
	 */
	function memberprejoin() {
		$id = $this->request->param ( 'id' );
		$ptm = new Potentialmembers ();
		$data = array (
				'status' => 7 
		); // 加入待审列表
		$staff = $ptm->update ( $data, array (
		    'id' => $id
		) );
		if ($staff) {
			return true;
		} else {
			return '添加失败，请稍后重试！';
		}
	}
	
	/**
	 * 编辑意向人员
	 */
	function potentialmembersmodify() {
		$telnumber = $this->request->param ( 'telnumber' );
		$ptm = new Potentialmembers ();
		$pinfo = $ptm->where ( array (
				'telnumber' => $telnumber 
		) )->find ();
		$this->assign ( 'menuUrl', array (
				'staff',
				'index' 
		) );
		$this->assign ( "staff", $pinfo );
		return $this->fetch ();
	}
	
	/**
	 * 确认修改意向人员
	 */
	function potentialmembersmodifycomplete() {
		$ptm = new Potentialmembers ();
		$data ['name'] = $this->request->param ( 'surname' );
		$data ['telnumber'] = $this->request->param ( 'telnumber' );
		$data ['station'] = $this->request->param ( 'station' );
		$result = $ptm->update ( $data, array (
				'telnumber' => $data ['telnumber'] 
		) );
		if ($result) {
			$this->success ( '修改成功', 'potentialmemberlist', '', 1 );
		} else {
			$this->error ( '修改失败', 'potentialmemberlist', '', 1 );
		}
	}
	/**
	 * 编辑岗位
	 */
	function stationmodification() {
		$id = $this->request->param ( 'id' );
		$station = new Station ();
		$sinfo = $station->where ( array (
				'id' => $id 
		) )->find ();
		$this->assign ( 'menuUrl', array (
				'staff',
				'index' 
		) );
		$this->assign ( "station", $sinfo );
		return $this->fetch ();
	}
	
	/**
	 * 确认修改岗位
	 */
	function stationmodificationcomplete() {
		$station = new Station ();
		$data ['id']  = $this->request->param('id');
		$data ['name'] = $this->request->param ( 'name' );
		$data ['belongto'] = $this->request->param ( 'type' );
		$result = $station->update ( $data, array (
				'id' => $data ['id'] 
		) );
		if ($result) {
			$this->success ( '修改成功', 'stationlist', '', 1 );
		} else {
			$this->error ( '修改失败', 'stationlist', '', 1 );
		}
	}
	
	/**
	 * 删除应聘者
	 */
	function delapplicant() {
		$recruit = new  Recruit();
		$id = $this->request->param ( 'id' );
		$data ['Status'] = 3;
		$result = $recruit->update ( $data, array (
				'Id' => $id 
		) );
		if ($result) {
			echo 1;
		} else {
			echo 0;
		}
	}
	/**
	 * 删除岗位
	 */
	function delstation() {
		$station = new Station ();
		$id = $this->request->param ( 'id' );
		$data ['status'] = 2;
		$result = $station->update ( $data, array (
				'id' => $id 
		) );
		if ($result) {
			echo 1;
		} else {
			echo 0;
		}
	}
	
	/**
	 * 删除意向人员记录
	 */
	function delpotentialmember() {
		$ptm = new Potentialmembers ();
		$telnumber = $this->request->param ( 'telnumber' );
		$data ['status'] = 3;
		$result = $ptm->update ( $data, array (
				'telnumber' => $telnumber 
		) );
		if ($result) {
			$this->success ( '修改成功', 'potentialmemberlist', '', 1 );
		} else {
			$this->error ( '修改失败', 'potentialmemberlist', '', 1 );
		}
	}
	
	/**
	 * 新增意向人员
	 */
	function potentialmembers_add() {
		if (strpos ( $this->rolename, '_' ) > 0) {
			$rarray = explode ( "_", $this->rolename );
			$company = $rarray [0];
		} else {
			$company = '股份';
		}
		// $target_role = $company.'_人资';
		// $target_role1 = $company.'_入职专员';
		// $queryrole = $this->db->query("SELECT username from users where role_id in (select id from user_roles where name in ('{$target_role}','{$target_role1}'))");
		// $usernamelist = $queryrole->result();
		// $condition = array("createdby"=>$username);
		// if($usernamelist){
		// $userlist = "'$username'";
		// foreach ($usernamelist as $val){
		// $userlist .= ",'".$val->username."'";
		// }
		// $condition = "createdby in ($userlist)";
		// }
		$station = new Station ();
		$stations = $station->where ( [ ] )->select ();
		$this->assign ( "stations", $stations );
		return $this->fetch ();
	}
	
	/**
	 * 意向人员新增确认
	 */
	function potentialmembers_add_do() {
		$post = $this->request->post ();
		$data ['name'] = trim ( ($post ['name']) );
		$data ['telnumber'] = $post ['telnumber'];
		$data ['station'] = $post ['station'];
		// if ($data['station'] == 1) {
		// $data['station'] = $this->input->post('station1');
		// if (strpos($this->rolename, '_') > 0) {
		// $data_station['belongto'] = strtoupper(explode('_', $this->rolename)[0]);
		// } else {
		// $data_station['belongto'] = '股份';
		// }
		// $station = $this->staff_model->get_stationby(array(
		// "name" => $data['station'],
		// "belongto" => $data_station['belongto']
		// ));
		// if (! $station) {
		// $data_station['name'] = $data['station'];
		// $data_station['createdby'] = $username;
		// $data_station['createdtime'] = date('y-m-d H:i:s');
		// $this->staff_model->stationlist_add($data_station);
		// }
		// }
		$data ['status'] = 2;
		$data ['createdby'] = Session::get ( 'admin' );
		$ptm = new Potentialmembers ();
		$ptm->save ( $data );
		$this->success ( '修改成功', 'potentialmemberlist', '', 1 );
	}
	/**
	 * 获取用户名
	 */
	function logname() {
		require_once 'pingyin.php';
		$id = $this->request->param ( 'id' );
		$ptm = new Potentialmembers ();
		$pst = new Staff ();
		$pinfo = $ptm->where ( array (
				'id' => $id 
		) )->find ();
		$itname = C_P ( $pinfo->name );
		$currentname = $itname;
		$num = 1;
		$flag = 100;
		while ( $flag ) {
			$flag --;
			$row = $pst->where ( "itname = '" . $itname . "'" )->find ();
			if ($row) {
				$itname = $currentname . '0' . $num;
				$num ++;
			} else {
				$flag = 0;
			}
		}
		echo $itname;
	}
	
	/**
	 * 确认登录名
	 */
	function confirm_logname() {
		$logonname = $this->request->param ( 'logname' );
		$id = $this->request->param ( 'id' );
		$staff = new Staff ();
		$row = $staff->where ( "itname = '" . $logonname . "'" )->find ();
		if ($row) {
			echo 1;
		} else {
			$ptm = new Potentialmembers ();
			$data = array (
					'itname' => $logonname 
			);
			$where ['id'] = $id;
			$msg = $ptm->update ( $data, $where );
			echo 0;
		}
	}
	
	/**
	 * 人员入职
	 */
	function prejoin() {
		$ptm = new Potentialmembers ();
		$staff = $ptm->where ( array (
				'id' => $this->request->param ( 'id' ) 
		) )->find ();
		$this->assign ( 'data', $staff );
		return $this->fetch ();
	}
	
	function prejoinconfirm() {
		$ptm = new Potentialmembers ();
		$post = $this->request->post();
		$staff = new Staff ();
		$data ['cname'] = $post ['name'];
		$data ['itname'] = trim($post['itname' ]);
		$data ['jobnumber'] = trim($post['jobnumber' ]);
		$data ['mobtel'] = trim($post['telnumber' ]);
		$data ['station'] = trim($post['station' ]);
		$data ['gender'] = key_exists('gender', $post) ?  trim($post['gender' ]) : '';
		$data ['enabled'] = 1;
		$c_j = $staff ->where ( "jobnumber = '" . $data ['jobnumber'] . "'  or itname='" . $data ['itname'] . "'" )->find();
		if ($c_j) {
			$this->error ( '该工号人员已经入职，请勿重复操作！', 'auditmemberlist', '', 2 );
		}
		$ptm->update( array('gender'=> $data ['gender'],'status'=>11),array('itname'=>$data ['itname']));
		$message = $staff->save($data);
		$this->success ( '提交成功', 'auditmemberlist', '', 1 );
	}
	
	function prejoinstafflist(){
		$this->assign ( "title", '预入职人员列表' );
		$columns = "[ //表头
							        {field: 'id', title: 'ID', sort: true, fixed: 'left'}
							        ,{field: 'cname', title: '姓名', sort: true}
							        ,{field: 'itname', title: '登录名'}
							        ,{field: 'mobtel', title: '手机号', sort: true, }
							        ,{field: 'station', title: '岗位', sort: true, }
							        ,{field: 'jobnumber', title: '工号', sort: true, }
							        ,{fixed: 'right',title:'操作',width:500, align:'center', toolbar: '#barDemo'}
							      ]";
		$dataurl = '/index/index/prejoinstaffs';
		$this->assign ( "keyword", '' );
		$this->assign ( "dataurl", $dataurl );
		$this->assign ( "columns", $columns );
		return $this->fetch ();
	}
	
	public function prejoinstaffs() {
		$get = $this->request->param ();
		$limit = $get ['limit'] ? $get ['limit'] : 10;
		$start = $get ['page'] ? ($get ['page'] - 1) * $limit : 0;
// 		$where = "status = 11 ";
		$where = "";
		$count = Db::name ( 'staff' )->where ( $where )->count ();
		$members = Db::name ( 'staff' )->where ( $where )->order ( 'id desc' )->limit ( $start, $limit )->select ();
		$returnmsg = array (
				"code" => 0,
				"count" => $count,
				"data" => $members
		);
		echo json_encode ( $returnmsg );
	}
	
	public function staffjoin(){
	    $id = $this->request->param ( 'id' );
	    if (! $id) {
	        $this->error('处理错误,为选择操作对象！','','',2);
	    }
	    $staff = new Staff();
	    $staff = $staff->where ( array (
	        'id' => $id
	    ) )->find ();
	    $this->assign("staff",$staff);
	    return $this->fetch();
	}
	
	function staffjoinconfirm() {
	    $id = $this->request->param ( 'id' );
	    $cardno = $this->request->param ( 'cardno' );
        $this->success('人员入职成功！','prejoinstafflist','',2);
	}
}
