<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/dbcon.asp" -->
<%
dim sql,rs,idx,title,g_mem,rs1,gu
%>
<!--#include file="../main/top.asp"-->

<script>
function viewLecGow(){

		 TG_PAY = window.open("","yesoft_quiz", "width=770,height=500,top=0,left=0,scrollbars=no,resizable=no,titlebar=no");
		 TG_PAY.focus();        
		 document.chfm.target="yesoft_quiz";
		 document.chfm.action="setinput.asp";
		 document.chfm.submit();

}

function list_del(idx){
		var bool = confirm("�����Ͻðڽ��ϱ�?");
		if (bool){
			location.href = "del.asp?idx="+idx+"&gu=<%=request("gu")%>";
		}
}

function AllCheck(thisimg,chekID){
	var srcAry = thisimg.src.split("/");
	if(srcAry[srcAry.length-1] == "noncheck.gif"){
		thisimg.src = "../rad_img/img/allcheck.gif";
		isChecked(true,chekID);
	}else{
		thisimg.src = "../rad_img/img/noncheck.gif";
		isChecked(false,chekID);
	}
}

function isChecked(cmd,chekID){
	var chekLen=chekID.length;
	if(chekLen){
		for (i=0;i<chekLen;i++){
			chekID[i].checked=cmd;
		}
	}
	else{
		chekID.checked=cmd;
	}
}

function delteAll(chkobj){
	var checkgbn = true;
	if(chkobj.length){
		for(i=0;i<chkobj.length;i++){
			if(chkobj[i].checked){
				checkgbn = false;
				break;
			}
		}
	}else{
		if(chkobj.checked){
			checkgbn = false;
		}
	}

	if(checkgbn){
		alert("�����Ͻ� ȸ���� �������ּ���!");
		return;
	}

	delok = confirm("üũ�� ȸ���� �����մϴ�");
	if(delok){
		document.chfm.submit();
	}
}
</script>

<div class="container">
	<!--#include file="left.asp"-->
	<div class="content">
		<h2 class="cTit"><span class="bullet"></span><%If request("gu") = "0" Then Response.write"ȸ��" End if%><%If request("gu") = "1" Then Response.write"����" End if%> �׷����</h2>

		<div class="tbl_top">
			<a href="write.asp?gu=<%=request("gu")%>" class="fbtn1">�׷���</a>
			<%If request("gu")=0 then%><a href="javascript:viewLecGow('<%=idx%>');" class="fbtn2">�������</a><%End if%>
		</div>

<form name="chfm" action="setinput.asp" method="post">	
		<table class="tbl" style="width:100%">
			<colgroup>
			<col style="width:5%" />
			<col />
			<col style="width:10%" />
			<col style="width:15%" />
			<col style="width:10%" />
			</colgroup>
			<thead>
				<tr>
					<th><img src="../rad_img/img/noncheck.gif" style="cursor:pointer;" onClick="AllCheck(this,document.all.idx);"></th>	
					<th>�׷��</th>
					<th>ȸ����</th>
					<th>ȸ���������</th>	
					<th>���</th>								
				</tr>				
			</thead>
			<tbody>
<%
sql="select idx,title,gu from group_mast where gu = "& request("gu") &" order by idx desc"
set rs=db.execute(sql)

if rs.eof or rs.bof then

else
do until rs.eof 

idx = rs(0)
title = rs(1)

if rs(2) = 0 then
sql="select count(idx) from member where sp1 = '"& idx &"'"
elseif rs(2) = 1 then
sql="select count(idx) from member where sp2 = '"& idx &"'"
elseif rs(2) = 2 then
sql="select count(idx) from member where sp3 = '"& idx &"'"
end if
set rs1 = db.execute(sql)

g_mem = rs1(0)
%>
				<tr>
					<td><input type="checkbox" name="idx" value="<%=rs(0)%>"></td>
					<td class="tl"><%=title%></td>
					<td><%=g_mem%>��</td>
					<td><a href="list_excel.asp?gm=<%=idx%>&gu=<%=request("gu")%>" class="sbtn">�����������ϱ�</a></td>
					<td><a href="edit.asp?idx=<%=idx%>&gu=<%=request("gu")%>" class="btns trans">����</a>
<a href="javascript:list_del('<%=idx%>');" class="btns">����</a></td>
					
				</tr>
<%
rs.movenext
loop
rs.close
end if
%>
			</tbody>
		</table>
</form>

<%If request("gu") = 0 then%>
		<div class="caution"><p>�׷��� �����ؼ� �ϰ������� ��������� �ϽǼ��� �ֽ��ϴ�.</p></div>
		<div class="caution"><p>��ϵ� ȸ���׷��� ����/���ǽ�û���� ��������� �������� ����� �����մϴ�.</p></div>
<%else%>
	<div class="caution"><p>�׷��� ������� ȸ����Ͽ��� ���ڱ׷��� �������ֽø� �׷캰�� ���ڸ� �߼��Ҽ� �ֽ��ϴ�.</p></div>
<%End if%>

	</div>
</div>

</body>
</html>
<!-- #include file = "../authpg_2.asp" -->