<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/dbcon.asp" -->
<%
Dim sql,dr,isRecod,isRows,isCols,rs1,title,pagesize
Dim intpg,blockPage,pagecount,recordcount,lyno
Dim gbnS,strPart,strSearch
Dim tabnm : tabnm = "coupon_price_mast"
Dim varPage

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

Dim strClmn : strClmn = " idx,cnumber,state,id,use_date,price,end_date,DATEDIFF (day,getdate(),end_date) "

gbnS = Request("gbnS")

if gbnS = "" then

	sql = "select Count(idx) from " & tabnm
	set dr = db.execute(sql)
	recordcount = int(dr(0))
	dr.close

	if recordcount > 0 then
		isRecod = True
		pagecount=int((recordcount-1)/pagesize)+1
		lyno = recordcount - ((intpg - 1) * pagesize)
		sql = "select  top " & pagesize & strClmn & "from " & tabnm & " where idx not in (select top " & ((intpg -1 ) * pagesize) & " idx from " & tabnm & " order by idx desc) order by idx desc"
	end if

else

	strPart = Request("strPart")
	strSearch = Request("strSearch")

	dim query
	query = " "& strPart & " like '%" & Replace(strSearch,"'","''") & "%' "
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

end If

varPage = "gbnS=" & gbnS & "&strPart=" & strPart & "&strSearch=" & strSearch
%>
<!--#include file="../main/top.asp"-->

<script language="javascript">
function go2ListPage(pg){
	document.location.href="<%=nowPage%>?intpg=" + pg + "&<%=varPage%>";
}

function AllCheck(thisimg,chekID){
	var srcAry = thisimg.src.split("/");
	if(srcAry[srcAry.length-1] == "noncheck.gif"){
		thisimg.src = "../rad_img/allcheck.gif";
		isChecked(true,chekID);
	}else{
		thisimg.src = "../rad_img/noncheck.gif";
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

function go2Search(){

	var clmn = document.form1.strSearch;

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
		alert("�����Ͻ� ������ �������ּ���!");
		return;
	}

	delok = confirm("üũ�� ������ �����մϴ�");
	if(delok){

		document.chfm.action = "coupon_price_del.asp";
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
		alert("������ ������ �������ּ���!");
		return;
	}

	delok = confirm("üũ�� ������ �̻���������� �����մϴ�");
	if(delok){

		document.chfm.action = "coupon_price_return.asp";
		document.chfm.submit();
	}
}
</script>

<div class="container">
	<!--#include file="left.asp"-->
	<div class="content">
		<h2 class="cTit"><span class="bullet"></span>������������</h2>

<form name="form1" method="get" action="<%=nowPage%>">
<input type="hidden" name="gbnS" value="s">
		<div class="schWrap1">
			<h3>�˻�</h3>
			<div class="sch_area1">
				<select id="strPart" name="strPart" class="seltxt">
					<option value="id" <%if strPart="id" then response.write"selected" end if%>>���̵�</option>
					<option value="cnumber" <%if strPart="cnumber" then response.write"selected" end if%>>������ȣ</option>
				</select>
				<input type="text" name="strSearch" id="strSearch" class="inptxt" value="<%=request("strSearch")%>" /></div>
			<a href="javascript:go2Search();" class="btn_search1">�˻�</a>		
		</div>
</form>

		<div class="tbl_top">
<form name="gm_form1" method="post" action="?">
<input type="hidden" name="intpg" value="<%=intpg%>">
<input type="hidden" name="strPart" value="<%=request("strPart")%>">
<input type="hidden" name="strSearch" value="<%=request("strSearch")%>">
<input type="hidden" name="gbnS" value="<%=request("gbnS")%>">
				<select name="gm1" id="gm1" onChange="document.gm_form1.submit();">
                <option<% if request("gm1") = "20" then response.write " selected" %> value="20">20</option>
				<option<% if request("gm1") = "50" then response.write " selected" %> value="50">50</option>
				<option<% if request("gm1") = "70" then response.write " selected" %> value="70">70</option>
				<option<% if request("gm1") = "100" then response.write " selected" %> value="100">100</option>
              </select>
</form>			
			<span class="tbl_total">��ü <%=recordcount%> (<%=intpg%>page/<%=pagecount%>pages)&nbsp;<a href="coupon_price_list_excel.asp?<%=varPage%>&intpg=<%=intpg%>" class="sbtn">�ش������� �����������ϱ�</a></span>
		</div>

<% 
if recordcount > 0 then

	set dr = db.execute(sql)
	isRows = split(dr.GetString(2),chr(13)) 
%>
<form name="chfm" method="post">
<input type="hidden" name="intpg" value="<%=intpg%>">
<input type="hidden" name="strPart" value="<%=request("strPart")%>">
<input type="hidden" name="strSearch" value="<%=request("strSearch")%>">
<input type="hidden" name="gbnS" value="<%=request("gbnS")%>">
			  
		<table class="tbl" style="width:100%">
			<colgroup>
			<col style="width:5%" />
			<col style="width:17%" />			
			<col style="width:17%" />
			<col style="width:17%" />
			<col style="width:20%" />
			<col />			
			</colgroup>
			<thead>
				<tr>
					<th><img src="../rad_img/noncheck.gif" style="cursor:pointer;" onClick="AllCheck(this,document.all.idx);"></th>	
					<th>������ȣ</th>	
					<th>���αݾ�</th>	
					<th>��ȿ�Ⱓ</th>		
					<th>��뿩��</th>
					<th>�����ֹ�</th>
				</tr>				
			</thead>
			<tbody>
<%
for ii = 0 to UBound(isRows) - 1
isCols = split(isRows(ii),chr(9))						
%>
						<tr>
							<td><input type="checkbox" name="idx" value="<%=isCols(0)%>"></td>
							<td><%=isCols(1)%></td>
							<td><%=formatnumber(isCols(5),0)%>��</td>
							<td><%If isCols(7) < 0 then%><font color='#cc0000'>�Ⱓ����</font><%else%><%=isCols(6)%><%End if%></td>
							<td><%if isCols(2) = 1 then
	response.write ""& isCols(3) &"("& left(isCols(4),10) &")"
else
	response.write"�̻��"
end if%></td>
<td>
<%
sql = "select order_id from order_mast where charindex(',"& isCols(1) &"',cnumber) > 0 order by idx desc"
Set rs1=db.execute(sql)

If rs1.eof Or rs1.bof Then
Else
Do Until rs1.eof
	Response.write "<a href='pay_list.asp?gbnS=1&strpart=order_id&strSearch="& rs1(0) &"' target='_blank'>"& rs1(0) &"</a><br>"
rs1.movenext
loop
rs1.close
End if
%>
</td>
						</tr><% lyno = lyno - 1
						Next %>
			</tbody>
		</table>
</form>


		<div class="tbl_btm">
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
			<div class="rbtn">
				<a href="javascript:delteAll(document.all.idx);" class="btn">���û���</a>
				<a href="javascript:delteAll1(document.all.idx);" class="btn">�̻�뺯��</a>
			</div>
		</div>
<%End if%>

<div class="caution"><p>������ �ڵ�/�������� ������ �����մϴ�.</p></div>

	</div>
</div>


</body>
</html>
<!-- #include file = "../authpg_2.asp" -->