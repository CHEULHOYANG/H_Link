<!-- #include file="../include/set_loginfo.asp" -->
<% if  isUsr then %>
<!-- #include file = "../include/dbcon.asp" -->
<!-- #include file="../include/head1.asp" -->

<script language="javascript">
function TxtChk_Length(obj){
	var objlen = obj.value.length;
	spanID.innerHTML = "<b>" + objlen + "</b>";

	if(objlen > 150){
		alert("150�� �̳��� �Է��ϼ���");
		obj.value = obj.value.substring(0,150);
		spanID.innerHTML = "<b>" + obj.value.length + "</b>";
		return false;
	}
}
</script>

<!-- #include file="../include/top.asp" -->

<div class="smain">    
	<!-- #include file="left.asp" -->
    <div class="content">
    	<div class="cont_tit">
        	<h3>ȸ��Ż��</h3>
        </div>
        <div class="scont">
        	                    <ul class="outTxt">
                        <li>ȸ��Ż�� ��û�Ͻø� �ش� ���̵�� <strong>��� Ż��ó��</strong>�˴ϴ�.</li>
                        <li>ȸ��Ż����, <strong>14�ϵ����� ȸ�������� �Ұ���</strong>�մϴ�. Ż��� �簡���� ���� ���̵� ��ü�ϸ鼭 �Ϲ� �̿��ڵ鲲 ���ظ� ��ġ�� ������ �����ϱ� ���� ��ġ�̿��� ���� ���� �ٶ��ϴ�. </li>
                        <li>ȸ��Ż�� ���, ȸ�������� ��� �����Ǹ� ��, �Ʒ��� <strong>������ ������ �Խù�</strong>�� Ż���Ŀ��� �������� �ʽ��ϴ�. Ż���Ŀ��� ȸ������ ������ ���� �ۼ��� ������ Ȯ���� �� ���� ������ �Խù� ���� ������ ���Ͻô� ��쿡�� �ݵ�� ���� �Խù��� �����Ͻ� ��,Ż�� ��û�Ͻñ� �ٶ��ϴ�.</li>
                        <li>- �Խ��� : Ÿ�ΰ� �Բ� ����ϴ� ������ ������ �Խù��� ���, �ǰ� ��<br />
                            - ���ų��� : ���������� �������<br />
                            - ������Ȳ : ���������� ���ӳ���</li>
                        <li>�������� ��޹�ħ�� ���� �ҷ��̿� �� �̿����ѿ� ���� ����� 3�������� �������� �ʰ� �����˴ϴ�.</li>
                    </ul>
<form name="outfm" method="post" action="myinfo_out_ok.asp" style="display:inline;">
			<div class="outList">
                            <ul>
                                <li><input type="checkbox" name="out_reason" id="out_reason" value="�ڷ��� ���� ����">&nbsp;�ڷ��� ���� ����</li>
                                <li><input type="checkbox" name="out_reason" id="out_reason" value="�ڷ��� ����">&nbsp;�ڷ��� ����</li>
                            </ul>
                            <ul>
                                <li><input type="checkbox" name="out_reason" id="out_reason" value="������ ����Ҹ�">&nbsp;������ ����Ҹ�</li>
                                <li><input type="checkbox" name="out_reason" id="out_reason" value="AS�Ҹ�">&nbsp;AS�Ҹ�</li>
                            </ul>
                            <ul>
                                <li><input type="checkbox" name="out_reason" id="out_reason" value="������������ ���">&nbsp;������������ ���</li>
                                <li><input type="checkbox" name="out_reason" id="out_reason" value="����Ʈ ������ ���">&nbsp;����Ʈ ������ ���</li>
                            </ul>
                            <ul>
                                <li><input type="checkbox" name="out_reason" id="out_reason" value="�̿�� ����">&nbsp;�̿�� ����</li>
                                <li><input type="checkbox" name="out_reason" id="out_reason" value="��Ÿ">&nbsp;��Ÿ</li>
                            </ul>
                        </div>
						<dl class="outre">
                            <dt>ȸ������ ���ɾ ����Ѹ��� ��Ź�帳�ϴ�.</dt>
                            <dd><textarea name="replcont" id="replcont" cols="45" rows="5" class="txtarea" onKeyup="TxtChk_Length(this);" style="width:96%"></textarea></dd>
                            <dd class="stip">��Ÿ�ǰ��� 250�� ���ܷ� �Է��Ͻ� �� �ֽ��ϴ�. <strong  ID="spanID">0</strong>/250Byte</dd>
                        </dl>
</form>

            <div class="cbtn"> <a href="javascript:if(confirm('������ ȸ��Ż���Ͻðڽ��ϱ�?')) document.outfm.submit();" class="mbtn grey">Ż���ϱ�</a> </div>

        </div>
    </div>
</div>

<!-- #include file="../include/bottom.asp" -->
<% else %>
<!-- #include file="../include/false_pg.asp" -->
<% end if %>