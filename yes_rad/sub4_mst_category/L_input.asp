<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/dbcon.asp" -->
<%

dim sql,rs,name,m_idx,idx,s_idx,ordnum,deep
Dim dr,rownum,isRecod,isRows,isCols
%>

<!--#include file="../main/top.asp"-->

<script>
function input_it(){
	var f = window.document.form1;
	if(f.name.value==""){
	alert("�з��������� �Է����ּ���.");
	f.name.focus();
	return;
	}	
	f.submit();
}
</script>

<div class="container">
	<!--#include file="left.asp"-->
	<div class="content">
		<h2 class="cTit"><span class="bullet"></span>��Ű��ī�װ�</h2>

<form name="form1" method="post" action="L_input_ok.asp" enctype="multipart/form-data">
		<table class="ftbl mb50" style="width:100%">
				<colgroup>
				<col style="width:20%" />
				<col style="width:80%" />
				</colgroup>
				<tbody>
                  <tr>
                    <th>����</th>
                    <td><input type="radio" name="state" value="0" checked> �ƴϿ�
						<input type="radio" name="state" value="1" > ��</td>
                  </tr>
					<tr>
						<th>�з���</th>
						<td><input type="text" id="name" name="name" class="inptxt1 w200" /></td>
					</tr>
                  <tr>
                    <th>����̹���</th>
                    <td>
                      <input type="file" name="img" class="inptxt1 w200"> <span class="stip">* �з���� ��ܿ� �������� �̹����Դϴ�.</span></td>
                  </tr>
				</tbody>
			</table>
</form>

		<div class="rbtn">
			<a href="javascript:input_it();" class="btn">�����ϱ�</a>
			<a href="list.asp" class="btn trans">�������</a>		
		</div>

	</div>
</div>

</body>
</html>
<!-- #include file = "../authpg_2.asp" -->