<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/dbcon.asp" --><%
Dim sql,dr,rownum,isRecod,isRows,isCols
Dim intpg,blockPage,pagecount,recordcount,lyno
Dim gbnS,strPart,strSearch
dim icon,icon_count,jj

rownum = 0
Dim tabnm : tabnm = "LectMast"
Dim varPage

Dim nowPage : nowPage = Request("URL")

intpg = Request("intpg")

if intpg = "" then
	intpg = 1
else
	intpg = int(intpg)
end if

const pagesize = 40

Dim strClmn : strClmn = " idx,strnm,cnt=(select count(idx) from LectAry where mastidx=A.idx),ordn,icon,recom,state,readnum "

gbnS = Request("gbnS")
strPart = Request("strPart")
strSearch = Request("strSearch")

if strPart = "" then
	if gbnS = "" then
		sql = "select count(idx) from " & tabnm
		set dr = db.execute(sql)
		recordcount = int(dr(0))

		if recordcount > 0 then
			isRecod = True
			pagecount=int((recordcount-1)/pagesize)+1
			lyno = recordcount - ((intpg - 1) * pagesize)
			sql = "select  top " & pagesize & strClmn & "from " & tabnm & " A where idx not in (select top " & ((intpg -1 ) * pagesize) & " idx from " & tabnm
			sql = sql & " order by ordn asc) order by ordn asc"
		end if
	else
		sql = "select count(idx) from " & tabnm & " where strnm like '%" & replace(strSearch,"'","''") & "%'"
		set dr = db.execute(sql)
		recordcount = int(dr(0))

		if recordcount > 0 then
			isRecod = True
			pagecount=int((recordcount-1)/pagesize)+1
			lyno = recordcount - ((intpg - 1) * pagesize)
			sql = "select  top " & pagesize & strClmn & "from " & tabnm & " A where strnm like '%" & replace(strSearch,"'","''") & "%' and idx not in (select top " & ((intpg -1 ) * pagesize) & " idx from " & tabnm
			sql = sql & " where strnm like '%" & replace(strSearch,"'","''") & "%' order by ordn asc) order by ordn asc"
		end if
	end if
else
	if gbnS = "" then
		sql = "select count(idx) from " & tabnm & " where gbn=" & strPart
		set dr = db.execute(sql)
		recordcount = int(dr(0))

		if recordcount > 0 then
			isRecod = True
			pagecount=int((recordcount-1)/pagesize)+1
			lyno = recordcount - ((intpg - 1) * pagesize)
			sql = "select  top " & pagesize & strClmn & "from " & tabnm & " A where gbn=" & strPart & " and idx not in (select top " & ((intpg -1 ) * pagesize) & " idx from " & tabnm
			sql = sql & " where gbn=" & strPart & " order by ordn asc) order by ordn asc"
		end if
	else
		sql = "select count(idx) from " & tabnm & " where gbn=" & strPart & " and strnm like '%" & replace(strSearch,"'","''") & "%'"
		set dr = db.execute(sql)
		recordcount = int(dr(0))

		if recordcount > 0 then
			isRecod = True
			pagecount=int((recordcount-1)/pagesize)+1
			lyno = recordcount - ((intpg - 1) * pagesize)
			sql = "select  top " & pagesize & strClmn & "from " & tabnm & " A where gbn=" & strPart & " and strnm like '%" & replace(strSearch,"'","''") & "%' and idx not in (select top " & ((intpg -1 ) * pagesize) & " idx from " & tabnm
			sql = sql & " where gbn=" & strPart & " and strnm like '%" & replace(strSearch,"'","''") & "%' order by ordn asc) order by ordn asc"
		end if
	end if
end if
varPage = "gbnS=" & gbnS & "&strSearch=" & strSearch & "&strPart=" & strPart %>

<!--#include file="../main/top.asp"-->

<script language="javascript">
function go2ListPage(pg){
	document.location.href="<%=nowPage%>?intpg=" + pg + "&<%=varPage%>";
}

function delMast(idxn){
	delok = confirm("������ �����Ͻðڽ��ϱ�?");
	if(delok){
		location.href="mst_del.asp?idx=" + idxn;
	}
}

function UpDwnord(plgun,idxn,m){
	var mxum = <%=rownum%>;
	var flg = false;

	if(plgun=="up"){
		if(parseInt(m,10) > 1) flg = true;
	}
	else{
		if(parseInt(m,10) < mxum) flg = true;
	}

	if(flg){
		location.href="mst_ordn.asp?idx=" + idxn + "&ordgbn=" + plgun;
	}
}

function go2Search(){
	
	var clmn = document.form1.strSearch;

	if(clmn.value==""){
		alert("��ȸ�Ͻ� �˻�� �Է����ּ���!");
		clmn.focus();
		return;
	}

	if(clmn.value.replace(/ /g,"")==""){
		alert("��ȸ�Ͻ� �˻�� �Է����ּ���!");
		clmn.select();
		return;
	}

	if(clmn.value.length < 2){
		alert("�˻����� 2�� �̻� �Է��ؾ� �մϴ�.");
		clmn.select();
		return;
	}
	document.form1.submit();
}
</script>

<div class="container">
	<!--#include file="left.asp"-->
	<div class="content">
		<h2 class="cTit"><span class="bullet"></span>��Ű�����°���</h2>

<form name="form1" method="get" action="<%=nowPage%>">
<input type="hidden" name="gbnS" value="s">
		<div class="tbl_top">
			<select class="seltxt w200" name="strPart" onChange="location.href='<%=nowPage%>?strPart=' + this.value;">
										<option value="">��ü</option><% set dr = db.execute("select idx,bname from mscate order by ordnum")
										if not dr.bof or not dr.eof then
										do until dr.eof %>
										<option<% if strPart = CStr(dr(0)) then response.write " selected"%> value="<%=dr(0)%>"><%=dr(1)%></option><% dr.moveNext
										loop
										end if
										dr.close %>
									</select> &nbsp;<input type="text" name="strSearch" class="inptxt1 w200" value="<%=request("strSearch")%>"> <a href="javascript:go2Search();" class="fbtn">�˻�</a>	 <a href="mst_reg.asp" class="fbtn1">��Ű�� ����ϱ�</a>
			<span class="tbl_total">��ü <%=recordcount%>�� (<%=intpg%>page/<%=pagecount%>pages)</span>
		</div>
</form>

<% if isRecod then
				set dr = db.execute(sql)
				if not dr.bof or not dr.eof then
					isRows = split(dr.getstring(2),chr(13))
					rownum = UBound(isRows)
				end if
				dr.close %>
		<table class="tbl" style="width:100%">
			<colgroup>
			<col style="width:10%" />
			<col />
			<col style="width:15%" />
			<col style="width:10%" />
			<col style="width:10%" />
			</colgroup>
			<thead>
				<tr>
					<th>����</th>	
					<th>������</th>
					<th>�ܰ���</th>
					<th>��ȸ</th>	
					<th>���</th>						
				</tr>				
			</thead>
			<tbody>
<% for ii = 0 to rownum - 1
						isCols = split(isRows(ii),chr(9)) %>
						<tr >
							<td><%=isCols(3)%></td>
							<td class="tl"><%If isCols(6) =1 Then Response.write"<font color='#cc0000'>[����]</font>&nbsp;" End if%><%If isCols(5) =1 Then Response.write"<font color='#ff6633'>[����]</font>&nbsp;" End if%><span style="cursor:pointer;color:#000000;" onMouseOver="this.style.color='#FF6600';" onMouseOut="this.style.color='#000000';" onClick="location.href='mst_edit.asp?idx=<%=isCols(0)%>&intpg=<%=intpg%>&<%=varPage%>';"><strong><%=isCols(1)%></strong></span><%                        	
				icon = split(isCols(4),",")
				icon_count = ubound(icon)
				for jj=0 to icon_count
					if len(trim(icon(jj))) > 5 then
					response.write "&nbsp;<img src='/ahdma/logo/"& trim(icon(jj)) &"'>"
					end if
				next						
				%></td>
							<td><%=isCols(2)%>��</td>
							<td><%=isCols(7)%></td>
							<td><a href="mst_edit.asp?idx=<%=isCols(0)%>&intpg=<%=intpg%>&<%=varPage%>" class="btns trans">����</a> <a href="javascript:delMast('<%=isCols(0)%>');" class="btns trans">����</a></td>
						</tr><% Next %>
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

<div class="caution"><p>��Ű���� �����ϱ��� �� ��Ű��ī�װ����� ������ֽñ� �ٶ��ϴ�.</p></div>
<div class="caution"><p>�ܰ��� ����ϼž� ��Ű���� �����ϽǼ� �ֽ��ϴ�.</p></div>
<div class="caution"><p>���Ǵ� ������ ���ؼ� ������ �˴ϴ�.</p></div>

	</div>
</div>

</body>
</html>
<!-- #include file = "../authpg_2.asp" -->