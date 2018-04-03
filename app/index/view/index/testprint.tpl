<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<script type="text/javascript"
	src="{%$base_url%}assets/javascript/jquery-1.8.js"></script>
<script type="text/javascript"
	src="{%$base_url%}assets/javascript/jquery.ui.js"></script>
<style>
body {
	font-size: 12px;
	
}

table {
	width: 700px;
 	text-align: center; 
	border: 2px solid black;
}

td {
	border: 1px solid black;
}
.nfirst_tb{
	width:20mm;
}
.PageNext{page-break-after: always;}     
</style>
</head>
<body>
<div style="width:100%;text-align:center;">
	<table style="border:none; ">
	<tr><td style="border:none; height:8mm;font-size:22px; font-weight: bold;letter-spacing: 8px;"><img  style="width: 32mm;margin-top: 0mm;position: absolute;margin-left: -44mm;
	"src="{%$base_url%}templates/{%$web_template%}/images/logocolor.png"></img>浙江森马服饰股份有限公司 </td></tr>
	<tr><td style="border:none; height:8mm;font-size:22px; font-weight: bold;letter-spacing: 8px;">社会应聘申请表 </td></tr>
	</table>
	<table style="height: 45mm; border-bottom: none;" cellspacing="0">
		<tr>
			<td  style="width:20mm;">姓 名</td>
			<td style="border-right: none; border-bottom: none; width: 20mm;">{%$basicinfo->CName%}</td>
			<td
				style="border-left-color: gray; border-right: none; border-bottom: none; width: 25mm;">英文名</td>
			<td
				style="border-left-color: gray; border-bottom: none; border-right: none; width: 18mm;">{%$basicinfo->EName%}</td>
			<td
				style="border-left-color: gray; border-bottom: none; border-right: none; width: 20mm;">应聘职位</td>
			<td
				style="border-left-color: gray; border-bottom: none; width: 35mm;"
				colspan="2">{%$basicinfo->Station%}</td>
			 {%if ($basicinfo->HeaderImg)%}
			<td style="width: 27mm; "rowspan="6"><img style="width:26mm" src="http://hr.semirapp.com{%$basicinfo->HeaderImg%}"></img></td>
			{%else%}
			<td style="width: 27mm;"rowspan="6"><div  style="width:10px; margin-left:48%;">照片 （ 一寸免冠 ）</div></td>
			{%/if%}
		</tr>
		<tr>
			<td class="nborder">性 别</td>
			<td style="border-top-color: gray; border-right: none; ">{%$basicinfo->Gender%}</td>
			<td style="border-top-color: gray;border-left-color: gray; border-right: none;">民 族</td>
			<td style="border-top-color: gray;border-left-color: gray; border-right: none;">{%$basicinfo->Nation%}</td>
			<td style="border-top-color: gray;border-left-color: gray; border-right: none;">E-mail</td>
			<td style="border-top-color: gray;border-left-color: gray;" colspan="2">{%$basicinfo->Email%}</td>
		</tr>
		<tr>
			<td class="nborder">身份证号</td>
			<td style="border-right: none; border-bottom: none;" colspan="2">{%$basicinfo->CardId%}</td>
			<td
				style="border-left-color: gray; border-right: none; border-bottom: none;">户籍性质</td>
			<td
				style="border-left-color: gray; border-bottom: none; border-right: none;">{%$basicinfo->Domicile%}
<!-- 				<input type="checkbox"  {%if (!$basicinfo->Domicile)%}checked{%/if%}>农村</input> -->
<!-- 				<input type="checkbox" {%if ($basicinfo->Domicile)%}checked{%/if%}>城镇</input> -->
				</td>
			<td
				style="width: 15mm; border-left-color: gray; border-bottom: none; border-right: none">婚 否</td>
			<td
				style="border-left-color: gray; border-bottom: none; font-size: 0.8em;">{%$basicinfo->IsMarry%}
<!-- 				<input type="checkbox" {%if ($basicinfo->IsMarry == 1)%}checked{%/if%}>已婚</input> -->
<!-- 				<input type="checkbox" {%if ($basicinfo->IsMarry == 0)%}checked{%/if%}>未婚</input> -->
<!-- 				<input type="checkbox"  {%if ($basicinfo->IsMarry == 2)%}checked{%/if%}>离异</input> -->
				</td>
		</tr>
		<tr>
			<td class="nborder">现居住地址</td>
			<td
				style="border-bottom: none; border-top-color: gray; border-right: none;"
				colspan="4">{%$basicinfo->LivePcc%}{%$basicinfo->LiveAddress%}</td>
			<td
				style="border-bottom: none; border-right: none; border-left-color: gray; border-top-color: gray;">现居住地固定电话</td>
			<td style="border-bottom: none;border-left-color: gray;border-top-color: gray;"></td>
		</tr>
		<tr>
			<td class="nborder">户口地址</td>
			<td style="border-top-color: gray; border-right: none;" colspan="4">{%$basicinfo->ResPcc%}{%$basicinfo->ResAddress%}</td>
			<td
				style="border-top-color: gray; border-left-color: gray; border-right: none;">移动电话</td>
			<td style="border-left-color: gray;border-top-color: gray;">{%$basicinfo->Telephone%}</td>
		</tr>
		<tr>
			<td class="nborder">政治面貌</td>
			<td  colspan="6">
<!-- 			<input type="checkbox" {%if ($basicinfo->Party == 1)%}checked{%/if%}>共产党员</input> -->
<!-- 			<input type="checkbox" {%if ($basicinfo->Party == 2)%}checked{%/if%}>预备党员</input> -->
<!-- 			<input type="checkbox"  {%if ($basicinfo->Party == 3)%}checked{%/if%}>群众</input> -->
<!-- 			<input type="checkbox"  {%if ($basicinfo->Party == 4)%}checked{%/if%}>民主党派__<u>{%$basicinfo->PartyName%}</u>__________</input> -->
				{%$basicinfo->Party%}
				</td>
		</tr>
	</table>
	<table style="border-top: none; border-bottom: none;" cellspacing="0">
		<tr>
			<td style="width:20mm;" rowspan="3">家庭情况 <br/>(若已婚,请提供配偶及子女信息)</td>
			<td style="border-right: none; border-bottom: none; height: 5mm;width: 20mm;">姓名</td>
			<td
				style="border-right: none; border-bottom: none; border-left-color: gray;width: 20mm;">关系</td>
			<td style="border-bottom: none; border-left-color: gray;">工作单位</td>
			<td style="border-right: none; border-bottom: none;width: 20mm;">姓名</td>
			<td
				style="border-right: none; border-bottom: none; border-left-color: gray;width: 20mm;">关系</td>
			<td style="border-left-color: gray; border-bottom: none;" colspan="2">工作单位</td>
		</tr>
		<tr>
			<td
				style="border-right: none; border-bottom: none; border-top-color: gray; height: 6mm;">{%$fmember1->UName%}</td>
			<td
				style="border-right: none; border-bottom: none; border-top-color: gray; border-left-color: gray;">{%$fmember1->UShip%}</td>
			<td
				style="border-bottom: none; border-top-color: gray; border-left-color: gray;">{%$fmember1->UCompany%}</td>
			<td
				style="border-right: none; border-bottom: none; border-top-color: gray;">{%$fmember2->UName%}</td>
			<td
				style="border-right: none; border-bottom: none; border-top-color: gray; border-left-color: gray;">{%$fmember2->UShip%}</td>
			<td
				style="border-bottom: none; border-top-color: gray; border-left-color: gray; border-top-color: gray;"
				colspan="2">{%$fmember2->UCompany%}</td>
		</tr>
		<tr>
			<td style="border-right: none; border-top-color: gray; height: 6mm;">{%$fmember3->UName%}</td>
			<td
				style="border-right: none; border-top-color: gray; border-left-color: gray;">{%$fmember3->UShip%}</td>
			<td style="border-top-color: gray; border-left-color: gray;">{%$fmember3->UCompany%}</td>
			<td style="border-right: none; border-top-color: gray;">{%$fmember4->UName%}</td>
			<td
				style="border-right: none; border-top-color: gray; border-left-color: gray;">{%$fmember4->UShip%}</td>
			<td style="border-top-color: gray; border-left-color: gray;"
				colspan="2">{%$fmember4->UCompany%}</td>
		</tr>
	</table>
	<table style="border-top: none; border-bottom: none;" cellspacing="0">
		<tr>
			<td class="nfirst_tb" 	style="border-bottom: none;" rowspan="4">学习经历<br/><span style="font-size:0.9em;"> (请从<strong>最近</strong>填写)</span>
			</td>
			<td
				style="border-right: none; border-bottom: none; width: 20mm; height: 6mm;">入校年月</td>
			<td
				style="border-right: none; border-bottom: none; border-left-color: gray; width: 20mm;">离校年月</td>
			<td
				style="border-bottom: none; border-left-color: gray; border-right: none;width: 28mm;">学校名称</td>
			<td
				style="border-right: none; border-bottom: none; border-left-color: gray;width: 30mm;">专业</td>
			<td
				style="border-right: none; border-bottom: none; border-left-color: gray;width: 15mm;">有无毕业证</td>
			<td style="border-left-color: gray; border-bottom: none;width: 40mm;" colspan="2">所获学历</td>
		</tr>
		<tr>
			<td
				style="border-right: none; border-bottom: none; border-top-color: gray; height: 6mm;">{%$eduinfo1->StartTime%}</td>
			<td
				style="border-right: none; border-bottom: none; border-top-color: gray; border-left-color: gray;">{%$eduinfo1->EndTime%}</td>
			<td
				style="border-bottom: none; border-top-color: gray; border-left-color: gray; border-right: none;">{%$eduinfo1->SchoolName%}</td>
			<td
				style="border-right: none; border-bottom: none; border-top-color: gray; border-left-color: gray;">{%$eduinfo1->Major%}</td>
			<td
				style="border-right: none; border-bottom: none; border-top-color: gray; border-left-color: gray;">{%$eduinfo1->IsDiploma%}</td>
			<td
				style="border-top-color: gray; border-top-color: gray; border-bottom: none; border-left-color: gray;"
				colspan="2">{%$eduinfo1->EduRecord%}</td>
		</tr>
		 {%if ($eduinfo2)%}
		<tr>
			<td
				style="border-right: none; border-bottom: none; border-top-color: gray; height: 6mm;">{%$eduinfo2->StartTime%}</td>
			<td
				style="border-right: none; border-bottom: none; border-top-color: gray; border-left-color: gray;">{%$eduinfo2->EndTime%}</td>
			<td
				style="border-bottom: none; border-top-color: gray; border-left-color: gray; border-right: none;">{%$eduinfo2->SchoolName%}</td>
			<td
				style="border-right: none; border-bottom: none; border-top-color: gray; border-left-color: gray;">{%$eduinfo2->Major%}</td>
			<td
				style="border-right: none; border-bottom: none; border-top-color: gray; border-left-color: gray;">{%$eduinfo2->IsDiploma%}</td>
			<td
				style="border-top-color: gray; border-top-color: gray; border-bottom: none; border-left-color: gray;"
				colspan="2">{%$eduinfo2->EduRecord%}</td>
		</tr>
		 {%/if%}
		 {%if ($eduinfo3)%}
		<tr>
			<td style="border-right: none; border-top-color: gray;border-bottom: none;height: 6mm;">{%$eduinfo3->StartTime%}</td>
			<td
				style="border-right: none; border-top-color: gray; border-left-color: gray; border-bottom: none;">{%$eduinfo3->EndTime%}</td>
			<td
				style="border-top-color: gray; border-left-color: gray;; border-right: none; border-bottom: none;">{%$eduinfo3->SchoolName%}</td>
			<td
				style="border-right: none; border-top-color: gray; border-left-color: gray; border-bottom: none;">{%$eduinfo3->Major%}</td>
			<td
				style="border-right: none; border-top-color: gray;border-left-color: gray;border-bottom: none;">{%$eduinfo3->IsDiploma%}</td>
			<td style="border-top-color: gray; border-left-color: gray;  border-bottom: none;"
				colspan="2">{%$eduinfo3->EduRecord%}</td>
		</tr>
		{%/if%}
	</table>
	<table style="border-top:1px solid black; border-bottom: none;" cellspacing="0">
		<tr>
			<td 	style="width:20mm;border-bottom: none;" rowspan="6">工作经历<br/><span style="font-size:0.9em;">(请从<strong>最近</strong>填写)</span>
			</td>
			<td
				style="border-right: none; border-bottom: none; width: 20mm; height: 6mm;">入职时间</td>
			<td
				style="border-right: none; border-bottom: none;border-left-color: gray;  width: 20mm; height: 6mm;">离职时间</td>
			<td
				style="border-right: none; border-bottom: none; border-left-color: gray; width: 38mm;">工作单位</td>
			<td
				style="border-bottom: none; border-left-color: gray; border-right: none; width: 30mm;">职位</td>
			<td
				style="border-right: none; border-bottom: none; border-left-color: gray;width: 20mm;">离职原因</td>
			<td
				style="border-bottom: none; border-left-color: gray; width: 30mm;">原单位证明人及固定电话</td>
		</tr>
		<tr>
			<td
				style="border-right: none; border-bottom: none; border-top-color: gray; height: 6mm;">{%$workexp1->EntryTime%}</td>
			<td
				style="border-right: none; border-bottom: none; border-top-color: gray; border-left-color: gray;">{%$workexp1->QuitTime%}</td>
			<td
				style="border-bottom: none; border-top-color: gray; border-left-color: gray; border-right: none;">{%$workexp1->Company%}</td>
			<td
				style="border-right: none; border-bottom: none; border-top-color: gray; border-left-color: gray;">{%$workexp1->Position%}</td>
			<td
				style="border-right: none; border-bottom: none; border-top-color: gray; border-left-color: gray;">{%$workexp1->Reason%}</td>
			<td
				style="border-top-color: gray; border-bottom: none; border-left-color: gray;">{%$workexp1->ContactUser%}-{%$workexp1->ContactTel%}</td>
		</tr>
		 {%if ($workexp2)%}
		<tr>
			<td
				style="border-right: none; border-bottom: none; border-top-color: gray; height: 6mm;">{%$workexp2->EntryTime%}</td>
			<td
				style="border-right: none; border-bottom: none; border-top-color: gray; border-left-color: gray;">{%$workexp2->QuitTime%}</td>
			<td
				style="border-bottom: none; border-top-color: gray; border-left-color: gray; border-right: none;">{%$workexp2->Company%}</td>
			<td
				style="border-right: none; border-bottom: none; border-top-color: gray; border-left-color: gray;">{%$workexp2->Position%}</td>
			<td
				style="border-right: none; border-bottom: none; border-top-color: gray; border-left-color: gray;">{%$workexp2->Reason%}</td>
			<td
				style="border-top-color: gray; border-bottom: none; border-left-color: gray;">{%$workexp2->ContactUser%}-{%$workexp2->ContactTel%}</td>
		</tr>
		{%/if%}
		{%if ($workexp3)%}
		<tr>
			<td
				style="border-right: none; border-bottom: none; border-top-color: gray; height: 6mm;">{%$workexp3->EntryTime%}</td>
			<td
				style="border-right: none; border-bottom: none; border-top-color: gray; border-left-color: gray;">{%$workexp3->QuitTime%}</td>
			<td
				style="border-bottom: none; border-top-color: gray; border-left-color: gray; border-right: none;">{%$workexp3->Company%}</td>
			<td
				style="border-right: none; border-bottom: none; border-top-color: gray; border-left-color: gray;">{%$workexp3->Position%}</td>
			<td
				style="border-right: none; border-bottom: none; border-top-color: gray; border-left-color: gray;">{%$workexp3->Reason%}</td>
			<td
				style="border-top-color: gray; border-bottom: none; border-left-color: gray;">{%$workexp3->ContactUser%}-{%$workexp3->ContactTel%}</td>
		</tr>
		{%/if%}
		{%if ($workexp4)%}
		<tr>
			<td
				style="border-right: none; border-bottom: none; border-top-color: gray; height: 6mm;">{%$workexp4->EntryTime%}</td>
			<td
				style="border-right: none; border-bottom: none; border-top-color: gray; border-left-color: gray;">{%$workexp4->QuitTime%}</td>
			<td
				style="border-bottom: none; border-top-color: gray; border-left-color: gray; border-right: none;">{%$workexp4->Company%}</td>
			<td
				style="border-right: none; border-bottom: none; border-top-color: gray; border-left-color: gray;">{%$workexp4->Position%}</td>
			<td
				style="border-right: none; border-bottom: none; border-top-color: gray; border-left-color: gray;">{%$workexp4->Reason%}</td>
			<td
				style="border-top-color: gray; border-left-color: gray; border-bottom: none;">{%$workexp4->ContactUser%}-{%$workexp4->ContactTel%}</td>
		</tr>
		{%/if%}
		{%if ($workexp5)%}
		<tr>
			<td style="border-right: none; border-top-color: gray; height: 6mm;">{%$workexp5->EntryTime%}</td>
			<td
				style="border-right: none; border-top-color: gray; border-left-color: gray;">{%$workexp5->QuitTime%}</td>
			<td
				style="border-right: none; border-top-color: gray; border-left-color: gray;">{%$workexp5->Company%}</td>
			<td
				style="border-right: none; border-top-color: gray; border-left-color: gray;">{%$workexp5->Position%}</td>
			<td
				style="border-right: none; border-top-color: gray; border-left-color: gray;">{%$workexp5->Reason%}</td>
			<td style="border-left-color: gray; border-top-color: gray; border-bottom: none;">{%$workexp5->ContactUser%}-{%$workexp5->ContactTel%}</td>
		</tr>
	{%/if%}
	</table>
	<table style="border-top: 1px solid black; border-bottom: none;" cellspacing="0">
		<tr>
			<td class="nfirst_tb"  rowspan="4">最近任职公司薪资情况</td>
			<td style="width: 135mm;padding-left:10px; height:8mm;border-bottom: none;  text-align: left;"
				colspan="4" rowspan="2"><strong>现年薪</strong>(税前)：___<u>{%$basicinfo->Income%}</u>___
				</td>
			<td style="width:25mm ;" rowspan="2">期望<strong>年薪</strong>(<strong>税前</strong>)
			</td>
			<td style="width:30mm ;" colspan="2" rowspan="2">{%$basicinfo->E_Salary%}</td>
		</tr>
		<tr>
		</tr>
		<tr>
			<td
				style="border-bottom: none; border-top-color: gray; font-size: 0.9em; text-align: left;"
				colspan="4"><strong style="font-size: 12px;">(本公司重视品德,请真实填写薪资状况,我们将依需求请您提供薪资证明)</strong></td>
			<td class="nborder" rowspan="2">与原公司是否签订竞业限制、保护商业秘密之类的协议</td>
			<td style="" colspan="2"
				rowspan="2">{%$basicinfo->Agreement%}
			</td>
		</tr>
	</table>
	<table style="border-top: none; border-bottom: none;" cellspacing="0">
		<tr>
			<td class="nfirst_tb"  rowspan="2">外语能力</td>
			<td style="border-bottom: none; border-right: none; width: 20mm;">语种</td>
			<td
				style="border-bottom: none; border-left-color: gray; width: 54mm;">{%$basicinfo->Language%}</td>
			<td style="width: 29mm;" rowspan="2">您通过何种渠道获悉我公司招聘信息</td>
			<td class="nborder" rowspan="2">{%$basicinfo->SourceResult%}{%$basicinfo->Source%}</td>
		</tr>
		<tr>
			<td style="border-top-color: gray; border-right: none;">能力</td>
			<td
				style="border-top-color: gray; border-left-color: gray;">{%$basicinfo->LangLevel%}
<!-- 				<input type="checkbox" {%if ($basicinfo->LangLevel ==1 )%}checked{%/if%}>了解</input> -->
<!-- 				<input type="checkbox" {%if ($basicinfo->LangLevel ==2 )%}checked{%/if%}>熟练</input> -->
<!-- 				<input type="checkbox" {%if ($basicinfo->LangLevel ==3 )%}checked{%/if%}>精通</input> -->
				</td>
		</tr>
	</table>
	<table style="border-top: none;border-bottom: none;" cellspacing="0">
		<tr>
			<td class="nfirst_tb"   style="height: 7mm;">专业证书</td>
			<td style="width: 75mm;">{%$basicinfo->Professional%}</td>
			<td style="border-right: none;width: 40mm;">通知录用可到职时间</td>
			<td style="border-left-color: gray;" >{%$basicinfo->EntryTime%}</td>
		</tr>
		</table>
		<table style="border-top: none;" cellspacing="0">
		<tr>
			<td class="nfirst_tb"  style="height: 9mm;">个性与爱好</td>
			<td class="nborder" colspan="7">{%$basicinfo->Interest%}</td>
		</tr>
		<tr>
			<td style="text-align: left" colspan="8"><strong><span >为方便及时联系到您,请留下亲人或朋友的电话(如下)</span></strong></td>
		</tr>
		<tr>
			<td style="border-right: none; height: 7mm; width:20mm"><strong>紧急联络人</strong></td>
			<td style="border-left-color: gray; border-right: none;width:25mm">{%$basicinfo->ContactName%}</td>
			<td style="border-left-color: gray; border-right: none;width:40mm">关系</td>
			<td style="border-left-color: gray; border-right: none; width: 15mm;">{%$basicinfo->ContactShip%}</td>
			<td style="border-left-color: gray; border-right: none;width:40mm">紧急联络人电话</td>
			<td style="border-left-color: gray;width:40mm" colspan="3">{%$basicinfo->ContactTel%}</td>
		</tr>
		<tr>
			<td style="border-right: none;" rowspan="2">是否有亲友在本公司</td>
			<td style="border-right: none; border-left-color: gray; width: 25mm;"
				rowspan="2">{%$basicinfo->IsFriend%}
<!-- 				<input type="checkbox" {%if ($basicinfo->IsFriend)%}checked{%/if%}>有</input><br /> -->
<!-- 			<input type="checkbox" {%if (!$basicinfo->IsFriend)%}checked{%/if%}>无</input> -->
			</td>
			<td
				style="border-left-color: gray; border-right: none; border-bottom: none; height: 6px;">本公司亲友姓名1</td>
			<td
				style="border-left-color: gray; border-bottom: none; border-right: none;">关系</td>
			<td
				style="border-left-color: gray; border-bottom: none; border-right: none;">本公司亲友姓名2</td>
			<td style="border-left-color: gray; border-bottom: none;">关系</td>
			<td style="border-right: none; width: 15mm;"
				rowspan="2">是否有过违法行为</td>
			<td style="border-left-color: gray;width:10mm" rowspan="2">{%$basicinfo->IsIllegal%}
<!-- 			<input type="checkbox" {%if ($basicinfo->IsIllegal)%}checked{%/if%}>有</input><br /> -->
<!-- 			<input type="checkbox"{%if (!$basicinfo->IsIllegal)%}checked{%/if%}>无</input> -->
			</td>
		</tr>
		<tr>
			<td style="border-left-color: gray; border-right: none;height: 6px;">{%$frmember1->FName%}</td>
			<td style="border-left-color: gray; border-right: none;">{%$frmember1->FShip%}</td>
			<td style="border-left-color: gray; border-right: none;">{%$frmember2->FName%}</td>
			<td style="border-left-color: gray;">{%$frmember2->FShip%}</td>
		</tr>
		<tr>
			<td style="text-align: left" colspan="8"><strong>请仔细阅读一下内容：</strong></td>
		</tr>
		<tr>
			<td style="text-align: left" colspan="8"><strong><span>应聘者声明：1.本人保证以上内容由本人自愿填写,所填写信息和提供材料均真实有效,无任何虚假情况；2.本人身体如有隐疾、怀孕或其他无法胜任工作的慢性病症,将在公司录用前如实告知；3.本人允许公司对所填写信息和提供材料的真实性予以调查,如有虚假,本人愿意承担相应的法律责任及因此导致的一切后果,接受公司包含解除劳动合同在内的一切处罚。</span></strong></td>
		</tr>
		<tr>
			<td style="text-align: right;font-size: 14px;" colspan="8"><span style="float:left;font-size:14px;">您的系统登陆名为：{%$basicinfo->itname%}</span><strong
				style="font-size: 16px;">应聘者签名</strong>:________________
				日期:_________________</td>
		</tr>
	</table>
	</div>
	<div class="PageNext"></div>     
	{%include file="../mspgb.tpl"%}
</body>
</html>