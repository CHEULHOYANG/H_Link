<!-- #include file="../include/set_loginfo.asp" -->
<% if isUsr then
Dim moneyHap	''�����ݾ�
Dim bycode			''�����Ϸù�ȣ
Dim paygbn			''�ܰ�,���� ����	0:�����̾�,1:����,2:�ܰ�
Dim payType
Dim cnumber,cprice,rs,i

cnumber = Request.Form("cnumber")
cprice = Request.Form("cprice")
moneyHap = Request.Form("moneyHap")
bycode = Request.Form("bycode")
paygbn = Request.Form("paygbn")
payType = Request.Form("payType")  

if not moneyHap = "" and not bycode = "" and not paygbn = "" and not payType = "" then

Dim Smode,MxIssueNO,CcMode
MxIssueNO = str_User_ID & "_" & svdatefomt

select case int(payType)
	case 2
		Smode = "3001"
		CcMode = "11"
	case 3
		Smode = "6101"
		CcMode = "10"
	case 4
		Smode = "2501"
		CcMode = "10"
end select

CcMode = "11"

Function svdatefomt()
	Dim dt1,dt2,dt3
	dt1 = replace(Date,"-","")
	dt2 = FormatDateTime(now(),4)
	dt3 = second(now)
	dt1 = Right(dt1,8)
	dt2 = replace(dt2,":","")

	if dt3 < 10 then
		dt3 = "0" & dt3
	end if
svdatefomt = dt1 & dt2 & dt3
End Function %><!-- #include file="../include/dbcon.asp" --><%

''���� state �� 3�� �� ����
''db.execute("delete order_mast where state=3")

''�̸� �ŷ� ������ Order_mast�� �Է�����
Dim idxAry : idxAry = split(bycode,"|")
dim payTitle,tabnm,strnm,clmn
if int(paygbn) < 1 then
	sql = "select strnm,intprice from PremTab where idx=" & bycode
	set dr = db.execute(sql)
	payTitle = dr(0)
	moneyHap = dr(1)
	dr.close

	tabnm = "PremTab"
	strnm = "�����̾� : "
	clmn = bycode

elseif int(paygbn) > 1 then
	sql = "select strnm from LecturTab where idx=" & idxAry(0)
	set dr = db.execute(sql)
	payTitle = dr(0)
	dr.close

	tabnm = "LecturTab"
	strnm = "�ܰ� : "
	clmn = "categbn"

	if UBound(idxAry) > 0 then
		payTitle = payTitle & " �� " & Ubound(idxAry) & "����"
	end if
else
	sql = "select strnm,intgigan from Lectmast where idx=" & bycode
	set dr = db.execute(sql)
	payTitle = dr(0) & "(" & dr(1) & "�ϰ���)"
	dr.close

	tabnm = "Lectmast"
	strnm = "���� : "
	clmn = "gbn"
end if

Dim reply,reply_count

reply = split(cnumber,",")
reply_count = ubound(reply)

For i = 1 To reply_count

	sql = "select count(idx) from coupon_price_mast where state=0 and cnumber = '"& reply(i) &"'"
	Set rs=db.execute(sql)

	If rs(0) = 1 then

		sql = "update coupon_price_mast set state=1 , id = '"& str_User_ID &"' , use_date = '"& Date() &"' where cnumber = '" & reply(i) & "' and state=0"
		db.execute(sql)
	Else
		response.write"<script>"
		response.write"alert('�����Ͻ� ������ ������ �߻��߽��ϴ�. �ٽ� �������ּ���!!');"
		response.write"self.location.href='../study/dan_list.asp';"
		response.write"</script>"
		response.end

	End if

Next



Dim intprice,categbn,tabidx,intgigan,tempd,eday,huil
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
		if intgigan < 61 then
			huil = 7
		elseif intgigan > 60 and intgigan < 181 then
			huil = 15
		elseif intgigan > 180 then
			huil = 30
		end if

		sql = "insert into order_mast (id,buygbn,tabidx,categbn,title,paytype,intprice,state,eday,holdil,yy,mm,dd,otp,cnumber,cprice) values ('" & str_User_ID & "'," & paygbn & "," & idxAry(ii) & "," & categbn & ",'" & strnm & "',7," &  intprice & ",3,convert(smalldatetime,'" & eday & "')," & huil & ","
		sql = sql & Year(now) & "," & Month(now) & "," & Day(now) & ",'" & MxIssueNO & "','"& cnumber &"',"& cprice &")"
		db.execute(sql)
Next

			sql = "update order_mast set state=0 where id='" & str_User_ID & "' and otp='" & MxIssueNO & "'"
			db.execute(sql)

response.write"<script>"
response.write"alert('���������� �Ϸ�Ǿ����ϴ�.');"
response.write"self.location.href='../my/01_main.asp';"
response.write"</script>"
response.end


else %><!-- #include file = "../include/false_pg.asp" --><% end if 
Else %><!-- #include file = "../include/false_pg.asp" --><% end if%>