<% dim menuidx
if inStr(Request.ServerVariables("PATH_INFO"),"page") > 0 then
	if isRecod then
		menuidx = idx
	else
		menuidx = 0
	end if
else
	menuidx = 0
end if  
dim pathAry : pathAry = split(Request.ServerVariables("PATH_INFO"),"/")
dim strFirstn
strFirstn = Left(pathAry(UBound(pathAry)),1)

select case strFirstn
	case "n"
		menuidx = 111
	case "f"
		menuidx = 112
	case "q"
		menuidx = 113
	case "d"
		menuidx = 114
	case "s"
		menuidx = 115
end select %>
	<div class="nlnbWrap">
		<h2><%=t_menu7%></h2>
		<div class="nlnb">
			<dl>
				<dt><a href="/cs/nlist.asp">��������</a></dt>
			</dl>
			<dl>
				<dt><a href="/cs/flist.asp">���ֹ����������亯</a></dt>
			</dl>
			<dl>
				<dt><a href="/cs/qlist.asp">���ǰԽ���</a></dt>
			</dl>
<% 
sql = "select idx,jemok from guideTab where gbn = 1 order by ordnum asc,idx desc"
set dr = db.execute(sql)
if not dr.bof or not dr.eof then
do until dr.eof 
%>
			<dl>
				<dt><a href="/cs/page.asp?idx=<%=dr(0)%>"><%=dr(1)%></a></dt>
			</dl>
<%
dr.movenext
Loop
else 
end if
dr.close

sql = "select idx,title from cal_mast order by idx desc"
set dr = db.execute(sql)
if not dr.bof or not dr.eof then
do until dr.eof 
%>
			<dl>
				<dt><a href="/cs/cal.asp?cal_idx=<%=dr(0)%>"><%=dr(1)%></a></dt>
			</dl>
<%
dr.movenext
Loop
else 
end if
dr.close
%>
			<dl>
				<dt><a href="/question/ing.asp">����</a></dt>
				<dd><a href="/question/ing.asp">�������μ���</a><a href="/question/end.asp">����ȼ���</a></dd>
			</dl>
		</div>

		<!-- #include file="../include/left2.asp" -->

<!--  ��ʽ���   -->
	<div style="text-align:center;">
	<% 
	sql = "select banner,banner_url,filegbn,target from banner where areagbn='045' order by  ordnum asc , idx desc"
	set dr = db.execute(sql)
	if not dr.bof or not dr.eof then
	do until dr.eof 
	response.write ""& BannerOutput(dr(0),dr(1),dr(2),200,dr(3)) &"<br /><br />"
	dr.movenext
	Loop
	end if
	dr.close %>
	</div>
<!--  ��ʳ�  -->

	</div>