<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/dbcon.asp" -->
<%
Dim sql,rs,favicon

sql = "select favicon from site_info"
Set rs=db.execute(sql)

If rs.eof Or rs.bof Then
	favicon = ""
Else
	favicon = rs(0)
rs.close
End if
%>

<!--#include file="../main/top.asp"-->

<script language="javascript">
function delLogo(){
		var bool = confirm("�ش� �±׸� �����Ͻðڽ��ϱ�?");
		if (bool){
			location.href = "favicon_del.asp";
		}
}
function go2Logo(){
	var f = window.document.lfom;
	if(f.pto.value==""){
	alert("�ĺ����� �������ּ���.");
	return;
	}
	f.submit();
}
</script>

<div class="container">
	<!--#include file="left.asp"-->
	<div class="content">
		<h2 class="cTit"><span class="bullet"></span>�ĺ��ܼ���</h2>
			
			<form name="lfom" action="favicon_ok.asp" method="post" enctype="multipart/form-data" style="display:inline;">
			<table class="ftbl mb50" style="width:100%">
				<colgroup>
				<col style="width:20%" />
				<col style="width:80%" />
				</colgroup>
				<tbody>
<%If len(favicon) > 0 then%>
					<tr>
						<th>����̹���</th>
						<td><img src="../../ahdma/logo/<%=favicon%>">
							<a href="javascript:delLogo();" class="fbtn">����</a></td>
					</tr>
<%End if%>
					<tr>
						<th>���ϼ���</th>
						<td><input type="file" id="pto" name="pto" class="inptxt1 w400" />
							<a href="javascript:go2Logo();" class="fbtn">�����ϱ�</a></td>
					</tr>

				</tbody>
			</table>
			</form>

			<div class="caution"><p>������ ���׷����͸� �̿��ؼ� �����ϱ� http://www.xiconeditor.com</p></div>
			<div class="caution"><p>�̹������� ������ ��ȯ�ϱ� http://www.smoothdraw.com/product/freeware.htm</p></div>

	</div>
</div>

</body>
</html>
<!-- #include file = "../authpg_2.asp" -->