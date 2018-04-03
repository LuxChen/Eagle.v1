{%include file="../header.tpl"%} 
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
		 
		$('button[name="del"]').bind("click", function(){
				$this = $(this).val();
				hiConfirm('确认删除此人员吗？',null,function(tp){
					if(tp){
						$.ajax({
							type: "POST",
							url: "{%site_url('staff/staff/delpotentialmemberlist')%}",
							data: "telnumber="+$this,
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
		});

			
		$("button[name='page']").bind("click",function(){
			var url = $(this).val();
			var key = $('input[name="keyword"]').val();
			if(url!='undefined'){
				$.post(url,{ keyword: key},function(data){
					 $('body').html(data);
				});
			}
		});
		$('button[name="prefer"]').bind("click",function(){
			name = $(this).attr('to');
			telnumber =  $(this).val();
			hiConfirm('确认添加 '+name+' 为意向人员吗？',null,function(tp){
			if(tp){
	            $.ajax({
	               type: "POST",
	               url: "{%site_url('staff/staff/addmembertopotential')%}/" +telnumber,
	               success:function(msg){
	                   //alert(msg);
	                   if(msg=="ok"){
	                       // $("tr#"+n).remove();
	                       jSuccess("操作成功! 正在刷新页面...",{
								VerticalPosition : 'center',
								HorizontalPosition : 'center',
								TimeShown : 2000,
							});
							window.location.reload();
	                   }else{
	                   }
	               }	   
	           });
         	  return false;
		}		
       });});
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
                type: {required: true},
                telnumber: {required: true}
            },
            messages: {
                type:{required: "填写邮件类型",remote:"此编号已经存在"},
				sendto: {required: "填写收件人"},
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
										window.location.reload();
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
    //]]>
</script>
<div id="showLayout" style="display:none;"></div>
<div class="pad10">
<!--      <div class="fright " style="background:#F7F7F7; padding:3px 0px 4px 20px;"> -->
<!--      <button class="buttom" name="memberadd" type="button" value="">新增意向人员</button>   -->
<!--      </div> -->
  <form action="" method="post">
  <div  class="pageTitleTop">用户管理 &raquo; 拓展渠道人员列表
  <button name="searchBut" type="submit" class="searchTopbuttom fright" value=""  > </button> <input name="keyword"  id="searchText" class="searchTopinput fright" type="text" value="{%$keyword%}"placeholder="搜索姓名/手机号"/>
  </div>
  </form>

  <div id="staffshow" >
      <div class="pageNav">{%$links%}</div>
    <table  class="treeTable" id="treeTable">
      <thead>
        <tr>
         <!-- <th width="40"><input id="all_check" type="checkbox"/></th>-->
          <th>姓名</th> 
<!--           <th>性别</th> -->
          <th>手机号</th>
<!--           <th>民族</th> -->
<!--           <th>年龄</th> -->
<!--           <th>籍贯</th> -->
<!--            <th>学历</th> -->
<!--           <th>工龄</th> -->
<!--           <th>部门</th> -->
          <th>岗位</th>
<!--           <th>状态</th> -->
          <th style="width:70mm">操作</th>
        </tr>
      </thead>
      <tbody>
      
      {%if ($data)%}
      {%foreach from=$data item=row%}
      <tr id="{%$row->id%}">
       <!-- <td><input class="all_check" type="checkbox" name="staff_id" value="{%$row->id%}"/></td>-->
        <td>{%$row->CName%}</td>
<!--          <td>{%$row->Gender%}</td> -->
         <td>{%$row->Telephone%}</td>
<!--          <td>{%$row->Nation%}</td> -->
<!--          <td>{%$row->localaddress%}</td> -->
<!--  	     <td>{%$row->eg%}  -->
<!--           </td> -->
<!--          <td>{%$row->workyear%}</td> -->
<!--          <td>{%$row->dept%}</td> -->
         <td>{%$stationlist[$row->Station]%}</td>
<!--          <td>{%if ($row->status == 0)%}未通知{%else if ($row->status == 1) %}已通知{%else if ($row->status == 6) %}简历已提交{%/if%}</td> -->
         
        <td>
<!--           	<button class="button"  name="join" type="button" value="{%$row->Telephone%}-{%$row->CName%}" style="margin-right:10px;">通知面试</button> -->
<!--           	<button class="button"  name="editinfo" type="button" value="{%$row->id%}" style="margin-right:10px;">编辑</button> -->
<!--           	<button class="button"  name="checkoffer" type="button" value="{%$row->Telephone%}-{%$row->CName%}" style="margin-right:10px;">OFFER提示</button> -->
<!--           	<button class="button"  name="checkname" type="button" value="{%$row->id%}" style="margin-right:10px;">检查登陆名</button> -->
          <button onclick="javascript:window.open('/index.php/staff/staff/testextraprint/{%$row->Telephone%}')"class="button" name="previewprint" type="button"  style="margin-right:10px;">简历预览</button>
          <button class="button"  name="prefer"  to="{%$row->CName%}"  type="button" value="{%$row->Telephone%}" style="margin-right:10px;">意向人员</button>
           <button class="buttonOt"  name="del" type="button" value="{%$row->Telephone%}">删除</button>
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
 
