<!-- #include file="../include/set_loginfo.asp" -->
<!-- #include file="../include/dbcon.asp" -->
<% if isUsr then
Dim bycode : bycode = Session("buySection")

if bycode = "" then %>
<!-- #include file = "../include/false_pg.asp" --><% else
Dim moneyHap,strnm,intgigan

sql = "select strnm,intprice,intgigan from PremTab where idx=" & bycode
set dr = db.execute(sql)
strnm = dr(0)
moneyHap = dr(1)
intgigan = dr(2)
dr.close %>
<!-- #include file="../include/head1.asp" -->
<!-- #include file="../include/top.asp" -->

<script language="javascript">
function go2Payin(pgType){
	fm = document.payfm;
	fm.payType.value=pgType;

	if(parseInt(pgType,10) > 1){
		w="390";
		h="360";
		fm.action = "pay_iframe.asp";

	}else{
			w="520";
			h="500";
		fm.action = "bank_in.asp";

	}

	var l = Math.round(screen.availWidth/2)-Math.round(w/2);
	var t = Math.round(screen.availHeight/2)-Math.round(h/2);
	var sFeatures = "width=" + w + ",height=" + h + ",top=" + t + ",left=" + l + ",resizable=no";
	TG_PAY = window.open("","TG_PAY",sFeatures);
	fm.target="TG_PAY";
	fm.submit();
	TG_PAY.focus();
}
</script>

<div class="scontent">
    	<div class="logtit">
                <h4>�����н� �����ϱ�</h4>
		</div>

<form name="payfm" method="post" style="display:inline;">
        <h3 class="stit">��������<em>(<span class="star">*</span>������� �ΰ����� ���Ե� �ݾ��Դϴ�.)</em></h3>
        <table class="ftbl" style="width:980px">
				<colgroup>
					<col style="width:22%" />
					<col style="width:78%" />																		
				</colgroup>
				<tbody>
					<tr>
						<th>��ǰ��</th>
						<td><strong><%=strnm%></strong></td>
					</tr>
					<tr>
						<th>�����Ⱓ</th>
						<td>�����Ϸκ��� <span class="fr"><%=intgigan%></font>�ϰ� ������ �̿��� �����մϴ�.</td>
					</tr>
					<tr>
						<th>�Ѱ����ݾ�</th>
						<td><span class="frprice"><%=FormatNumber(moneyHap,0)%></span> ��</td>
					</tr>
				</tbody>
			</table> 
<form name="payfm" method="post" style="display:inline;">
<input type="hidden" name="moneyHap" value="<%=moneyHap%>">
<input type="hidden" name="bycode" value="<%=bycode%>">
<input type="hidden" name="paygbn" value="0">
<input type="hidden" name="payType">
<input type="hidden" name="cnumber" id="cnumber" value="" />
<input type="hidden" name="cprice" id="cprice" value="0" />    
</form>

        <div class="cbtn"> 
		<a href="javascript:go2Payin(2);" class="mbtn grey">�ſ�ī��/üũī�����</a><a href="javascript:go2Payin(1);" class="mbtn blue">�������Ա��ϱ�</a> <a href="javascript:go2Payin(4);" class="mbtn red">�ǽð�������ü�ϱ�</a> 
		
		<!--
		<a href="javascript:go2Payin(3);" class="mbtn green">�޴����Ҿװ����ϱ�</a> 
		!-->
		</div>

    </div>

<!-- #include file="../include/bottom.asp" -->
<% end if
else %>
<!-- #include file = "../include/false_pg.asp" --><% end if
Session.Abandon %>
