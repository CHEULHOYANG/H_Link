<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/dbcon.asp" -->
<%
dim sql,rs,name,m_idx,idx,s_idx,ordnum,deep
dim name1,img,s_idx1,brand
Dim dr,rownum,isRecod,isRows,isCols

sql="select title,img,uidx from dan_category where idx="& request("idx")
set rs=db.execute(sql)

if rs.eof or rs.bof then
else
	name1 = rs(0)
	img = rs(1)
	s_idx = rs(2)
rs.close
end if
%>
<!-- #include file = "../main/top.asp" -->
<script>
function input_it(){

	var f = window.document.form1;

	if(f.name.value==""){
	alert("�з����� �Է����ּ���.");
	f.name.focus();
	return;
	}	

	f.submit();
}
</script>

<div class="container">
	<!--#include file="left.asp"-->
	<div class="content">
		<h2 class="cTit"><span class="bullet"></span>�ܰ�ī�װ�</h2>

<form name="form1" method="post" action="M_edit_ok.asp" enctype="multipart/form-data">
<input type="hidden" name="idx" value="<%=request("idx")%>">
		<table class="ftbl mb50" style="width:100%">
				<colgroup>
				<col style="width:20%" />
				<col style="width:80%" />
				</colgroup>
				<tbody>
					<tr>
						<th>�����з�</th>
						<td><select name="S_idx" class="seltxt w200">
                            <%
						  	sql="select idx,title from dan_category where deep=0 order by ordnum asc,idx desc"
							set rs=db.execute(sql)
							if rs.eof or rs.bof then
							else
							do until rs.eof
							idx=rs(0)
							name=rs(1)
						  %>
                            <option value="<%=idx%>" <%if int(idx) = int(s_idx1) then response.write"selected" end if%>><%=name%></option>
                            <%
							rs.movenext
							Loop
							rs.close
							end if
							%>
                          </select></td>
					</tr>
					<tr>
						<th>�з���</th>
						<td><input type="text" id="name" name="name" class="inptxt1 w200" value="<%=name1%>" /></td>
					</tr>
                  <tr>
                    <th>����̹���</td>
                    <td>
                      <input type="file" name="img" class="inptxt1 w200"> <%If Len(img) > 0 then%><input type="checkbox" name="checkdel" value="1"> ����<a href="/ahdma/quiz/<%=img%>">(<%=img%>)</a><%End if%> <span class="stip">* �з���� ��ܿ� �������� �̹����Դϴ�.</span></td>
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