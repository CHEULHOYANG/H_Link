<!-- #include file="../include/set_loginfo.asp" -->
<% if isUsr then
	response.redirect "../main/index.asp"
	response.end
end if
%>
<!-- #include file = "../include/refer_check.asp" -->
<%
vPage = vPage & "/member/agree.asp"
if vReferer = vPage then
%><!-- #include file = "../include/dbcon.asp" -->
<!-- #include file="../include/head1.asp" -->
<!-- #include file="../include/daum_zip.asp" -->

<script>
function idd_check(){

	var f = window.document.regfm;

	if(f.usrid.value==""){
	alert("���̵� �Է����ּ���.");
	f.usrid.focus();
	return;
	}
    if(f.usrid.value.length < 6 || f.usrid.value.length > 16) {
	alert ( "ID�� 6 ~ 16�ڸ��� �����մϴ�." )  ;
	f.usrid.focus();
	return ;
	}

	f.idcheck.value = "";

		$.ajax({
			url: "../xml/id_check.asp",
			type:"POST",
			data:{"id":""+f.usrid.value+""},
			dataType:"text",
			cache:false,
			processData:true,
			success:function(_data){						

				var a = _data

				alert(a);
				
				if (a == "�̹̻������ ���̵��Դϴ�.")
				{					
					f.usrid.value='';
					return;
				}
				else
				{
					f.idcheck.value = "1";
				}


			},
			error:function(xhr,textStatus){
			alert("[����]����:"+xhr.status+"                                     ");
			}	
		});	


		
}

function NumKeyOnly(){
	if((event.keyCode<48)||(event.keyCode>57)) event.returnValue=false;
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


	clmn = theform.usrid;
	if(theform.idcheck.value==""){
		if(clmn.value.length > 0){
			alert("���̵� �ߺ�Ȯ���� �ϼž� �մϴ�.");
			clmn.select();
		}else{
			alert("���̵� �Է����ּ���.");
			clmn.focus();
		}
	return;
	}

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
			alert("������ �Է��� �ſ� ���� �н����带 �Է��ϼž� �մϴ�!");
			clmn.select();
		}else{
			alert("������ �Է��� �н����带 �ѹ� �� �Է����ּ���!");
			clmn.focus();
		}
	return;
	}

	clmn = theform.uname;
	if(clmn.value==""){
		alert("�̸��� �Է����ּ���!");
		clmn.focus();
		return;
	}
	clmn = theform.juminno1;
	if(clmn.value==""){
		alert("��������� �Է����ּ���.");
		clmn.focus();
		return;
	}
	clmn = theform.juminno1;
	if(clmn.value.length != 8){
		alert("��������� ��Ȯ�� �Է����ּ��� ��) 20201231 �Է����ּ���.");
		return;
	}

	clmn = theform.hp1;
	if(clmn.value==""){
		alert("�޴���ȭ��ȣ�� ��Ȯ�ϰ� �Է��ϼ���!");
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
		alert("�޴���ȭ��ȣ�� ��Ȯ�ϰ� �Է��ϼ���!");
		clmn.focus();
		return;
	}
	if(clmn.value.length < 3){
		alert("�޴���ȭ��ȣ�� ��Ȯ�ϰ� �Է��ϼ���!");
		clmn.select();
		return;
	}

	clmn = theform.hp3;
	if(clmn.value==""){
		alert("�޴���ȭ��ȣ�� ��Ȯ�ϰ� �Է��ϼ���!");
		clmn.focus();
		return;
	}
	if(clmn.value.length < 4){
		alert("�޴���ȭ��ȣ�� ��Ȯ�ϰ� �Է��ϼ���!");
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

function idcheck_reset(){
	document.regfm.idcheck.value="";
}
function Id_Check(){
    //document.regfm.idcheck.value="1";
	if(document.regfm.usrid.value==""){ 
	alert("���̵� �Է��� �ּ���.");
	document.regfm.usrid.focus();
	return;
	}
	window.open('id_check.asp?id='+document.regfm.usrid.value,'id_check','width=400,height=200,menubar=no,scrollbars=no');
}
function sub(url, field)
{ 
	var opt = "toolbar=no,resizable=yes,scrollbars=yes,location=no,resize=no,menubar=no,directories=no,copyhistory=0,width=500,height=300,top= 330,left = 370"; 	
	window.open(url, 'new_window', opt); 
} 
function onlyEng(objtext1) {
				var inText = objtext1.value;
				var ret;	
				for (var i = 0; i < inText.length; i++) {
				    ret = inText.charCodeAt(i);
					if ((ret > 122) || (ret < 48) || (ret > 57 && ret < 65) || (ret > 90 && ret < 97)) {
						alert("�����ڿ� ���ڸ��� �Է����ּ���.");
						objtext1.value = "";
						objtext1.focus();
						return false;
					}
				}
				return true;
}
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
</script>

<!-- #include file = "../include/top.asp" -->

<div class="scontent">

    	<div class="step_join">
                <ul>
                    <li>�������<span class="step st1 mbg">POLICY AGREE</span><span class="mline"></span></li>
                    <li class="on">ȸ������ �Է�<span class="step st2 mbg">ȸ������ �Է�</span><span class="mline"></span></li>
                    <li>���ԿϷ�<span class="step st3 mbg">���ԿϷ�</span></li>
                </ul>
            </div>

        <h3 class="stit mt30">ȸ���⺻����<em>(<span class="star">*</span>ǥ�õ� �׸��� �� �Է��� �ּž� ������ �����մϴ�.)</em></h3>

<form name="regfm" action="memin_ok.asp" method="post" style="display:inline;">
		<table class="ftbl" style="width:980px">
				<colgroup>
					<col style="width:20%" />
					<col style="width:80%" />
				</colgroup>
				<tbody>
					<tr>
						<th>���̵�<span class="star">*</span></th>
						<td><input type="text" name="usrid" class="inptxt1" tabindex="1" onKeyPress="javascript:this.value=this.value.toLowerCase();" onKeyUp="onlyEng(regfm.usrid);" />
							<a href="javascript:idd_check();" class="fbtn">�ߺ�Ȯ��</a></td>
					</tr>
					<tr>
						<th>��й�ȣ<span class="star">*</span></th>
						<td><input type="password" name="pwd1" class="inptxt1" tabindex="2" />
							<span class="stip pl10">* 4���̻��� ���� �� ����</span></td>
					</tr>
					<tr>
						<th>��й�ȣȮ��<span class="star">*</span></th>
						<td><input type="password" name="pwd2" class="inptxt1" tabindex="3" /></td>
					</tr>
					<tr>
						<th>�̸�<span class="star">*</span></th>
						<td><input type="text" name="uname" class="inptxt1" tabindex="4" /></td>
					</tr>

					<tr>
						<th>�������<span class="star">*</span></th>
						<td><input type="text" name="juminno1" class="inptxt1" tabindex="4" onkeyup="onlynum(regfm.juminno1);" maxlength="8" /> <span class="stip pl10">* ��)20201231</span></td>
					</tr>

					<tr>
						<th>�޴���ȭ��ȣ<span class="star">*</span></th>
						<td><input type="text" name="hp1" onkeyup="onlynum(regfm.hp1);" maxlength="3" class="inptxt1 w50" tabindex="5" />
							&nbsp;-&nbsp;
							<input type="text" name="hp2" onkeyup="onlynum(regfm.hp2);" maxlength="4" class="inptxt1 w50" tabindex="6" />
							&nbsp;-&nbsp;
							<input type="text" name="hp3" onkeyup="onlynum(regfm.hp3);" maxlength="4" class="inptxt1 w50" tabindex="7" /></td>
					</tr>


					<tr>
						<th>�̸���<span class="star">*</span></th>
						<td><input type="text" name="email" class="inptxt1 w600" tabindex="11" /></td>
					</tr>

					
					<tr>
						<th>���ſ���</th>
						<td><input type="checkbox" name="sms_res" id="sms_res" value="1">
							SMS ����
							<input type="checkbox" name="email_res" id="email_res" value="1">
							�̸��� ����</td>
					</tr>
				</tbody>
			</table>

<input type="hidden" name="sndinID" value="">
<input type="hidden" name="codzip" value="">
<input type="hidden" name="idcheck" value="">
</form>

        <div class="cbtn"> <a href="javascript:goReg_Member(regfm);" class="mbtn grey">�����ϱ�</a><a href="/main/index.asp" class="mbtn">����ϱ�</a> </div>

</div>

<!-- #include file = "../include/bottom.asp" --><% else %>
<!-- #include file = "../include/false_pg.asp" -->
<% end if %>

