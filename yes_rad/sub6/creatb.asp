<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/dbcon.asp" -->
<%
dim sql,dr,rs
%>
<!--#include file="../main/top.asp"-->

<script language="javascript">
function RdoBtnn(r){
	rdobj = eval("fm." + r);

	fq = true;
	for(i=0;i<rdobj.length;i++){
		if(rdobj[i].checked){
			fq = false;
			break;
		}
	}
return fq;
}

function go2WriteOk(thefm){
	var clmn;
	clmn = thefm.jemok;
	if(clmn.value==""){
		alert("�Խ��� ������ �Է��ϼ���!");
		clmn.focus();
		return;
	}
	if(clmn.value.replace(/ /g,"")==""){
		alert("�Խ��� ������ �Է��ϼ���!");
		clmn.select();
		return;
	}

	if(RdoBtnn("pgbn")){
		alert("������ �������ּ���!");
		return;
	}

	if(RdoBtnn("ygbn")){
		alert("�뵵�� �������ּ���!");
		return;
	}

	if(RdoBtnn("mgbn")){
		alert("����� �������ּ���!");
		return;
	}

thefm.submit();
}

</script>

<div class="container">
	<!--#include file="left.asp"-->
	<div class="content">
		<h2 class="cTit"><span class="bullet"></span>�Խ��ǻ���</h2>
<form name="fm" action="creatb_ok.asp" method="post" style="display:inline;">
		<table class="ftbl mb50" style="width:100%">
				<colgroup>
				<col style="width:20%" />
				<col style="width:80%" />
				</colgroup>
				<tbody>
					<tr>
						<th>ȸ���׷�</th>
						<td><%
sql = "select idx,title from group_mast where gu = 0 "
set rs=db.execute(sql)

if rs.eof or rs.bof then
else
do until rs.eof
%>
<input type="checkbox" name="mem_group" id="mem_group" value="<%=rs(0)%>" /> <%=rs(1)%>&nbsp;<%
rs.movenext
loop
rs.close
end if
%></td>
					</tr>
					<tr>
						<th>����</th>
						<td><input type="text" name="jemok" class="inptxt1 w200"></td>
					</tr>
					<tr>
						<th>��������</th>
						<td><input type="radio" name="logincheck" value="0" checked> ����
                          <input type="radio" name="logincheck" value="1"> ȸ����
                          <input type="radio" name="logincheck" value="2"> ����ȸ����</td>
					</tr>
					<tr>
						<th>�ۼ�����</th>
						<td><input type="radio" name="pgbn" value="0"> ����������
                          <input type="radio" name="pgbn" value="1">  ȸ������</td>
					</tr>
					<tr>
						<th>����</th>
						<td><input type="radio" name="ygbn" value="1"> �ڷ��
                          <input type="radio" name="ygbn" value="2"> Ŀ�´�Ƽ(������)
                          <input type="radio" name="ygbn" value="3"> Ŀ�´�Ƽ(�Ϲ�)</td>
					</tr>
					<tr>
						<th>���</th>
						<td><input type="radio" name="mgbn" value="0"> ��� ����
						<input type="radio" name="mgbn" value="1"> ���</td>
					</tr>
					<tr>
						<th>��ܳ���</th>
						<td><textarea name="top_message" class="inptxt1" id="top_message" style="width:600px;height:100px"></textarea></td>
					</tr>					
					<tr>
						<th>�ϴܳ���</th>
						<td><textarea name="bottom_message" class="inptxt1" id="bottom_message" style="width:600px;height:100px"></textarea></td>
					</tr>		
				</tbody>
			</table>
</form>

		<div class="rbtn">
			<a href="javascript:go2WriteOk(fm);" class="btn">�����ϱ�</a>
			<a href="javascript:history.back();" class="btn trans">��Ϻ���</a>		
		</div>

	</div>
</div>

</body>
</html>
<!-- #include file = "../authpg_2.asp" -->