<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/dbcon.asp" -->
<%
Dim sql,dr,isRows,isCols,rowsNum,idx,logo,gbn
%>

<!--#include file="../main/top.asp"-->

<script language="javascript">
function logo_it(){

	var f = window.document.lfom;
	
	if(f.logo.value.length==0){
	alert("�ΰ������� �������ּ���.");
	f.logo.focus();
	return;
	}
	
	f.submit();
	
}

function logo_it1(){

	var f = window.document.lfom1;
	
	if(f.logo.value.length==0){
	alert("�ΰ������� �������ּ���.");
	f.logo.focus();
	return;
	}
	
	f.submit();
	
}
function logo_del(idx){
	var delok = confirm("�����Ͻðڽ��ϱ�?");
	if(delok){
		location.href="logo_del.asp?idx=" + idx;
	}
}
</script>

<div class="container">
	<!--#include file="left.asp"-->
	<div class="content">
		<h2 class="cTit"><span class="bullet"></span>�ΰ����</h2>

		<table class="tbl" style="width:100%">
			<colgroup>
			<col style="width:15%" />
			<col />
			<col style="width:40%" />
			</colgroup>
			<thead>
				<tr>
					<th>����</th>	
					<th>����</th>
					<th>�����̹���</th>
				</tr>				
			</thead>
			<tbody>
<%
sql = "select idx,imgsrc,gbn from logoTab where gbn = 1"
set dr = db.execute(sql)

if dr.eof or dr.bof then
else

	idx = dr(0)
	logo = dr(1)
	gbn = dr(2)

dr.close
end if
%>                            
<form name="lfom" action="logo_ok.asp" method="post" enctype="multipart/form-data" style="display:inline;">
<input type="hidden" name="idx" value="<%=idx%>">   
<input type="hidden" name="gbn" value="1">   
				<tr>
					<th><span class="mile bl">�ΰ�#1</span></th>
					<td class="tl"><input type="file" name="logo" class="inptxt1 w400"> <a href="javascript:logo_it();" class="fbtn">�����ϱ�</a></td>
					<td><% if len(logo) > 0 then %><img src="../../ahdma/logo/<%=logo%>"><%end if%></td>
				</tr>
</form>
<%
Dim idx2,logo2,gbn2
sql = "select idx,imgsrc,gbn from logoTab where gbn = 2"
set dr = db.execute(sql)

if dr.eof or dr.bof then
else

	idx2 = dr(0)
	logo2 = dr(1)
	gbn2 = dr(2)

dr.close
end if
%>             
<form name="lfom1" action="logo_ok.asp" method="post" enctype="multipart/form-data" style="display:inline;">
<input type="hidden" name="idx" value="<%=idx2%>">   
<input type="hidden" name="gbn" value="2">   
				<tr>
					<th><span class="mile">�ΰ�#2</span></th>
					<td class="tl"><input type="file" name="logo" class="inptxt1 w400"> <a href="javascript:logo_it1();" class="fbtn">�����ϱ�</a> <% if len(logo2) > 0 then %><a href="javascript:logo_del(<%=idx2%>);" class="fbtn1">�̹�������</a><%End if%></td>
					<td><% if len(logo2) > 0 then %><img src="../../ahdma/logo/<%=logo2%>"><%end if%></td>
				</tr>
</form>
			</tbody>
		</table>

<div class="caution"><p>�̹������� jpg,gif,png ���� ���ε� �����մϴ�.</p></div>

	</div>
</div>

</body>
</html>
<!-- #include file = "../authpg_2.asp" -->