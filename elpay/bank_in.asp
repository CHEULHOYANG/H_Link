<!-- #include file = "../include/set_loginfo.asp" --><% if isUsr then %>
<!-- #include file = "../include/dbcon.asp" --><%

Function Tag2Txt(s)
	s = Replace(s,"'","''")
	s = Replace(s,"<","&lt;")
	s = Replace(s,">","&gt;")
	s = Replace(s,"&","&amp;")
	Tag2Txt = s
End Function

Dim moneyHap	''�����ݾ�
Dim bycode			''�����Ϸù�ȣ
Dim bycode1			''�����Ϸù�ȣ
Dim paygbn			''�ܰ�,���� ����	0:�����̾�,1:����,2:�ܰ�
Dim idxAry,idxAry1

moneyHap = Request.Form("moneyHap")
bycode = Request.Form("bycode")
bycode1 = Request.Form("bycode1")
paygbn = Request.Form("paygbn")

Dim payTitle

if int(paygbn) < 1 then
	sql = "select strnm,intprice from PremTab where idx=" & bycode
	set dr = db.execute(sql)
	payTitle = Tag2Txt(dr(0))
	moneyHap = dr(1)
	dr.close
elseif int(paygbn) > 1 Then

	If Len(bycode) > 0 Then
	
		idxAry = split(bycode,"|")
		sql = "select strnm from LecturTab where idx=" & idxAry(0)
		set dr = db.execute(sql)
		payTitle = dr(0)
		payTitle = Tag2Txt(payTitle)
		dr.close

		if UBound(idxAry) > 0 then
			payTitle = payTitle & " �� " & Ubound(idxAry) & "����"
		end If
		
	End If

	If Len(bycode) = 0 And Len(bycode1) > 0 Then
	
		idxAry1 = split(bycode1,"|")
		sql = "select title from book_mast where idx=" & idxAry1(0)
		set dr = db.execute(sql)
		payTitle = dr(0)
		payTitle = Tag2Txt(payTitle)
		dr.close

		if UBound(idxAry1) > 0 then
			payTitle = payTitle & " �� " & Ubound(idxAry1) & "��"
		end If
		
	End if	

else
	sql = "select strnm,intgigan from Lectmast where idx=" & bycode
	set dr = db.execute(sql)
	payTitle = dr(0) & "(" & dr(1) & "�ϰ���)"
	dr.close
end if  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>�������Ա�</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link rel="stylesheet" type="text/css" href="/img/default.css" />

<script language="javascript">
function resvBank(thefm){
	var clmn;
<%If moneyHap > 0 then%>
	clmn = thefm.usrnm;
	if(clmn.value==""){
		alert("�Ա��Ͻ� ���� �̸��� �Է����ּ���!");
		clmn.focus();
		return;
	}

	if(clmn.value.replace(/ /g,"") == ""){
		alert("�Ա��Ͻ� ���� �̸��� �Է����ּ���!");
		clmn.select();
		return;
	}

	clmn = thefm.bankinfo;
	if(clmn.value==""){
		alert("��ϵ� �Աݰ��°� ��� �������Ա��� ����Ͻ� �� �����ϴ�.\n\nī��,�ǽð���ü,�ڵ��������� �̿����ּ���!");
		self.close();
		return;
	}
<%end if%>
thefm.submit()
}
</script>

<body style="margin:10px 0 0 10px">

<h3 class="stit">������ �Աݽ�û</h3>
<form name="payfm" method="post" action="pay_bank.asp" style="display:inline;">
<input type="hidden" name="cnumber" value="<%=request.Form("cnumber")%>">
<input type="hidden" name="cprice" value="<%=request.Form("cprice")%>">
<input type="hidden" name="cash" value="<%=request.Form("cash")%>">
<input type="hidden" name="moneyHap" value="<%=moneyHap%>">
<input type="hidden" name="bycode" value="<%=bycode%>">
<input type="hidden" name="buygbn" value="<%=paygbn%>">
<input type="hidden" name="paytype" value="1">
<input type="hidden" name="payTitle" value="<%=payTitle%>">
<input type="hidden" name="bycount" value="<%=request.Form("bycount")%>">

<input type="hidden" name="send_price" value="<%=request.Form("send_price")%>">
<input type="hidden" name="bycode1" value="<%=request.Form("bycode1")%>">
<input type="hidden" name="name" value="<%=request.Form("name")%>">
<input type="hidden" name="tel1" value="<%=request.Form("tel1_1")%>-<%=request.Form("tel1_2")%>-<%=request.Form("tel1_3")%>">
<input type="hidden" name="tel2" value="<%=request.Form("tel2_1")%>-<%=request.Form("tel2_2")%>-<%=request.Form("tel2_3")%>">
<input type="hidden" name="email" value="<%=request.Form("email")%>">
<input type="hidden" name="zipcode1" value="<%=request.Form("zipcode1")%>">
<input type="hidden" name="zipcode2" value="<%=request.Form("zipcode2")%>">
<input type="hidden" name="juso1" value="<%=request.Form("juso1")%>">
<input type="hidden" name="juso2" value="<%=request.Form("juso2")%>">
<input type="hidden" name="memo" value="<%=request.Form("memo")%>">
<input type="hidden" name="b_price" value="<%=request.Form("b_price")%>">
            <table class="ftbl" style="width:500px">
                <colgroup>
                <col style="width:22%" />
                <col style="width:78%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th>�����ݾ�</th>
                        <td><span class="frprice"><%=Formatnumber(moneyHap,0)%></span> ��(�ΰ�������)</td>
                    </tr>
<%If moneyHap > 0 then%>
                    <tr>
                        <th>�Ա��ڸ�</th>
                        <td><input type="text" name="usrnm" value="<%=str_User_Nm%>" class="inptxt1 w80" /></td>
                    </tr>
                    <tr>
                        <th>�Ա���������</th>
                        <td><select name="bankinfo" class="seltxt1 w300">
                  <% sql = "select bankname,banknumber,use_name from bank"
								set dr = db.execute(sql)
								if Not dr.bof or Not dr.eof then
								do until dr.eof %>
                  <option value="<%=dr(0)%> , <%=dr(1)%> , <%=dr(2)%>"><%=dr(0)%> / <%=dr(1)%> / <%=dr(2)%></option>
                  <% dr.MoveNext
								Loop
								else %>
                  <option value="">��ϵ� �������� ����</option>
                  <% end if
								dr.close %>
                </select></td>
                    </tr>
<%else%>
                    <tr>
                        <th>�������</th>
                        <td><strong>���������ݰ���</strong></td>
                    </tr>
<%End if%>
                </tbody>
            </table>
</form>
<%If moneyHap > 0 then%>
            <div class="cbtn"> <a href="javascript:resvBank(payfm);" class="mbtn grey">�Ա��ϱ�</a> <a href="javascript:self.close();" class="mbtn">����ϱ�</a> </div>
<%else%>
            <div class="cbtn"> <a href="javascript:resvBank(payfm);" class="mbtn grey">�����ݰ���</a> <a href="javascript:self.close();" class="mbtn">����ϱ�</a> </div>
<%End if%>

</body>
</html><% else %>
<!-- #include file = "../include/false_pg.asp" --><% end if %>