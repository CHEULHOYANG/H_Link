<%
Option Explicit

Response.Buffer=true
Response.Expires=0
Response.ExpiresAbsolute=Now()-1
Response.AddHeader"Pragma","no-cache"
Response.AddHeader"Cache-Control","private"
Response.CacheControl="no-cache"

Dim int_Cookies : int_Cookies = Request.Cookies("strInfo")

if int_Cookies = "0" Then

	Response.redirect "main.asp"
	Response.End
	
else
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko">
<head>
<title>��������Ʈ �ַ�ǰ����ڸ��</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="imagetoolbar" content="no" />

<script type="text/javascript"> window.top.document.title = document.title </script>
<script type='text/javascript'>var domain = "http://"+document.domain+"/"</script>
<script type='text/javascript' src='/include/jquery.js'></script>
<link rel="stylesheet" type="text/css" href="../rad_img/default.css" />
<script language="javascript">
function strOnSubmit(isKey,theform){

	clmn = theform.strID;
	if(clmn.value==""){
		alert("���̵� �Է��ϼ���.");
		clmn.focus();
		return;
	}
	clmn = theform.strPwd;
	if(clmn.value == ""){
		alert("��й�ȣ�� �Է����ּ���.");
		clmn.focus();
		return;
	}
theform.submit();
}
</script>
</head>

<body>
<div class="mlogin">
	<dl class="logTxt">
		<dt>��������Ʈ�ַ�� ��������������<br />���� ���� ȯ���մϴ�.</dt>
		<dd>�α����� �ϼž� �����ý��ۿ� ������ �����մϴ�.<br />
			�Է¶��� ���̵�� ��й�ȣ�� �Է��� �ּ���!</dd>
	</dl>
	<div class="logbox">
<form name="theForm" method="post" action="login_ok.asp">
		<div class="login">
			<ul>
				<li><strong>���̵�</strong><input type="text" name="strID" id="input" tabIndex="1" /></li>
				<li><strong>��й�ȣ</strong><input type="password" name="strPwd" id="input" onKeyPress="if(event.keyCode==13){javascript:strOnSubmit(false,document.theForm);}" tabIndex="2" /></li>
			</ul>
			<a href="javascript:strOnSubmit(false,document.theForm);" class="log_btn">�α���</a>
			<div class="id_save"><strong>�������� ������ : <%=Request.Servervariables("REMOTE_ADDR")%></strong><br />������ ���� �����Ǹ� �����մϴ�.</div>
		</div>
</form>
	</div>
</div>

</body>
</html>
<%End if%>