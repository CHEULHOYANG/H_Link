<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/dbcon.asp" -->
<%
Dim idx,btname,jemok,neyong,gbn
Dim sql,dr

idx = Request("idx")

if idx = "" then
	btname = "�ۼ�"
else 
	sql = "select jemok,neyong,gbn from guideTab where idx=" & idx
	Set Dr = db.execute(sql)

	If dr.eof Or dr.bof Then

		response.write"<script>"
		response.write"alert('�����Ϳ���!!');"
		response.write"history.back();"
		response.write"</script>"
		response.end

	Else

		jemok = Dr(0)
		neyong = Dr(1)
		gbn = Dr(2)
		
		btname = "����"

	Dr.Close
	End If
	
end If

Dim t_menu1

sql = "select t_menu1 from site_info"
Set dr=db.execute(sql)

If dr.eof Or dr.bof Then
	t_menu1 = "�п��Ұ�"
Else
	t_menu1 = dr(0)
dr.close
End if
%>
<!--#include file="../main/top.asp"-->

<script type="text/javascript" src="/nicedit/nicEdit.js"></script>
<script type="text/javascript">
bkLib.onDomLoaded(function() {
	new nicEditor({fullPanel : true}).panelInstance('neyong');
});
</script>

<script language="javascript">
function go2WriteOk(theform){
	clmn = theform.jemok;
	if(clmn.value==""){
		alert("������ �Է��ϼ���!");
		clmn.focus();
		return;
	}
	if(clmn.value.replace(/ /g,"") == ""){
		alert("������ �Է��ϼ���!");
		clmn.select();
		return;
	}
	clmn = theform.neyong;
	clmn.value = nicEditors.findEditor('neyong').getContent();
	if(clmn.value==""  || clmn.value=="<br>") {
	alert("������ �Է����ּ���");
	return;
	}
	
theform.submit();
}
</script>

<div class="container">
	<!--#include file="left.asp"-->
	<div class="content">
		<h2 class="cTit"><span class="bullet"></span>�ȳ�������(<%=btname%>)</h2>

<form name="faqfm" action="guidewrite_ok.asp" method="post" style="display:inline;">
<input type="hidden" name="idx" value="<%=idx%>">
		<table class="ftbl mb50" style="width:100%">
				<colgroup>
				<col style="width:20%" />
				<col style="width:80%" />
				</colgroup>
				<tbody>
					<tr>
						<th>����</th>
						<td><select name="gbn" id="gbn"  class="seltxt">
											<option value="0" <%If gbn=0 Then response.write"selected" End if%>>����Ʈ�ϴ�</option>
  <option value="1" <%If gbn=1 Then response.write"selected" End if%>>������</option>
  <option value="2" <%If gbn=2 Then response.write"selected" End if%>><%=t_menu1%></option>
</select></td>
					</tr>
					<tr>
						<th>�⺻���Է�</th>
						<td><input type="radio" name="aaa" onclick="document.faqfm.jemok.value='';" checked> ����<br />
											<input type="radio" name="aaa" onclick="document.faqfm.jemok.value='��������ó����ħ';"> ��������ó����ħ<br />
											<input type="radio" name="aaa" onclick="document.faqfm.jemok.value='����Ʈ�̿���';"> ����Ʈ�̿���<br />
											<input type="radio" name="aaa" onclick="document.faqfm.jemok.value='���������������̿�ȳ��� ���� ����';"> ���������������̿�ȳ��� ���� ����</td>
					</tr>
					<tr>
						<th>����</th>
						<td><input type="text" name="jemok" class="inptxt1 w500" value="<%=jemok%>"></td>
					</tr>
					<tr>
						<th>����</th>
						<td><a href="javascript:popenWindow('/nicedit/upimg.asp?box=neyong','390','290');"><img src="/nicedit/bt1.gif" border="0"></a><a href="javascript:popenWindow('/nicedit/vod.asp?box=neyong','390','290');"><img src="/nicedit/bt2.gif" border="0"></a><a href="javascript:popenWindow('/nicedit/files.asp?box=neyong','390','290');"><img src="/nicedit/bt3.gif" border="0"></a><textarea name="neyong" id="neyong" rows="2" cols="20" style="width:600px; height:200px;"><%=neyong%></textarea></td>
					</tr>

				</tbody>
			</table>
</form>
		<div class="rbtn">
			<a href="javascript:go2WriteOk(document.faqfm);" class="btn">�����ϱ�</a>
			<a href="guide.asp" class="btn trans">���ư���</a>		
		</div>

	</div>
</div>

</body>
</html>
<!-- #include file = "../authpg_2.asp" -->