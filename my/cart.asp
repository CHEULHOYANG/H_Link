<!-- #include file = "../include/set_loginfo.asp" -->
<!-- #include file = "../include/dbcon.asp" -->
<% if isUsr then
Dim bycode,bycode1			''���� �Ϸù�ȣ �迭
Dim buygbn			''�ܰ�,���� ����	1:����,2:�ܰ�
Dim paytype			''�������
Dim moneyHap	''�ΰ��� ���� �����ݾ�
Dim cnumber,cprice,rs,i,payTitle1,order_id

Dim payTitle,usrnm,bankinfo,send_price
payTitle = Request.Form("payTitle")
usrnm = Request.Form("usrnm")
bankinfo = Request.Form("bankinfo")
moneyHap = Request.Form("moneyHap")
cnumber = Request.Form("cnumber")
cprice = Request.Form("cprice")
send_price = Request.Form("send_price")

order_id = session.sessionID & "-" & year(date) & month(date) & day(date) & hour(time) & minute(time) & second(time)

Dim name,tel1,tel2,email,zipcode1,zipcode2,juso1,juso2,memo,b_price

name = Request.Form("name")
tel1 = Request.Form("tel1_1") &"-"& Request.Form("tel1_2") &"-"& Request.Form("tel1_3")
tel2 = Request.Form("tel2_1") &"-"& Request.Form("tel2_2") &"-"& Request.Form("tel2_3")
email = Request.Form("email")
zipcode1 = Request.Form("zipcode1")
zipcode2 = Request.Form("zipcode2")
juso1 = Request.Form("juso1")
juso2 = Request.Form("juso2")
memo = Request.Form("name")
b_price = Request.Form("b_price")

''bank_order inSert
Dim ordidx
sql = "select isNull(Max(idx),0) + 1 from bank_order"
set dr = db.execute(sql)
ordidx = dr(0)
dr.close

usrnm = Replace(usrnm,"'","''")
usrnm = Replace(usrnm,"<","&lt;")
usrnm = Replace(usrnm,">","&gt;")

Dim reply,reply_count

reply = split(cnumber,",")
reply_count = ubound(reply)

For i = 1 To reply_count

	sql = "select count(idx) from coupon_price_mast where state=0 and cnumber = '"& reply(i) &"'"
	Set rs=db.execute(sql)

	If rs(0) = 1 then
	Else
		response.write"<script>"
		response.write"alert('�����Ͻ� ������ ������ �߻��߽��ϴ�. �ٽ� �������ּ���!!');"
		response.write"self.close();"
		response.write"</script>"
		response.end
	End if

Next

bycode = Request.Form("bycode")
bycode1 = Request.Form("bycode1")

Dim idxAry : idxAry = split(bycode,"|")
Dim idxAry1 : idxAry1 = split(bycode1,"|")

	payTitle1 = ""
	if UBound(idxAry1) > 0 Then
	
		payTitle1 =  " + ��ǰ (" & Ubound(idxAry1) & "��)"

		If send_price > 0 Then payTitle1 =  " + ��ۺ� (" & send_price & "��)"

	end If
	
	response.write payTitle1

sql = "insert into bank_order (idx,usrnm,usrid,paytitle,bkinfo,nprice,order_id) values (" & ordidx & ",'" & usrnm & "','" & str_User_ID & "','" & payTitle & payTitle1 & "','" & bankinfo & "'," & moneyHap & ",'"& order_id &"')"
db.execute(sql)



buygbn = Request.Form("buygbn")
paytype = Request.Form("paytype")

Dim tabnm,strnm,clmn
if int(buygbn) > 1 then
	tabnm = "LecturTab"
	strnm = "�ܰ� : "
	clmn = "categbn"
elseif int(buygbn) < 1 then
		tabnm = "PremTab"
		strnm = "�����̾� : "
		clmn = bycode
else
	tabnm = "Lectmast"
	strnm = "���� : "
	clmn = "gbn"
end if


Dim intprice,categbn,tabidx,intgigan

dim tempd,eday,huil

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

	''���бⰣ ����
	''�Ⱓ�� 30 - 60�� ���� : 7�� ����
	''�Ⱓ�� 61 - 180�� ���� : 15�� ����
	''�Ⱓ�� 181 �̻��� ���� : 30�� ���� ����

	if intgigan < 61 then
		huil = 7
	elseif intgigan > 60 and intgigan < 181 then
		huil = 15
	elseif intgigan > 180 then
		huil = 30
	end if

	sql = "insert into order_mast (id,buygbn,tabidx,categbn,title,paytype,intprice,state,eday,holdil,bankidx,cnumber,cprice,order_id) values ('" & str_User_ID & "'," & buygbn & "," & idxAry(ii) & "," & categbn & ",'" & strnm & "'," & paytype & "," &  intprice & ",1,convert(smalldatetime,'" & eday & "')," & huil & "," & ordidx & ",'"& cnumber &"',"& cprice &",'"& order_id &"')"
	response.write sql
	db.execute(sql)

	db.execute("delete wish_list where userid='" & str_User_ID & "' and buygbn=" & buygbn & " and tabidx=" & idxAry(ii))
Next

''�����Ͻ���
for ii = 0 to UBound(idxAry1)

		sql = "select price1,title from book_mast where idx=" & idxAry1(ii)
		response.write sql
		set dr = db.execute(sql)
		intprice = dr(0)
		categbn = 0
		strnm = dr(1)
		intgigan = 0
		dr.close
		sql = ""

		tempd = Cstr(DateAdd("d",intgigan,date))
		eday = tempd & " " & FormatDateTime(now(),4) & ":00"
		huil = 7

		sql = "insert into order_mast (id,buygbn,tabidx,categbn,title,paytype,intprice,state,eday,holdil,bankidx,cnumber,cprice,s_name,s_tel1,s_tel2,s_email,s_zipcode1,s_zipcode2,s_juso1,s_juso2,s_memo,bookidx,order_id) values ('" & str_User_ID & "'," & buygbn & "," & idxAry1(ii) & "," & categbn & ",'" & strnm & "'," & paytype & "," &  intprice & ",1,convert(smalldatetime,'" & eday & "')," & huil & "," & ordidx & ",'"& cnumber &"',"& cprice &",'"& name &"','"& tel1 &"','"& tel2 &"','"& email &"','"& zipcode1 &"','"& zipcode2 &"','"& juso1 &"','"& juso2 &"','"& memo &"',1,'"& order_id &"')"
		db.execute(sql)
Next

set dr = nothing
db.close
set db = nothing

response.redirect "pay_bank_end.asp?ordidx=" & ordidx
else %>
<!-- #include file = "../include/false_pg.asp" --><% end if %>