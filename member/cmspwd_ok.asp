<!-- #include file="../include/set_loginfo.asp" -->
<!-- #include file = "../include/refer_check.asp" -->
<!-- #include file="../include/md5.asp"-->
<%
vPage = vPage & "/member/cmsid.asp"

if vReferer = vPage then %><!-- #include file = "../include/dbcon.asp" --><%	Dim username,email,tel2,userid

	tel2 = Request.Form("tel1") &"-"& Request.Form("tel2") &"-"& Request.Form("tel3")
	userid = Request.Form("usrid")
	email = Request.Form("email")

	tel2 = Tag2Txt(tel2)
	userid = Tag2Txt(userid)
	email = Tag2Txt(email)

	randomize
	
	dim new_pwd,random
	
	Random = array(int((122-97)*rnd + 97),int((122-97)*rnd + 97),int((122-97)*rnd + 97),int((122-97)*rnd + 97),int((9999-1000)*rnd + 1000))

	new_pwd = chr(random(0))&""&chr(random(1))&""&chr(random(2))&""&chr(random(3))&""&random(4)

	Dim FindRecod
	Dim pwd,user_email

	sql = "select email from member where id='" & userid & "' and tel2='" & tel2 & "' and email='" & email & "' "
	set dr = db.execute(sql)

	If dr.eof Or dr.bof Then
	else


		sql = "update member set pwd ='"& md5(new_pwd) & "' where id='" & userid & "' and tel2='" & tel2 & "' and email='" & email & "' "
		db.execute sql,,adexecutenorecords

		FindRecod = True

	dr.close
	end if
%>
<!-- #include file="../include/head1.asp" -->
<!-- #include file = "../include/top.asp" -->

<div class="scontent">

    	<h3 class="stit mt30">��й�ȣã��</h3>

		<table class="ftbl" style="width:980px">
				<colgroup>
					<col style="width:20%" />
					<col style="width:80%" />
				</colgroup>
				<tbody>
<%if FindRecod Then%>
					<tr>
						<th>���̵�</th>
						<td><strong><%=userid%></strong></td>
					</tr>
					<tr>
						<th>�ӽú�й�ȣ</th>
						<td>ȸ������ �ӽ� ��й�ȣ�� <font color="cc0000"><strong><%=new_pwd%></strong></font> �Դϴ�.<br />�α����� �������ֽñ� �ٶ��ϴ�.</td>
					</tr>
<%else%>
					<tr>
						<th>���̵�</th>
						<td><strong><%=userid%></strong></td>
					</tr>
					<tr>
						<th>��й�ȣ</th>
						<td><font color="cc0000"><strong>�˼��մϴ�!</strong></font><br />�Է��� ������ ��ġ�ϴ� ȸ�������� ã�� ���߽��ϴ�.<br />������ �� �Է��� <font color="cc0000">ȸ������</font>�� ��Ȯ���� Ȯ�����ֽñ� �ٶ��ϴ�!</td>
					</tr>
<%End if%>
				</tbody>
			</table>

        <div class="cbtn"> <a href="login.asp" class="mbtn grey">�α���</a><a href="cmsid.asp" class="mbtn">���̵�/��й�ȣã��</a> </div>
</div>

<%
Function Tag2Txt(s)
		s = Replace(s,"'","''")
		s = Replace(s,"<","&lt;")
		s = Replace(s,">","&gt;")
		s = Replace(s,"&","&amp;")
		Tag2Txt = s
End Function
%>

<!-- #include file = "../include/bottom.asp" -->
<%else %>
<!-- #include file = "../include/false_pg.asp" -->
<% end if %>