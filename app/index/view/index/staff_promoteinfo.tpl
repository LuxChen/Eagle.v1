{%include file="../header.tpl"%} 
<script type="text/javascript">
    // JavaScript Document
 $(document).ready(function(){
	   $('[fs]').inputDefault();
	 $("#treeTable").treeTable();
		$("table#treeTable tbody tr:odd").addClass('even');
		$("table#treeTable tbody tr").mousedown(function() {
		  $("tr.selected").removeClass("selected"); // Deselect currently selected rows
		  $(this).addClass("selected");
		});
         
        $('table#treeTable tbody tr').hover(
			function () {
				$(this).addClass("hover");
				  var tds = $(this).find('td');
				  //alert();
				  $(this).children("td").children(".funShow").css("display","block");
				   //$(this).children("td").children("div").css("display","block");
			},
			function () {
				$(this).removeClass("hover");
				 
				 $(this).children("td").children(".funShow").css("display","none");
			}
		);

	
	 $("button[name='page']").bind("click",function(){
					var url = $(this).val();
					if(url!='undefined'){
						window.location=url;
						 
					}
				});
	
 });
    //]]>
   
</script>
<div id="showLayout" style="display:none;">
</div>
   <div class="fright " style="background:#F7F7F7; ">
   <!-- {%if ($sysPermission["staff_sms_chuku"] == 1)%} {%/if%}-->
     </div>
  <form action="" method="post">
  <div  class="pageTitleTop">用户管理 &raquo; 调岗人员信息 
  <button name="searchBut" type="submit" class="searchTopbuttom fright" value=""  > </button> <input name="keyword"  id="searchText" class="searchTopinput fright" type="text" value="{%$keyword%}"placeholder="搜索姓名/登录名"/>
  </div>
  </form>
      <div class="clearb"></div>
  <div id="showLayout" style="display:none;"></div>
  <div id="staffshow">
  <div id = "statistics">
  <h2 style="float:left;;">调岗人员列表</h2>
  
  </div>
  	<table  class="treeTable" id="treeTable">
      <thead>
        <tr>
          <th>姓名</th>
          <th>资产信息</th>
<!--           <th>工号</th> -->
<!--           <th>调动前部门主管 </th> -->
          <th>调动前事业部 </th>
          <th>调动前系统/中心 </th>
          <th>调动前部门</th>
          <th>调动前科室</th>
          <th>调动前职务 </th>
          <th>调动前职务级别 </th>
          <th>调动前工作地</th>
          <th>调动前审批权限</th>
<!--           <th>调动后部门主管 </th> -->
          <th>调动后事业部 </th>
          <th>调动后系统/中心 </th>
          <th>调动后部门</th>
          <th>调动后科室</th>
          <th>调动后职务 </th>
          <th>调动后职务级别 </th>
          <th>调动后工作地</th>
          <th>调动后审批权限</th>
<!--            <th>登记日期</th> -->
<!--            <th>生效日期</th> -->
        </tr>
      </thead>
      <tbody>
      {%if ($data)%}
      {%foreach from=$data item=row%}
      <tr>
        <td>{%$row->name%} </td>
<!--         <td>{%$row->cardnumber%}</td>  -->
<!--         <td>{%$row->scharger%}</td>  -->
        <td><a href="#" data-toggle="tooltip" title="{%$row->pinfo%}">{%mb_substr($row->pinfo,0,10)%}</a></td> 
        <td>{%$row->scompany%}</td> 
        <td>{%$row->scenter%}</td> 
        <td>{%$row->sdept%}</td> 
        <td>{%$row->soffice%}</td> 
        <td>{%$row->sduty%}</td> 
        <td>{%$row->sdtype%}</td> 
        <td>{%$row->saddress%}</td> 
        <td>{%$row->sauth%}</td> 
<!--         <td>{%$row->echarger%}</td>  -->
        <td>{%$row->ecompany%}</td> 
        <td>{%$row->ecenter%}</td> 
        <td>{%$row->edept%}</td> 
        <td>{%$row->eoffice%}</td> 
        <td>{%$row->eduty%}</td> 
        <td>{%$row->edtype%}</td> 
        <td>{%$row->eaddress%}</td> 
        <td>{%$row->eauth%}</td> 
<!--         <td>{%$row->regdate%}</td>  -->
<!--         <td>{%$row->validdate%}</td>  -->
        </tr>
        {%/foreach%}
        {%/if%}
        </tbody>
    </table>
  <div class="pageNav">{%$links%}</div>
  </div>
{%include file="../foot.tpl"%}