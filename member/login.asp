<!-- #include file="../include/set_loginfo.asp" -->
<!-- #include file = "../include/dbcon.asp" -->
<% if isUsr then
	response.redirect "../main/index.asp"
	response.end
end If
%>
<!-- #include file="../include/head1.asp" -->

<script language="javascript">
function strOnLogin(isKey,theform){
if(isKey || event) event.returnValue = false;

	clmn = theform.usrid;
	if(clmn.value==""){
		alert("���̵� �Է��ϼ���!!");
		clmn.focus();
		return;
	}
	clmn = theform.usrpwd;
	if(clmn.value == ""){
		alert("��й�ȣ�� �Է����ּ���!");
		clmn.focus();
		return;
	}
theform.submit();
}
</script>

<!-- #include file = "../include/top.asp" -->
<div class="scontent">
    	<div class="logcont">
        	<div class="logtit">
                <h3>LOGIN</h3>
            </div>
<form name="logfm" action="login_ok.asp" method="post" style="display:inline;">
<input type="hidden" name="str__Page" value="<%=request("str__Page")%>">
            <div class="log_box">
            	<p>���̵� �����ø� ���� ȸ�������� ���ֽñ� �ٶ��ϴ�.</p>
                <ul>
	                <li><input type="text" name="usrid" class="inptxt2"  tabindex="11" placeholder="���̵�"  /></li>
    	            <li><input type="password" name="usrpwd" class="inptxt2" tabindex="12" placeholder="��й�ȣ"  onkeypress="if(event.keyCode==13){javascript:strOnLogin(false,logfm);}"  /></li>
                </ul>
                <a href="javascript:strOnLogin(false,logfm);" class="btn_login">�α���</a>
            </div>
</form>
			<div class="find_blk">
                <a href="/member/agree.asp">����ȸ������</a><a href="/member/cmsid.asp">���̵�/��й�ȣã��</a>
            </div>

            <ul class="btns">
<%If Len(sns_naver1) > 0 And Len(sns_naver2) > 0 then%>
                <li><span>���̹� ���̵�� ���ϰ� �α��� �� �� �ֽ��ϴ�.</span><a href="/sns_naver/naver_login.asp"><img src="../img/img/btn_naver.gif" alt="���̹� �α���" /></a></li>
<%End if%>
<%If Len(sns_kakao) > 0 then%>
				<li><span>īī���� ���̵�� ���ϰ� �α��� �� �� �ֽ��ϴ�.</span><a href="javascript:createKakaotalkLogin();"><img src="../img/img/btn_kakao.gif" alt="īī�� �α���" /></a></li>                
<%End if%>
            </ul>
        </div>
    </div>

<!-- #include file = "../include/bottom.asp" -->