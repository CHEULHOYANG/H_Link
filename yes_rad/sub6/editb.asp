<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/dbcon.asp" -->
<%
dim tabnm : tabnm = Request("idx")
dim sql,dr,rs

sql = "select jemok,pgbn,ygbn,mgbn,logincheck,mem_group,top_message,bottom_message from board_mast where idx=" & tabnm
set dr = db.execute(sql)
dim jemok,pgbn,ygbn,mgbn,logincheck,mem_group,top_message,bottom_message
jemok = dr(0)
pgbn = dr(1)
ygbn = dr(2)
mgbn = dr(3)
logincheck = dr(4)
mem_group = dr(5)
top_message = dr(6)
bottom_message = dr(7)
dr.close

dim bbsJemok
bbsJemok = jemok
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

	if(RdoBtnn("mgbn")){
		alert("����� �������ּ���!");
		return;
	}

thefm.submit();
}

function bbsDel(bbcn){
	if(bbcn < 2){
		alert("�Խ����� �ּ� 1�� �̻��� �־�� �մϴ�!");
		return;
	}

	var delok = confirm("�� <%=bbsJemok%> �Խ����� ������ �����Ͻðڽ��ϱ�?");
	if(delok){
		location.href="deleteb.asp?tabnm=<%=tabnm%>";
	}
}
</script>

<div class="container">
	<!--#include file="left.asp"-->
	<div class="content">
		<h2 class="cTit"><span class="bullet"></span>�Խ��ǻ���</h2>

<form name="fm" action="editb_ok.asp" method="post" style="display:inline;">
<input type="hidden" name="tabnm" value="<%=tabnm%>">	    
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
<input type="checkbox" name="mem_group" id="mem_group" value="<%=rs(0)%>" <%if instr(mem_group,", "& rs(0) &",") then response.write"checked" end if%> /> <%=rs(1)%>&nbsp;<%
rs.movenext
loop
rs.close
end if
%></td>
					</tr>
					<tr>
						<th>����</th>
						<td><input type="text" name="jemok" class="inptxt1 w200" value="<%=jemok%>"></td>
					</tr>
					<tr>
						<th>��������</th>
						<td><input type="radio" name="logincheck" value="0" <% if int(logincheck) = 0 then response.write " checked"%> > ����
                          <input type="radio" name="logincheck" value="1" <% if int(logincheck) = 1 then response.write " checked"%> > ȸ����
                          <input type="radio" name="logincheck" value="2" <% if int(logincheck) = 2 then response.write " checked"%> > ����ȸ����</td>
					</tr>
					<tr>
						<th>�ۼ�����</th>
						<td><input type="radio" name="pgbn" value="0" <% if int(pgbn) = 0 then response.write " checked"%>> ����������
                          <input type="radio" name="pgbn" value="1" <% if int(pgbn) = 1 then response.write " checked"%>>  ȸ������</td>
					</tr>
					<tr>
						<th>����</th>
						<td><input type="radio" name="ygbn" value="1" <% if int(ygbn) = 1 then response.write " checked"%>> �ڷ��
                          <input type="radio" name="ygbn" value="2" <% if int(ygbn) = 2 then response.write " checked"%>> Ŀ�´�Ƽ(������)
                          <input type="radio" name="ygbn" value="3" <% if int(ygbn) = 3 then response.write " checked"%>> Ŀ�´�Ƽ(�Ϲ�)</td>
					</tr>
					<tr>
						<th>���</th>
						<td><input type="radio" name="mgbn" value="0" <% if int(mgbn) = 0 then response.write " checked"%>> ��� ����
						<input type="radio" name="mgbn" value="1" <% if int(mgbn) = 1 then response.write " checked"%>> ���</td>
					</tr>
					<tr>
						<th>��ܳ���</th>
						<td><textarea name="top_message" class="inptxt1" id="top_message" style="width:600px;height:100px"><%=top_message%></textarea></td>
					</tr>					
					<tr>
						<th>�ϴܳ���</th>
						<td><textarea name="bottom_message" class="inptxt1" id="bottom_message" style="width:600px;height:100px"><%=bottom_message%></textarea></td>
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