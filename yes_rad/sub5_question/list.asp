<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/dbcon.asp" -->
<%
dim idx,ca1,ca2,title,price,admin_gu,readnum,costnum,regdate,sql,rs
dim page,recordcount,pagecount,totalpage,i,blockpage,pagesize
dim searchstr,searchpart,ca,index,sq
dim gu
%>

<!--#include file="../main/top.asp"-->

<script>
function quiz_del(idx,page,searchpart,searchstr,ca){
		var bool = confirm("�����Ͻðڽ��ϱ�?");
		if (bool){
			location.href = "del.asp?idx="+idx+"&page="+page+"&searchpart="+searchpart+"&searchstr="+searchstr+"&ca="+ca;
		}
}
</script>

<div class="container">
	<!--#include file="left.asp"-->
	<div class="content">
		<h2 class="cTit"><span class="bullet"></span>�������׸����</h2>

		<form name="form1" method="get" action="list.asp">
		<input type="hidden" name="ca" value="<%=request("ca")%>">
		<div class="schWrap1">
			<h3>�˻�</h3>
			<div class="sch_area1">
				<select id="searchpart" name="searchpart" class="seltxt">
					<option value="title" >����</option>
				</select>
				<input type="text" name="searchstr" id="searchstr" class="inptxt" value="<%=request("searchstr")%>" /></div>
			<a href="javascript:document.form1.submit();" class="btn_search1">�˻�</a>		
		</div>
		</form>

		<form name="form2" method="get" action="list.asp">
		<input type="hidden" name="searchpart" value="<%=request("searchpart")%>">
		<input type="hidden" name="searchstr" value="<%=request("searchstr")%>">
		<div class="tbl_top">
			<select name="ca" onchange="document.form2.submit();" class="seltxt w200">
			<option value="">������ ����.</option>
			<%
			sql="select idx,title from question_list order by idx desc"
			set rs=db.execute(sql)
			if rs.eof or rs.bof then
			else
			do until rs.eof
			%>
				  <option value="<%=rs(0)%>" <%If request("ca") = ""& rs(0) &"" Then response.write"selected" End if%>><%=rs(1)%></option>
			<%
			rs.movenext
			Loop
			rs.close
			end if
			%>
			</select> <span class="tbl_total"><a href="input.asp"  class="fbtn1">�����׸��߰�</a></span>
		</div>
		</form>

		<table class="tbl" style="width:100%">
			<colgroup>
			<col style="width:5%" />
			<col style="width:20%" />
			<col />
			<col style="width:10%" />
			<col style="width:10%" />
			</colgroup>
			<thead>
				<tr>
					<th>��ȣ</th>	
					<th>������</th>
					<th>�����׸�</th>
					<th>��������</th>	
					<th>���</th>								
				</tr>				
			</thead>
			<tbody>
<%
if request("page")="" then
   page=1
else 
   page=request("page")
end If

pagesize=10

sq = ""
If Len(request("ca")) > 0 Then
	If Len(sq) = 0 then
		sq = ""& sq &" ca = "& request("ca") &""
	Else
		sq = ""& sq &" and ca = "& request("ca") &""
	End if
End If
If Len(request("searchstr")) > 0 Then
	If Len(sq) = 0 then
		sq = ""& sq &" "& request("searchpart") &" like '%"& request("searchstr") &"%'"
	Else
		sq = ""& sq &" and "& request("searchpart") &" like '%"& request("searchstr") &"%'"
	End if
End if

if Len(sq) = 0 Then

	sql = "select count(idx) as reccount from question_mast"
	set rs=db.execute(sql)
	recordcount =rs(0)
	pagecount=int((recordcount-1)/pagesize)+1
	sql = "SELECT top " & pagesize & " idx,title,r_gu,ordnum,(select title from question_list where idx = A.ca) from question_mast A where idx not in"
	sql = sql & "(select top " & ((page -1 ) * pagesize) & " idx from question_mast order by ordnum asc) order by ordnum asc"
	set rs=db.execute(sql)

else

	sql = "select count(idx) as reccount from question_mast where "& sq &""
	set rs=db.execute(sql)
	recordcount =rs(0)
	pagecount=int((recordcount-1)/pagesize)+1
	sql = "SELECT top " & pagesize & " idx,title,r_gu,ordnum,(select title from question_list where idx = A.ca) from question_mast A where "& sq &" and idx not in"
	sql = sql & "(select top " & ((page -1 ) * pagesize) & " idx from question_mast where "& sq &" order by ordnum asc) order by ordnum asc"
	set rs=db.execute(sql)

end if

if rs.eof or rs.bof Then

else
Index = (pagesize + recordcount) - (page * pagesize) + 1		
do until rs.eof
Index = Index - 1
%>
				<tr>
					<td><%=index%></td>
					<td class="tl"><%=rs(4)%></td>
					<td class="tl"><%=rs(1)%></td>
					<td><%If rs(2) = 0 Then response.write"������" Else response.write"�Է���" End if%></td>
					<td><a href="edit.asp?ca=<%=request("ca")%>&idx=<%=rs(0)%>&page=<%=page%>&searchstr=<%=request("searchstr")%>&searchpart=<%=request("searchpart")%>" class="btns">����</a>
					<a href="javascript:quiz_del('<%=rs(0)%>','<%=page%>','<%=request("searchpart")%>','<%=request("searchstr")%>','<%=request("ca")%>');" class="btns trans">����</a></td>
					
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
				<a href="?page=1&searchstr=<%=request("searchstr")%>&searchpart=<%=request("searchpart")%>&ca=<%=request("ca")%>"><img src="/yes_rad/rad_img/img/a_prev2.gif" alt="ó��������"></a>
<%
blockPage=Int((page-1)/10)*10+1
if blockPage = 1 Then
Else
%>
<a href="?page=<%=blockPage-10%>&searchstr=<%=request("searchstr")%>&searchpart=<%=request("searchpart")%>&ca=<%=request("ca")%>"><img src="/yes_rad/rad_img/img/a_prev1.gif" alt="����������" /></a>
<%
End If
   i=1
   Do Until i > 10 or blockPage > pagecount
      If blockPage=int(page) Then
%>
<strong><%=blockPage%></strong>
<%Else%>
<a href="?page=<%=blockPage%>&searchstr=<%=request("searchstr")%>&searchpart=<%=request("searchpart")%>&ca=<%=request("ca")%>" class="num"><%=blockPage%></a>
<%
End If    
blockPage=blockPage+1
i = i + 1
Loop

if blockPage > pagecount Then
Else
%>
<a href="?page=<%=blockPage%>&searchstr=<%=request("searchstr")%>&searchpart=<%=request("searchpart")%>&ca=<%=request("ca")%>"><img src="/yes_rad/rad_img/img/a_next1.gif" alt="����������"></a>
<%
End If
%>	
				<a href="?page=<%=pagecount%>&searchstr=<%=request("searchstr")%>&searchpart=<%=request("searchpart")%>&ca=<%=request("ca")%>"><img src="/yes_rad/rad_img/img/a_next2.gif" alt="������������"></a>			
			</div>
		</div>

	</div>
</div>

</body>
</html>
<!-- #include file = "../authpg_2.asp" -->