<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/dbcon.asp" -->
<!-- #include file = "../../include/fso.asp" -->
<%
Dim s_name,a_email,shop_url,shop_title,shop_keyword,mem_mileage,b_money,b_money_total,mileage_use,mileage_from,mileage_to
Dim c_name,c_ceo,c_juso,c_number,c_tel,c_fax,c_comnumber,c_chage
Dim ksnetid,dacomid,card_system,banktownid
dim help_time1,help_time2,help_email,help_tel
dim tak_url
dim pay_select,sms_id
Dim name_check,name_id

strTname="config"
strFile = Server.MapPath("..\..\") & "\ahdma\cfgini\"& strtname &".cfg"
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

if shop_url = "" then
	shop_url = "http://" & request.ServerVariables("HTTP_HOST")
end If

Dim sns_kakao,sns_naver1,sns_naver2,sql,rs,huday,player1,player2,watermark,google_pwd

sql = "select kakao,naver1,naver2,huday,player1,player2,watermark,google_pwd from site_info"
Set rs=db.execute(sql)

If rs.eof Or rs.bof Then
Else
	
	sns_kakao = rs(0)
	sns_naver1 = rs(1)
	sns_naver2 = rs(2)
	huday = rs(3)
	player1 = rs(4)
	player2 = rs(5)
	watermark = rs(6)
	google_pwd = rs(7)

rs.close
End if
%>
<!--#include file="../main/top.asp"-->

<div class="container">
	<!--#include file="left.asp"-->
	<div class="content">
		<h2 class="cTit"><span class="bullet"></span>����Ʈ��������</h2>


<form name="form1" method="post" action="config_ok.asp" style="display:inline;">

		<table class="ftbl mb50" style="width:100%">
				<colgroup>
				<col style="width:20%" />
				<col style="width:80%" />
				</colgroup>
				<tbody>
					<tr>
						<th>������ Player ��뼳��</th>
						<td><input type="checkbox" name="player1" value="y" <%If Len(player1) > 0 Then Response.write"checked" End if%>> ������ Player1 ���
						<br/><input type="checkbox" name="player2" value="y" <%If Len(player2) > 0 Then Response.write"checked" End if%>> ������ Player2 ��� (��õ)
						<br /><input type="checkbox" name="watermark" value="y" <%If Len(watermark) > 0 Then Response.write"checked" End if%>> ���̵���͸�ũ��� <span class="stip">* ���͸�ũ ���� ���̵� ������ ����� �������� �Ǹ� ��üȭ�鿡���� �̻��˴ϴ�.</span></td>
					</tr>
					<tr>
						<th>����Ʈ �̸�</th>
						<td><input type="text" name="s_name" class="inptxt1 w400" value="<%=s_name%>"></td>
					</tr>
					<tr>
						<th>����Ʈ �ּ�</th>
						<td><input type="text" name="shop_url" size="50" class="inptxt1 w400" value="<%=shop_url%>" ></td>
					</tr>
					<tr>
						<th>����Ʈ Title</th>
						<td><input type="text" name="shop_title" size="50" class="inptxt1 w500" value="<%=shop_title%>" ></td>
					</tr>
					<tr>
						<th>�˻�Ű����</th>
						<td><textarea name="shop_keyword" cols="80" rows="4" class="inptxt1 w500" style="height:100px"><%=shop_keyword%></textarea></td>
					</tr>
					<tr>
						<th>������ �̸���</th>
						<td><input type="text" name="a_email" class="inptxt1 w400" size="30" value="<%=a_email%>" ></td>
					</tr>
					<tr>
						<th>���ð��ȳ�#1</th>
						<td><input type="text" name="help_time1" size="50" class="inptxt1 w400" value="<%=help_time1%>" ></td>
					</tr>
					<tr>
						<th>���ð��ȳ�#2</th>
						<td><input type="text" name="help_time2" size="50" class="inptxt1 w400" value="<%=help_time2%>" ></td>
					</tr>
					<tr>
						<th>������̸���</th>
						<td><input type="text" name="help_email" size="50" class="inptxt1 w400" value="<%=help_email%>" ></td>
					</tr>
					<tr>
						<th>�����͹�ȣ</th>
						<td><input type="text" name="help_tel" size="50" class="inptxt1 w400" value="<%=help_tel%>" ></td>
					</tr>
					<tr>
						<th>ȸ���</th>
						<td><input type="text" name="c_name" class="inptxt1 w400" value="<%=c_name%>" ></td>
					</tr>
					<tr>
						<th>��ǥ���̸�</th>
						<td><input type="text" name="c_ceo" class="inptxt1 w400" size="15" value="<%=c_ceo%>" ></td>
					</tr>
					<tr>
						<th>ȸ���ּ�</th>
						<td><input type="text" name="c_juso" class="inptxt1 w400" size="80" value="<%=c_juso%>" ></td>
					</tr>
					<tr>
						<th>����ڹ�ȣ</th>
						<td><input type="text" name="c_number" class="inptxt1 w400" value="<%=c_number%>" ></td>
					</tr>
					<tr>
						<th>ȸ����ȭ��ȣ</th>
						<td><input type="text" name="c_tel" class="inptxt1 w400" value="<%=c_tel%>" ></td>
					</tr>
					<tr>
						<th>ȸ���ѽ���ȣ</th>
						<td><input type="text" name="c_fax" class="inptxt1 w400" value="<%=c_fax%>" ></td>
					</tr>
					<tr>
						<th>����ǸŹ�ȣ</th>
						<td><input type="text" name="c_comnumber" class="inptxt1 w400" value="<%=c_comnumber%>" ></td>
					</tr>
					<tr>
						<th>��������å����</th>
						<td><input type="text" name="c_chage" size="15" class="inptxt1 w400" value="<%=c_chage%>" ></td>
					</tr>
					<tr>
						<th>�������������</th>
						<td><input name="name_id" type="radio" id="name_id" value="" <%if name_id = "" then response.write"checked" end if%>>
								   �̻��
								   <input type="radio" name="name_id" id="name_id" value="1" <%if name_id = "1" then response.write"checked" end if%>>
								  ���
<span class="stip">���� ������3���� ������ �� ���Ŀ� ����Ǵ� �����Ǵ� �����մϴ�.</span></td>
					</tr>
					<tr>
						<th>�����н�ȸ����뿩��</th>
						<td><input name="ksnetid" type="radio" id="radio" value="1" <%if ksnetid = "1" then response.write"checked" end if%>>
								   ��� 
								   <input type="radio" name="ksnetid" id="radio2" value="2" <%if ksnetid = "2" then response.write"checked" end if%>>
								  �̻��
<span class="stip">�����н�ȸ���̶�? �Ⱓ���� ��Ű��/�ܰ��� ���Ѿ��� �����Ҽ� �ִ� ȸ���Դϴ�.</span></td>
					</tr>
					<tr>
						<th>ȸ������������</th>
						<td><input type="text" name="mem_mileage" size="10" class="inptxt1 w100" value="<%=mem_mileage%>"  onKeyPress="if((event.keyCode<48)||(event.keyCode>57)) event.returnValue=false;" maxlength="5">
									<span class="stip">������� 0�� �Է��Ͻø� �˴ϴ�.</span></td>
					</tr>
					<tr>
						<th>�α���������</th>
						<td><input type="text" name="name_check" size="10" class="inptxt1 w100" value="<%=name_check%>"  onKeyPress="if((event.keyCode<48)||(event.keyCode>57)) event.returnValue=false;" maxlength="5">
									<span class="stip">������� 0�� �Է��Ͻø� �˴ϴ�.</span></td>
					</tr>
					<tr>
						<th>�ް��ϼ���</th>
						<td><input type="text" name="huday" size="10" class="inptxt1 w100" value="<%=huday%>"  onKeyPress="if((event.keyCode<48)||(event.keyCode>57)) event.returnValue=false;" maxlength="5"> ��
									<span class="stip">������� 0�� �Է��Ͻø� �˴ϴ�.</span></td>
					</tr>
					<tr>
						<th>��ۺ���</th>
						<td>���籸�� ��� �� �հ谡                                 
 <input name="banktownid" type="text" class="inptxt1 w100" id="banktownid"  onKeyPress="if((event.keyCode<48)||(event.keyCode>57)) event.returnValue=false;" value="<%=banktownid%>" size="10">
 ��
 ���ϸ� 
 ��ۺ� 
 <input name="pay_select" type="text" class="inptxt1 w100" id="pay_select"  onKeyPress="if((event.keyCode<48)||(event.keyCode>57)) event.returnValue=false;" value="<%=pay_select%>" size="10">
 ���� �߰��˴ϴ�.
<span class="stip">������� 0�� �Է��Ͻø� �˴ϴ�.</span></td>
					</tr>
					<tr>
						<th>���ڼ���</th>
						<td><input type="text" name="sms_id" size="40" class="inptxt1 w400" value="<%=sms_id%>" >
									 <span class="stip"><a href="http://www.ppurio.com" target="_blank">http://www.ppurio.com</a> > ȸ������ > ���������� ���̵�,�߽Ź�ȣ(���ڸ�)�� &quot;,&quot;�� �����ؼ� �Է��Ͻø� �˴ϴ�. �߼۾����Ǵ� FTP�����ǿ� �����ϰ� �Է��ϼ���.</span></td>
					</tr>
					<tr>
						<th>īī���α���</th>
						<td><input type="text" name="kakao" size="40" class="inptxt1 w400" value="<%=sns_kakao%>" >
									 <span class="stip"><a href="https://developers.kakao.com" target="_blank">https://developers.kakao.com</a> > ��Ű > JavaScript Ű�Է�</span></td>
					</tr>
					<tr>
						<th>���̹��α��� Client ID</th>
						<td><input type="text" name="naver1" size="40" class="inptxt1 w400" value="<%=sns_naver1%>" >
									 <span class="stip"><a href="https://developers.naver.com" target="_blank">https://developers.naver.com</a> > �����ø����̼� > ���ø����̼� > Client ID�Է�</span></td>
					</tr>
					<tr>
						<th>���̹��α��� Client Secret</th>
						<td><input type="text" name="naver2" size="40" class="inptxt1 w400" value="<%=sns_naver2%>" >
									 <span class="stip"><a href="https://developers.naver.com" target="_blank">https://developers.naver.com</a> > �����ø����̼� > ���ø����̼� > Client Secret�Է�</span></td>
					</tr>
					<tr>
						<th>���� ���ϼ���</th>
						<td><input type="text" name="google_pwd" size="40" class="inptxt1 w400" value="<%=google_pwd%>" >
									 <span class="stip">01-01,03-01,05-05,05-28,06-06,08-15,10-03,12-25 ���·� �Է�</span></td>
					</tr>
				</tbody>
			</table>
</form>
		<div class="rbtn">
			<a href="javascript:document.form1.submit();" class="btn">�����ϱ�</a>
		</div>



	</div>
</div>


</body>
</html><%
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

End Function %>
<!-- #include file = "../authpg_2.asp" -->