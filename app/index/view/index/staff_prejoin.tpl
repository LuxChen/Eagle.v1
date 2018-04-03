<script type="text/javascript">
function confirmdept(){
	 //表单的处理
	 var post_data = $("#prejoinform").serializeArray();
	 url = "{%site_url('staff/staff/prejoinconfirm')%}";
	  if($('#station').val()==""){
		  alert("请填写岗位");
		  return false;
	  }
	  else if($('#jobnumber').val()==""){
		  alert("请填写工号");
		  return false;
	  }
	  else if($('input[name="dept"]').val()==""){
		  alert("请选择部门");
		  return false;
	  }
	  else if($('input[name="deptleader"]').val()==""){
		  alert("请填写主管！");
		  return false;
	  }
	  else if($("#checkjobnumber").html() != ""){
		  alert("请检查工号！");
		  return false;
	  }
	  else if($('input[name="location"]').val()==""){
		  alert("请填写工作地！");
		  return false;
	  }
    $("#sbtn").attr("onclick", "null"); 
    $("#sbtn").css("background","gray"); 
	 $.ajax({
		   type: "POST",
			  url: url,
			  async:false,
			  data:post_data,
			  success: function(msg){
// 				  if(msg){
// 					 alert(msg);
// 				  }else{
					 hiOverAlert('人员预入职成功！');
				 	 closed();
// 				  }
			  },
			error: function(XMLHttpRequest, textStatus, errorThrown) {
					  hiOverAlert('人员预入职成功！');
					  closed();
			}
		  });
}

$("#dept").click(function(){
    $("#sbtn").attr("onclick", "confirmdept();"); 
    $("#sbtn").css("background","#069"); 
	var h= '400px';
	$('.pop1').height(h);
	$('.pop1,#popup_container1').show();
	$.ajax({
		type: "POST",
		url: '{%site_url("staff/staff/prejoindetail")%}',
		cache:false,
		success: function(msg){ 
			$('#popup_message1').html(msg);
			
		},
		error:function(){
			hiAlert("出错啦，刷新试试，如果一直出现，可以联系开发人员解决");
		}
	});
});

function closed1(){
	$('.pop1,#popup_container1').hide();
}

function checkjobnumber(){
	jobnumber = $('#jobnumber').val();	
	  $.ajax({
          type: "POST",
          url: "{%site_url('staff/staff/check_jobnumber')%}",
		  async:false,
          data: "jobnumber="+jobnumber,
          success: function(msg){
				if (msg==""){   
					$('#checkjobnumber').html('');	
				}else{
					$('#checkjobnumber').html("工号已存在，请修改！");	 
					$('#checkjobnumber').show();
				}
          }
      });
}

// function autocomplete start	
$.ajax({
       type: "POST",
       url: "{%site_url('staff/staff/staffAllJasonExtra')%}",
		async:false, 
		dataType: "json",//返回json格式的数据
       success: function(msg){
			//alert(msg);
				$( "#deptleader" ).autocomplete({
					source:  msg ,
					focus: function( event, ui ) {
								$( "#deptleader" ).val( ui.item.label.split('|')[0] );
								return false;
							},
					select: function( event, ui ) {
								$( "#deptleader" ).val(ui.item.label.split('|')[0] );
							    return false;
							}
			}).data( "autocomplete" )._renderItem = function( ul, item ) {
				return $( "<li>" )
				.data( "item.autocomplete", item )
				.append( "<a>" + item.label + "<br>" + item.value + "</a>" )
				.appendTo( ul );
				};
       }
   });
</script>
<form method="post" id="prejoinform">
<div class="sidebarLeft " style="width: 95%;margin: 0 2.5%;" >
          <div class="clearb h10"></div>
          <div  class="formLab">姓名：</div>
          <div  class="formLabi">
            <input name="name" id="name"  class="inputText" type="text" value="{%$data->name%}" size="20" maxlength="60"  disabled="disabled" />
          </div>
          <div class="clearb h10"></div>
         <div  class="formLab">性别：</div>
        <div  class="formLabi">
          <input name="gender" type="radio" id="gender" value="0" checked="checked" />男&nbsp;&nbsp;&nbsp;&nbsp;
          <input name="gender" type="radio" id="gender" value="1" />女
          </div>
          <div class="clearb h10"></div>
          <div  class="formLab">手机号：</div>
          <div  class="formLabi">
            <input name="telnumber" id="telnumber"  class="inputText" type="text" value="{%$data->telnumber%}" size="20" maxlength="60"   disabled="disabled"/>
          </div>
         <div class="h10 clearb"> </div>
        <div  class="formLab">工号：</div>
        <div  class="formLabi">
         	<input name="jobnumber" id="jobnumber"  class="inputText" type="text" value="" size="20" maxlength="13"  onblur="checkjobnumber();"  />(限制长度为13位)
			<span id="checkjobnumber" style="color:red; display:none;"></span>
        </div>
          <div class="clearb h10"></div>
          <div  class="formLab">部门：</div>
          <div  class="formLabi">
            <input id="dept"  class="buttom" type="button"  value="请选择...">
            <input name="dept"  class="buttom" type="text"  value="" hidden="hidden">
          </div>
		  <div  class="formLab">部门主管：</div>
          <div  class="formLabi">
            <input id="deptleader"    class="inputText"  type="text"    placeholder = "请输入姓名" name = "deptleader" id = "deptleader" style="width:100px;">
          </div>
          <div class="clearb h10"></div>
          <div  class="formLab">岗位：</div>
          <div  class="formLabi">
            <input name="station" id="station"  class="inputText" type="text" value="{%$data->station%}" size="20" maxlength="60"    disabled="disabled" />
          </div>
         <div class="h10 clearb"> </div>
        <div  class="formLab">工作地：</div>
        <div  class="formLabi">
         	<input name="location" type="text"  class="inputText" id="location" value="" size="4" maxlength="40"  />
        </div>
		<input name="station" value="{%$data->station%}" type="text" hidden="hidden">
        <input name="name" value="{%$data->name%}" type="text" hidden="hidden">
        <input name="telnumber" value="{%$data->telnumber%}" type="text" hidden="hidden">
        <input name="itname" value="{%$data->itname%}" type="text" hidden="hidden">
        <input name="pid" value="{%$data->id%}" type="text" hidden="hidden">
</div>
</form>
<span id="sbtn"  class="buttom"  style="margin:0 4.5%;" onclick="confirmdept();">确定</span>

<div class="pop1">
		
</div>
<div id="popup_container1" style="display:none;position: absolute;top:0px; left:50%; z-index: 99999; padding: 0px; margin: 0;  width: 500px; height: 400px;background:#fff;">
		<h1 id="popup_title1" style="cursor: move;">请选择部门</h1>
		<span id="popup_close1" onclick="closed1();"></span>
		<div id="popup_content1"  class="openBox">
  			<div id="popup_message1" style="height: 342px;">
  			</div>
  		</div>
</div>