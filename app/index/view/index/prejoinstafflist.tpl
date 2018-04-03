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
		 
		$('button[name="join"]').bind("click", function(){
			$id = $(this).val();
			$tj = $(this).attr('tj');
			$tn = $(this).attr('tn');
		    $("#personid").val($id);
		    $("#pname").val($tn);
		    $("#jobnumber").val($tj);
	    	$('#popup_container0').show();
			$("#cbtn").attr("onclick", "confirminfo();"); 
		    $("#cbtn").css("background","#069"); 
		}
	);
		$('button[name="del"]').bind("click", function(){
				$this = $(this).val();
				hiConfirm('确认删除此用户？',null,function(tp){
					if(tp){
						$.ajax({
							type: "POST",
							url: "{%site_url('staff/staff/staffjoinreject')%}",
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
               url: "{%site_url('staff/staff/prejoinstaffmodify')%}/" + $(this).val(),
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
						firstname:{required: true,maxlength: 20},
						email:{required: true,minlength: 2} //,checkname:''
		            },
		            messages: {
		                surname:{required: "用户姓必填",minlength: "最多20个字符"},
						firstname:{required: "用户名必填",minlength: "最多20个字符"},
						email:{required: " 请输入Email地址",minlength: "至少2个字符",checkname:'此email已经存在'}
		            },
					submitHandler : function(){
								   //表单的处理
								   var post_data = $("#hiAlertform").serializeArray();
								   url = "{%site_url('staff/staff/prejoinstaffmodifycomplete')%}";
								   hiClose();
								   $.ajax({
										 type: "POST",
											url: url,
											async:false,
											data:post_data,
											success: function(msg){
												if (msg == 1 || msg == 2){
													 jSuccess("操作成功"+msg+"! 正在刷新页面...",{
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
											},
											error:function(){
												alert('ajax调用错误');
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
		 //// 附件下载
		$("button[name='attdownload']").bind("click",function(){
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
    });
    //]]>
	function confirminfo(){
		personId =  $("#personid").val();			
		cardno =  $("#cardno").val();		
// 		if(cardno == ""){
// 		    alert("请录入卡号！");	
// 			return false;
// 		}
		$("#cbtn").attr("onclick", "null"); 
	    $("#cbtn").css("background","gray"); 
	    $("#notemsg").show(); 
		$.ajax({
			type: "POST",
			url: "{%site_url('staff/staff/staffjoinconfirm')%}",
			data: "id="+personId+"&cardno="+cardno,
			success: function(msg){
				var reg=new RegExp("^1");
				if(reg.test(msg)){
					hiOverAlert("人员入职成功！"+msg.substring(1));
					setInterval(function(){window.location.reload();},1000);
				}else{
					hiAlert(msg);
// 					setInterval(function(){window.location.reload();},2000);
				}
			}
		});
	}
	
	function closed(){
    	$('#popup_container0').hide();
	}
	/////////////////////////////////////////
    $("body").keydown(function(event) {
        if (event.keyCode == "13") {//keyCode=13是回车键
           $('button[name="searchBut"]').click();
        }
    });
</script>
<style>
.expdata{font-size:14px;padding:2px 5px;background-color:#069; color:white;border:none;margin-left:8px;}
</style>
<div id="showLayout" style="display:none;"></div>
<div class="pad10">
<!--     <div class="fright searchTop"><input name="adOudn" id="adOudn" type="hidden" /><input name="searchText"  id="searchText" class="searchTopinput fleft" type="text"/><input name="searchBut" type="button" class="searchTopbuttom fleft" value=""  /></div> -->
  <form action="" method="post">
  <div  class="pageTitleTop">用户管理 &raquo; 预入职人员列表
   <button name ="exportdata"  type="submit"  value="1" class="expdata fright" onmouseover="this.style.background='black';"  onmouseout="this.style.background='#069'">导出Excel</button>
  <button name="searchBut" type="submit" class="searchTopbuttom fright" value=""  > </button> <input name="keyword"  id="searchText" class="searchTopinput fright" type="text" value="{%$keyword%}"placeholder="搜索姓名/账号/岗位"/>
  <select class="searchTopinput fright"  name="accounttype" style="margin-right:10px;">
		<option value="0">选择用户状态...</option>
		<option value="1" {%if ($status ==1)%}selected{%/if%}>预入职</option>
		<option value="2" {%if ($status ==2)%}selected{%/if%}>已入职</option>
 </select>
  </div>
  </form>
  <div id="staffshow" >
      <div class="pageNav">{%$links%}</div>
    <table  class="treeTable" id="treeTable">
      <thead>
        <tr>
         <!-- <th width="40"><input id="all_check" type="checkbox"/></th>-->
          <th>姓名</th> 
          <th>登录帐号</th>
          <th>手机号</th>
          <th>工号</th>
          <th>工作地</th>
           <th>岗位</th>
          <th>部门</th>
         
          <th>用户状态</th>
          <th>操作</th>
        </tr>
      </thead>
      <tbody>
      
      {%if ($data)%}
      {%foreach from=$data item=row%}
  	  <tr id="{%$row->id%}">
       <!-- <td><input class="all_check" type="checkbox" name="staff_id" value="{%$row->id%}"/></td>-->
        <td>{%$row->cname%}</td>
         <td>{%$row->itname%}</td>
         <td>{%$row->mobtel%}</td>
         <td>{%$row->jobnumber%}</td>
         <td>{%$row->location%}</td>
 <td>{%$row->station%} 
          </td>
        <td><span title="{%$row->deptOu%}">{%$row->deptname%}</span> 
         
        <td> 
             {%if ($row->status == 0)%}预入职{%else%} 已入职 {%/if%}
         </td>
        <td>
		      <button class="button" onclick="javascript:window.open('/index.php/staff/staff/resumeprint/{%$row->id%}')" name="previewprint" type="button" 
              {%if ($row->pe == 1)%}
     		  style="margin-right:10px; "
   			   {%else%}
		       style="margin-right:10px; background:gray""
  		      {%/if%}
		       >简历预览</button>
        	 <button class="button"   to="{%$row->name%}"  name="attdownload" type="button" value="{%$row->mobtel%}" style="margin-right:10px;">附件下载</button>
          	  {%if ($row->status == 0)%}
          	<button class="button"  name="join" type="button" value="{%$row->id%}"  tn = "{%$row->cname%}"  tj = "{%$row->jobnumber%}" style="margin-right:10px;">欢迎入职</button>
          	<button class="button"  name="editinfo" type="button" value="{%$row->staffid%}" style="margin-right:10px;">编辑</button>
          	  {%/if%}
           <button class="buttonOt"  name="del" type="button" value="{%$row->id%}">删除</button>
          </td>
      </tr>
      {%/foreach%}
      
      {%else%}
      <tr>
        <td colspan="9">暂无记录！</td>
      </tr>
      {%/if%}
        </tbody>
      
    </table>
	  <div class="pageNav">{%$links%}</div>
  </div>
</div>
<style>
.pop0 {position: absolute; z-index: 99998; top: 0px; left: 0px; width: 100%; display:none; background: rgb(0, 0, 0) none repeat scroll 0% 0%; opacity: 0.5;}
#popup_title0{
font-size: 12px;
font-weight: bold;
text-align: left;
line-height: 1.9em;
color: #FFF;
background: #318E2B;
padding: 0 0 0 8px;
margin: 0em;
}
#popup_close0{
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
#popup_container0{
font-family: Verdana, Geneva, sans-serif;
font-size: 12px;
min-width: 300px;
_width: 320px;
max-width: 600px;
background: #fff;
border: solid 4px #666;
color: #000;
}
#popup_container0 .formLab{
width:50%;
text-align:right;
}
.header1{
font-size:15px;
color:gray;
margin-left:35%;
letter-spacing: 2px;
}
</style>
<div id="popup_container0" style="display:none;position: absolute;top:150px; left:calc(50% - 200px); z-index: 99999; padding: 0px; margin: 0;  width: 360px; height: 300px;">
		<h1 id="popup_title0" style="cursor: move;">欢迎入职</h1>
		<span id="popup_close0" onclick="closed();"></span>
		<div id="popup_content0">
  			<div id="popup_message0" style="height: 342px;">
  			  			<form method="post" id="prejoinform">
				<div>
				         <div class="header1"><h3>员工卡号录入</h3></div>
				        <div  class="formLab">人员姓名：</div>
				        <div  class="formLabi">
				         	<input name="pname" id="pname"  class="inputText" type="text" value="" size="16" maxlength="16"  readonly="readonly" style="background:lightgray;"/>
				          	<span id="pname" style="color:red; display:none;"></span>
				        </div>
				         <div class="h10 clearb"> </div>
				        <div  class="formLab">工号：</div>
				        <div  class="formLabi">
				         	<input name="jobnumber" type="text"  class="inputText" id="jobnumber" value="" size="16" maxlength="16"  readonly="readonly" style="background:lightgray;"/>
				        </div>
				         <div class="h10 clearb"> </div>
				        <div  class="formLab">卡号：</div>
				        <div  class="formLabi">
				         	<input name="cardno" type="text"  class="inputText" id="cardno" value="" size="16" maxlength="16" />
				        </div>
				           <input name="personid"  id = "personid" value=""  hidden="hidden"/>
				</div>
				</form>
				<div style="margin:50px 130px 0 130px;"><a id= "cbtn" class="buttom"   onclick="confirminfo();">确定</a><a class="buttom" onclick="closed();" style="margin-left:18px;">取消</a></div>
				<div style="margin:20px; display:none;" id="notemsg" ><span style="color:red;">请求已提交,程序处理中...完成后,页面将自动刷新,请等待！</span></div>
  		    </div>
  		</div>
</div>	
