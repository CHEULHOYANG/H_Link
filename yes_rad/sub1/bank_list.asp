<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/dbcon.asp" -->
<%
Dim sql,dr,isRecod,recodnum
sql="select idx,bankname,banknumber,use_name from bank"
set dr = db.execute(sql)

if Not Dr.Bof or Not Dr.Eof then
	isRecod = True
	Dim isRows
	isRows = Split(Dr.GetString(2),chr(13))
	recodnum = UBound(isRows)
end if

Dr.Close
Set Dr = Nothing

%>

<!--#include file="../main/top.asp"-->

<script language="javascript">
function InputChk(){

	var clmn = form1.bankname;
	if(clmn.value==""){
		alert("������� �Է����ּ���!");
		clmn.focus();
		return;
	}
	clmn = form1.banknumber;
	if(clmn.value==""){
		alert("���¹�ȣ�� �Է����ּ���!");
		clmn.focus();
		return;
	}
	clmn = form1.use_name;
	if(clmn.value==""){
		alert("�����ָ� �Է����ּ���!");
		clmn.focus();
		return;
	}
	document.form1.submit();
}

function DeleteAdm(idxnum){
	del_ck = confirm("�ش� ������¸� �����Ͻðڽ��ϱ�?");
	if(del_ck){
		document.location.href="bank_del.asp?idx=" + idxnum;
	}
}
</script>

<div class="container">
	<!--#include file="left.asp"-->
	<div class="content">
		<h2 class="cTit"><span class="bullet"></span>�Ա��������</h2>

<form name="form1" method="post" action="bank_ok.asp">
		<table class="tbl" style="width:100%">
			<colgroup>
			<col style="width:30%" />
			<col style="width:30%" />
			<col style="width:30%" />
			<col style="width:10%" />
			</colgroup>
			<thead>
				<tr>
					<th>�����</th>	
					<th>���¹�ȣ</th>
					<th>������</th>
					<th>�߰�</th>	
								
				</tr>				
			</thead>
			<tbody>
				<tr>
					<td><input type="text" name="bankname" class="inptxt1" style="text-align:center;" ></td>
					<td><input type="text" name="banknumber" class="inptxt1" style="text-align:center;" ></td>
					<td><input type="text" name="use_name" class="inptxt1" style="text-align:center;" ></td>
					<td><a href="javascript:InputChk();" class="fbtn">�����ϱ�</a></td>
				</tr>
			</tbody>
		</table>
</form>

<%If isRecod Then %>
		<table class="tbl" style="width:100%">
			<colgroup>
			<col style="width:30%" />
			<col style="width:30%" />
			<col style="width:30%" />
			<col style="width:10%" />
			</colgroup>
			<thead>
				<tr>
					<th>�����</th>	
					<th>���¹�ȣ</th>
					<th>������</th>
					<th>���</th>	
								
				</tr>				
			</thead>
			<tbody>
              <% 
 
			  Dim isCols
							 for ii = 0 to Ubound(isRows) - 1
							 isCols = split(isRows(ii),chr(9)) %>
<form name="bedit<%=isCols(0)%>" method="post" action="bank_edit.asp">
<input type="hidden" name="idx" value="<%=isCols(0)%>">
				<tr>
					<td><input type="text" name="bankname" class="inptxt1" style="text-align:center;" value="<%=isCols(1)%>"></td>
					<td><input type="text" name="banknumber" class="inptxt1" style="text-align:center;" value="<%=isCols(2)%>"></td>
					<td><input type="text" name="use_name" class="inptxt1" style="text-align:center;" value="<%=isCols(3)%>"></td>
					<td><a href="javascript:document.bedit<%=isCols(0)%>.submit();" class="btns trans">����</a>&nbsp;<a href="javascript:DeleteAdm(<%=isCols(0)%>);" class="btns">����</a></td>
				</tr>
</form>              
              <% Next %>
			</tbody>
		</table>
<%End if%>
	</div>
</div>

</body>
</html>
<%
db.Close
Set db = Nothing
%>
<!-- #include file = "../authpg_2.asp" -->