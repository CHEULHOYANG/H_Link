<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/dbcon.asp" -->
<% 
Dim sql,dr
Dim pop_nm,pop_neyong,pop_width,pop_height,pop_top,pop_left,pop_cookie,pop_gu

Dim idx : idx = Request("idx")

sql = "select pop_nm,pop_neyong,pop_width,pop_height,pop_top,pop_left,pop_cookie,pop_gu from PopinfoTab where pop_idx=" & idx
set dr = db.execute(sql)

If dr.eof Or dr.bof Then

	response.write"<script>"
	response.write"alert('�����Ϳ���!!');"
	response.write"history.back();"
	response.write"</script>"
	response.end

Else

	pop_nm = dr(0)
	pop_neyong = dr(1)
	pop_width = dr(2)
	pop_height = dr(3)
	pop_top = dr(4)
	pop_left = dr(5)
	pop_cookie = dr(6)
	pop_gu = dr(7)

dr.close
End if
%>

<!--#include file="../main/top.asp"-->

<script language="javascript">
function NumKeyOnly(){
	if((event.keyCode<48)||(event.keyCode>57)) event.returnValue=false;
}
function goPopup_Edite(theform){
	var clmn;
	var maxsize = 900;
	var minsize = 900;

	clmn = theform.pop_nm;
	if(clmn.value == ""){
		alert("�˾�â�� ���� Ÿ��Ʋ��  �Է��ϼ���!");
		clmn.focus();
		return;
	}
	if(clmn.value.replace(/ /g,"") == ""){
		alert("�˾�â�� ���� Ÿ��Ʋ�� �Է����ּ���!");
		clmn.select();
		return;
	}

	clmn = theform.size_width;
	if(clmn.value == ""){
		alert("�˾�â ����ũ�⸦ �Է��ϼ���!");
		clmn.focus();
		return;
	}

	if(parseInt(clmn.value,100) > maxsize){
		alert("â�� ����ũ��� �ִ� " + maxsize + " ���� �Է��� �� �ֽ��ϴ�.");
		clmn.select();
		return;
	}

	if(parseInt(clmn.value,100) < minsize){
		alert("â�� ����ũ��� �ּ� " + minsize + " �̻� �Է��ؾ� �մϴ�.");
		clmn.select();
		return;
	}

	clmn = theform.size_height;
	if(clmn.value == ""){
		alert("�˾�â ����ũ�⸦ �Է��ϼ���!");
		clmn.focus();
		return;
	}

	if(parseInt(clmn.value,100) > maxsize){
		alert("â�� ����ũ��� �ִ� " + maxsize + " ���� �Է��� �� �ֽ��ϴ�.");
		clmn.select();
		return;
	}

	if(parseInt(clmn.value,100) < minsize){
		alert("â�� ����ũ��� �ּ� " + minsize + " �̻� �Է��ؾ� �մϴ�.");
		clmn.select();
		return;
	}

	clmn = theform.popcont;
	clmn.value = nicEditors.findEditor('popcont').getContent();
	if(clmn.value==""  || clmn.value=="<br>") {
	alert("������ �Է����ּ���");
	return;
	}

theform.submit();
}
</script>

<script type="text/javascript" src="/nicedit/nicEdit.js"></script>
<script type="text/javascript">
bkLib.onDomLoaded(function() {
	new nicEditor({fullPanel : true}).panelInstance('popcont');
});
</script>

<div class="container">
	<!--#include file="left.asp"-->
	<div class="content">
		<h2 class="cTit"><span class="bullet"></span>�˾�â����</h2>

<form name="popform" method="post" action="popup_edit_ok.asp" style="display:inline;">
<input type="hidden" name="idx" value="<%=idx%>">
		<table class="ftbl mb50" style="width:100%">
				<colgroup>
				<col style="width:20%" />
				<col style="width:80%" />
				</colgroup>
				<tbody>
					<tr>
						<th>�˾�â����</th>
						<td><input type="radio" name="pop_gu" value="0" <%If pop_gu = 0 Then Response.write"checked" End if%>>&nbsp;��&nbsp;&nbsp;<input type="radio" name="pop_gu" value="1" <%If pop_gu = 1 Then Response.write"checked" End if%>>&nbsp;�����</td>
					</tr>
					<tr>
						<th>�˾�âŸ��Ʋ</th>
						<td><input type="text" class="inptxt1 w400" name="pop_nm" value="<%=pop_nm%>"></td>
					</tr>
					<tr>
						<th>�˾�âũ��</th>
						<td><input type="text" class="inptxt1 w60" size="5" maxlength="3" name="size_width" onKeyPress="NumKeyOnly();" value="<%=pop_width%>">
                           *
                            <input type="text" class="inptxt1 w60" size="5" maxlength="3" name="size_height" onKeyPress="NumKeyOnly();" value="<%=pop_height%>">
                            (���� X ����)</td>
					</tr>
					<tr>
						<th>�˾���ġ</th>
						<td><input type="text" class="inptxt1 w60" size="5" maxlength="3" name="size_top" onKeyPress="NumKeyOnly();" value="<%=pop_top%>">
                            /
                            <input type="text" class="inptxt1 w60" size="5" maxlength="3" name="size_left" onKeyPress="NumKeyOnly();" value="<%=pop_left%>">
                            (��� X ����)</td>
					</tr>
					<tr>
						<th>��������</th>
						<td><a href="javascript:popenWindow('/nicedit/upimg.asp?box=popcont','390','290');"><img src="../../nicedit/bt1.gif" border="0"></a><a href="javascript:popenWindow('/nicedit/vod.asp?box=popcont','390','290');"><img src="../../nicedit/bt2.gif" border="0"></a><a href="javascript:popenWindow('/nicedit/files.asp?box=popcont','390','290');"><img src="../../nicedit/bt3.gif" border="0"></a><textarea name="popcont" id="popcont" rows="2" cols="20" style="width:780px; height:390px;"><%=pop_neyong%></textarea></td>
					</tr>
					<tr>
						<th>�ɼ�</th>
						<td><input type="checkbox"<%if int(pop_cookie) > 0  then response.write " checked"%> name="pop_cookie"> [������ �� â�� �ٽ� ���� ����] ��� �����</td>
					</tr>
				</tbody>
			</table>
</form>

		<div class="rbtn">
			<a href="javascript:goPopup_Edite(document.popform);" class="btn">�����ϱ�</a>		
			<a href="popup_list.asp" class="btn  trans">��Ϻ���</a>
		</div>

	</div>
</div>

</body>
</html>
<%
db.Close
Set db = Nothing
%>
<!-- #include file = "../authpg_2.asp" -->