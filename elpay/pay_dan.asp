<!-- #include file="../include/set_loginfo.asp" -->
<!-- #include file="../include/dbcon.asp" -->
<% if isUsr Then

Dim u_name,u_tel1,u_tel2,u_email,moneyHap1,bycount,u_zipcode1,u_juso1,u_juso2,u_mileage

sql = "select name,tel1,tel2,email,zipcode1,juso1,juso2,mileage from member where id = '"& str_User_ID &"'"
Set rs=db.execute(sql)

If rs.eof Or rs.bof Then
Else

	u_name = rs(0)
	u_tel1 = split(rs(1),"-")	
	u_tel2 = split(rs(2),"-")
	u_email = rs(3)
	u_zipcode1 = rs(4)
	u_juso1 = rs(5)
	u_juso2 = rs(6)
	u_mileage = rs(7)

rs.close
End if

Dim book_idx,bcount,b_price,i,rs,aaa,sql1,bycode1

Dim strAry : strAry = Session("buySection")
Dim strAry1 : strAry1 = Session("buySection1")

''response.write ""& strAry &"<br />"
''response.write ""& strAry1 &"<br />"

if strAry = "" then %>
<!-- #include file = "../include/false_pg.asp" --><% else
Dim aryBy : aryBy = Split(strAry,"|")
Dim aryBy1 : aryBy1 = Split(strAry1,"|")

Dim rcd,moneyHap,numHap,bycode
dim query,linguid
moneyHap = 0
moneyHap1 = 0
numHap = 0 
%>

<!-- #include file="../include/head1.asp" -->
<!-- #include file="../include/top.asp" -->
<!-- #include file="../include/daum_zip.asp" -->

<script>
function go2Payin(pgType){
	fm = document.payfm;
	if(fm.paygbn.value==""){
		alert("����&���缱���� ���ּ���");
		return;
	}
	if ((fm.bycode.value=="") && (fm.bycode1.value=="")){
		alert("�������������ϴ�!");
		return;
	}

	fm.payType.value=pgType

<%If Len(strAry1) > 3 Then%>
	if(fm.name.value==""){
		alert("�����ôº� �̸��� �Է����ּ���");
		fm.name.focus();
		return;
	}
	if(fm.tel1_1.value==""){
		alert("�����ôº� ����ó�� �Է����ּ���");
		fm.tel1_1.focus();
		return;
	}
	if(fm.tel1_2.value==""){
		alert("�����ôº� ����ó�� �Է����ּ���");
		fm.tel1_2.focus();
		return;
	}
	if(fm.tel1_3.value==""){
		alert("�����ôº� ����ó�� �Է����ּ���");
		fm.tel1_3.focus();
		return;
	}
	if(fm.zipcode1.value==""){
		alert("�ּҸ� �Է����ּ���");
		fm.zipcode1.focus();
		return;
	}
	if(fm.juso1.value==""){
		alert("�ּҸ� �Է����ּ���");
		fm.juso1.focus();
		return;
	}
	if(fm.juso1.value==""){
		alert("�ּҸ� �Է����ּ���");
		fm.juso2.focus();
		return;
	}
	if(fm.email.value==""){
		alert("�̸����ּҸ� �Է����ּ���");
		fm.email.focus();
		return;
	}
<%end if%>

	if ( (parseInt(fm.moneyHap.value) == 0) && (parseInt(fm.cprice.value) > 0)){
		var bool = confirm("�������� �����Ͻðڽ��ϱ�?");
		if (bool){
			fm.action = "coupon_ok.asp";
			fm.submit();
		}

	}else{



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
}

function viewList(){
	var args = viewList.arguments;
	var listidx = args[0];

	var w,h
	w = 790;
	h = 500;
	var l = Math.round(screen.availWidth/2)-Math.round(w/2);
	var t = Math.round(screen.availHeight/2)-Math.round(h/2);
	var sFeatures = "width=" + w + ",height=" + h + ",top=" + t + ",left=" + l + ",resizable=no,scrollbars=1";
	var opurl = "openlist.asp?listidx=" + listidx;
	var op = window.open(opurl, "listWin", sFeatures);
	op.focus();
}

function coupon_check(){

	var f = window.document.payfm;

	f.moneyHap.value = f.moneyHap1.value;

	if(f.paygbn.value==""){
		alert("����&���缱���� ���ּ���");
		return;
	}

	if (parseInt(f.moneyHap.value) <= 0){
			f.moneyHap.value = 0;
			alert("�����ϽǱݾ��� �����ñ⶧���� ���̻� ������ ����Ͻ� �ʿ䰡 �����ϴ�.\n\n�������Ա� ���������� Ŭ���Ͻø� �ڵ����� ���������� �Ϸ�˴ϴ�.");
			return;
	}

	if(f.cnum.value==""){
	alert("������ȣ�� ��Ȯ�� �Է����ּ���!!");
	f.cnum.focus();
	return;
	}

	if (f.cnumber.value.indexOf(""+f.cnum.value+"") != -1){
		alert("�̹� ������ ������ ������ȣ�Դϴ�.");
		f.cnum.focus();
		return;
	}

	var a1 = f.cnum.value;
		$.ajax({
			url: "../xml/coupon_price_check.asp",
			type:"POST",
			data:{"key":a1},
			dataType:"text",
			cache:false,
			processData:true,
			success:function(_data){								
				var a = _data;	

				if(a == "0"){
					alert("��ϵ� ���������� �����ϴ�.");
					f.cnum.value = '';
				}
				else
				{
					alert("���������� ����Ǿ����ϴ�.");				
					f.cnumber.value = ""+ f.cnumber.value +","+a1+"";
					f.cprice.value = parseInt(f.cprice.value) + parseInt(a);

					if (parseInt(f.moneyHap.value) < 0){
						f.moneyHap.value = 0;
					}else{
						f.moneyHap.value = parseInt(f.moneyHap1.value) - parseInt(f.cash.value) - parseInt(a);
					}

					//�ݾ��� -�� �Ǿ����� üũ�� 0���� ����
					if (parseInt(f.moneyHap.value) < 0){
						f.moneyHap.value = 0;
					}

					$('#pay_total').html(Encode_Number(f.moneyHap.value));

					f.cnum.value = '';

					if ((f.moneyHap.value==0) && (f.cprice.value > 0)){
						alert("�������Ա� ���������� Ŭ���Ͻø� �ڵ����� ���������� �Ϸ�˴ϴ�.");
						$('#pay_total').html("0");
					}

				}		

			},
			error:function(xhr,textStatus){
			alert("[����]����:"+xhr.status+"                                     ");
			}	
		});		
}



function Encode_Number(number)
  {
   if(isNaN(number) || parseInt(number,10)<0) return false;
   
   var int;
   var float="";
   var tmp;
   var ans="";
   
   if(number.indexOf(".")==-1) int=number;
   else {
    int=number.substring(0,number.indexOf("."));
 float=number.substring(number.indexOf("."),number.length);
   }

   var num=int.split("");
   
   tmp=num.reverse();

   for(a=0;a<tmp.length;a++) {
    if(!(a%3) && a!=0) {
  ans+=",";  
 }
    ans+=tmp[a];
   }

   tmp=ans.split("").reverse();
   ans="";

   for(a=0;a<tmp.length;a++) ans+=tmp[a];

   for(a=0;a<2;a++)
    if(ans.charAt(0)=="0" || ans.charAt(0)==",") ans=ans.substring(1,ans.length);

   return ans+float;
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
function cash_check(){

	var f = window.document.payfm;

	f.moneyHap.value = f.moneyHap1.value;

	if(f.paygbn.value==""){
		alert("����&���缱���� ���ּ���");
		return;
	}

	if (parseInt(f.moneyHap.value) <= 0){
			f.moneyHap.value = 0;
			alert("�����ϽǱݾ��� �����ñ⶧���� ���̻� �������� ����Ͻ� �ʿ䰡 �����ϴ�.\n\n�������Ա� ���������� Ŭ���Ͻø� �ڵ����� ���������� �Ϸ�˴ϴ�.");
			return;
	}

	if(f.cash.value==""){
	alert("�������� ��Ȯ�� �Է����ּ���!!");
	f.cash.focus();
	return;
	}

	if(parseInt(f.cash.value) > parseInt(<%=u_mileage%>)){
	alert("�����Ͻ� �����ݺ��� ���� �ݾ��� �Է��ϼ̽��ϴ�.");
	f.cash.value = <%=u_mileage%>;
	f.cash.focus();
	return;
	}

	if(parseInt(f.cash.value) > parseInt(f.moneyHap.value)){
	alert("�����ݾ׸�ŭ�� �������� �Է����ּ���.");
	f.cash.value = f.moneyHap.value;
	f.cash.focus();
	return;
	}

	var a1 = f.cash.value;

		$.ajax({
			url: "../xml/cash_price_check.asp",
			type:"POST",
			data:{"price":a1,"uid":"<%=str_User_ID%>"},
			dataType:"text",
			cache:false,
			processData:true,
			success:function(_data){								
				var a = _data;	

				if(a == "0"){
					alert("�����ݿ���!!");
					f.cash.value = 0;
				}
				else
				{
					alert("������ ���� ����Ǿ����ϴ�.");				

					if (parseInt(f.moneyHap.value) < 0){
						f.moneyHap.value = 0;
					}else{
						f.moneyHap.value = parseInt(f.moneyHap1.value) - parseInt(f.cprice.value) - parseInt(a);
					}

					//�ݾ��� -�� �Ǿ����� üũ�� 0���� ����
					if (parseInt(f.moneyHap.value) < 0){
						f.moneyHap.value = 0;
					}

					$('#pay_total').html(Encode_Number(f.moneyHap.value));

					if (f.moneyHap.value==0 ){
						alert("�������Ա� ���������� Ŭ���Ͻø� ������ �Ϸ�˴ϴ�.");
						$('#pay_total').html("0");
					}

				}		

			},
			error:function(xhr,textStatus){
			alert("[����]����:"+xhr.status+"                                     ");
			}	
		});		
}
</script>

<div class="scontent">
    	<div class="logtit">
                <h4>�ܰ�/���� �����ϱ�</h4>
		</div>
        <h3 class="stit">������ǰ<em>(<span class="star">*</span>�����Ͻ÷��� ������ ������ �� Ȯ�����ּ���.)</em></h3>
		<table class="btbl" style="width:980px">
					<colgroup>
						<col style="width:10%" />
						<col style="width:65%" />
						<col style="width:10%" />
						<col style="width:15%" />
					</colgroup>
					<thead>
						<tr>
							<th>����</th>								
							<th>����/����</th>
							<th>����</th>
							<th>�ݾ�</th>
						</tr>				
					</thead>
					<tbody>
<% 
If Len(strAry) > 2 Then

			  sql = "select intgigan,strnm,strteach,totalnum,idx,intprice,book_idx from LecturTab"
              for ii = 0 to Ubound(aryBy)
              rcd = split(aryBy(ii),",")
              query = sql & " where idx=" & rcd(0)
              set dr = db.execute(query)
              if int(rcd(1)) > 0 Then
	
if InStr(strAry,""& dr(4) &",1") then
              	moneyHap = moneyHap + int(dr(5))
End if

              	numHap = numHap + 1
              	bycode = bycode & rcd(0) & "|" 
				
				b_price = 0

				''book_idx = split(dr(6),",")
				''bcount = ubound(book_idx)

				''For i = 1 To bcount
				
				''	sql1 = "select price1 from book_mast where state = 0 and idx = "& book_idx(i)
				''	Set rs=db.execute(sql1)

				''	If rs.eof Or rs.bof Then
				''	Else
				''		if InStr(strAry1,""& dr(4) &",1") then
				''							b_price = b_price + rs(0)						
				''		End if
				''	End If
				
				''Next

moneyHap = moneyHap + b_price


				%>
						<tr>
							<td>����</td>
							<td class="tl"><%=dr(1)%></td>							
							<td>1</td>
							<td><strong class="fr"><%=formatnumber(dr(5),0)%></strong>��</td>
						</tr>
<% else
              linguid = True %>

<% end if
              Next
              if not bycode = "" then
              	bycode = bycode & "|"
              	bycode = replace(bycode,"||","")
              end if

End if


 

''������ʹ� ����
If Len(strAry1) > 2 Then

			  sql = "select price1,title from book_mast"
              for ii = 0 to Ubound(aryBy1)
              rcd = split(aryBy1(ii),",")
if len(rcd(0)) = 0 Then rcd(0) = 0
              query = sql & " where idx=" & rcd(0)
              set dr = db.execute(query)

If dr.eof Or dr.bof Then
else


              	numHap = numHap + 1
              	bycode1 = bycode1 & rcd(0) & "|" 
				
				b_price = 0
				
				If Len(request("gcount"& rcd(0) &"")) = 0 Then
				b_price = b_price + dr(0)
				else
				b_price = b_price + (dr(0) * request("gcount"& rcd(0) &""))
				End if

		moneyHap = moneyHap + b_price
		moneyHap1 = moneyHap1 + b_price


				%>
						<tr>
							<td>����</td>
							<td class="tl"><%=dr(1)%></td>							
							<td><%If Len(request("gcount"& rcd(0) &"")) = 0 Then response.write "1" Else response.write request("gcount"& rcd(0) &"") End if%></td>
							<td><strong class="fr"><%=formatnumber(b_price,0)%></strong>��</td>
						</tr>
<%
End If

bycount = bycount & "|" & request("gcount"& rcd(0) &"")

				next


              if not bycode1 = "" then
              	bycode1 = bycode1 & "|"
              	bycode1 = replace(bycode1,"||","")
              end if

End if
%>		
					</tbody>
				</table>

<form name="payfm" method="post" style="display:inline;">
        <h3 class="stit">��������<em>(<span class="star">*</span>ǥ�õ� �׸��� �� �Է��� �ּž� ������ �����մϴ�.)</em></h3>
        <table class="ftbl" style="width:980px">
				<colgroup>
					<col style="width:22%" />
					<col style="width:78%" />																		
				</colgroup>
				<tbody>
<%If Len(strAry1) > 2 Then

''��ۺ�üũ ���籸���հ谡 ������
If Int(moneyHap1) >= Int(banktownid) Then
	pay_select = 0
End If

moneyHap = moneyHap + pay_select
%>
					<tr>
						<th>��ۺ�</th>
						<td><span class="fr">+ <%=FormatNumber(pay_select,0)%></span> �� (<%=FormatNumber(banktownid,0)%>�� �̸� ���縦 �����ϴ� ���� ��ۺ� <%=FormatNumber(pay_select,0)%>���� �߰��� �ΰ��˴ϴ�.)</td>
					</tr>
					<tr>
						<th>�Ѱ����ݾ�</th>
						<td><span class="frprice" id="pay_total"><%=FormatNumber(moneyHap,0)%></span> ��</td>
					</tr>
<%Else
	pay_select = 0
%>
					<tr>
						<th>�Ѱ����ݾ�</th>
						<td><span class="frprice" id="pay_total"><%=FormatNumber(moneyHap,0)%></span></td>
					</tr>
<%End if%>
<input type="hidden" name="moneyHap" id="moneyHap" value="<%=moneyHap%>">
<input type="hidden" name="moneyHap1" id="moneyHap1" value="<%=moneyHap%>">

					<tr>
						<th>�������� �����Է�</th>
						<td><input type="text" id="cnum" name="cnum" class="inptxt1" />
							<a href="javascript:coupon_check();" class="fbtn">�Է�Ȯ��</a></td>
					</tr>

					<tr>
						<th>������</th>
						<td><input type="text" id="cash" name="cash" class="inptxt1" value="0" onkeyup="onlynum(payfm.cash);" />
							<a href="javascript:cash_check();" class="fbtn">�Է�Ȯ��</a> <span class="fr">(���������� : <%=FormatNumber(u_mileage,0)%>��)</span></td>
					</tr>

<%If Len(strAry1) > 1 then%>
					<tr>
						<th>�����ôº�<span class="star">*</span></th>
						<td><input type="text" name="name" id="name" class="inptxt1" value="<%=u_name%>" /></td>
					</tr>
					<tr>
						<th>����ó<span class="star">*</span></th>
						<td><input type="text" name="tel1_1" id="tel1_1" class="inptxt1 w50" value="<%=u_tel2(0)%>" /> - <input type="text" name="tel1_2" id="tel1_2" class="inptxt1 w50" value="<%=u_tel2(1)%>" /> - <input type="text" name="tel1_3" id="tel1_3" class="inptxt1 w50" value="<%=u_tel2(2)%>" /></td>
					</tr>
					<tr>
						<th rowspan="3">�ּ�<span class="star">*</span></th>
						<td><input type="text" name="zipcode1" id="post1" class="inptxt1 w50" value="<%=u_zipcode1%>" />
							<a href="javascript:openDaumPostcode();" class="fbtn">�����ȣ</a></td>
					</tr>
					<tr>
						<td><input type="text" name="juso1" id="addr" class="inptxt1 w600" value="<%=u_juso1%>" /></td>
					</tr>
					<tr>
						<td><input type="text" name="juso2" id="addr2" class="inptxt1 w600" value="<%=u_juso2%>" /></td>
					</tr>
					<tr>
						<th>�̸���<span class="star">*</span></th>
						<td><input type="text" id="email" name="email" class="inptxt1 w600" value="<%=u_email%>" /></td>
					</tr>
					<tr>
						<th>��û����</th>
						<td><input type="text" name="memo" id="memo" class="inptxt1 w600"/></td>
					</tr>
<%End if%>
				</tbody>
			</table> 
<input type="hidden" name="b_price" value="<%=b_price%>">
<input type="hidden" name="send_price" value="<%=pay_select%>">
<input type="hidden" name="bycode" value="<%=bycode%>">
<input type="hidden" name="bycode1" value="<%=bycode1%>">
<input type="hidden" name="bycount" value="<%=bycount%>">
<input type="hidden" name="paygbn" value="2">
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

<%If Int(moneyHap) = 0 then%>
<script>
function free_go(){
	var fm = window.document.payfm;
	fm.action = "pay_free_ok.asp";
	fm.submit();
}
free_go();
</script>
<%End if%>

<!-- #include file="../include/bottom.asp" --><% end if
else %>
<!-- #include file = "../include/false_pg.asp" --><% end if
Session.Abandon%>