<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/dbcon.asp" -->
<%
Dim sql,dr,isRecod,isRows,isCols
sql = "select idx,strnm,intgigan,intprice from premTab order by idx"
set dr = db.execute(sql)
if Not dr.Bof or Not dr.Eof then
	isRecod = True
	isRows = split(dr.getString(2),chr(13))
end if
dr.close
%>
<!--#include file="../main/top.asp"-->

<script language="javascript">
function setPriminput(){
	var clmn
	clmn = document.fminput.strnm;
	if(clmn.value == ""){
		alert("�����н����� �Է��ϼ���!");
		clmn.focus();
		return;
	}
	if(clmn.value.replace(/ /g,"") == ""){
		alert("�����н����� �Է��ϼ���!");
		clmn.select();
		return;
	}

	clmn = document.fminput.intgigan;
	if(clmn.value == ""){
		alert("�����н��� �Ⱓ�� �Է��ϼ���!");
		clmn.focus();
		return;
	}

	clmn = document.fminput.intprice;
	if(clmn.value == ""){
		alert("�����н��� ������ �Է��ϼ���!");
		clmn.focus();
		return;
	}

	document.fminput.submit();
}

function setPrim_del(idx){
		var bool = confirm("�����Ͻðڽ��ϱ�?");
		if (bool){
			location.href = "prium_del.asp?idx="+idx;
		}
}

function setPrim(i,idxn){
	var clmn
	clmn = eval("document.all.strnm" + i);
	if(clmn.value == ""){
		alert("�����н����� �Է��ϼ���!");
		clmn.focus();
		return;
	}
	if(clmn.value.replace(/ /g,"") == ""){
		alert("�����н����� �Է��ϼ���!");
		clmn.select();
		return;
	}

	clmn = eval("document.all.intgigan" + i);
	if(clmn.value == ""){
		alert("�����н��� �Ⱓ�� �Է��ϼ���!");
		clmn.focus();
		return;
	}

	clmn = eval("document.all.intprice" + i);
	if(clmn.value == ""){
		alert("�����н��� ������ �Է��ϼ���!");
		clmn.focus();
		return;
	}

	document.fm.idx.value=idxn;
	document.fm.requn.value=i;
	document.fm.submit();
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
</script>

<div class="container">
	<!--#include file="left.asp"-->
	<div class="content">
		<h2 class="cTit"><span class="bullet"></span>�����н����ݰ���</h2>

<form name="fminput" method="post" action="prium_input.asp" style="display:inline;">
<input type="hidden" name="idx">
<input type="hidden" name="requn">
			<table class="ftbl mb50" style="width:100%">
				<colgroup>
				<col style="width:20%" />
				<col style="width:80%" />
				</colgroup>
				<tbody>
					<tr>
						<th>�����н� ��ǰ���</th>
						<td><input type="text" class="inptxt1 w200" style="text-align:center;" name="strnm" placeholder="��ǰ��" >
						<input type="text" class="inptxt1 w100" style="text-align:center;" name="intgigan" maxlength="3" onKeyUp="onlynum(fminput.intgigan);" placeholder="�Ⱓ">
						<input type="text" class="inptxt1 w100" style="text-align:center;" name="intprice" onKeyUp="onlynum(fminput.intprice);" placeholder="����">
						<a href="javascript:setPriminput();" class="fbtn">����ϱ�</a></td>
					</tr>
				</tbody>
			</table>
</form>

<% if isRecod then %>
<form name="fm" method="post" action="prium_ok.asp" style="display:inline;">
<input type="hidden" name="idx"><input type="hidden" name="requn">
		<table class="tbl" style="width:100%">
			<colgroup>
			<col />
			<col style="width:20%" />
			<col style="width:20%" />
			<col style="width:15%" />
			</colgroup>
			<thead>
				<tr>
					<th>�����н���</th>	
					<th>�� ��</th>
					<th>����</th>
					<th>���</th>	
				</tr>				
			</thead>
			<tbody>
			<% for ii = 0 to UBound(isRows) - 1
						isCols = split(isRows(ii),chr(9))%>
						<tr>
							<td><input type="text" class="inptxt1 w300" style="text-align:center;" name="strnm<%=ii%>" value="<%=isCols(1)%>"></td>
							<td><input type="text" class="inptxt1 w100" style="text-align:center;" name="intgigan<%=ii%>" value="<%=isCols(2)%>" maxlength="3" onKeyUp="onlynum(fm.intgigan<%=ii%>);"></td>
							<td><input type="text" class="inptxt1 w100" style="text-align:center;" name="intprice<%=ii%>" value="<%=isCols(3)%>" onKeyUp="onlynum(fm.intprice<%=ii%>);"></td>
							<td><a href="javascript:setPrim('<%=ii%>','<%=isCols(0)%>');" class="btns trans">����</a> <a href="javascript:setPrim_del('<%=isCols(0)%>');" class="btns trans">����</a></td>
						</tr><% Next %>
			</tbody>
		</table>
</form>
<%End if%>

<div class="caution"><p>��� ���Ǹ� �Ⱓ���� ���Ѿ��� �̿��Ҽ� �ִ� �����н���ǰ�� ����� �ֽ��ϴ�</p></div>

	</div>
</div>

</body>
</html>
<!-- #include file = "../authpg_2.asp" -->