<!-- #include file = "../include/set_loginfo.asp" -->
<!-- #include file = "../include/dbcon.asp" -->
<!-- #include file="../include/head1.asp" -->

<script language="javascript">
function NumKeyOnly(){
	if((event.keyCode<48)||(event.keyCode>57)) event.returnValue=false;

	if(event.keyCode==13) goReg_Member(true,document.regn);
}
function goReg_Member(){

	if(!document.agree.agreerull1.checked){
		alert("����Ʈ�̿����� �ڼ��� �о�ð� �����ϼž� �մϴ�.");
		return;
	}

	if(!document.agree.agreerull2.checked){
		alert("��������ó����ħ�� �ڼ��� �о�ð� �����ϼž� �մϴ�.");
		return;
	}

	if(!document.agree.agreerull3.checked){
		alert("���������� ���� �� �̿������ �ڼ��� �о�ð� �����ϼž� �մϴ�.");
		return;
	}

	document.agree.submit();
}
function agree_all(){

	document.agree.agreerull1.checked = false;
	document.agree.agreerull2.checked = false;
	document.agree.agreerull3.checked = false;

	if (document.agree.all_checked.checked==true){
		document.agree.agreerull1.checked = true;
		document.agree.agreerull2.checked = true;
		document.agree.agreerull3.checked = true;
	}

}
</script>

<style>
.logBox1{width:980px;border-top:1px solid #ebebeb;border-left:1px solid #ebebeb;border-right:1px solid #ebebeb;border-bottom:1px solid #ebebeb;background:#f8f8f8;padding:40px 0;overflow:hidden;margin:0 0 40px 0}
.all_check{display:inline-block;float:left;font-size:17px;letter-spacing:-1px;color:#4e4e4e}
.all_agree{display:inline-block;float:right;font-size:19px;letter-spacing:-1px;font-weight:500;color:#111;}
</style>

<!-- #include file = "../include/top.asp" -->

<div class="scontent">
    	<div class="step_join">
                <ul>
                    <li class="on">�������<span class="step st1 mbg">POLICY AGREE</span><span class="mline"></span></li>
                    <li>ȸ������ �Է�<span class="step st2 mbg">ȸ������ �Է�</span><span class="mline"></span></li>
                    <li>���ԿϷ�<span class="step st3 mbg">���ԿϷ�</span></li>
                </ul>
            </div>

<form name="agree" method="post" action="<%if len(name_id) > 10 then%>ipin.asp<%else%>memberin.asp<%End if%>">

<div class="logBox1">
			<div class="ftbl_box">
				<div class="all_check">�Ʒ� ��� ����� ������ Ȯ���ϰ� ��ü �����մϴ�.</div>
				<div class="all_agree">
					<input type="checkbox" name="all_checked" id="all_checked" onclick="agree_all();" />
					��� ����� �����մϴ�.
				</div>
			</div>
</div>

        <div class="logBox mb50">
            <h3 class="subTit">����Ʈ�̿���</h3>
            <div class="ftbl_box">
                <div class="scroll">
<%
sql = "select neyong from guideTab where jemok ='����Ʈ�̿���'"
set dr = db.execute(sql)
if not dr.bof or not dr.eof then 

	response.write dr(0)

else
end if
%>
                </div>
                <div class="agreeTxt">
                    <input type="checkbox" name="agreerull1" id="agreerull1"> ����Ʈ�̿����� �����մϴ�.
					</div>
            </div>
        </div>
        <div class="logBox mb50">
            <h3 class="subTit">��������ó����ħ</h3>
            <div class="ftbl_box">	
                <div class="scroll">
<%
sql = "select neyong from guideTab where jemok ='��������ó����ħ'"
set dr = db.execute(sql)
if not dr.bof or not dr.eof then 

	response.write dr(0)

else
end if
%>
                </div>
                <div class="agreeTxt">
                    <input type="checkbox" name="agreerull2" id="agreerull2"> ��������ó����ħ �����մϴ�.
                </div>
            </div>
        </div>
        <div class="logBox mb50">
            <h3 class="subTit">���������������̿�ȳ��� ���� ����</h3>
            <div class="ftbl_box">	
                <div class="scroll">
<%
sql = "select neyong from guideTab where jemok ='���������������̿�ȳ��� ���� ����'"
set dr = db.execute(sql)
if not dr.bof or not dr.eof then 

	response.write dr(0)

else
end if
%>
                </div>
                <div class="agreeTxt">
                    <input type="checkbox" name="agreerull3" id="agreerull3"> ���������� ���� �� �̿������ �����մϴ�.
                </div>
            </div>
        </div>
</form>

        <div class="cbtn"> <a href="javascript:goReg_Member();" class="mbtn grey">�����ϱ�</a><a href="/main/index.asp" class="mbtn">����ϱ�</a> </div>
</div>

<!-- #include file = "../include/bottom.asp" -->