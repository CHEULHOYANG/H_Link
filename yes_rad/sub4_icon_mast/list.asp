<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/dbcon.asp" -->
<!--#include file="../main/top.asp"-->
<script>
function icon_del(idx){
		var bool = confirm("�����Ͻðڽ��ϱ�?");
		if (bool){
			location.href = "del.asp?idx="+idx;
		}
}
</script>

<div class="container">
	<!--#include file="left.asp"-->
	<div class="content">
		<h2 class="cTit"><span class="bullet"></span>���Ǿ����ܼ���</h2>

		<div class="tbl_top">
			<a href="input.asp" class="fbtn1">�����ܵ��</a>	
		</div>

		<table class="tbl" style="width:100%">
			<colgroup>
			<col />
			<col style="width:20%" />
			<col style="width:20%" />
			</colgroup>
			<thead>
				<tr>
					<th>�������̸�</th>	
					<th>������</th>
					<th>���</th>						
				</tr>				
			</thead>
			<tbody>
                <%
			  dim sql,rs,idx,icon,name
			  
			  sql="select idx,icon,name from icon_mast order by idx desc"
			  set rs=db.execute(sql)
			  
			  if rs.eof or rs.bof then
			  else
			  do until rs.eof
			  idx = rs(0)
			  icon = rs(1)
			  name = rs(2)
			  %>
				<tr>
					<td><%=name%></td>
					<td><img src="/ahdma/logo/<%=icon%>"></td>
					<td><a href="edit.asp?idx=<%=idx%>" class="btns trans">����</a>
					<a href="javascript:icon_del('<%=idx%>');" class="btns">����</a></td>					
				</tr>
                <%
			  rs.movenext
			  loop
			  end if
			  %>
			</tbody>
		</table>

	</div>
</div>


</body>
</html>
<!-- #include file = "../authpg_2.asp" -->