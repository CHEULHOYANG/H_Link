<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/dbcon.asp" -->
<%
dim count1,count2,bdate
dim sql,rs
sql="select count(idx) from member where email_res=1"
set rs=db.execute(sql)

count1=rs(0)
rs.close

bdate = left(now(),10)
bdate = split(bdate,"-")

sql="select count(idx) from member where b_year='"& bdate(0) &"' and b_month='"& bdate(1) &"' and b_day='"& bdate(2) &"' "
set rs=db.execute(sql)

count2=rs(0)
rs.close
%>
<!--#include file="../main/top.asp"-->

<script language="javascript">
function admin_mail_send(){
	var f = window.document.mail;
	if(f.FORM_title.value==""){
	alert("���ϸ� ������ �Է����ּ���.");
	f.FORM_title.focus();
	return;
	}

	clmn = f.FORM_Content;
	clmn.value = nicEditors.findEditor('FORM_Content').getContent();
	if(clmn.value==""  || clmn.value=="<br>") {
	alert("������ �Է����ּ���");
	return;
	}

	if(f.from_email.value==""){
	alert("������ ����� �����ּҸ� �Է����ּ���.");
	f.from_email.focus();
	return;
	}
	f.submit();
}
</script>

<script type="text/javascript" src="/nicedit/nicEdit.js"></script>
<script type="text/javascript">
bkLib.onDomLoaded(function() {
	new nicEditor({fullPanel : true}).panelInstance('FORM_Content');
});
</script>

<div class="container">
	<!--#include file="left.asp"-->
	<div class="content">
		<h2 class="cTit"><span class="bullet"></span>�̸��Ϲ߼۰���</h2>
		<form name="mail" method="post" action="mlist_ok.asp">
		<table class="ftbl mb50" style="width:100%">
				<colgroup>
				<col style="width:20%" />
				<col style="width:80%" />
				</colgroup>
				<tbody>
					<tr>
						<th>����ȸ��</th>
						<td><input type="radio" name="groub" value="1" checked> ���� ����ȸ�� (<%=count2%>��)<br />
						<input type="radio" name="groub" value="2"> ���ϸ� �����㰡ȸ�� (<%=count1%>��)<br />
						<input type="radio" name="groub" value="3"> �̸����Է� &nbsp;<input type="text" name="to_email" class="inptxt1 w300" size="40"></td>
					</tr>
					<tr>
						<th>����</th>
						<td><input name="FORM_title" type="text" class="inptxt1 w400" id="FORM_title" size="80"></td>
					</tr>
					<tr>
						<th>����</th>
						<td><a href="javascript:popenWindow('/nicedit/upimg.asp?box=FORM_Content','390','290');"><img src="../../nicedit/bt1.gif" border="0"></a><a href="javascript:popenWindow('/nicedit/vod.asp?box=FORM_Content','390','290');"><img src="../../nicedit/bt2.gif" border="0"></a><a href="javascript:popenWindow('/nicedit/files.asp?box=FORM_Content','390','290');"><img src="../../nicedit/bt3.gif" border="0"></a>
                          <textarea name="FORM_Content" id="FORM_Content" rows="2" cols="20" style="width:580px; height:200px;"></textarea></td>
					</tr>
					<tr>
						<th>�߼��̸����ּ�</th>
						<td><input name="from_email" type="text" class="inptxt1" id="from_email" size="40"></td>
					</tr>
				</tbody>
			</table>
		</form>
		<div class="rbtn">
			<a href="javascript:admin_mail_send();" class="btn">�߼��ϱ�</a>
		</div>

	</div>
</div>

</body>
</html>
<!-- #include file = "../authpg_2.asp" -->