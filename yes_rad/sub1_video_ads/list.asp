<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/dbcon.asp" -->
<%
Dim dr,rownum,isRecod,isRows,isCols,munje_count
dim idx,ca1,ca2,title,price,admin_gu,readnum,costnum,regdate,sql,rs
dim page,recordcount,pagecount,totalpage,i,blockpage,pagesize
dim munje_time1,munje_time2,munje_bang1,munje_bang2,munje_date1,munje_date2,munje_repeat,sec
dim searchstr,searchpart,m_id,rs1,tca1,tca2,index
dim gu

if request("page")="" then
   page=1
   else 
   page=request("page")
end if
pagesize=10

if request("searchstr")="" Then

	sql = "select count(idx) as reccount from quiz_munje"
	set rs=db.execute(sql)
	recordcount =rs(0)

	pagecount=int((recordcount-1)/pagesize)+1
	sql = "SELECT top " & pagesize & " idx,dbo.LecturTab_title(ca1),dbo.sectionTab_title(ca2),title,price,admin_gu,readnum,costnum,regdate,munje_time1,munje_time2,munje_bang1,munje_bang2,munje_date1,munje_date2,munje_repeat,dbo.quiz_category_title(tca1),dbo.quiz_category_title(tca2),sec,state,dbo.quiz_munje_list_count(idx) from quiz_munje where idx not in"
	sql = sql & "(select top " & ((page -1 ) * pagesize) & " idx from quiz_munje) order by idx desc"
	set rs=db.execute(sql)

else

	searchstr=request("searchstr")
	searchpart=request("searchpart")

	sql = "select count(idx) as reccount from quiz_munje where "& searchpart &" like '%"& searchstr &"%'"
	set rs=db.execute(sql)
	recordcount =rs(0)

	pagecount=int((recordcount-1)/pagesize)+1
	sql = "SELECT top " & pagesize & " idx,dbo.LecturTab_title(ca1),dbo.sectionTab_title(ca2),title,price,admin_gu,readnum,costnum,regdate,munje_time1,munje_time2,munje_bang1,munje_bang2,munje_date1,munje_date2,munje_repeat,dbo.quiz_category_title(tca1),dbo.quiz_category_title(tca2),sec,state,dbo.quiz_munje_list_count(idx) from quiz_munje where "& searchpart &" like '%"& searchstr &"%' and idx not in"
	sql = sql & "(select top " & ((page -1 ) * pagesize) & " idx from quiz_munje where "& searchpart &" like '%"& searchstr &"%') order by idx desc"
	set rs=db.execute(sql)

end if
%>
<!-- #include file = "../main/top.asp" -->
<script>
function quiz_del(idx,page,searchpart,searchstr){
		var bool = confirm("�����Ͻðڽ��ϱ�?");
		if (bool){
			location.href = "del.asp?idx="+idx+"&page="+page+"&searchpart="+searchpart+"&searchstr="+searchstr;
		}
}
</script>

<div class="container">
	<!--#include file="left.asp"-->
	<div class="content">
		<h2 class="cTit"><span class="bullet"></span>����������</h2>

<form name="form1" method="post" action="list.asp">
		<div class="schWrap1">
			<h3>�˻�</h3>
			<div class="sch_area1">
				<select id="searchpart" name="searchpart" class="seltxt">
					<option value="title" <%If request("searchpart") = "title" Then Response.write"selected" End if%>>����</option>
				</select>
				<input type="text" name="searchstr" id="searchstr" class="inptxt" value="<%=request("searchstr")%>" /></div>
			<a href="javascript:document.form1.submit();" class="btn_search1">�˻�</a>		
		</div>
</form>

		<div class="tbl_top">
			<a href="input.asp" class="fbtn1">���� ����ϱ�</a>	
			<span class="tbl_total">��ü <%=recordcount%>�� (<%=page%>page/<%=pagecount%>pages)</span>		
		</div>

<table class="tbl" style="width:100%">
			<colgroup>
			<col style="width:5%" />
			<col style="width:10%" />
			<col style="width:15%" />
			<col />
			<col style="width:10%" />
			<col style="width:8%" />
			<col style="width:15%" />
			<col style="width:15%" />
			</colgroup>
			<thead>
				<tr>
					<th>��ȣ</th>	
					<th>ī�װ�</th>
					<th>���ð���</th>
					<th>����</th>	
					<th>����</th>								
					<th>����</th>
					<th>����</th>
					<th>���</th>
				</tr>				
			</thead>
			<tbody>
<%
if rs.eof or rs.bof Then
else
Index = (pagesize + recordcount) - (page * pagesize) + 1		
do until rs.eof
Index = Index - 1
idx = rs(0)
ca1 = rs(1)
ca2 = rs(2)
title = rs(3)
price = rs(4)
admin_gu = rs(5)
readnum = rs(6)
costnum = rs(7)
regdate = rs(8)
munje_time1 = rs(9)
munje_time2 = rs(10)
munje_bang1 = rs(11)
munje_bang2 = rs(12)
munje_date1 = rs(13)
munje_date2 = rs(14)
munje_repeat = rs(15)
tca1 = rs(16)
tca2 = rs(17)
sec = rs(18)
munje_count = rs(20)
%>
				<tr>
					<td><%=index%></td>
					<td><%=tca1%><%If Len(tca2) > 0 Then %> &gt; <%=tca2%><%End if%></td>
					<td><%If IsNull(ca1) then%>-<%else%><%=ca1%> &gt; <%=ca2%><%End if%></td>
					<td class="tl"><a href="edit.asp?idx=<%=idx%>&page=<%=page%>&searchstr=<%=request("searchstr")%>&searchpart=<%=request("searchpart")%>"><%If rs(19) = 1 Then Response.write"[����]&nbsp;" End if%><%=title%></a></td>
					<td><%if price = 0 then response.write"����" End if%><%if price = 1 then response.write"�����н�" End if%><%if price = 2 then response.write"������ȣ("& sec &")" End if%></td>
					<td><%=munje_count%>����</td>
					<td><%if munje_date1=1 then%><%=munje_date2%><%if munje_time1<>"0" then response.write "("& munje_time1 &"~"& munje_time2 &")" end if%>/<%end if%><%if munje_repeat=0 then response.write"�ݺ�" else response.write"1ȸ" end if%>/<%if munje_bang1=0 then response.write"����" else response.write"����" end if%>(<%if munje_bang2=0 then response.write"��ü" else response.write"�ѹ���" end if%>)</td>
					<td height="30" width="13%">
					<a href="../quiz_munje_list/list.asp?q_idx=<%=idx%>" target="_blank" class="btns trans">��������</a>
					<a href="edit.asp?idx=<%=idx%>&page=<%=page%>&searchstr=<%=request("searchstr")%>&searchpart=<%=request("searchpart")%>" class="btns">����</a>
					<a href="javascript:quiz_del('<%=idx%>','<%=page%>','<%=request("searchpart")%>','<%=request("searchstr")%>');" class="btns">����</a></td>
				</tr>
<%
rs.movenext
loop
rs.close
end if
%>
			</tbody>
		</table>

<div class="cbtn mb80">
			<div class="paging">
				<a href="?page=1&searchstr=<%=request("searchstr")%>&searchpart=<%=request("searchpart")%>"><img src="/yes_rad/rad_img/img/a_prev2.gif" alt="ó��������"></a>
<%
blockPage=Int((page-1)/10)*10+1
if blockPage = 1 Then
Else
%>
<a href="?page=<%=blockPage-10%>&searchstr=<%=request("searchstr")%>&searchpart=<%=request("searchpart")%>"><img src="/yes_rad/rad_img/img/a_prev1.gif" alt="����������" /></a>
<%
End If
   i=1
   Do Until i > 10 or blockPage > pagecount
      If blockPage=int(page) Then
%>
<strong><%=blockPage%></strong>
<%Else%>
<a href="?page=<%=blockPage%>&searchstr=<%=request("searchstr")%>&searchpart=<%=request("searchpart")%>" class="num"><%=blockPage%></a>
<%
End If    
blockPage=blockPage+1
i = i + 1
Loop

if blockPage > pagecount Then
Else
%>
<a href="?page=<%=blockPage%>&searchstr=<%=request("searchstr")%>&searchpart=<%=request("searchpart")%>"><img src="/yes_rad/rad_img/img/a_next1.gif" alt="����������"></a>
<%
End If
%>	
				<a href="?page=<%=pagecount%>&searchstr=<%=request("searchstr")%>&searchpart=<%=request("searchpart")%>"><img src="/yes_rad/rad_img/img/a_next2.gif" alt="������������"></a>			
			</div>
		</div>

	</div>
</div>

</body>
</html>
<!-- #include file = "../authpg_2.asp" -->