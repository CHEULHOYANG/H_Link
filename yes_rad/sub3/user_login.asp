<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/dbcon.asp" -->
<%
Dim sql,rs,usrid,usrnm

usrid = Request("usrid")

sql = "select name from member where id = '"& usrid &"'"
Set rs=db.execute(sql)

If rs.eof Or rs.bof Then
	Response.write"<script>"
	Response.write"alert('ȸ����������!!');"
	Response.write""
	Response.write"</script>"
	Response.end
Else
	usrnm = rs(0)
rs.close
End if

dim login_new_ip
	
login_new_ip = Request.ServerVariables("HTTP_X_FORWARDED_FOR")'Ŭ���̾�Ʈ�� ����IP����

If login_new_ip = "" Then '����Ip�ƴҶ� ����IP����(Ŭ���̾�Ʈ)
   login_new_ip = Request.ServerVariables("REMOTE_ADDR")
end if

sql = "Update member set ins_my = '"& login_new_ip &"' where id='"& usrid &"'"
db.execute sql,,adexecutenorecords

Response.Cookies("userInfo") = usrid & "," & usrnm & ",,"

Response.redirect "/main/index.asp"
Response.end
%>
<!-- #include file = "../authpg_2.asp" -->