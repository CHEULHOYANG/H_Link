<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/dbcon.asp" -->
<%
Dim sql,dr,isRecod,recodnum
recodnum = 0
sql="select idx,id,pwd,regdate,manage from admin_mast order by idx desc"
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
function InputChk(theform){
	var clmn = theform.id;
	if(clmn.value==""){
		alert("�߰��� ������ ���̵� �Է����ּ���!");
		clmn.focus();
		return false;
	}
	clmn = theform.pwd;
	if(clmn.value==""){
		alert("�н����带 �Է����ּ���!");
		clmn.focus();
		return false;
	}
return true;
}
function DeleteAdm(idxnum){
	var adLevel =<%=recodnum%>;
	if(adLevel< 2){
		alert("������ ������ �ּ� 1�� �̻� �־�� �մϴ�.\n\n������ ������ 1�� �̻� �߰��Ͻ� �Ŀ� ���� ���ּ���!");
	}
	else{
		del_ck = confirm("�ش� ������ ������ �����Ͻðڽ��ϱ�?");
		if(del_ck){
			document.location.href="admin_del.asp?idxnum=" + idxnum;
		}
	}
}
</script>

<div class="container">
	<!--#include file="left.asp"-->
	<div class="content">
		<h2 class="cTit"><span class="bullet"></span>�����ڼ���</h2>

		<div class="tbl_top">
			<a href="admin_input.asp" class="fbtn1">�����ڵ��</a>
		</div>

		<table class="tbl" style="width:100%">
			<colgroup>
			<col style="width:10%" />
			<col style="width:10%" />
			<col />
			<col style="width:10%" />
			</colgroup>
			<thead>
				<tr>
					<th>���̵�</th>	
					<th>��й�ȣ</th>
					<th>����</th>
					<th>���</th>
				</tr>				
			</thead>
			<tbody>
<%
                    Dim isCols
                    for ii = 0 to Ubound(isRows) - 1
                    isCols = split(isRows(ii),chr(9)) 
%>
				<tr>
					<td><%=isCols(1)%></td>
					<td><%=left(isCols(2),2)%>XXXX</td>
					<td class="tl">
					<input name="manage" type="checkbox" id="manage" value="a1" disabled <%If instr(isCols(4),", a1,") Then response.write"checked" End if%> >
                      </label>
                      ����Ʈ��������
                      <input name="manage2" type="checkbox" id="manage" value="a2" disabled <%If instr(isCols(4),", a2,") Then response.write"checked" End if%>>
                      �����ڼ���
                      <input name="manage2" type="checkbox" id="manage" value="a3" disabled <%If instr(isCols(4),", a3,") Then response.write"checked" End if%>>
                      �������������
                      <input name="manage2" type="checkbox" id="manage" value="a4" disabled <%If instr(isCols(4),", a4,") Then response.write"checked" End if%>>
                      �������������
                      <input name="manage2" type="checkbox" id="manage" value="a5" disabled <%If instr(isCols(4),", a5,") Then response.write"checked" End if%>>
                      �Ա��������
                      <input name="manage2" type="checkbox" id="manage" value="a6" disabled <%If instr(isCols(4),", a6,") Then response.write"checked" End if%>>
                      �˾�â����
                      <input name="manage2" type="checkbox" id="manage" value="a7" disabled <%If instr(isCols(4),", a7,") Then response.write"checked" End if%>>
                      ���Ǿ����ܼ���
                      <input name="manage2" type="checkbox" id="manage" value="a8" disabled <%If instr(isCols(4),", a8,") Then response.write"checked" End if%>>
                      �����������<br />

<input name="manage2" type="checkbox" id="manage" value="b1" disabled <%If instr(isCols(4),", b1,") Then response.write"checked" End if%>>
                      �ĺ��ܰ���
                      <input name="manage2" type="checkbox" id="manage" value="b2" disabled <%If instr(isCols(4),", b2,") Then response.write"checked" End if%>>
                      �ΰ����<br />					

					
					<input name="manage2" type="checkbox" id="manage" value="c1" disabled <%If instr(isCols(4),", c1,") Then response.write"checked" End if%>>
                      ȸ���׷����
                      <input name="manage2" type="checkbox" id="manage" value="c2" disabled <%If instr(isCols(4),", c2,") Then response.write"checked" End if%>>
                      ȸ�����
                      <input name="manage2" type="checkbox" id="manage" value="c3" disabled <%If instr(isCols(4),", c3,") Then response.write"checked" End if%>>
                      ȸ���뷮���
                      <input name="manage2" type="checkbox" id="manage" value="c4" disabled <%If instr(isCols(4),", c4,") Then response.write"checked" End if%>>
                      ���ϸ�������
                      <input name="manage2" type="checkbox" id="manage" value="c5" disabled <%If instr(isCols(4),", c5,") Then response.write"checked" End if%>>
                      ȸ���⼮��Ȳ
                      <input name="manage2" type="checkbox" id="manage" value="c6" disabled <%If instr(isCols(4),", c6,") Then response.write"checked" End if%>>
                      Ż��ȸ������
                      <input name="manage2" type="checkbox" id="manage" value="c7" disabled <%If instr(isCols(4),", c7,") Then response.write"checked" End if%>>
                      �������̵����
                      <input name="manage2" type="checkbox" id="manage" value="c8" disabled <%If instr(isCols(4),", c8,") Then response.write"checked" End if%>>
                      �̸��Ϲ߼۰���
                      <input name="manage2" type="checkbox" id="manage" value="c9" disabled <%If instr(isCols(4),", c9,") Then response.write"checked" End if%>>
                      ���ڹ߼۱׷����
                      <input name="manage2" type="checkbox" id="manage" value="c10" disabled <%If instr(isCols(4),", c10,") Then response.write"checked" End if%>>
                      ���ڹ߼۰���<br />

					<input name="manage2" type="checkbox" id="manage" value="d1" disabled <%If instr(isCols(4),", d1,") Then response.write"checked" End if%>>
                      �������
                      <input name="manage2" type="checkbox" id="manage" value="d2" disabled <%If instr(isCols(4),", d2,") Then response.write"checked" End if%>>
                      �����԰���
                      <input name="manage2" type="checkbox" id="manage" value="d3" disabled <%If instr(isCols(4),", d3,") Then response.write"checked" End if%>>
                      �����Ե��
                      <input name="manage2" type="checkbox" id="manage" value="d4" disabled <%If instr(isCols(4),", d4,") Then response.write"checked" End if%>>
                      ��������
                      <input name="manage2" type="checkbox" id="manage" value="d5" disabled <%If instr(isCols(4),", d5,") Then response.write"checked" End if%>>
                      �ڷ��
                      <input name="manage2" type="checkbox" id="manage" value="d6" disabled <%If instr(isCols(4),", d6,") Then response.write"checked" End if%>>
                      �������亯
                      <input name="manage2" type="checkbox" id="manage" value="d7" disabled <%If instr(isCols(4),", d7,") Then response.write"checked" End if%>>
                      �����ı�<br />
					  
					  <input name="manage2" type="checkbox" id="manage" value="e1" disabled <%If instr(isCols(4),", e1,") Then response.write"checked" End if%>>
                      ��ǰī�װ�
                      <input name="manage2" type="checkbox" id="manage" value="e2" disabled <%If instr(isCols(4),", e2,") Then response.write"checked" End if%>>
                      ��ǰ���
                      <input name="manage2" type="checkbox" id="manage" value="e3" disabled <%If instr(isCols(4),", e3,") Then response.write"checked" End if%>>
                      ��ǰ���
                      <input name="manage2" type="checkbox" id="manage" value="e4" disabled <%If instr(isCols(4),", e4,") Then response.write"checked" End if%>>
                      ��ǰ�뷮���
                      <input name="manage2" type="checkbox" id="manage" value="e5" disabled <%If instr(isCols(4),", e5,") Then response.write"checked" End if%>>
                      �ֹ�/��۰���<br />

					<input name="manage2" type="checkbox" id="manage" value="f1" disabled <%If instr(isCols(4),", f1,") Then response.write"checked" End if%>>
                      ���°���
                      <input name="manage2" type="checkbox" id="manage" value="f2" disabled <%If instr(isCols(4),", f2,") Then response.write"checked" End if%>>
                      ī�װ�����
                      <input name="manage2" type="checkbox" id="manage" value="f3" disabled <%If instr(isCols(4),", f3,") Then response.write"checked" End if%>>
                      ��������
                      <input name="manage2" type="checkbox" id="manage" value="f4" disabled <%If instr(isCols(4),", f4,") Then response.write"checked" End if%>>
                      ��������
                      <input name="manage2" type="checkbox" id="manage" value="f5" disabled <%If instr(isCols(4),", f5,") Then response.write"checked" End if%>>
                      �������<br />
					  
					  <input name="manage2" type="checkbox" id="manage" value="g1" disabled <%If instr(isCols(4),", g1,") Then response.write"checked" End if%>>
                      ����ī�װ�
                      <input name="manage2" type="checkbox" id="manage" value="g2" disabled <%If instr(isCols(4),", g2,") Then response.write"checked" End if%>>
                      ������
                      <input name="manage2" type="checkbox" id="manage" value="g3" disabled <%If instr(isCols(4),", g3,") Then response.write"checked" End if%>>
                      ���踸���
                      <input name="manage2" type="checkbox" id="manage" value="g4" disabled <%If instr(isCols(4),", g4,") Then response.write"checked" End if%>>
                      ����������<br />
					  <input name="manage2" type="checkbox" id="manage" value="h1" disabled <%If instr(isCols(4),", h1,") Then response.write"checked" End if%>>
                      ��������
                      <input name="manage2" type="checkbox" id="manage" value="h2" disabled <%If instr(isCols(4),", h2,") Then response.write"checked" End if%>>
                      �������亯
                      <input name="manage2" type="checkbox" id="manage" value="h3" disabled <%If instr(isCols(4),", h3,") Then response.write"checked" End if%>>
                      ���ֹ�������
                      <input name="manage2" type="checkbox" id="manage" value="h4" disabled <%If instr(isCols(4),", h4,") Then response.write"checked" End if%>>
                      �ȳ�������
                      <input name="manage2" type="checkbox" id="manage" value="h5" disabled <%If instr(isCols(4),", h5,") Then response.write"checked" End if%>>
                      ��ʰ���
                      <input name="manage2" type="checkbox" id="manage" value="h6" disabled <%If instr(isCols(4),", h6") Then response.write"checked" End if%>>
                      ��������<br />
					  <input name="manage2" type="checkbox" id="manage" value="i1" disabled <%If instr(isCols(4),", i1,") Then response.write"checked" End if%>>
                      �Խ��ǰ���<br />
					  <input name="manage2" type="checkbox" id="manage" value="j1" disabled <%If instr(isCols(4),", j1,") Then response.write"checked" End if%>>
                      �����ںм�
                      <input name="manage2" type="checkbox" id="manage" value="j2" disabled <%If instr(isCols(4),", j2,") Then response.write"checked" End if%>>
                      �����м�
                      <input name="manage2" type="checkbox" id="manage" value="j3" disabled <%If instr(isCols(4),", j3,") Then response.write"checked" End if%>>
                      �Ϻ��м�
                      <input name="manage2" type="checkbox" id="manage" value="j4" disabled <%If instr(isCols(4),", j4,") Then response.write"checked" End if%>>
                      ���Ϻ��м�
                      <input name="manage2" type="checkbox" id="manage" value="j5" disabled <%If instr(isCols(4),", j5,") Then response.write"checked" End if%>>
                      �ð����м�
                      <input name="manage2" type="checkbox" id="manage" value="j6" disabled <%If instr(isCols(4),", j6,") Then response.write"checked" End if%>>
                      �б⺰�м�
                      <input name="manage2" type="checkbox" id="manage" value="j7" disabled <%If instr(isCols(4),", j7,") Then response.write"checked" End if%>>
                      ���Ӱ�κм�
                      <input name="manage2" type="checkbox" id="manage" value="j8" disabled <%If instr(isCols(4),", j8,") Then response.write"checked" End if%>>
                      �����ʱ�ȭ</td>
					<td><a href="admin_edit.asp?id=<%=isCols(1)%>" class="btns">����</a> <a href="javascript:DeleteAdm(<%=isCols(0)%>);" class="btns trans">����</a></td>
				</tr>
				<% Next  %>
			</tbody>
		</table>


		<div class="caution"><p>������ ������ ���ϴ� ��ŭ ����ϰ� ���� �� �� �ֽ��ϴ�. �� <strong>�ּ� 1�� �̻�</strong>�� ������ ���̵� ��ϵǾ� �־�� �մϴ�.</p></div>

		<div class="caution"><p><font color="#CC0000"><strong>��ϵ� ������ �н����带 ����</strong></font> �Ͻ÷��� ���� ����ϰ� �ִ� ���̵�� ���ο� �н����带 �Է��ϰ� [<strong>�����ڵ��</strong>]��ư�� Ŭ���ϼ���!</p></div>

		<div class="caution"><p>�������� ���̵�� �н����尡 <strong>Ÿ�ο��� ������� �ʵ��� �����Ͻʽÿ�!</strong></p></div>

	</div>
</div>



</body>
</html>
<!-- #include file = "../authpg_2.asp" -->