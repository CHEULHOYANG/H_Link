<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/fso.asp" -->
<%
Dim shop_url,sms_id

strTname="config"
strFile = Server.MapPath("..\..\") & "\ahdma\cfgini\"& strtname &".cfg"
arrConfig = Split(ReadTextFile(strFile),chr(13))

sms_id =			arrConfig(29)			''Ȯ�庯��

if len(sms_id) < 10 Then

	response.write"<script language='javascript'>"
	response.write"alert('���ڹ߼ۺ��Ⱦ��̵�/����Ű�� ��Ȯ�� �Է����ּ���.');"
	response.write"self.location.href='../sub1/list.asp';"
	response.write"</script>"
	response.end	

end if


sms_id = split(sms_id,",")

dim send_tel,res_tel

send_tel = request("send_tel")
msg = request("message")
res_tel = request("to_tel")

Dim api_url
api_url = "https://www.ppurio.com/api/send_euckr_text.php"

Dim userid, callback, phone, msg, names, appdate, subject
userid = ""& sms_id(0) &""                           ' [�ʼ�] �Ѹ��� ���̵�
callback = ""& sms_id(1) &""                    ' [�ʼ�] �߽Ź�ȣ - ���ڸ�
phone = ""& res_tel &""                       ' [�ʼ�] ���Ź�ȣ - �������� ��� |�� ���� "010********|010********|010********"
msg = Server.URLEncode(""& msg &"") ' [�ʼ�] ���ڳ��� - �̸�(names)���� �ִٸ� [*�̸�*]�� ġȯ�Ǽ� �߼۵�
names = Server.URLEncode("")          ' [����] �̸� - �������� ��� |�� ���� "ȫ�浿|�̼���|��ö��"
subject = Server.URLEncode("")        ' [����] ���� (30byte)

Dim xmlHttp, result
SET xmlHttp = Server.CreateObject("Microsoft.XMLHTTP")
xmlHttp.open "POST", api_url, False
xmlHttp.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
xmlHttp.setRequestHeader "Accept-Language","ko"
xmlHttp.send "userid="&userid&"&callback="&callback&"&phone="&phone&"&msg="&msg&"&names="&names&"&appdate="&appdate&"&subject="&subject

if xmlHttp.status = 200 then
	result = xmlHttp.responseText
Else
	result = "server_error"
End if
SET xmlHttp = Nothing

Response.write"<script language='javascript'>"
Response.write"alert('"& result &"');"
Response.write"self.location.href='smslist.asp';"
Response.write"</script>"
Response.End

Function ReadTextFile(fpath)
	Dim objFile,strReturnString
	Set objFile = objFso.OpenTextFile(fpath , 1)

	if objFile.AtEndOfStream then

		Dim aryNum

		for aryNum = 0 to 32
			strReturnString = strReturnString & chr(13)
		Next

	else

		strReturnString = objFile.readAll

	end if

ReadTextFile = strReturnString

objFile.Close

Set objFile = Nothing

End Function 
%>
<!-- #include file = "../authpg_2.asp" -->