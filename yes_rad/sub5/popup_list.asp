<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/dbcon.asp" -->
<%

Dim sql,Dr,isRecod

sql = "select pop_idx,pop_nm,pop_width,pop_height,pop_gbn,pop_gu from PopINfoTab"
Set Dr = db.execute(sql,,adCmdText)
if Not Dr.Bof or Not Dr.Eof then
	Dim isRows,isCols
	isRows = Split(Dr.GetString(2),chr(13))
	isRecod = True
end if
Dr.Close
Set Dr = Nothing
%>

<!--#include file="../main/top.asp"-->

<script language="javascript">
function Use_PopupDel(idxnum){
	delconfirm = confirm("������ �����Ͻðڽ��ϱ�?");
	if(delconfirm){
		document.location.href="popup_del.asp?idx=" + idxnum;
	}
}

function PreView_Pop(idxnm,fwidth,fheight){
	openPage_URL = "pop_view.asp?idxnum=" + idxnm + "&pop_height=" + fheight;
	var k = window.open(openPage_URL,"winpop","width=" + fwidth + ",height=" + fheight + ",top=0,left=0");
	k.focus();
}

function UsePop(idxnum,gbn,tdobj){
	var params = "key=" + escape(idxnum) + "&keygbn=" + escape(gbn) + "&keyary=" + tdobj;
	sndReq("popuse_xml.asp",params,viewpopList,"POST");
	//location.href="popuse_xml.asp?" + params;
}

function viewpopList(){
	if(objXmlhttp.readyState == 4){
		if(objXmlhttp.status==200){
		//	alert(objXmlhttp.responseText);

			var xmlDoc = objXmlhttp.responseXML;
			var objRows = xmlDoc.getElementsByTagName("isrows").item(0);
			var objCols = objRows.getElementsByTagName("iscols");
			var strmsg = objCols.item(0).firstChild.nodeValue;
			var strobjnm =  objCols.item(1).firstChild.nodeValue;
			var inHtm = objCols.item(2).firstChild.nodeValue;

			alert(strmsg);
			document.getElementById(strobjnm).innerHTML = inHtm;

		}else{
			alert("error:�����ڿ��� �����ϼ���...!");
		}
	}
}
</script>
</head>

<div class="container">
	<!--#include file="left.asp"-->
	<div class="content">
		<h2 class="cTit"><span class="bullet"></span>�˾�â����</h2>

		<div class="tbl_top">
			<a href="popup_mk.asp" class="fbtn1">�˾�â���</a>
		</div>

<% if isRecod then %>
		<table class="tbl" style="width:100%">
			<colgroup>
			<col style="width:10%" />
			<col />
			<col style="width:15%" />
			<col style="width:10%" />
			<col style="width:20%" />
			</colgroup>
			<thead>
				<tr>
					<th>����</th>	
					<th>�˾�â ����</th>	
					<th>�˾�â ũ��</th>
					<th>�������</th>
					<th>�̸�����</th>	
				</tr>				
			</thead>
			<tbody>
<% for ii = 0 to Ubound(isRows) - 1
						isCols = split(isRows(ii),chr(9))%>
				<tr>
					<td><%If isCols(5) = 0 Then Response.write"��" Else Response.write"�����" End if%></td>
					<td class="tl"><%=isCols(1)%></td>
					<td><%=isCols(2)%> * <%=isCols(3)%></td>
					<td ID="ajxAry<%=ii%>"><span style="cursor:pointer;color:<% if int(isCols(4)) = 1 then %>#666666;" onclick="UsePop('<%=isCols(0)%>',0,'ajxAry<%=ii%>');">�����<% else %>#CC0000;" onclick="UsePop('<%=isCols(0)%>',1,'ajxAry<%=ii%>');">������<% end if %></td>
					<td><a href="javascript:PreView_Pop('<%=isCols(0)%>','<%=isCols(2)%>','<%=isCols(3)%>');" class="btns">�̸�����</a>
					<a href="popup_edite.asp?idx=<%=isCols(0)%>" class="btns trans">����</a>
<a href="javascript:Use_PopupDel('<%=isCols(0)%>');" class="btns trans">����</a></td>
				</tr>
				<% Next %>
			</tbody>
		</table>
<%End if%>

<div class="caution"><p><strong>[�������]</strong> Ŭ���� ��� / �̻������ ������ �����մϴ�.</p></div>

	</div>
</div>

</body>
</html>
<%
db.Close
Set db = Nothing
%>
<!-- #include file = "../authpg_2.asp" -->