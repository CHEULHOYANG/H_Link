<!-- #include file="../include/set_loginfo.asp" -->
<% if isUsr then %>
<!-- #include file="../include/dbcon.asp" -->
<%
Dim intpg,blockPage,pagecount,recordcount,lyno,end_check
Dim tabnm : tabnm = "order_mast"

Dim nowPage : nowPage = Request("URL")

intpg = Request("intpg")
if intpg = "" then
	intpg = 1
else
	intpg = int(intpg)
end if

const pagesize = 10

Dim strClmn : strClmn = " titlenm = dbo.LectuTitle(tabidx,buygbn),title,regdate,(intprice-cprice-cash)+send_price,paytype=dbo.PayTypeStr(paytype),state=case state when 0 then 'btn_11.gif' else 'btn_10.gif' end,state,eday,bookidx,s_state,order_id,idx "

sql = "select Count(idx) from " & tabnm & " where (state = 0 or state =2) and bookidx=1 and id='" & str_User_ID & "'"
set dr = db.execute(sql)
recordcount = int(dr(0))
dr.close

if recordcount > 0 then
	isRecod = True
	pagecount=int((recordcount-1)/pagesize)+1
	lyno = recordcount - ((intpg - 1) * pagesize)
end if %>
<!-- #include file="../include/head1.asp" -->

<script language="javascript">
function go2ListPage(pg){
	document.location.href="<%=nowPage%>?intpg=" + pg;
}
</script>

<!-- #include file="../include/top.asp" -->

<div class="smain">    
	<!-- #include file="left.asp" -->
    <div class="content">
    	<div class="cont_tit">
        	<h3>�ֹ�/�����ȸ</h3>
        </div>
        <div class="scont">

			<table class="btbl mb80" style="width:830px">
					<colgroup>
						<col style="width:10%" />
						<col style="width:12%" />
						<col style="width:40%" />
						<col style="width:16%" />
						<col style="width:12%" />
						<col style="width:10%" />
					</colgroup>
					<thead>
						<tr>
							<th>��ȣ</th>								
							<th>�ֹ���ȣ</th>
							<th>��ǰ��</th>
							<th>�����ݾ�</th>
							<th>�����Ȳ</th>		
							<th>������</th>
						</tr>				
					</thead>
					<tbody>
<%
if isRecod Then

	sql = "select  top " & pagesize & strClmn & "from " & tabnm & " where (state = 0 or state =2) and bookidx=1 and id='" & str_User_ID & "' and idx not in (select top " & ((intpg -1 ) * pagesize) & " idx from " & tabnm & " where (state = 0 or state =2) and bookidx=1 and id='" & str_User_ID & "' order by idx desc) order by idx desc"
	set dr = db.execute(sql)
	isRows = split(dr.GetString(2),chr(13))

		for ii = 0 to UBound(isRows) - 1
		isCols = split(isRows(ii),chr(9))
			 
		end_check = DateDiff("d", date(),isCols(7))
%>
				<tr>
					<td><%=lyno%></td>
					<td onclick="self.location.href='08_view.asp?idx=<%=isCols(11)%>&intpg=<%=intpg%>';" style="cursor:pointer;"><font color='#CC0000'><%=isCols(10)%></font></td>
					<td class="tl" onclick="self.location.href='08_view.asp?idx=<%=isCols(11)%>&intpg=<%=intpg%>';" style="cursor:pointer;" >&nbsp;<%=isCols(1)%><%=isCols(0)%></td>
					<td><strong class="fr"><%=formatnumber(isCols(3),0)%></strong>��</td>
					<td><%If isCols(9) = 0 Then response.write"�����" End if%><%If isCols(9) = 1 Then response.write"�����" End if%><%If isCols(9) = 2 Then response.write"��ۿϷ�" End if%><%If isCols(9) = 3 Then response.write"�ֹ����" End if%><%If isCols(9) = 4 Then response.write"ȯ��" End if%><%If isCols(9) = 5 Then response.write"��ǰ" End if%></td>
					<td><%=replace(formatdatetime(isCols(2),2),"-",".")%></td>					
				</tr>
<%
			lyno = lyno - 1
		next
End If
%>
					</tbody>
				</table>

<%if isRecod then%>
		<div class="paging">
<%
blockPage = int((intpg-1)/10) * 10 + 1

if blockPage = 1 Then
else %>
			<a href="javascript:go2ListPage('1');"><img src="../img/img/a_prev2.gif" alt="ó��������"></a>			
			<a href="javascript:go2ListPage('<%=int(blockPage-1)%>');"><img src="../img/img/a_prev1.gif" alt="����������"></a>
<% end if

ii = 1
Do Until ii > 10 or blockPage > pagecount
	if blockPage = int(intpg) then 
%>
			<strong><%=blockPage%></strong>
<%	else	%>
			<a href="javascript:go2ListPage('<%=blockPage%>');" class="pnum"><%=blockPage%></a>
<%
end if
	blockPage = blockPage + 1
    ii = ii + 1
	Loop
	
if blockPage > pagecount then 
else %>
			<a href="javascript:go2ListPage('<%=blockPage%>');"><img src="../img/img/a_next1.gif" alt="����������"></a>			
			<a href="javascript:go2ListPage('<%=pagecount%>');"><img src="../img/img/a_next2.gif" alt="������������"></a>
<%End if%>
		</div>
<%End if%>

        </div>
    </div>
</div>

<!-- #include file="../include/bottom.asp" -->
<% else %><!-- #include file = "../include/false_pg.asp" -->
<% end if %>