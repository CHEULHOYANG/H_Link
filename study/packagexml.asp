<?xml version="1.0" encoding="euc-kr"?><%  Response.ContentType = "text/xml" %>
<!DOCTYPE RootXml[
<!ELEMENT RootXml (isrows*)>
	<!ELEMENT isrows ANY>
	<!ATTLIST isrows
	flg CDATA #REQUIRED>
]><% Dim key : key = Request.Form("key") %>
<RootXml><% if Not key = "" then
	key = Replace(key,"'","")
	key = Replace(key,"--","")

''�α���üũ*****************************************************

	Dim str_Cookies_Ary
	Dim str_User_ID

	if Replace(Request.Cookies("userInfo")," ","") = "" then
		remsg = "true"
	else

		str_Cookies_Ary = Split(Request.Cookies("userInfo"),",")
		if UBOund(str_Cookies_Ary) = 3 then
			str_User_ID =  str_Cookies_Ary(0) %><!-- #include file = "../include/dbcon.asp" --><%

			''��ٱ��� ����****************************************************
			dim buygbn : buygbn = 1
			dim sql,cnt

			sql = "update wish_list set tabidx=" & key & " where userid='" & str_User_ID & "' and buygbn=" & buygbn & " and tabidx=" & key
			db.execute sql,cnt

			if cnt < 1 then
				db.execute("insert into wish_list (buygbn,tabidx,userid) values (" & buygbn & "," & key & ",'" & str_User_ID & "')")
				remsg = "false"
			else
				remsg = "true"
			end if

			db.close
			set db = Nothing
			''��ٱ��� End****************************************************

		else
			remsg = "true"
		end if
	end if

''�α���üũ***************************************************** %>
	<isrows flg="<%=remsg%>"/><% end if %>
</RootXml>