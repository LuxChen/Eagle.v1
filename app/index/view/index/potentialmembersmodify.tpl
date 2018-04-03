 
  <div class="staffadd pad5 " style="  ">
    
    <!--begin form -->
    <div class="staffformInfo fleft">
          <div class="formLine  clearb" ></div>
          <div  class="formLab">基本信息</div>
          <div  class="formLabt">姓名：</div>
          <div  class="formLabi">
            <input name="surname"  class="inputText" type="text" id="surname"   size="8" maxlength="12" value="{%$staff->name%}" />
            (中文) </div>
<!--           <div  class="formLabt">性别：</div> -->
<!--           <div  class="formLabi"> -->
<!--             <input name="gender" class="inputText" id="gender" type="text" disabled  value="{%$staff->gender%}" size="4" maxlength="4"  /> -->
<!--             </div> -->
<!--           <div class="h10 clearb"> </div> -->
<!--           <div  class="formLab">&nbsp;</div> -->
<!--         <div  class="formLabt">年龄：</div> -->
<!--         <div  class="formLabi"> -->
<!--          	<input name="age" id="age"  class="inputText" type="text" value="{%$staff->age%}" size="4" maxlength="4"  /> -->
<!--         </div> -->
<!--         <div  class="formLabt">工龄：</div> -->
<!--         <div  class="formLabi"> -->
<!--          	<input name="workyear" id="workyear"  class="inputText" type="text" value="{%$staff->workyear%}" size="4" maxlength="4"  /> -->
<!--         </div> -->
<!--         <div  class="formLabt">籍贯：</div> -->
<!--         <div  class="formLabi"> -->
<!--          	<input name="localaddress" type="text"  class="inputText" id="localaddress" value="{%$staff->localaddress%}" size="8" maxlength="8"  /> -->
<!--         </div> -->
<!--          <div class="h10 clearb"> </div> -->
<!--         <div  class="formLab">&nbsp;</div> -->
<!--         <div  class="formLabt">学历：</div> -->
<!--         <div  class="formLabi"> -->
<!--          	<input name="eg" class="inputText" id="eg" type="text" value="{%$staff->eg%}" size="12" maxlength="20"  /> -->
<!--         </div> -->
         <div  class="formLabt">手机号：</div>
        <div  class="formLabi">
         	<input name="telnumber" id="telnumber"  class="inputText" type="text" value="{%$staff->telnumber%}"    size="12" maxlength="12"  />
        </div>
         <div class="h10 clearb"> </div>
        <div  class="formLab">&nbsp;</div>
<!--         <div  class="formLabt">部门：</div> -->
<!--         <div  class="formLabi"> -->
<!--          	<input name="dept" type="text"  class="inputText" id="dept" value="{%$staff->dept%}" size="12" maxlength="12"  /> -->
<!--         </div> -->
         <div  class="formLabt">岗位：</div>
        <div  class="formLabi">
         	<input name="station" id="station"  class="inputText" type="text" value="{%$staff->station%}"    size="12" maxlength="12"  />
        </div>
          <div class="formLine clearb " ></div>
          <div  class="formLab">&nbsp;</div>
          <div class="formcontrol" style="margin-left:35%">
            <input name="id" id="id" type="hidden" value="{%$staff->id%}" />
            <input name="action" type="hidden" value="modify" />
            <input name="addcomplete" class="buttom" type="submit" value="提交完成" />
            &nbsp;&nbsp;
            <input type="button" onclick=" " class="a_close buttom" value="放弃" />
          </div>
      
    </div>
    <div class=" clearb"> </div>
    </div>
    <!--end form --> 
   
 