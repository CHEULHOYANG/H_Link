<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/refer_check.asp" --><%
vPage = vPage & "/yes_rad/sub3/setinput.asp?idx="
if inStr(vReferer,vPage) > 0 then %>
<!-- #include file = "../../include/dbcon.asp" -->
<%
dim idx,buygbn,categbn,tabidx,strsday,intgigan,paytype,paytime,payday,huday
idx = Request.Form("idx")
buygbn = Request.Form("buygbn")
categbn = Request.Form("categbn")
tabidx = Request.Form("tabidx")
strsday = Request.Form("strsday")
intgigan = Request.Form("intgigan")
paytype = Request.Form("paytype")
paytime = formatdatetime(now,4)

sql = "select huday from site_info"
set dr = db.execute(sql)

If dr.eof Or dr.bof Then
	huday = 0
Else
	huday = dr(0)
dr.close
End if

dim sql,dr
sql = "select id,name from member where idx=" & idx
set dr = db.execute(sql)

dim id,name
id = dr(0)
name = dr(1)
dr.close

function Txt2str(str)
	str = replace(str,"<","&lt;")
	str = replace(str,">","&gt;")
	str = replace(str,"'","''")
	Txt2str = str
end function

idx = Txt2str(idx)
buygbn = Txt2str(buygbn)
categbn = Txt2str(categbn)
tabidx = Txt2str(tabidx)
strsday = Txt2str(strsday)
intgigan = Txt2str(intgigan)
paytype = Txt2str(paytype)

payday = strsday & " " & paytime & ":00"

Dim tabnm,strnm,clmn,tableidx,dbbuygbn


''***********************
''�����̾� �׽�Ʈ

''select case int(buygbn)
''	case 0
''		tabnm = "primTab"
''		strnm = "�����̾� : "
''		clmn = ""
''	''************************
''	case 1
''		tabnm = "Lectmast"
''		strnm = "���� : "
''		tableidx = categbn
''	case 2
''		tabnm = "Lectmast"
''		strnm = "���� : "
''		tableidx = tabidx
''	case 3
''		tabnm = "LecturTab"
''		strnm = "�ܰ� : "
''		tableidx = tabidx
''end select
''*****************************

select case int(buygbn)
	case 1
		tabnm = "premTab"
		strnm = "�����̾� : "
		tableidx = categbn
		dbbuygbn = 0
	case 2
		tabnm = "Lectmast"
		strnm = "���� : "
		tableidx = tabidx
		dbbuygbn = 1
	case 3
		tabnm = "LecturTab"
		strnm = "�ܰ� : "
		tableidx = tabidx
		dbbuygbn = 2
end select


''�����ߴ��� üũ
Dim isGumed,bycnt
isGumed = True
''�����̾� ���°� �ִ� ��쿣 ��������� �ʿ䰡 ����
sql = "select count(idx) from order_mast where id='" & id & "' and buygbn=0 and eday > convert(smalldatetime,getdate())"
set dr = db.execute(sql)
bycnt = int(dr(0))
dr.close

Dim strMsg
if bycnt > 0 then
	isGumed = False
	strMsg = "�����̾����¸� �����ϰ� �ְų� �Աݴ�� �� �̹Ƿ� ��������� �Ͻ� �� �����ϴ�."
else
	sql = "select count(idx) from order_mast where bookidx=0 and id='" & id & "' and buygbn=" & dbbuygbn & " and tabidx=" & tableidx & " and eday > convert(smalldatetime,getdate())"
	set dr = db.execute(sql)
	dim bbycnt : bbycnt = int(dr(0))
	dr.close

	if bbycnt > 0 then
		isGumed = False
		strMsg = "�̹� �����ϰ� �ְų�  �Աݴ�� �� �̹Ƿ� ��������� �Ͻ� �� �����ϴ�."
	end if
end if


if isGumed then

	sql = "select intprice from " & tabnm & " where idx=" & tableidx
	Dim intprice,huil
	set dr = db.execute(sql)
	intprice = dr(0)
	dr.close

	''���бⰣ ����
	''�Ⱓ�� 30 - 60�� ���� : 7�� ����
	''�Ⱓ�� 61 - 180�� ���� : 15�� ����
	''�Ⱓ�� 181 �̻��� ���� : 30�� ���� ����

	huil = huday

	dim tempd,eday
	tempd = Cstr(DateAdd("d",intgigan,strsday))
	eday = tempd & " " & FormatDateTime(now(),4) & ":00"

	dim sday,yy,mm,dd,dary
	sday = payday

	''������躯��
	dary = split(strsday,"-")
	yy = int(dary(0))
	mm = int(dary(1))
	dd = int(dary(2))
	sql = "insert into order_mast (id,buygbn,tabidx,categbn,title,sday,eday,paytype,intprice,payday,yy,mm,dd,state,holdil) values ('"
	sql = sql & id & "'," & dbbuygbn & "," & tableidx & "," & categbn & ",'" & strnm & "',convert(smalldatetime,'" & sday & "'),convert(smalldatetime,'" & eday & "')," & paytype & "," &  intprice & ",convert(smalldatetime,'" & payday & "'),"
	sql = sql & yy & "," & mm & "," & dd & ",0," & huil & ")"
	db.execute(sql)
	strMsg = id & " ���� ��������� ���ƽ��ϴ�!"
	''response.write sql

end if %>

<script language="javascript">

	alert("<%=strMsg%>");
	opener.location.reload();
	self.close();

</script>
</head>
<% else %><!-- #include file = "../../include/false_pg.asp" -->
<% end if
db.close
set db = nothing %>
<!-- #include file = "../authpg_2.asp" -->