<%
Dim objFso,strTname,strFile,arrConfig

set objFso = server.CreateObject("scripting.filesystemobject")

Dim s_name,a_email,shop_url,shop_title,shop_keyword,mem_mileage,b_money,b_money_total,mileage_use,mileage_from,mileage_to
Dim c_name,c_ceo,c_juso,c_number,c_tel,c_fax,c_comnumber,c_chage
Dim ksnetid,dacomid,card_system,banktownid
dim help_time1,help_time2,help_email,help_tel
dim tak_url
dim pay_select,sms_id
Dim name_check,name_id

''����Ʈ����
strTname="config"
strFile = Server.MapPath("..\") & "\ahdma\cfgini\"& strtname &".cfg"
''response.write configFile
arrConfig = Split(ReadTextFile(strFile),chr(13))

''config ini ���� ���� ����
s_name =			arrConfig(0)				''����Ʈ�̸�
a_email =			arrConfig(1)				''�������̸���
shop_url =		arrConfig(2)				''����Ʈ�ּ�
shop_title =		arrConfig(3)				''����ƮTitle
shop_keyword =	arrConfig(4)			''�˻�����Ű����
help_time1 =		arrConfig(5)				''���ϰ����ͻ��ð�
help_time2 =		arrConfig(6)				''�ָ������ͻ��ð�
help_email =		arrConfig(7)			''������̸���
help_tel =			arrConfig(8)				''���׹�����ȭ
mem_mileage =	arrConfig(9)			''ȸ�����Ը��ϸ���
c_name =			arrConfig(10)			''ȸ���
c_ceo =			arrConfig(11)			''��ǥ���̸�
c_juso =			arrConfig(12)			''ȸ���ּ�
c_number =		arrConfig(13)			''����ڹ�ȣ
c_tel =			arrConfig(14)				''ȸ����ȭ��ȣ
c_fax =			arrConfig(15)				''ȸ���ѽ���ȣ
c_comnumber =	arrConfig(16)		''����Ǹž��Ű��ȣ
c_chage =		arrConfig(17)			''��������å����
b_money =		arrConfig(18)			''Ȯ�庯��
b_money_total =	arrConfig(19)		''Ȯ�庯��
mileage_use =		arrConfig(20)		''Ȯ�庯��
mileage_from =	arrConfig(21)		''Ȯ�庯��
mileage_to =		arrConfig(22)		''Ȯ�庯��
ksnetid =			arrConfig(23)			''Ȯ�庯��
dacomid =		arrConfig(24)			''Ȯ�庯��
card_system =		arrConfig(25)		''Ȯ�庯��
tak_url =			arrConfig(26)			''Ȯ�庯��
banktownid =		arrConfig(27)		''Ȯ�庯��
pay_select =		arrConfig(28)		''Ȯ�庯��
sms_id =			arrConfig(29)			''Ȯ�庯��
name_check =		arrConfig(30)		''Ȯ�庯��
name_id =		arrConfig(31)			''Ȯ�庯��


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

Set objFso = Nothing
%>