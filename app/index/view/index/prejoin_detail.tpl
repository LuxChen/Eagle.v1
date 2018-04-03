<script type="text/javascript">
	var setting = {
         view: {  
            selectedMulti: false        //禁止多点选中  
         },  
		data: {
			simpleData: {
				enable: true
			}
		},
		callback: {  
            onClick: function(treeId, treeNode) {  
                var treeObj = $.fn.zTree.getZTreeObj(treeNode);  
                var selectedNode = treeObj.getSelectedNodes()[0];  
	            $("input[name='dept']").val(selectedNode.id);  
	            $("#dept").val(selectedNode.name);  
                closed1();
            }  
        }  
	};
	
	$(document).ready(function(){
		$.ajax({
            type:'POST',
            url:'{%site_url("public/deptlist/deptsys_tree_check_prejoin")%}',
            data:'',
            dataType:'json',
            success:function(msg){
               $.fn.zTree.init($("#treeDemo"), setting, msg);
			}
        });
		
	});
	
function getdetp(){
	var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
	var nodes = treeObj.getCheckedNodes(true);
	//alert(JSON.stringify(nodes))
	var str='';
	$.each(nodes,function(i,data){
		str+='<tr>';
		str+='<td><input type="hidden" name="deptlist[]" value="'+data.id+'" />'+data.attr+'</td>';
        str+='<td><input type="checkbox" value="1" name="isleader[]"/></td>';
        str+='<td><a href="javascript:;" class="del_'+data.id+'" onclick="removeDept(this)">移除</a></td>';
        str+='</tr>';
	});
	closed();
	$('#tab_dept:nth-child(1),#tab_dept:nth-child(2)').append(str);
	
}

</script>
<div class="sidebarLeft " style="width: 95%;margin: 0 2.5%;">
    <!--begin dept -->
  <div class="pad10">
    <div class="ouTreeTitle" >组织结构</div>
    <div class="ouTree pad5" style="height:246px;overflow:auto">
    	<ul id="treeDemo" class="ztree" style="min-height:241px;"></ul>
      	
    </div>
  </div>
  
  <!--end dept --> 
</div>
