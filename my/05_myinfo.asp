<!-- #include file="../include/set_loginfo.asp" -->
<% if  isUsr then %>
<!-- #include file = "../include/dbcon.asp" -->
<%
sql = "select idx,id,pwd,name,juminno1,juminno2,tel1,tel2,email,zipcode1,zipcode2,juso1,juso2,b_year,b_month,b_day,b_type,sms_res,email_res from member where id='" & str_User_ID & "'"
dim idx,id,pwd,name,juminno1,juminno2,tel1,tel2,email,zipcode1,zipcode2,juso1,juso2,b_year,b_month,b_day,b_type,sms_res,email_res
set dr = db.execute(sql)
idx = dr(0)
id = dr(1)
pwd = dr(2)
name = dr(3)
juminno1 = dr(4)
juminno2 = dr(5)
tel1 = split(dr(6),"-")
tel2 = split(dr(7),"-")
email = dr(8)
zipcode1 = dr(9)
zipcode2 = dr(10)
juso1 = dr(11)
juso2 = dr(12)
b_year = dr(13)
b_month = dr(14)
b_day = dr(15)
b_type = dr(16)
sms_res = dr(17)
email_res = dr(18)
dr.close %>
<!-- #include file="../include/head1.asp" -->
<!-- #include file="../include/daum_zip.asp" -->

<script>
function onlynum(objtext1){
				var inText = objtext1.value;
				var ret;
				for (var i = 0; i < inText.length; i++) {
				    ret = inText.charCodeAt(i);
					if (!((ret > 47) && (ret < 58)))  {
						alert("���ڸ��� �Է����ּ���.");
						objtext1.value = "";
						objtext1.focus();
						return false;
					}
				}
				return true;
}
function  RightDay(y,m){
	var thisYY,thisMM,thisDD;

	thisYY = parseInt(y,10);
	thisMM = parseInt(m,10);
	thisDD = "";

	if((thisMM == 4) || (thisMM == 6) || (thisMM == 9) || (thisMM ==11)){
		thisDD = "30";
	}
	else if(thisMM == 2){
			thisDD = (thisYY % 4) == 0 ? "29" : "28";
	}else{
		thisDD = "31";
	}
return thisDD;
}

function LocalNum(strNum){
	var strlocal="02|031|032|033|041|042|043|051|052|053|054|055|061|062|063|064|060|070|080";
	var numLen = strlocal.split("|");
	for(i=0;i<numLen.length;i++){
		if(numLen[i] == strNum){
			return false;
			break;
		}
	}
return true;
}

function HandNum(strNum){
	var strlocal="010|011|016|017|018|019";
	var numLen = strlocal.split("|");
	for(i=0;i<numLen.length;i++){
		if(numLen[i] == strNum){
			return false;
			break;
		}
	}
	return true;
}

function emailCheck(str) {
	if(str.match(/[\w\-\~]+\@[\w\-\~]+(\.[\w\-\~]+)+/g)!=str) return true;
}

function goReg_Member(theform){
	var clmn;

if (theform.pwd1.value != "")
{

	clmn = theform.pwd1;
	if(clmn.value==""){
		alert("�н����带 �Է����ּ���!");
		clmn.focus();
		return;
	}
	pass1 = clmn.value;

	clmn = theform.pwd2;
	if(clmn.value != pass1){
		if(clmn.value.length > 0){
			alert("���� �Է��� �н������ ���� �ʽ��ϴ�!                ");
			clmn.select();
		}else{
			alert("�н����带 �ѹ��� �Է��ϼž� �մϴ�!              ");
			clmn.focus();
		}
	return;
	}

}
	clmn = theform.hp1;
	if(clmn.value==""){
		alert("�޴����� ��Ȯ�ϰ� �Է��ϼ���!");
		clmn.focus();
		return;
	}
	if(HandNum(clmn.value)){
		alert("���� ���� ��ȣ�Դϴ�.");
		clmn.select();
		return;
	}

	clmn = theform.hp2;
	if(clmn.value==""){
		alert("�޴����� ��Ȯ�ϰ� �Է��ϼ���!");
		clmn.focus();
		return;
	}
	if(clmn.value.length < 3){
		alert("�޴����� ��Ȯ�ϰ� �Է��ϼ���!");
		clmn.select();
		return;
	}

	clmn = theform.hp3;
	if(clmn.value==""){
		alert("�޴����� ��Ȯ�ϰ� �Է��ϼ���!");
		clmn.focus();
		return;
	}
	if(clmn.value.length < 4){
		alert("�޴����� ��Ȯ�ϰ� �Է��ϼ���!");
		clmn.select();
		return;
	}

	clmn = theform.email;
	if(clmn.value == ""){
		alert("�̸����� �Է����ּ���!");
		clmn.focus();
		return;
	}

	if(emailCheck(clmn.value)){
		alert("�̸����� ��Ȯ�ϰ� �Է����ּ���!");
		clmn.select();
		return;
	}

document.regfm.submit();
}

</script>

<!-- #include file="../include/top.asp" -->

<div class="smain">    
	<!-- #include file="left.asp" -->
    <div class="content">
    	<div class="cont_tit">
        	<h3>ȸ����������</h3>
        </div>
        <div class="scont">

<form name="regfm" action="myinfo_ok.asp" method="post" style="display:inline;">
<input type="hidden" name="idx" value="<%=idx%>">
            <table class="ftbl" style="width:830px">
                <colgroup>
                <col style="width:22%" />
                <col style="width:78%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th>���̵�</th>
                        <td><%=id%></td>
                    </tr>
                    <tr>
                        <th>�̸�</th>
                        <td><%=name%></td>
                    </tr>
                    <tr>
                        <th>�������</th>
                        <td><%=juminno1%></td>
                    </tr>
					<tr>
						<th>��й�ȣ<span class="star">*</span></th>
						<td><input type="password" name="pwd1" class="inptxt1" tabindex="2" />
							<span class="stip pl10">* 4���̻��� ���� �� ����, ����� �Է�</span></td>
					</tr>
					<tr>
						<th>��й�ȣȮ��<span class="star">*</span></th>
						<td><input type="password" name="pwd2" class="inptxt1" tabindex="3" /></td>
					</tr>
					<tr>
						<th>�޴���ȭ��ȣ<span class="star">*</span></th>
						<td><input type="text" name="hp1" onkeyup="onlynum(regfm.hp1);" maxlength="3" class="inptxt1 w50" tabindex="5" value="<%=tel2(0)%>"/>
							&nbsp;-&nbsp;
							<input type="text" name="hp2" onkeyup="onlynum(regfm.hp2);" maxlength="4" class="inptxt1 w50" tabindex="6" value="<%=tel2(1)%>" />
							&nbsp;-&nbsp;
							<input type="text" name="hp3" onkeyup="onlynum(regfm.hp3);" maxlength="4" class="inptxt1 w50" tabindex="7" value="<%=tel2(2)%>" /></td>
					</tr>
					<tr>
						<th>�̸���<span class="star">*</span></th>
						<td><input type="text" name="email" class="inptxt1 w600" tabindex="11" value="<%=email%>" /></td>
					</tr>

					<tr>
						<th rowspan="3">�ּ�</th>
						<td><input type="text" name="zipcode1" id="post1" class="inptxt1 w50" tabindex="12" readonly value="<%=zipcode1%>" /> <a href="javascript:openDaumPostcode();" class="fbtn">�����ȣ</a></td>
					</tr>
					<tr>
						<td><input type="text" name="juso1" id="addr" class="inptxt1 w600" tabindex="13" readonly value="<%=juso1%>" /></td>
					</tr>
					<tr>
						<td><input type="text" name="juso2" id="addr2" class="inptxt1 w600" tabindex="14" value="<%=juso2%>" /></td>
					</tr>
					<tr>
						<th>���ſ���</th>
						<td><input type="checkbox" name="sms_res" id="sms_res" value="1" <%If sms_res=1 Then response.write"checked" End if%>>
							SMS ����
							<input type="checkbox" name="email_res" id="email_res" value="1" <%If email_res=1 Then response.write"checked" End if%>>
							�̸��� ����</td>
					</tr>
                </tbody>
            </table>
</form>

			<div class="cbtn"> <a href="javascript:goReg_Member(regfm);" class="mbtn grey">��������</a> </div>

        </div>
    </div>
</div>

<!-- #include file="../include/bottom.asp" -->
<% else %>
<!-- #include file="../include/false_pg.asp" -->
<% end if %>