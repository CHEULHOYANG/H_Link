<!-- #include file = "../include/set_loginfo.asp" --><% if isUsr then %>
<!-- #include file = "../include/dbcon.asp" --><%
Dim ordIdx
ordIdx = Request("ordidx")

sql = "select usrnm,paytitle,bkinfo,nprice from bank_order where idx=" & ordIdx
set dr = db.execute(sql)
Dim usrnm,paytitle,bkinfoAry,nprice
usrnm = dr(0)
paytitle = dr(1)
bkinfoAry = split(dr(2),",")
nprice =  dr(3)
dr.close
set dr = nothing
db.close
set db = nothing %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>�������Ա�</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<link rel="stylesheet" type="text/css" href="/img/default.css" />

<body style="margin:10px 0 0 10px">

<h3 class="stit">������ �Աݽ�û</h3>
            <table class="ftbl" style="width:500px">
                <colgroup>
                <col style="width:22%" />
                <col style="width:78%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th>�����ݾ�</th>
                        <td><span class="frprice"><%=Formatnumber(nprice,0)%></span> ��(�ΰ�������)</td>
                    </tr>
                    <tr>
                        <th>�Ա��ڸ�</th>
                        <td><%=usrnm%></td>
                    </tr>
                    <tr>
                        <th>�Ա���������</th>
                        <td><%=bkinfoAry(0)%>&nbsp;<%=bkinfoAry(1)%>&nbsp;<%=bkinfoAry(2)%></td>
                    </tr>
                </tbody>
            </table>

			<div class="cbtn"> <a href="javascript:self.close();" class="mbtn">â�ݱ�</a> </div>

			<ul class="free">
				<li class="cont"><span><strong class="fr">�Ա��Ͻ��� </strong>������(<%=help_tel%>)�� �����ֽñ� �ٶ��ϴ�.</span></li>
				<li class="cont"><span>�Ա� Ȯ�� �� 1�ð� �̳��� ó���˴ϴ�.</span></li>
			</ul>

</body>
</html>
<script>
opener.self.location.href='/my/02_paylist.asp';
</script>
<% else %>
<!-- #include file = "../include/false_pg.asp" --><% end if %>