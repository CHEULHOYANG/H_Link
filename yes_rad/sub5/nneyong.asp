<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/dbcon.asp" -->
<%
Dim sql,dr,idx,intpg
dim jemok,neyong,wday,readnum

idx = Request("idx")
intpg = Request("intpg")

sql = "select jemok,neyong,wday,readnum from notice where idx=" & idx
set dr = db.execute(sql)

If dr.eof Or dr.bof Then

	response.write"<script>"
	response.write"alert('�����Ϳ���!!');"
	response.write"history.back();"
	response.write"</script>"
	response.end

Else

	jemok = dr(0)
	neyong = dr(1)
	wday = dr(2)
	readnum = dr(3)
	
dr.close 
End if
%>
<!--#include file="../main/top.asp"-->

<script language="javascript">
function delLicen(){
	delok = confirm("������ �����Ͻðڽ��ϱ�?");
	if(delok){
		location.href="ndel.asp?idx=<%=idx%>";
	}
}
</script>

<div class="container">
	<!--#include file="left.asp"-->
	<div class="content">
		<h2 class="cTit"><span class="bullet"></span>��������</h2>

		<table class="ftbl mb50" style="width:100%">
				<colgroup>
				<col style="width:20%" />
				<col style="width:80%" />
				</colgroup>
				<tbody>
					<tr>
						<th>����</th>
						<td><%=jemok%></td>
					</tr>
					<tr>
						<th>�ۼ���</th>
						<td><%=wday%></td>
					</tr>
					<tr>
						<th>��ȸ��</th>
						<td><%=readnum%></td>
					</tr>
					<tr>
						<th>����</th>
						<td><%=neyong%></td>
					</tr>

				</tbody>
			</table>
		<div class="rbtn">
			<a href="nedit.asp?idx=<%=idx%>&intpg=<%=intpg%>&strPart=<%=request("strPart")%>&strSearch=<%=request("strSearch")%>" class="btn">����</a>
			<a href="javascript:delLicen();" class="btn">����</a>
			<a href="nlist.asp?intpg=<%=intpg%>" class="btn trans">��Ϻ���</a>		
		</div>

	</div>
</div>


</body>
</html>
<!-- #include file = "../authpg_2.asp" -->