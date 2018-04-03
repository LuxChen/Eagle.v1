  <div class="staffadd pad5 " style="  ">
    <!--begin form -->
          <div  style="font-size:15px;color:gray;">基本信息</div>
    <div class=" fleft">
          <div class="formLine  clearb" ></div>
          <div  class="formLabt">姓名：</div>
          <div  class="formLabi">
            <input name="name" class="inputText" type="text" id="name"   size="12" maxlength="22" value="" />
            (中文) </div>
         <div class="h10 clearb"> </div>
         <div  class="formLabt">手机号：</div>
        <div  class="formLabi">
         	<input name="telnumber" id="telnumber"  class="inputText" type="text" value=""    size="12" maxlength="12"  />
        </div>
         <div  class="formLabt">岗位：</div>
        <div  class="formLabi" id="sta">
        	<select id = "station"  name = "station">
        		<option   value="0">请选择...</option>
		      {%foreach from=$stations item=row%}
        		<option   value="{%$row->name%}">{%$row->name%}</option>
        	   {%/foreach%}
        		<option   value="1">自定义</option>
        	</select>       	 
        	<input name="station1"   id="station1" hidden="hidden" class="inputText" type="text" value=""    size="12" maxlength="12"  >
        </div>
          <div class="formLine clearb " ></div>
          <div  class="formLab">&nbsp;</div>
          <div class="formcontrol" style="margin-left:35%">
            <input name="addcomplete" class="buttom" type="button" value="提交完成" onclick="checkstationname();return false;"/>
            &nbsp;&nbsp;
            <input type="button" onclick=" " class="a_close buttom" value="放弃" />
          </div>
      
    </div>
    <div class=" clearb"> </div>
    </div>
    <!--end form --> 
   <script>
    	$(document).on("blur",'#station1',function(){ 
      	  var txt = $(this).val();
    	  $('input[name="station1"]').val(txt);
    	});
    	$(document).on("blur",'#name',function(){ 
      	  var txt = $(this).val();
    	  if(txt.indexOf(" ")>0){
    		  alert('姓名不能包含空格,已自动删除！');
    	 }
      	  txt = txt.replace(/\s/g, "");
    	  $('input[name="name"]').val(txt);
    	});
    	$(document).on("blur",'#telnumber',function(){ 
      	  var txt = $(this).val();
    	  $('input[name="telnumber"]').val(txt);
    	});
    	$(document).on("change",'select#station',function(){ 
    	  var txt = $(this).val();
    	  $('select[name="station"]').val(txt);
		      if(txt == 1){
		    	   doreplace();
		      }
		      else{
		    	  $('select[name="station"]').css("width","auto");
		    	  $('input[name="station1"]').hide();
		      }
	      });
	    function doreplace(){
	    		$('select[name="station"]').css("width","70px");
	    		$('input[name="station1"]').show();
	     }
	    function checkstationname(){
	    	  var txt = $('select[name="station"]').val();
	    	  var name = $('input[name="name"]').val();
	    	  var telnumber = $('input[name="telnumber"]').val();
	    	  var station = $('input[name="station1"]').val();
		      if(name == ''){
		    	 alert("请填写姓名！");
		    	 return false;
		      }
		      if(telnumber == ''){
		    	 alert("请填写手机号码！");
		    	 return false;
		      }
		      if(txt == 1 || txt == 0){
		    	  if(station == ''){
		    		  alert("请填写岗位名称！");
		    		  return false;
		    	  }
		      }
	        $('form').submit();
	    }
</script>
 