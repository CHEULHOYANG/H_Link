<!-- #include file = "../include/set_loginfo.asp" -->
<!-- #include file = "../include/dbcon.asp" -->
<% if isUsr then
Dim bycode,bycode1			''���� �Ϸù�ȣ �迭
Dim buygbn			''�ܰ�,���� ����	1:����,2:�ܰ�
Dim paytype			''�������
Dim moneyHap	''�ΰ��� ���� �����ݾ�
Dim cnumber,cprice,rs,i,payTitle1,order_id,bycount

Dim payTitle,usrnm,bankinfo,send_price
payTitle = Request.Form("payTitle")
usrnm = Request.Form("usrnm")
bankinfo = Request.Form("bankinfo")
moneyHap = Request.Form("moneyHap")
cnumber = Request.Form("cnumber")
cprice = Request.Form("cprice")
send_price = Request.Form("send_price")

If Len(send_price) = 0 Then send_price = 0

order_id = Left(session.sessionID,4) & Right(year(date),2) & month(date) & day(date) & hour(time) & minute(time) & second(time)

Dim name,tel1,tel2,email,zipcode1,zipcode2,juso1,juso2,memo,b_price

name = Request.Form("name")
tel1 = Request.Form("tel1")
tel2 = Request.Form("tel2")
email = Request.Form("email")
zipcode1 = Request.Form("zipcode1")
zipcode2 = Request.Form("zipcode2")
juso1 = Request.Form("juso1")
juso2 = Request.Form("juso2")
memo = Request.Form("memo")
b_price = Request.Form("b_price")

Dim ordidx
sql = "select isNull(Max(idx),0) + 1 from bank_order"
set dr = db.execute(sql)
ordidx = dr(0)
dr.close

bycode = Request.Form("bycode")
bycode1 = Request.Form("bycode1")
bycount = Request.Form("bycount")

Dim idxAry : idxAry = split(bycode,"|")
Dim idxAry1 : idxAry1 = split(bycode1,"|")
Dim idxAry2 : idxAry2 = split(bycount,"|")

paygbn = 1
paytype = 1

dim paygbn

if int(paygbn) < 1 Then

	sql = "select strnm,intprice from PremTab where idx=" & bycode
	set dr = db.execute(sql)
	payTitle = dr(0)
	payTitle = Tag2Txt(payTitle)
	moneyHap = dr(1)
	dr.close

	tabnm = "PremTab"
	strnm = "�����̾� : "
	clmn = bycode

elseif int(paygbn) > 1 Then

	''���°��� �´ٸ�
	If Len(bycode) > 0 then

		sql = "select strnm from LecturTab where idx=" & idxAry(0)
		set dr = db.execute(sql)
		payTitle = dr(0)
		payTitle = Tag2Txt(payTitle)
		dr.close

		tabnm = "LecturTab"
		strnm = "�ܰ� : "
		clmn = "categbn"

		if UBound(idxAry) > 0 then
			payTitle = payTitle & " �� " & Ubound(idxAry) & "����"
		end If
	
	End If

	''���簪�� �´ٸ�
	If Len(bycode) = 0 And Len(bycode1) > 0 Then

		sql = "select title from book_mast where idx=" & idxAry1(0)
		set dr = db.execute(sql)
		payTitle = dr(0)
		payTitle = Tag2Txt(payTitle)
		dr.close

		tabnm = "LecturTab"
		strnm = "���� : "
		clmn = "categbn"

		if UBound(idxAry1) > 0 then
			payTitle = payTitle & " �� ����" & Ubound(idxAry1) & "��"
		end If
	
	End if	

Else

	sql = "select strnm,intgigan from Lectmast where idx=" & bycode
	set dr = db.execute(sql)
	payTitle = dr(0) & "(" & dr(1) & "�ϰ���)"
	payTitle = Tag2Txt(payTitle)
	dr.close

	tabnm = "Lectmast"
	strnm = "���� : "
	clmn = "gbn"
end If

Dim huday

sql = "select huday from site_info"
set dr = db.execute(sql)

If dr.eof Or dr.bof Then
	huday = 0
Else
	huday = dr(0)
dr.close
End if

Dim tabnm,strnm,clmn

Dim intprice,categbn,tabidx,intgigan,tempd,eday,huil

If Len(bycode) > 0 then

for ii = 0 to UBound(idxAry)

		sql = "select intprice," & clmn & ",intgigan from " & tabnm & " where idx=" & idxAry(ii)
		set dr = db.execute(sql)
		intprice = dr(0)
		categbn = dr(1)
		intgigan = int(dr(2))
		dr.close
		sql = ""

		tempd = Cstr(DateAdd("d",intgigan,date))
		eday = tempd & " " & FormatDateTime(now(),4) & ":00"

		''�ް���
		huil = huday

		sql = "insert into order_mast (id,buygbn,tabidx,categbn,title,paytype,intprice,state,eday,holdil,yy,mm,dd,otp,cnumber,cprice,order_id) values ('" & str_User_ID & "'," & paygbn & "," & idxAry(ii) & "," & categbn & ",'" & strnm & "'," & payType & "," &  intprice & ",0,convert(smalldatetime,'" & eday & "')," & huil & ","
		sql = sql & Year(now) & "," & Month(now) & "," & Day(now) & ",'" & ordidx & "','"& cnumber &"',"& cprice &",'"& order_id &"')"
		db.execute(sql)
Next

End If

Function Tag2Txt(s)
	s = Replace(s,"'","''")
	s = Replace(s,"<","&lt;")
	s = Replace(s,">","&gt;")
	s = Replace(s,"&","&amp;")
	Tag2Txt = s
End Function

response.write "<script>"
response.write "alert('���ᰭ�ǰ� ��ϵǾ����ϴ�.');"
response.write "self.location.href='../my/01_main.asp';"
response.write "</script>"
response.end

else %>
<!-- #include file = "../include/false_pg.asp" --><% end if %>