<!--METADATA TYPE="typelib" NAME="ADODB Type Library" File="c:\program files\common files\system\ado\msado15.dll"-->
<%
Option Explicit
Response.Buffer=true
Response.CacheControl = "no-cache"
Response.AddHeader "pragma","no-cache"
Response.Expires = -1

Session.Codepage = 949
Response.CharSet = "EUC-KR"

%>
<!-- #include file="../include/injection.asp" -->
<%
Dim str_Cookies_Ary
Dim str_User_ID
Dim str_User_Nm

Dim isUsr			''ȸ��
Dim strProg : strProg = "true"		''client login blean

if Replace(Request.Cookies("userInfo")," ","") = "" then		''�α��� ������ ������...

	isUsr = False

else		''�α��� ������ ������...

	str_Cookies_Ary = Split(Request.Cookies("userInfo"),",")

	if UBOund(str_Cookies_Ary) = 3 then	'' |�� split ���̴� 3�̾�� �Ѵ� -- ��Ű ���� ����

		str_User_ID =  replace(str_Cookies_Ary(0),chr(13),"")
		str_User_Nm = replace(str_Cookies_Ary(1),chr(13),"")

		''ȸ������
		isUsr = True
		strProg = "false"

	else

		isUsr = False

	end if

end if	''�α��� ���� ��

Dim str__Page,str__Var
if Not request.ServerVariables("QUERY_STRING") = "" then
	str__Var = "?" & request.ServerVariables("QUERY_STRING")
end if

''//-----------------td ���� ����

	Dim tdnum,lineL,strNum,splitNum,lineNum,rowsNum

''//-----------------sql query�� ����

Dim sql,dr,ii,isRecod,isRows,isCols
%>
<!--#include file="../include/siteinfo.asp" -->