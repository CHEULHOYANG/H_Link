<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/dbcon.asp" -->
<%
dim sql,rs,title,idx,gu

idx=request("idx")

sql="select idx,title,gu from group_mast where idx="& idx
set rs=db.execute(sql)

if rs.eof or rs.bof then

	response.write"<script language='javascript'>"
	response.write"alert('�����ڷ��Դϴ�.');"
	response.write"history.back();"
	response.write"</script>"
	response.End

Else

	idx=rs(0)
	title=rs(1)
	gu = rs(2)

rs.close
end if
%>
<!--#include file="../main/top.asp"-->

<script>
function group_insert(){
	var f = window.document.board_write;
	if(f.title.value==""){
	alert("�׷���� �Է����ּ���.");
	f.title.focus();
	return;
	}
	f.submit();
}
</script>

<div class="container">
	<!--#include file="left.asp"-->
	<div class="content">
		<h2 class="cTit"><span class="bullet"></span><%If request("gu") = "0" Then Response.write"ȸ��" End if%><%If request("gu") = "1" Then Response.write"����" End if%> �׷����</h2>

<form name="board_write" method="post" action="edit_ok.asp" >
<input type="hidden" name="idx" value="<%=request("idx")%>">
<input type="hidden" name="gu" value="<%=gu%>">
		<table class="ftbl mb50" style="width:100%">
				<colgroup>
				<col style="width:20%" />
				<col style="width:80%" />
				</colgroup>
				<tbody>
					<tr>
						<th>�׷��</th>
						<td><input type="text" name="title" size="50" class="inptxt1 w200" value="<%=title%>"></td>
					</tr>
				</tbody>
			</table>
</form>

		<div class="rbtn">
			<a href="javascript:group_insert();" class="btn">�����ϱ�</a>
			<a href="list.asp?gu=<%=request("gu")%>" class="btn trans">��Ϻ���</a>		
		</div>

	</div>
</div>

</body>
</html>
<!-- #include file = "../authpg_2.asp" -->