<!-- #include file="../include/set_loginfo.asp" -->
<% if isUsr then %>
<!-- #include file="../include/dbcon.asp" -->
<%
Dim intpg,blockPage,pagecount,recordcount,lyno
Dim tabnm : tabnm = "teach_board"
Dim gbnS,strPart,strSearch
Dim varPage

Dim nowPage : nowPage = Request("URL")

intpg = Request("intpg")

if intpg = "" then
	intpg = 1
else
	intpg = int(intpg)
end if

const pagesize = 20

Dim strClmn : strClmn = "idx,title,gu,regdate,dbo.teach_mast_idx(tid),dbo.teach_mast_title(tid)"

dim ssqll

if Len(Request("searchstr")) = 0 Then

	varPage = "searchpart=&searchstr="

	sql = "select Count(idx) from " & tabnm &" where id='" & str_User_ID & "'"
	set dr = db.execute(sql)
	recordcount = int(dr(0))
	dr.close

	if recordcount > 0 then
		isRecod = True
		pagecount=int((recordcount-1)/pagesize)+1
		lyno = recordcount - ((intpg - 1) * pagesize)
		ssqll = "select  top " & pagesize & strClmn & "from " & tabnm & " where id='" & str_User_ID & "' and idx not in (select top " & ((intpg -1 ) * pagesize) & " idx from " & tabnm & " where id='" & str_User_ID & "' order by idx desc) order by idx desc"
	end If
	
Else

	varPage = "searchpart=" & request("searchpart") & "&searchstr=" & request("searchstr") & ""

	dim query
	If request("searchpart") = "0" then	query = " id='" & str_User_ID & "' and title like '%" & Replace(request("searchstr"),"'","''") & "%'"

	sql = "select count(idx) from " & tabnm & " where " & query
	set dr = db.execute(sql)
	recordcount = int(dr(0))
	dr.close

	if recordcount > 0 then
		isRecod = True
		pagecount=int((recordcount-1)/pagesize)+1
		lyno = recordcount - ((intpg - 1) * pagesize)
		ssqll = "select  top " & pagesize & strClmn & "from " & tabnm & " where " & query & " and idx not in (select top " & ((intpg -1 ) * pagesize) & " idx from " & tabnm & " where " & query & " order by idx desc) order by idx desc"
	end If
	
end if %>
<!-- #include file="../include/head1.asp" -->

<script language="javascript">
function go2ListPage(pg){
	document.location.href="<%=nowPage%>?intpg=" + pg + "&<%=varPage%>";
}
function go3Search(){
	var clmn = sform.searchstr;
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

	if(clmn.value.length< 2){
		alert("��ȸ�� �ܾ�� 2�� �̻� �Է��ؾ� �մϴ�.");
		clmn.select();
		return false;
	}

	document.sform.submit();

}
</script>

<!-- #include file="../include/top.asp" -->

<div class="smain">    
	<!-- #include file="left.asp" -->
    <div class="content">
    	<div class="cont_tit">
        	<h3><%=t_menu3%> �Խñ�</h3>
        </div>
        <div class="scont">

<table class="btbl" style="width:830px">
                        <colgroup>
                        <col style="width:10%" />
						<col style="width:20%" />
                        <col />
                        <col style="width:15%" />
                        </colgroup>
                        <thead>
                            <tr>
                                <th>��ȣ</th>
                                <th>����</th>
                                <th>����</th>
                                <th>�����</th>
                            </tr>
                        </thead>
                        <tbody>
<% 
if isRecod then

	set dr = db.execute(ssqll)
	isRows = split(dr.GetString(2),chr(13))

	for ii = 0 to UBound(isRows) - 1
	isCols = split(isRows(ii),chr(9))
%>
				<tr>
					<td><%=lyno%></td>
					<td class="tl"><a href="/teach/list.asp?tidx=<%=isCols(4)%>&gu=<%=isCols(2)%>">[<%=isCols(5)%>] <%If isCols(2) = 0 Then Response.write"��������" End if%><%If isCols(2) = 1 Then Response.write"�ڷ��" End if%><%If isCols(2) = 2 Then Response.write"�������亯" End if%><%If isCols(2) = 3 Then Response.write"�����ı�" End if%></a></td>
					<td class="tl"><a href="/teach/content.asp?tidx=<%=isCols(4)%>&idx=<%=isCols(0)%>&gu=<%=isCols(2)%>"><%=isCols(1)%></a></td>
					<td><%=replace(formatdatetime(isCols(3),2),"-",".")%></td>
				</tr>
<%
	lyno = lyno - 1
	Next

else
End if%>

                        </tbody>
                    </table>

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
	
if blockPage > pagecount Then
else %>
			<a href="javascript:go2ListPage('<%=blockPage%>');"><img src="../img/img/a_next1.gif" alt="����������"></a>			
			<a href="javascript:go2ListPage('<%=pagecount%>');"><img src="../img/img/a_next2.gif" alt="������������"></a>
<%End if%>
		</div>

<form name="sform" method="post" action="?">
                <div class="boardSch">
                    <fieldset>
                        <select name="searchpart" class="seltxt1 w100">
							<option value="0" <%If request("searchpart") = "0" Then response.write"selected" End if%>>����</option>
                        </select>
                        <input type="text" name="searchstr" class="inptxt1" value="<%=request("searchstr")%>" />
                        <a href="javascript:go3Search();" class="fbtn grey">�˻��ϱ�</a>
                    </fieldset>
                </div>
</form>

        </div>
    </div>
</div>

<!-- #include file="../include/bottom.asp" -->
<%
Function cutStr(str, cutLen)
	Dim strLen, strByte, strCut, strRes, char, i
	strLen = 0
	strByte = 0
	strLen = Len(str)
	for i = 1 to strLen
		char = ""
		strCut = Mid(str, i, 1)
		char = Asc(strCut)
		char = Left(char, 1)
		if char = "-" then
			strByte = strByte + 2
		else
			strByte = strByte + 1
		end if
		if cutLen < strByte then
			strRes = strRes & ".."
			exit for
		else
			strRes = strRes & strCut
		end if
	next
	cutStr = strRes
End Function

Function viewProg(v,u)
	if isUsr then
		viewProg = 0
		if int(v) > 1 and Not u = str_User_ID then
			viewProg = 2
		end if
	else
		viewProg = 1
	end if
End Function

else %><!-- #include file = "../include/false_pg.asp" -->
<% end if %>