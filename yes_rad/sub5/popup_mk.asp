<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/dbcon.asp" -->
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
<form name="popform" method="post" action="popup_mk_ok.asp" style="display:inline;">
		<table class="ftbl mb50" style="width:100%">
				<colgroup>
				<col style="width:20%" />
				<col style="width:80%" />
				</colgroup>
				<tbody>
					<tr>
						<th>�˾�â����</th>
						<td><input type="radio" name="pop_gu" value="0" checked>&nbsp;��&nbsp;&nbsp;<input type="radio" name="pop_gu" value="1">&nbsp;�����</td>
					</tr>
					<tr>
						<th>�˾�âŸ��Ʋ</th>
						<td><input type="text" class="inptxt1 w400" name="pop_nm"></td>
					</tr>
					<tr>
						<th>�˾�âũ��</th>
						<td><input type="text" class="inptxt1 w60" size="5" maxlength="3" name="size_width" onKeyPress="NumKeyOnly();">
                           *
                            <input type="text" class="inptxt1 w60" size="5" maxlength="3" name="size_height" onKeyPress="NumKeyOnly();">
                            (���� X ����)</td>
					</tr>
					<tr>
						<th>�˾���ġ</th>
						<td><input type="text" class="inptxt1 w60" size="5" maxlength="3" name="size_top" onKeyPress="NumKeyOnly();">
                            /
                            <input type="text" class="inptxt1 w60" size="5" maxlength="3" name="size_left" onKeyPress="NumKeyOnly();">
                            (��� X ����)</td>
					</tr>
					<tr>
						<th>��������</th>
						<td><a href="javascript:popenWindow('/nicedit/upimg.asp?box=popcont','390','290');"><img src="../../nicedit/bt1.gif" border="0"></a><a href="javascript:popenWindow('/nicedit/vod.asp?box=popcont','390','290');"><img src="../../nicedit/bt2.gif" border="0"></a><a href="javascript:popenWindow('/nicedit/files.asp?box=popcont','390','290');"><img src="../../nicedit/bt3.gif" border="0"></a><textarea name="popcont" id="popcont" rows="2" cols="20" style="width:780px; height:390px;"></textarea></td>
					</tr>
					<tr>
						<th>�ɼ�</th>
						<td><input type="checkbox" name="pop_cookie"> [������ �� â�� �ٽ� ���� ����] ��� �����</td>
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
<!-- #include file = "../authpg_2.asp" -->