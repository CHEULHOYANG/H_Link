<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/dbcon.asp" -->
<%
Dim sql,dr,isRecod,isRows,isCols,rs,pagesize
Dim intpg,blockPage,pagecount,recordcount,lyno
Dim gbnS,strPart,strSearch
Dim tabnm : tabnm = "member"
Dim varPage,sql1,gm

Dim nowPage : nowPage = Request("URL")

intpg = Request("intpg")
if intpg = "" then
	intpg = 1
else
	intpg = int(intpg)
end if

If request("gm1") = 0 then

	pagesize = 50
	response.cookies("gm1") = 50

Else

	pagesize = request("gm1")
	response.cookies("gm1") = request("gm1")

End if

Dim strClmn : strClmn = " idx,id,name,juminno2,email,regdate,login_count,tel2,sp1 "

gbnS = Request("gbnS")
gm = request("gm")

if gbnS = "" Then

	If Len(gm) > 0 then

		sql = "select Count(idx) from " & tabnm &" where sp1 = "& request("gm") &""
		set dr = db.execute(sql)
		recordcount = int(dr(0))
		dr.close

		if recordcount > 0 then
			isRecod = True
			pagecount=int((recordcount-1)/pagesize)+1
			lyno = recordcount - ((intpg - 1) * pagesize)
			sql = "select  top " & pagesize & strClmn & "from " & tabnm & " where sp1 = "& request("gm") &" and idx not in (select top " & ((intpg -1 ) * pagesize) & " idx from " & tabnm & " where sp1 = "& request("gm") &" order by idx desc) order by idx desc"
		end If
	
	Else

		sql = "select Count(idx) from " & tabnm
		set dr = db.execute(sql)
		recordcount = int(dr(0))
		dr.close

		if recordcount > 0 then
			isRecod = True
			pagecount=int((recordcount-1)/pagesize)+1
			lyno = recordcount - ((intpg - 1) * pagesize)
			sql = "select  top " & pagesize & strClmn & "from " & tabnm & " where idx not in (select top " & ((intpg -1 ) * pagesize) & " idx from " & tabnm & " order by idx desc) order by idx desc"
		end If

	End if

else

	strPart = Request("strPart")
	strSearch = Request("strSearch")

	dim query

	If Len(gm) > 0 then
		query = strPart & " like '%" & Replace(strSearch,"'","''") & "%' and sp1 = "& request("gm") &""
	Else
		query = strPart & " like '%" & Replace(strSearch,"'","''") & "%' "
	End if

	sql = "select count(idx) from " & tabnm & " where " & query
	set dr = db.execute(sql)
	recordcount = int(dr(0))
	dr.close

	if recordcount > 0 then
		isRecod = True
		pagecount=int((recordcount-1)/pagesize)+1
		lyno = recordcount - ((intpg - 1) * pagesize)
		sql = "select  top " & pagesize & strClmn & "from " & tabnm & " where " & query & " and idx not in (select top " & ((intpg -1 ) * pagesize) & " idx from " & tabnm & " where " & query & " order by idx desc) order by idx desc"
	end if

end if
varPage = "gm="& gm &"&gbnS=" & gbnS & "&strPart=" & strPart & "&strSearch=" & strSearch
%>
<!--#include file="../main/top.asp"-->

<script language="javascript">
function go2ListPage(pg){
	document.location.href="<%=nowPage%>?intpg=" + pg + "&<%=varPage%>";
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

function go2Search(form1){
	var clmn = fm.strSearch;
	if(clmn.value==""){
		alert("��ȸ�� �ܾ �Է����ּ���!");
		clmn.focus();
		return;
	}

	if(clmn.value.replace(/ /g,"")==""){
		alert("��ȸ�� �ܾ �Է����ּ���!");
		clmn.select();
		return;
	}

	if(clmn.value.length < 2){
		alert("��ȸ�� �ܾ�� 2�� �̻� �Է��ؾ� �մϴ�.");
		clmn.select();
		return;
	}
	document.form1.submit();
}

function go2View(idx){
	location.href="view.asp?idx=" + idx + "&<%=varPage%>&intpg=<%=intpg%>";
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
		document.chfm.action="deletemember.asp";
		document.chfm.submit();
	}
}
function delteAll1(chkobj){
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

	delok = confirm("üũ�� ȸ�� �׷��� �����մϴ�");
	if(delok){
		document.chfm.action="deletemember1.asp";
		document.chfm.submit();
	}
}
</script>

<div class="container">
	<!--#include file="left.asp"-->
	<div class="content">
		<h2 class="cTit"><span class="bullet"></span>ȸ�����</h2>

<form name="form1" method="get" action="<%=nowPage%>">
<input type="hidden" name="gbnS" value="s">
<input type="hidden" name="gm" value="<%=request("gm")%>">
		<div class="schWrap1">
			<h3>�˻�</h3>
			<div class="sch_area1">
				<select id="strPart" name="strPart" class="seltxt">
                                              <option value="id" <%If request("strPart") = "id" Then Response.write"selected" End if%>>���̵�</option>
                                              <option value="name" <%If request("strPart") = "name" Then Response.write"selected" End if%>>�� ��</option>
                                              <option value="email" <%If request("strPart") = "email" Then Response.write"selected" End if%>>�̸���</option>
                                              <option value="tel2" <%If request("strPart") = "tel2" Then Response.write"selected" End if%>>�޴���</option>
				</select>
				<input type="text" name="strSearch" id="strSearch" class="inptxt" value="<%=request("strSearch")%>" /></div>
			<a href="javascript:document.form1.submit();" class="btn_search1">�˻�</a>		
		</div>
</form>

		<div class="tbl_top">

<form name="gm_form" method="post" action="?"><select name="gm" id="gm" onChange="document.gm_form.submit();">
                <option<% if request("gm") = "" then response.write " selected" %> value="">��ü</option>
                <%
sql1 = "select idx,title from group_mast where gu = 0 "
set rs=db.execute(sql1)

if rs.eof or rs.bof then
else
do until rs.eof
%>
                <option<% if request("gm") = ""& rs(0) &"" then response.write " selected" %> value="<%=rs(0)%>"><%=rs(1)%></option>
                <%
rs.movenext
loop
rs.close
end if
%>
              </select></form>

<form name="gm_form1" method="post" action="?">
<input type="hidden" name="intpg" value="<%=intpg%>">
<input type="hidden" name="gm" value="<%=request("gm")%>">
<input type="hidden" name="gbnS" value="<%=request("gbnS")%>">
<input type="hidden" name="strPart" value="<%=request("strPart")%>">
<input type="hidden" name="strSearch" value="<%=request("strSearch")%>">
				<select name="gm1" id="gm1" onChange="document.gm_form1.submit();" style="margin:0 0 0 10px">
                <option<% if request("gm1") = "20" then response.write " selected" %> value="20">20</option>
				<option<% if request("gm1") = "50" then response.write " selected" %> value="50">50</option>
				<option<% if request("gm1") = "70" then response.write " selected" %> value="70">70</option>
				<option<% if request("gm1") = "100" then response.write " selected" %> value="100">100</option>
              </select>
</form>

			<span class="tbl_total">��ü <%=recordcount%>�� (<%=intpg%>page/<%=pagecount%>pages)&nbsp;&nbsp;<a href="list_excel.asp?gm=<%=request("gm")%>" class="sbtn">�����������ϱ�</a></span>
		</div>

<%
if isRecod then
				Dim sex
				set dr = db.execute(sql)
				isRows = split(dr.GetString(2),chr(13))
                %>          
<form name="chfm" method="post">
<input type="hidden" name="intpg" value="<%=intpg%>">
<input type="hidden" name="gm" value="<%=request("gm")%>">
<input type="hidden" name="gbnS" value="<%=request("gbnS")%>">
<input type="hidden" name="strPart" value="<%=request("strPart")%>">
<input type="hidden" name="strSearch" value="<%=request("strSearch")%>">
		<table class="tbl" style="width:100%">
			<colgroup>
			<col style="width:5%" />
			<col style="width:20%" />
			<col style="width:25%" />
			<col style="width:15%" />
			<col style="width:10%" />
			<col style="width:10%" />
			<col style="width:15%" />
			</colgroup>
			<thead>

				<tr>
					<th><img src="/yes_rad/rad_img/img/noncheck.gif" style="cursor:pointer;" onClick="AllCheck(this,document.all.idx);"></th>	
					<th>�̸�(���̵�)</th>
					<th>�̸����ּ�</th>
					<th>����ó</th>	
					<th>����Ƚ��</th>	
					<th>������</th>
					<th>���</th>
				</tr>				
			</thead>
			<tbody>
<% for ii = 0 to UBound(isRows) - 1
						isCols = split(isRows(ii),chr(9))
						%>
				<tr>
					<td><input type="checkbox" name="idx" value="<%=isCols(0)%>"></td>
					<td><span style="cursor:pointer;" onClick="go2View('<%=isCols(0)%>');"><%=isCols(2)%>(<%=isCols(1)%>)</span></td>
					<td><span style="cursor:pointer;" onClick="go2View('<%=isCols(0)%>');"><%=isCols(4)%></span></td>
					<td><span style="cursor:pointer;" onClick="go2View('<%=isCols(0)%>');"><%=isCols(7)%></span></td>
					<td><span style="cursor:pointer;" onClick="go2View('<%=isCols(0)%>');"><%=isCols(6)%>ȸ</span></td>
					<td><span style="cursor:pointer;" onClick="go2View('<%=isCols(0)%>');"><%=Formatdatetime(isCols(5),2)%></span></td>
					<td><a href="user_login.asp?usrid=<%=isCols(1)%>" target="_blank" class="btns trans">ȸ���α���</a>&nbsp;<a href="javascript:window.open('../sub3_sms/user_sms.asp?to_id=<%=isCols(7)%>','sms','width=750,height=520,menubar=no,scrollbars=no');" class="btns trans">���ڹ߼�</a></td>
				</tr>
<% lyno = lyno - 1
						Next %>
			</tbody>
		</table>

		<div class="tbl_top">
			<a href="javascript:delteAll(document.all.idx);" class="fbtn1">���� ����</a>	

			<span class="tbl_total"> <select name="ssp1" id="ssp1" >
			<option value="0">ȸ���׷�</option>
                <%
sql1 = "select idx,title from group_mast where gu = 0 "
set rs=db.execute(sql1)

if rs.eof or rs.bof then
else
do until rs.eof
%>
                <option value="<%=rs(0)%>"><%=rs(1)%></option>
                <%
rs.movenext
loop
rs.close
end if
%>
              </select>
			  
			  <select name="ssp2" id="ssp2" >
			  <option value="0">���ڱ׷�</option>
                <%
sql1 = "select idx,title from group_mast where gu = 1 "
set rs=db.execute(sql1)

if rs.eof or rs.bof then
else
do until rs.eof
%>
                <option value="<%=rs(0)%>"><%=rs(1)%></option>
                <%
rs.movenext
loop
rs.close
end if
%>
              </select>
			  
			  <a href="javascript:delteAll1(document.all.idx);" class="fbtn">���� �׷� ����</a></span>
		</div>

<%End if%>

</form>

<% if isRecod Then%>
		<div class="cbtn">
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

<div class="caution"><p>ȸ���������� Ŭ���Ͻø� ����������� ȸ���α����� �ϽǼ� �ֽ��ϴ�.</p></div>
<div class="caution"><p>ȸ���� Ŭ���Ͻø� �������� ��Ϲ� �������� ���������� �ٷ� �����մϴ�.</p></div>
<div class="caution"><p>���ڸ� �����Ͻø� �ٷ� ȸ������ ���ڸ� �߼��Ҽ� �ֽ��ϴ�.</p></div>

	</div>
</div>
</body>
</html>
<!-- #include file = "../authpg_2.asp" -->