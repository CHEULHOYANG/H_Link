<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/dbcon.asp" --><%
Dim sql,dr,isRecod,isRows,isCols
Dim intpg,blockPage,pagecount,recordcount,lyno
Dim gbnS,strPart,strSearch
Dim tabnm : tabnm = "oneone"
Dim varPage

Dim nowPage : nowPage = Request("URL")

intpg = Request("intpg")
if intpg = "" then
	intpg = 1
else
	intpg = int(intpg)
end if

const pagesize = 20

Dim strClmn : strClmn = " qidx,quserid,qtitle,qansgbn=case qansgbn when 1 then 'O' else 'X' end,regdate "

gbnS = Request("gbnS")
strSearch = Request("strSearch")
strPart = Request("strPart")

if Len(strSearch) = 0 then
	varPage = "gbnS=&strPart=&strSearch="
	sql = "select Count(qidx) from " & tabnm
	set dr = db.execute(sql)
	recordcount = int(dr(0))
	dr.close

	if recordcount > 0 then
		isRecod = True
		pagecount=int((recordcount-1)/pagesize)+1
		lyno = recordcount - ((intpg - 1) * pagesize)
		sql = "select  top " & pagesize & strClmn & "from " & tabnm & " where qidx not in (select top " & ((intpg -1 ) * pagesize) & " qidx from " & tabnm & " order by qidx desc) order by qidx desc"
	end If
	
Else

	varPage = "gbnS=" & gbnS & "&strPart=" & strPart & "&strSearch=" & strSearch

	dim query
	query = strPart & " like '%" & Replace(strSearch,"'","''") & "%'"

	sql = "select count(qidx) from " & tabnm & " where " & query
	set dr = db.execute(sql)
	recordcount = int(dr(0))
	dr.close

	if recordcount > 0 then
		isRecod = True
		pagecount=int((recordcount-1)/pagesize)+1
		lyno = recordcount - ((intpg - 1) * pagesize)
		sql = "select  top " & pagesize & strClmn & "from " & tabnm & " where " & query & " and qidx not in (select top " & ((intpg -1 ) * pagesize) & " qidx from " & tabnm & " where " & query & " order by qidx desc) order by qidx desc"
	end if
end if %>
<!--#include file="../main/top.asp"-->

<script language="javascript">
function go2ListPage(pg){
	document.location.href="<%=Request("URL")%>?intpg=" + pg + "&<%=varPage%>";
}
function delLicen(idx,intpg,strPart,strSearch){
	delok = confirm("������ �����Ͻðڽ��ϱ�?");
	if(delok){
		location.href="qdel.asp?idx="+idx+"&intpg="+intpg+"&strPart="+strPart+"&strSearch="+strSearch+"";
	}
}
function go2Search(fm){
	var clmn = fm.strSearch;
	if(clmn.value==""){
		alert("��ȸ�� �ܾ �Է����ּ���!");
		clmn.focus();
		return false;
	}

	if(clmn.value.replace(/ /g,"")==""){
		alert("��ȸ�� �ܾ �Է����ּ���!");
		clmn.select();
		return false;
	}

	if(clmn.value.length < 2){
		alert("��ȸ�� �ܾ�� 2�� �̻� �Է��ؾ� �մϴ�.");
		clmn.select();
		return false;
	}
return true;
}
</script>

<div class="container">
	<!--#include file="left.asp"-->
	<div class="content">
		<h2 class="cTit"><span class="bullet"></span>�������亯</h2>

<form name="form1" method="post" action="?">
		<div class="schWrap1">
			<h3>�˻�</h3>
			<div class="sch_area1">
				<select id="strPart" name="strPart" class="seltxt">
					<option value="qtitle" <%If strPart="qtitle" Then Response.write"selected" End if%>>����</option>
					<option value="quserid" <%If strPart="quserid" Then Response.write"selected" End if%>>���̵�</option>
				</select>
				<input type="text" name="strSearch" id="strSearch" class="inptxt" value="<%=request("strSearch")%>" /></div>
			<a href="javascript:document.form1.submit();" class="btn_search1">�˻�</a>		
		</div>
</form>

		<div class="tbl_top">
			��ü <%=recordcount%>�� (<%=intpg%>page/<%=pagecount%>pages)
		</div>

<% if isRecod Then

				set dr = db.execute(sql)
				isRows = split(dr.GetString(2),chr(13)) 
%>
		<table class="tbl" style="width:100%">
			<colgroup>
			<col style="width:8%" />
			<col />
			<col style="width:10%" />
			<col style="width:10%" />
			<col style="width:8%" />
			<col style="width:8%" />
			</colgroup>
			<thead>
				<tr>
					<th>��ȣ</th>	
					<th>����</th>
					<th>���̵�</th>
					<th>�����</th>	
					<th>����</th>
					<th>����</th>
				</tr>				
			</thead>
			<tbody>
<%
				for ii = 0 to UBound(isRows) - 1
						isCols = split(isRows(ii),chr(9))
%>
						<tr>
							<td><%=lyno%></td>
							<td class="tl"><a href="qneyong.asp?idx=<%=isCols(0)%>&intpg=<%=intpg%>&<%=varPage%>"><%=isCols(2)%></a></td>
							<td><%=isCols(1)%></td>
							<td><%=formatdatetime(isCols(4),2)%></td>
							<td><%=isCols(3)%></td>
						    <td><a href="javascript:delLicen('<%=isCols(0)%>','<%=intpg%>','<%=request("strPart")%>','<%=request("strSearch")%>');" class="btns trans">����</a></td>
						</tr>
						<% lyno = lyno - 1
						Next %>
			</tbody>
		</table>

		<div class="cbtn mb80">
<%
blockPage = int((intpg-1)/10) * 10 + 1
%>
			<div class="paging">
			<% if blockPage > 1 Then %>
				<a href="javascript:go2ListPage('1');"><img src="/yes_rad/rad_img/img/a_prev2.gif" alt="ó��������"></a>
				<a href="javascript:go2ListPage('<%=int(blockPage-1)%>');"><img src="/yes_rad/rad_img/img/a_prev1.gif" alt="����������" /></a>
			<%End if%>
			<% ii = 1
									Do Until ii > 10 or blockPage > pagecount
									if blockPage = int(intpg) then %>
				<strong><%=blockPage%></strong><% else %>
				<a href="javascript:go2ListPage('<%=blockPage%>');" class="num"><%=blockPage%></a>
				<% end if
									blockPage = blockPage + 1
									ii = ii + 1
									Loop %>
			<% if blockPage > pagecount then 
			else
			%>
				<a href="javascript:go2ListPage('<%=blockPage%>');"><img src="/yes_rad/rad_img/img/a_next1.gif" alt="����������"></a>
				<a href="javascript:go2ListPage('<%=pagecount%>');"><img src="/yes_rad/rad_img/img/a_next2.gif" alt="������������"></a>
			<%End if%>
			</div>
		</div>

<%End if%>


	</div>
</div>

</body>
</html>
<!-- #include file = "../authpg_2.asp" -->