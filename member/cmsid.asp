<!-- #include file="../include/set_loginfo.asp" -->
<!-- #include file="../include/dbcon.asp" -->
<!-- #include file="../include/head1.asp" -->

<script language="javascript">
function NumKeyOnly(){
	if((event.keyCode<48)||(event.keyCode>57)) event.returnValue=false;

	if(event.keyCode==13) goReg_Member(true,document.regn);
}

function goReg_Member(){
	var theform = document.regn;

	var clmn;
	clmn = theform.username;
	if(clmn.value == ""){
		alert("�̸����� ������ϴ�. �̸��� �Է����ּ���!");
		clmn.focus();
		return;
	}
	if(clmn.value.replace(/ /g,"") == ""){
		alert("�̸����� ������ϴ�. �̸��� �Է����ּ���!");
		clmn.select();
		return;
	}

	clmn = theform.tel1;
	if(clmn.value==""){
		alert("�޴�����ȣ�� �Է����ּ���!");
		clmn.focus();
		return;
	}
	clmn = theform.tel2;
	if(clmn.value==""){
		alert("�޴�����ȣ�� �Է����ּ���!");
		clmn.focus();
		return;
	}
	clmn = theform.tel3;
	if(clmn.value==""){
		alert("�޴�����ȣ�� �Է����ּ���!");
		clmn.focus();
		return;
	}

	clmn = theform.email;
	if(clmn.value==""){
		alert("�̸����ּҸ� �Է����ּ���!");
		clmn.focus();
		return;
	}
theform.submit();
}

function goReg_Member1(){

	var theform1 = document.regn1;

	var clmn;
	clmn = theform1.usrid;
	if(clmn.value == ""){
		alert("���̵���� ������ϴ�. ���̵� �Է����ּ���!");
		clmn.focus();
		return;
	}
	if(clmn.value.replace(/ /g,"") == ""){
		alert("���̵���� ������ϴ�. ���̵� �Է����ּ���!");
		clmn.select();
		return;
	}

	clmn = theform1.tel1;
	if(clmn.value==""){
		alert("�޴�����ȣ�� �Է����ּ���!");
		clmn.focus();
		return;
	}
	clmn = theform1.tel2;
	if(clmn.value==""){
		alert("�޴�����ȣ�� �Է����ּ���!");
		clmn.focus();
		return;
	}
	clmn = theform1.tel3;
	if(clmn.value==""){
		alert("�޴�����ȣ�� �Է����ּ���!");
		clmn.focus();
		return;
	}

	clmn = theform1.email;
	if(clmn.value==""){
		alert("�̸����ּҸ� �Է����ּ���!");
		clmn.focus();
		return;
	}

theform1.submit();

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
    	<div class="logtit">
                <h4>���̵�ã��</h4>
            </div>
            <div class="logBox">
                <p class="tip">ȸ�����Խ� ����Ͻ� �̸�/�޴�����ȣ/�̸����ּҸ� �Է����ּ���.</p>
                <ul class="idpw">
<form name="regn" method="post" action="cmsid_ok.asp" >
                    <li class="input">
                        <p><label>�̸�</label>
                            <input type="text" name="username" class="inptxt2" style="width:367px" tabindex="1" /></p>
                        <p><label>�޴�����ȣ</label>
                        	<input type="text" id="tel1" name="tel1" class="inptxt2 w100" onkeyup="onlynum(regn.tel1);" maxlength="4" tabindex="2" />
                        <input type="text" id="tel2" name="tel2" class="inptxt2 w100" onkeyup="onlynum(regn.tel2);" maxlength="4" tabindex="3" />
                        <input type="text" id="tel3" name="tel3" class="inptxt2 w100" onkeyup="onlynum(regn.tel3);" maxlength="4" tabindex="4" /></p>
						<p><label>�̸����ּ�</label>
                            <input type="text" id="email" name="email" class="inptxt2" style="width:367px" tabindex="5" /></p>
					</li>
</form>
                    <li>
                        <a href="javascript:goReg_Member();" class="btn_id pw">���̵�<br/>ã��</a>			</li>
                </ul>
            </div>
            <div class="logtit">
                <h4>��й�ȣã��</h4>
            </div>
            <div class="logBox">
                <p class="tip">ȸ�����Խ� ����Ͻ� ���̵�/�޴�����ȣ/�̸����ּҸ� �Է����ּ���.</p>
                <ul class="idpw">
<form name="regn1" method="post" action="cmspwd_ok.asp" >
                    <li class="input">
                        <p><label>���̵�</label>
                            <input type="text" name="usrid" class="inptxt2" style="width:367px" tabindex="11" /></p>
                        <p><label>�޴�����ȣ</label>
                        	<input type="text" id="tel1" name="tel1" class="inptxt2 w100" onkeyup="onlynum(regn.tel1);" maxlength="4" tabindex="12" />
                        <input type="text" id="tel2" name="tel2" class="inptxt2 w100" onkeyup="onlynum(regn.tel2);" maxlength="4" tabindex="13" />
                        <input type="text" id="tel3" name="tel3" class="inptxt2 w100" onkeyup="onlynum(regn.tel3);" maxlength="4" tabindex="14" /></p>
						<p><label>�̸����ּ�</label>
                            <input type="text" id="email" name="email" class="inptxt2" style="width:367px" tabindex="15" /></p>
					</li>
</form>
                    <li><a href="javascript:goReg_Member1();" class="btn_id pw">��й�ȣ<br />ã��</a></li>
                </ul>
            </div>
    </div>

<!-- #include file = "../include/bottom.asp" -->