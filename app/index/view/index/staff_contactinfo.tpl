<script type="text/javascript">
function confirminfo(id){
	datingtime = $("#datingtime").val();
	datingplace = $("#datingplace").val();
	contactname = $("#contactname").val();
	contactphone = $("#contactphone").val();
	employeename = $("#employeename").val();
	employeephone = $("#employeephone").val();
	$.ajax({
			type: "POST",
			url: "{%site_url('staff/staff/sendnotification')%}",
			data: "id="+id+"&datingtime="+datingtime+"&datingplace="+datingplace+"&contactname="+contactname+"&contactphone="+contactphone+"&employeename="+employeename+"&employeephone="+employeephone,
			success: function(msg){
// 				alert(msg);
				if(msg==1){
			    	hiOverAlert('通知"'+employeename+'"面试成功，面试时间为：' +datingtime);
			    	closed();
				}else{
					hiAlert(msg);
				}
			}
	});
}
</script>
  			<form method="post" id="prejoinform">
				<div>
				         <div class="header1"><h3>面试通知信息确认</h3></div>
				        <div  class="formLab">面试时间：</div>
				        <div  class="formLabi">
				         	<input name="datingtime" id="datingtime"  class="inputText" type="text" value="{%$datingtime%}" size="16" maxlength="16" />
				          	<span id="checkjobnumber" style="color:red; display:none;"></span>
				        </div>
				          <div class="clearb h10"></div>
				          <div  class="formLab">面试地点：</div>
				          <div  class="formLabi">
					         	<textarea name="datingplace" id="datingplace"  class="inputText"  maxlength="70" >{%$address%}</textarea>
				          </div>
				         <div class="h10 clearb"> </div>
				        <div  class="formLab">联系人姓名：</div>
				        <div  class="formLabi">
				         	<input name="contactname" type="text"  class="inputText" id="contactname" value="{%$contactname%}" size="8" maxlength="8" />
				        </div>
				          <div class="clearb h10"></div>
				          <div  class="formLab">联系人电话：</div>
				          <div  class="formLabi">
				         	<input name="contactphone" type="text"  class="inputText" id="contactphone" value="{%$contactphone%}" size="14" maxlength="14"/>
				           </div>
				          <div class="clearb h10"></div>
				          				          <div  class="formLab">面试对象姓名：</div>
				          <div  class="formLabi">
				         	<input name="employeename" id="employeename"  class="inputText" type="text" value="{%$employeename%}" size="8" maxlength="8"  readonly="readonly" style="background:lightgray;" />
				          </div>
				          <div class="clearb h10"></div>
				          <div  class="formLab">面试对象手机号：</div>
				          <div  class="formLabi">
				         	<input name="employeephone" id="employeephone"  class="inputText" type="text" value="{%$employeephone%}" size="14" maxlength="14" readonly="readonly" style="background:lightgray;"/>
				          </div>
				</div>
				</form>
				<div style="margin:50px 180px;"><a class="buttom"   onclick="confirminfo({%$pid%});">确定</a><a class="buttom" onclick="closed();" style="margin-left:18px;">取消</a></div>
