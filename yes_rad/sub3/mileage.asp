<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/dbcon.asp" -->
<%

dim sdate,edate,SearchPart,SearchStr,rs1
dim strPart,strSearch,sq
dim price,gu,g_title,regdate
dim page,recordcount,pagecount,totalpage,i,blockpage,pagesize
dim gu_price1,gu_price2,id,rest_price,sql,rs,sp6,sp1,t_price1,t_price2,idx,search_go

if request("page")="" then
   page=1
   else 
   page=request("page")
end if

If request("gm1") = 0 then

	pagesize = 50
	response.cookies("gm1") = 50

Else

	pagesize = request("gm1")
	response.cookies("gm1") = request("gm1")

End if

search_go=request("search_go")
strPart=request("strPart")
strSearch = request("strSearch")
sdate = request("sdate")
edate = request("edate")

if request("search_go")="1" Then

	sq = ""

	if Len(strSearch) > 0 then
		sq = ""& strPart &" like '%"& strSearch &"%'"
	end if
	
	if Len(sdate) > 0 And Len(edate) > 0 then
		
		if Len(sq) > 0 then
			sq = ""& sq &" and (regdate between convert(smalldatetime,'" & sdate & " 00:00')" & " and convert(smalldatetime,'" & edate & " 23:59'))"
		else
			sq = ""& sq &" (regdate between convert(smalldatetime,'" & sdate & " 00:00')" & " and convert(smalldatetime,'" & edate & " 23:59'))"
		end if
		
	end if
	
	sql = "select count(idx) as reccount from mileage where "& sq &""
	set rs=db.execute(sql)
	recordcount =rs(0)
	pagecount=int((recordcount-1)/pagesize)+1
	sql = "SELECT top " & pagesize & " price,gu,g_title,regdate,id,idx from mileage where "& sq &" and idx not in"
	sql = sql & "(select top " & ((page -1 ) * pagesize) & " idx from mileage where "& sq &" order by idx desc)order by idx desc"
	set rs=db.execute(sql)

else

	sql = "select count(idx) as reccount from mileage "
	set rs=db.execute(sql)
	recordcount =rs(0)
	pagecount=int((recordcount-1)/pagesize)+1
	sql = "SELECT top " & pagesize & " price,gu,g_title,regdate,id,idx from mileage where idx not in"
	sql = sql & "(select top " & ((page -1 ) * pagesize) & " idx from mileage order by idx desc)order by idx desc"
	set rs=db.execute(sql)

end if

%>
<!--#include file="../main/top.asp"-->

<script>
function check_del(theForm){

var num = <%=recordcount%>;
var sel_check = false;

if(num == 0) alert("������ ����� �����ϴ�");


else if(num == 1) {


    if(frmlist.idx.checked) sel_check = true;
    if(sel_check){
            var del_check = window.confirm("üũ�� ����� �ϰ������մϴ�");
            if(del_check) 
			document.frmlist.action="mileage_check_del.asp";
			document.frmlist.submit();
    } else alert("������ ����� �������ּ���.");


} else if(num > 1) {


    var idx_len = theForm.idx.length;

    for (i=0; i < idx_len; i++){
         if(theForm.idx[i].checked){
            sel_check = true;
            break;
         }
    }
    if(sel_check){
         var del_check = window.confirm("üũ�� ����� �ϰ������մϴ�"); 
         if(del_check)
		 document.frmlist.action="mileage_check_del.asp";
		 document.frmlist.submit();
     } else alert("������ ����� �������ּ���");


}


} 

function ToggleCheckAll(button) {
	var sa=true;
	if(button.checked) sa=false;
	for (var i=0;i<document.frmlist.elements.length;i++) {
		var e = document.frmlist.elements[i];
		if(sa) e.checked=false;
		else e.checked=true;
	}
	if(sa) button.checked=false;
	else button.checked=true;
}

function setDate(obj,from,to)
{
	var obj = document.getElementsByName(obj);
	obj[0].value = (from) ? from : "";
	//obj[1].value = (from) ? to : "";
}

function select_search_form(theform){
	
	var f = eval('document.'+theform+'');
	
	if((f.search_check1.checked==false) && (f.search_check6.checked==false)){
	alert('�˻��� �Ͻñ� ���� �˻������� �������ּ���');
	return;
	}
	
	f.submit();
}
</script>

<div class="container">
	<!--#include file="left.asp"-->
	<div class="content">
		<h2 class="cTit"><span class="bullet"></span>�����ݳ���</h2>

<form name="form1" method="get" action="<%=Request("URL")%>">
<input type="hidden" name="page" value="<%=page%>">
<input type="hidden" name="search_go" value="1">
		<div class="schWrap">
			<h3>�˻�</h3>
			<div class="sch_area" style="line-height:40px">
				<input class="inptxt1 w100" id="sdate" value="<%=sdate%>" name="sdate" readonly /> ~ <input class="inptxt1 w100" id="edate" value="<%=edate%>" name="edate" readonly /><br />
				<select name="strPart" class="seltxt">
                      <option value="id" <%if strPart="id" then response.write"selected" end if%>>���̵�</option>
                </select>
				<input type="text" id="strSearch" name="strSearch" class="inptxt" value="<%=strSearch%>" /></div>
			<a href="javascript:document.form1.submit();" class="btn_search">�˻��ϱ�</a>		
		</div>
</form>

		<div class="tbl_top">
<form name="gm_form1" method="post" action="?">
<input type="hidden" name="page" value="<%=page%>">
<input type="hidden" name="search_go" value="<%=search_go%>">
<input type="hidden" name="sdate" value="<%=sdate%>">
<input type="hidden" name="edate" value="<%=edate%>">
<input type="hidden" name="strPart" value="<%=strPart%>">
<input type="hidden" name="strSearch" value="<%=strSearch%>">
				<select name="gm1" id="gm1" onChange="document.gm_form1.submit();">
                <option<% if request("gm1") = "20" then response.write " selected" %> value="20">20</option>
				<option<% if request("gm1") = "50" then response.write " selected" %> value="50">50</option>
				<option<% if request("gm1") = "70" then response.write " selected" %> value="70">70</option>
				<option<% if request("gm1") = "100" then response.write " selected" %> value="100">100</option>
              </select>
</form>

			<span class="tbl_total">��ü <%=recordcount%>�� (<%=page%>page/<%=pagecount%>pages)&nbsp;<a href="mileage_excel.asp" class="sbtn">�����������ϱ�</a></span>
		</div>
<form name="frmlist" method="post" >
<input type="hidden" name="page" value="<%=page%>">
<input type="hidden" name="search_go" value="<%=search_go%>">
<input type="hidden" name="sdate" value="<%=sdate%>">
<input type="hidden" name="edate" value="<%=edate%>">
<input type="hidden" name="strPart" value="<%=strPart%>">
<input type="hidden" name="strSearch" value="<%=strSearch%>">

		<table class="tbl" style="width:100%">
			<colgroup>
			<col style="width:5%" />
			<col style="width:15%" />
			<col style="width:15%" />
			<col />
			<col style="width:10%" />
			<col style="width:10%" />
			</colgroup>
			<thead>
				<tr>
					<th><input type="checkbox" name="CheckAll" onClick="ToggleCheckAll(this)"></th>	
					<th>���̵�</th>
					<th>��¥</th>
					<th>���γ���</th>
					<th>����</th>	
					<th>����</th>								
				</tr>				
			</thead>
			<tbody>
<%
if rs.eof or rs.bof then
else
t_price1 = 0
t_price2 = 0
do until rs.eof 
price=rs(0)
gu=rs(1)
if gu=1 then
gu_price1=price
gu_price2=0
elseif gu=2 then
gu_price1=0
gu_price2=price
end if
g_title=rs(2)
regdate=rs(3)
id=rs(4)
idx = rs(5)
%>
				<tr>
					<td><input type="checkbox" name="idx" value="<%=idx%>"></td>
					<td><%=id%></td>
					<td><%=right(FormatDateTime(regdate,2),10)%>&nbsp;<%=FormatDateTime(regdate,4)%></td>
					<td class="tl"><%=g_title%></td>
					<td><font color="#cc0000"><%=formatnumber(gu_price2,0)%>��</font></td>
					<td><font color="#336699"><%=formatnumber(gu_price1,0)%>��</font></td>
				</tr>
<%
rs.movenext
t_price1 = t_price1 + gu_price2
t_price2 = t_price2 + gu_price1
loop
end if
rs.close
%>
			</tbody>
		</table>
</form>

		<div class="tbl_btm mb80">
			<div class="paging">
				<a href="?page=1&search_go=<%=request("search_go")%>&strSearch=<%=request("strSearch")%>&strPart=<%=request("strPart")%>"><img src="/yes_rad/rad_img/img/a_prev2.gif" alt="ó��������"></a>
<%
blockPage=Int((page-1)/10)*10+1
if blockPage = 1 Then
Else
%>
<a href="?page=<%=blockPage-10%>&search_go=<%=request("search_go")%>&strSearch=<%=request("strSearch")%>&strPart=<%=request("strPart")%>"><img src="/yes_rad/rad_img/img/a_prev1.gif" alt="����������" /></a>
<%
End If
   i=1
   Do Until i > 10 or blockPage > pagecount
      If blockPage=int(page) Then
%>
<strong><%=blockPage%></strong>
<%Else%>
<a href="?page=<%=blockPage%>&search_go=<%=request("search_go")%>&strSearch=<%=request("strSearch")%>&strPart=<%=request("strPart")%>" class="num"><%=blockPage%></a>
<%
End If    
blockPage=blockPage+1
i = i + 1
Loop

if blockPage > pagecount Then
Else
%>
<a href="?page=<%=blockPage%>&search_go=<%=request("search_go")%>&strSearch=<%=request("strSearch")%>&strPart=<%=request("strPart")%>"><img src="/yes_rad/rad_img/img/a_next1.gif" alt="����������"></a>
<%
End If
%>	
				<a href="?page=<%=pagecount%>&search_go=<%=request("search_go")%>&strSearch=<%=request("strSearch")%>&strPart=<%=request("strPart")%>"><img src="/yes_rad/rad_img/img/a_next2.gif" alt="������������"></a>			
			</div>
			<div class="rbtn">
				<a href="javascript:check_del(document.frmlist);" class="btn">���û���</a>

			</div>
		</div>

	</div>
</div>

</body>
</html>
<!-- #include file = "../authpg_2.asp" -->

<link rel="stylesheet" href="../../include/pikaday.css">
<script src="../../include/moment.js"></script>
<script src="../../include/pikaday.js"></script>

<script>
    var picker = new Pikaday(
    {
        field: document.getElementById('sdate'),
        firstDay: 1,
		format: "YYYY-MM-DD",
        minDate: new Date('<%=left(date(),4)-10%>-01-01'),
        maxDate: new Date('<%=left(date(),4)+10%>-12-31'),
        yearRange: [<%=left(date(),4)-10%>,<%=left(date(),4)+10%>]
    });
    var picker1 = new Pikaday(
    {
        field: document.getElementById('edate'),
        firstDay: 1,
		format: "YYYY-MM-DD",
        minDate: new Date('<%=left(date(),4)-10%>-01-01'),
        maxDate: new Date('<%=left(date(),4)+10%>-12-31'),
        yearRange: [<%=left(date(),4)-10%>,<%=left(date(),4)+10%>]
    });
</script>