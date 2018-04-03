{%include file="../header.tpl"%} 
<link rel="stylesheet" href="{%base_url()%}assets/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">
<script type="text/javascript" src="{%base_url()%}assets/ztree/js/jquery.ztree.core.js"></script>
<script type="text/javascript" src="{%base_url()%}assets/ztree/js/jquery.ztree.excheck.js"></script> 
 
<script type="text/javascript">
    //<![CDATA[
    $(document).ready(function(){
		$("#treeTable").treeTable();
		$("table#treeTable tbody tr:odd").addClass('even');
		$("table#treeTable tbody tr").mousedown(function() {
		  $("tr.selected").removeClass("selected"); // Deselect currently selected rows
		  $(this).addClass("selected");
		});
         
        $('table#treeTable tbody tr').hover(
			function () {
				$(this).addClass("hover");
			},
			function () {
				$(this).removeClass("hover");
			}
		);
		 
		$('button[name="join"]').bind("click", function(){
			$this = $(this).val();
			name = $(this).attr('to');
			date = new Date();
			dy = date.getFullYear();
			dm = date.getMonth()+1;
			dd = date.getDate();
			datestr = dy+"-"+dm+"-"+dd+" 10:00";
			hiPrompt('确认通知 '+name+' 来面试吗？面试时间为：',datestr,'面试确认',function(r){ 
					  if(r) {
							$.ajax({
								type: "POST",
								url: "{%site_url('staff/staff/sendnotification')%}",
								data: "id="+$this+"&datestr="+r,
								success: function(msg){
									//alert(msg);
									if(msg==1){
								    	hiOverAlert('通知"'+name+'"面试成功，面试时间为：' +r);
									}else{
										hiAlert(msg);
									}
								}
									   
							});
					}}); 
		}
	);
		$('button[name="prejoin"]').bind("click", function(){
			$this = $(this).val();
			id = $(this).attr('to');
			itname = $('#'+$this).html();
			if(itname==''){
				alert("请先检查账号！");
				return false;
			}
			var deptlist=[];
			var h=$('body').height();
			$('.pop0').height(h);
			$('.pop0,#popup_container0').show();
			$.ajax({
				type: "POST",
				url: '{%site_url("staff/staff/staffprejoin")%}',
				data:"id="+id,
				cache:false,
				success: function(msg){ 
					$('#popup_message0').html(msg);
					
				},
				error:function(){
					alert("出错啦，刷新试试，如果一直出现，可以联系开发人员解决");
				}
			});
		}
	);
		
		$('button[name="del"]').bind("click", function(){
				$this = $(this).val();
				hiConfirm('确认删除此用户？',null,function(tp){
					if(tp){
						$.ajax({
							type: "POST",
							url: "{%site_url('staff/staff/delpotentialmember')%}",
							data: "id="+$this,
							success: function(msg){
								//alert(msg);
								if(msg==1){
									// $("tr#"+n).remove();
									jSuccess("操作成功! 正在刷新页面...",{
										VerticalPosition : 'center',
										HorizontalPosition : 'center',
										TimeShown : 1000,
									});
// 									key = $('input[name="searchText"]').val();
// 									val = $('input[name="rootid"]').val();
// 									loadstaff(val,key)
									setInterval(function(){window.location.reload();},1000);
// 									window.location = "{site_url('staff/') ?>";
										
								}else{
									hiAlert(msg);
								}
							}
								   
						});
						return false;
							
					}
				});
			}
		);
		
		$('button[name="editinfo"]').bind("click",function(){
            $.ajax({
               type: "POST",
               url: "{%site_url('staff/staff/potentialmembersmodify')%}/" + $(this).val(),
               success:function(msg){
                   //alert(msg);
                   if(msg=="0"){
                       // $("tr#"+n).remove();
                       jError("操作成功! 正在刷新页面...",{
							VerticalPosition : 'center',
							HorizontalPosition : 'center',
							TimeShown : 2000,
						});
                     
                   }else{
                        $("#showLayout").html(msg);
						  hiBox('#showLayout','编辑用户','','','','.a_close');
						  $('#hiAlertform').bind("invalid-form.validate").validate(addjs);
                   }
               }	   
           });

           return false;
				
       }
);
		
		 var addjs = {
		            rules: {
						surname:{required: true,maxlength: 20},
						telnumber:{required: true,minlength: 3} //,checkname:''
		            },
		            messages: {
		                surname:{required: "用户姓名必填",minlength: "最多20个字符"},
		                telnumber:{required: " 请输入Email地址",minlength: "至少2个字符",checkname:'此email已经存在'}
		            },
					submitHandler : function(){
								   //表单的处理
								   var post_data = $("#hiAlertform").serializeArray();
								   url = "{%site_url('staff/staff/potentialmembersmodifycomplete')%}";
								   hiClose();
								   $.ajax({
										 type: "POST",
											url: url,
											async:false,
											data:post_data,
											success: function(msg){
												if (msg == 1 ){
													 jSuccess("操作成功! 正在刷新页面...",{
														VerticalPosition : 'center',
														HorizontalPosition : 'center',
														TimeShown : 1000
													});
													window.location.reload();
												}else{
													jError("操作失败! ",{
														VerticalPosition : 'center',
														HorizontalPosition : 'center',
														TimeShown : 1000
													});
											   }
											}
										});
								   return false;//阻止表单提交
						}
		        };
		 
		$("button[name='page']").bind("click",function(){
			var url = $(this).val();
			var key = $('input[name="keyword"]').val();
			if(url!='undefined'){
				$.post(url,{ keyword: key},function(data){
					 $('body').html(data);
				});
			}
		});
		
		 //// 登录名设置
		$("button[name='checkname']").click(function(){
			telnumber = $(this).val();
			id = $(this).attr("to");
			logrequest =$.ajax({url:"/index.php/staff/staff/get_logname/"+telnumber,async:false});
			var logname = logrequest.responseText;
			hiPrompt('可用登录名:',logname,'登录名确认',function(r){ 
				  if(r) {
						confirmrequest =$.ajax({url:"/index.php/staff/staff/confirm_logname/"+r+"/"+id,async:false});
						var con = confirmrequest.responseText;
					    if(con==1){
					    	alert('你选择的登录名“' +r+'”已被占用请修改！');
							$("button[name='checkname']").trigger('click');
					    }
					    else {
					    	hiOverAlert('供该对象使用的登陆名是“' +r+'“');
					    	$('#'+id).html(r);
					    }
				  }
				}); 
		});
		 //// 发送offer提醒
		$("button[name='checkoffer']").click(function(){
			id = $(this).val();
			name = $(this).attr('to');
			hiConfirm('确认已发送OFFER给 '+name+' 吗？',null,function(tp){
				if(tp){
							logrequest =$.ajax({url:"/index.php/staff/staff/checkoffer/"+id,async:false});
							var result = logrequest.responseText;
							if(result){
							   jSuccess("操作成功! 正在刷新页面...",{
										VerticalPosition : 'center',
										HorizontalPosition : 'center',
										TimeShown : 1000
								  });
								}
						}
					});
			});
		 //// 附件下载
		$("button[name='attdownload']").click(function(){
			telnumber = $(this).val();
			logrequest =$.ajax({url:"/index.php/staff/staff/attdownload/"+telnumber,async:false});
			var result = logrequest.responseText;
			if(result==0){
				alert('该用户还未上传相关附件，无法下载！');
			}
			else{
				window.location= result;
			}
		});
		 //// 新加 人员
		$("button[name='memberadd']").click(function(){
				$.ajax({
						type: "POST",
						url: '{%site_url("staff/staff/potentialmembers_add")%}',
						cache:false,
						data: '',
						success: function(msg){
							$("#showLayout").html(msg);  
							hiBox('#showLayout','新增意向人员',500,'','','.a_close'); 
							$('#hiAlertform').bind("invalid-form.validate").validate(formva); 
							//$("#adddept").show();   
							
						},
						error:function(){
							hiAlert("出错啦，刷新试试，如果一直出现，可以联系开发人员解决");
						}
					});
				
				 			
			});
	///
 var formva = {
            rules: {

            },
            messages: {
            },
			submitHandler : function(){
					 //表单的处理
					 var post_data = $("#hiAlertform").serializeArray();
					 url = "{%site_url('staff/staff/potentialmembers_add_do')%}";
					  
					 $.ajax({
						   type: "POST",
							  url: url,
							  async:false,
							  data:post_data,
							  success: function(msg){
								  hiClose();
								  if (msg == "ok" ){
									   jSuccess("Success, current page is being refreshed",{
										  VerticalPosition : 'center',
										  HorizontalPosition : 'center',
										  TimeShown : 1000,
									  });
										window.location.href="{%site_url('staff/staff/potentialmembers')%}";
								  }else{
									  jError("操作失败! ",{
										  VerticalPosition : 'center',
										  HorizontalPosition : 'center',
										  TimeShown : 1000,
									  });
								 }
							  }
						  });
					 return false;//阻止表单提交
				}
        };
    });
    
	 function closed(){
			$('.pop0,#popup_container0').hide();
		}
	 ///////////////////////////////////////////////
	    $("body").keydown(function(event) {
	        if (event.keyCode == "13") {//keyCode=13是回车键
	           $('button[name="searchBut"]').click();
	        }
	    });
</script>
<style>
.buttonOt{padding:1px 5px;}
.expdata{font-size:14px;padding:2px 5px;background-color:#069; color:white;border:none;margin-left:8px;}
</style>
<div id="showLayout" style="display:none;"></div>
<div class="pad10">
  <form action="" method="post">
  <div  class="pageTitleTop">用户管理 &raquo; 待入职人员列表
 <button name ="exportdata"  type="submit"  value="1" class="expdata fright" onmouseover="this.style.background='black';"  onmouseout="this.style.background='#069'">导出Excel</button>
  <button name="searchBut" type="submit" class="searchTopbuttom fright" value=""  > </button> <input name="keyword"  id="searchText" class="searchTopinput fright" type="text" value="{%$keyword%}"placeholder="搜索姓名/手机号/岗位"/>
  </div>
  </form>
  <div id="staffshow" >
      <div class="pageNav">{%$links%}</div>
    <table  class="treeTable" id="treeTable">
      <thead>
        <tr>
         <!-- <th width="40"><input id="all_check" type="checkbox"/></th>-->
          <th>姓名</th> 
          <th>登陆名</th>
<!--           <th>性别</th> -->
          <th>手机号</th>
<!--           <th>年龄</th> -->
<!--           <th>籍贯</th> -->
<!--            <th>学历</th> -->
<!--           <th>工龄</th> -->
<!--           <th>部门</th> -->
          <th>岗位</th>
          <th>状态</th>
          	   <th style="width:70mm">操作</th>
        </tr>
      </thead>
      <tbody>
      
      {%if ($data)%}
      {%foreach from=$data item=row%}
      <tr>
        <td>{%$row->name%}</td>
        <td id="{%$row->id%}">{%$row->itname%}</td>
         <td>{%$row->telnumber%}</td>
         <td>{%$row->station%}</td>
         <td>{%if ($row->status == 7)%}待入职{%else if ($row->status == 12) %}已入职{%else%}未知{%/if%}</td>
        <td>
             <button onclick="javascript:window.open('/index.php/staff/staff/testextraprint/{%$row->telnumber%}')"class="button" name="previewprint" type="button"               {%if ($row->pe == 1)%}
     		  style="margin-right:10px; "
   			   {%else%}
		       style="margin-right:10px; background:gray""
  		      {%/if%}
		       >简历预览</button>
          	<button class="button"  name="checkname" type="button" value="{%$row->telnumber%}" to ="{%$row->id%}" style="margin-right:10px;">检查账号</button>
          	<button class="button"  name="prejoin" type="button" value="{%$row->id%}"   to ="{%$row->id%}" style="margin-right:10px;">入职</button>
<!--           	<button class="button"  name="editinfo" type="button" value="{%$row->id%}" style="margin-right:10px;">编辑</button> -->
           <button class="buttonOt"  name="del" type="button" value="{%$row->id%}">删除</button>
        </td>
      </tr>
      {%/foreach%}
      
      {%else%}
      <tr>
        <td colspan="11">暂无记录！</td>
      </tr>
      {%/if%}
        </tbody>
      
    </table>
	  <div class="pageNav">{%$links%}</div>
  </div>
</div>
 <style>
.pop0 ,.pop1{position: absolute; z-index: 99998; top: 0px; left: 0px; width: 100%; display:none; background: rgb(0, 0, 0) none repeat scroll 0% 0%; opacity: 0.5;}
#popup_title0,#popup_title1{
font-size: 12px;
font-weight: bold;
text-align: left;
line-height: 1.9em;
color: #FFF;
background: #318E2B;
padding: 0 0 0 8px;
margin: 0em;
}
#popup_close0,#popup_close1{
    position: absolute;
    right: 7px;
    top: 2px;
    color: #FFF;
    font: 14px bold Arial, Helvetica, sans-serif;
    width: 16px;
    height: 16px;
    background: url(/assets/hialert/default/close.png) no-repeat;
    cursor: pointer;
}
#popup_container0,#popup_container1{
font-family: Verdana, Geneva, sans-serif;
font-size: 12px;
min-width: 300px;
_width: 320px;
max-width: 600px;
background: #fff;
border: solid 4px #666;
color: #000;
}
</style>
<div class="pop0">
		
</div>
<div id="popup_container0" style="display:none;position: absolute;top:100px; left:calc(50% - 250px); z-index: 99999; padding: 0px; margin: 0;  width: 500px; height: 400px;">
		<h1 id="popup_title0" style="cursor: move;">人员预入职</h1>
		<span id="popup_close0" onclick="closed();"></span>
		<div id="popup_content0">
  			<div id="popup_message0" style="height: 342px;">
  			</div>
  		</div>
</div>
