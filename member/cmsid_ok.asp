<!-- #include file="../include/set_loginfo.asp" -->
<!-- #include file = "../include/refer_check.asp" -->
<%
vPage = vPage & "/member/cmsid.asp"

if vReferer = vPage then %><!-- #include file = "../include/dbcon.asp" --><%	Dim username,email,tel2

	username = Request.Form("username")
	email = Request.Form("email")
	tel2 = Request.Form("tel1") &"-"& Request.Form("tel2") &"-"& Request.Form("tel3")

	username = Tag2Txt(username)
	email = Tag2Txt(email)
	tel2 = Tag2Txt(tel2)

	Dim FindRecod

	sql = "select id,regdate from member where name='" & username & "' and email='" & email & "' and tel2='" & tel2 & "' "
	set dr = db.execute(sql)

	if not dr.Bof or not dr.Eof then
		Dim userid,regdate
		userid = dr(0)
		regdate = dr(1)
		FindRecod = True
	end if
	dr.close

Function Tag2Txt(s)
			s = Replace(s,"'","''")
			s = Replace(s,"<","&lt;")
			s = Replace(s,">","&gt;")
			s = Replace(s,"&","&amp;")
			Tag2Txt = s
End Function
%>
<!-- #include file="../include/head1.asp" -->
<!-- #include file = "../include/top.asp" -->

<div class="scontent">

    	<h3 class="stit mt30">���̵�ã��</h3>

		<table class="ftbl" style="width:980px">
				<colgroup>
					<col style="width:20%" />
					<col style="width:80%" />
				</colgroup>
				<tbody>
					<tr>
						<th>���̵�</th>
						<td><% if FindRecod then %><%=username%>���� <%=formatdatetime(regdate,2)%>&nbsp;<%=formatdatetime(regdate,4)%>�� ���̵� <strong><%=userid%></strong>(��)�� �����ϼ̽��ϴ�.<%else%><font color="cc0000"><strong>�˼��մϴ�!</strong></font><br />�Է��� ������ ��ġ�ϴ� ȸ�������� ã�� ���߽��ϴ�.<br />������ �� �Է��� <font color="cc0000">ȸ������</font>�� ��Ȯ���� Ȯ�����ֽñ� �ٶ��ϴ�!<%end if%></td>
					</tr>
				</tbody>
			</table>

        <div class="cbtn"> <a href="login.asp" class="mbtn grey">�α���</a><a href="cmsid.asp" class="mbtn">���̵�/��й�ȣã��</a> </div>
</div>

<!-- #include file = "../include/bottom.asp" -->
<% else %>
<!-- #include file = "../include/false_pg.asp" -->
<% end if %>
