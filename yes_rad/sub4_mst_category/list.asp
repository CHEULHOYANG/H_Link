<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/dbcon.asp" -->
<%

Dim dr,rownum,isRecod,isRows,isCols
dim sql,rs,name,m_idx,idx,s_idx,ordnum,deep,brand
dim rs1,name1,m_idx1,idx1,s_idx1,ordnum1,deep1
dim rs2,name2,m_idx2,idx2,s_idx2,ordnum2,deep2
dim show_t1,show_t2,gu,board_count,board_count1,board_count2
dim i,j,k

show_t1=request("show_t1")
show_t2=request("show_t2")
%>
<!--#include file="../main/top.asp"-->
<script>
function L_del(idx){
		var bool = confirm("\n�ش� �з��� �����Ͻðڽ��ϱ�?\n");
		if (bool){
			location.href = "L_del.asp?idx="+idx;
		}
}
</script>

<div class="container">
	<!--#include file="left.asp"-->
	<div class="content">
		<h2 class="cTit"><span class="bullet"></span>��Ű��ī�װ�</h2>

		<div class="tbl_top">
			<a href="L_input.asp" class="fbtn1">ī�װ� �����</a>	
		</div>

<table class="tbl" style="width:100%">
			<colgroup>
			<col style="width:10%" />
			<col />
			<col style="width:20%" />
			<col style="width:20%" />
			</colgroup>
			<thead>
				<tr>
					<th>�з�</th>	
					<th>�з��̸�</th>
					<th>�ܰ���</th>
					<th>���</th>	
				</tr>				
			</thead>
			<tbody>
<%
sql="select count(idx) from mscate "
set rs=db.execute(sql)
		
board_count = rs(0)
		  
sql="select idx,bname,img,cnt = (select count(idx) from Lectmast where gbn = A.idx),state from mscate A order by ordnum asc,idx desc"
set rs=db.execute(sql)

if rs.eof or rs.bof then
else
i=1
do until rs.eof
idx=rs(0)
name=rs(1)	
%>
				<tr>
					<td><%if i > 1 then%><a href="up.asp?idx=<%=rs(0)%>"><img src="../rad_img/a_up.gif" border="0"></a>&nbsp;<%end if%><%if board_count <> i then%><a href="down.asp?idx=<%=rs(0)%>"><img src="../rad_img/a_down.gif" border="0"></a><%end if%></td>
					<td  class="tl"><%If rs(4) = 1 Then Response.write"<font color='#ff6633'>[����]</font>&nbsp;" End if%><%If Len(rs(2)) > 0 Then Response.write"<font color='#cc0000'>[�̹���]</font>&nbsp;" End if%><%=name%></td>
					<td><%=rs(3)%>��</td>
					<td><a href="L_edit.asp?idx=<%=idx%>" class="btns trans">����</a> <a href="javascript:L_del('<%=idx%>');" class="btns trans">����</a></td>
				</tr>
<%
rs.movenext
i=i+1
loop
rs.close
end if
%>

			</tbody>
		</table>

		<div class="caution"><p>��Ű�����¸� ����Ͻñ����� ���� ī�װ��� ���� ����ϼž� �մϴ�.</p></div>
		<div class="caution"><p> �з� ������ �̹����� ÷���Ͻø� �ش� �з��� ���϶� ��Ű�� ��� ��ܿ� �������� �˴ϴ�.</p></div>
		<div class="caution"><p>�з��� 2�� �̻��ΰ�� ���Ʒ���ư�� �̿��ؼ� ������ �����Ҽ� �ֽ��ϴ�.</p></div>

	</div>
</div>

</body>
</html>
<!-- #include file = "../authpg_2.asp" -->