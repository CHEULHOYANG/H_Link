<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/dbcon.asp" -->
<%
Dim sql,rs
Dim idx,title,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r_gu,ordnum,ca

idx=request("idx")

sql="select idx,title,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r_gu,ordnum,ca from question_mast where idx = '"& idx &"'"
set rs=db.execute(sql)

if rs.eof or rs.bof Then

	response.write"<script>"
	response.write"alert('�������� �ʴ� �Խù��Դϴ�.');"
	response.write"history.back();"
	response.write"</script>"
	response.end

Else

	idx = rs(0)
	title = rs(1)
	r1 = rs(2)
	r2 = rs(3)
	r3 = rs(4)
	r4 = rs(5)
	r5 = rs(6)
	r6 = rs(7)
	r7 = rs(8)
	r8 = rs(9)
	r9 = rs(10)
	r10 = rs(11)
	r_gu = rs(12)
	ordnum = rs(13)
	ca = rs(14)

rs.close
end if
%>

<!--#include file="../main/top.asp"-->

<script>
function input_quiz(){

	var f = window.document.fm;

	if(f.title.value==""){
	alert("������������ �Է����ּ���.");
	f.title.focus();
	return;
	}

	f.submit();
}

function dandisplay(flag){

	if (flag==0)
	{
		mview_divList1.style.display = "";
		mview_divList2.style.display = "";
		mview_divList3.style.display = "";
		mview_divList4.style.display = "";
		mview_divList5.style.display = "";
		mview_divList6.style.display = "";
		mview_divList7.style.display = "";
		mview_divList8.style.display = "";
		mview_divList9.style.display = "";
		mview_divList10.style.display = "";
	}
	else
	{
		mview_divList1.style.display = "none";
		mview_divList2.style.display = "none";
		mview_divList3.style.display = "none";
		mview_divList4.style.display = "none";
		mview_divList5.style.display = "none";
		mview_divList6.style.display = "none";
		mview_divList7.style.display = "none";
		mview_divList8.style.display = "none";
		mview_divList9.style.display = "none";
		mview_divList10.style.display = "none";	
	}

} 

</script>

<div class="container">
	<!--#include file="left.asp"-->
	<div class="content">
		<h2 class="cTit"><span class="bullet"></span>�������׸����</h2>

<form action="edit_ok.asp" method="post" name="fm">
<input type="hidden" name="idx" value="<%=request("idx")%>">
<input type="hidden" name="page" value="<%=request("page")%>">
<input type="hidden" name="searchpart" value="<%=request("searchpart")%>">
<input type="hidden" name="searchstr" value="<%=request("searchstr")%>">

			<table class="ftbl mb50" style="width:100%">
				<colgroup>
				<col style="width:20%" />
				<col style="width:80%" />
				</colgroup>
				<tbody>
					<tr>
						<th>����������</th>
						<td><select name="ca" class="seltxt" >
  <option value="0">�з��������ϼ���.</option>
<%
sql="select idx,title from question_list order by idx desc"
set rs=db.execute(sql)
if rs.eof or rs.bof then
else
do until rs.eof
%>
      <option value="<%=rs(0)%>" <%If ca=rs(0) Then response.write"selected" End if%>><%=rs(1)%></option>
<%
rs.movenext
Loop
rs.close
end if
%>
    </select></td>
					</tr>
					<tr>
						<th>��������</th>
						<td><input type="text" name="ordnum" class="inptxt1 w60" size="5" onKeyUp="onlynum(fm.ordnum);" value="<%=ordnum%>">
							<span class="stip">* 0���� ������ �˴ϴ�.</span></td>
					</tr>
					<tr>
						<th>��������</th>
						<td><input name="r_gu" type="radio" value="0" <%If r_gu = 0 Then response.write"checked" End if%> onClick="dandisplay(0);"> 
������&nbsp;&nbsp;
<input type="radio" name="r_gu" value="1" <%If r_gu = 1 Then response.write"checked" End if%> onClick="dandisplay(1);"> 
�Է���</td>
					</tr>
					<tr>
						<th>��������</th>
						<td><textarea name="title" cols="80" class="inptxt1 w500" id="title" style="height:70px"><%=title%></textarea></td>
					</tr>
					<tr style="display:<%If r_gu=1 Then response.write"none" End if%>;" id="mview_divList1">
                    <th>1�� �׸�</th>
                    <td>
                      <input name="r1" type="text" class="inptxt1 w400" id="r1" size="80" value="<%=r1%>"></td>
                  </tr>
                  <tr style="display:<%If r_gu=1 Then response.write"none" End if%>;" id="mview_divList2">
                    <th>2�� �׸�</th>
                    <td>
                      <input name="r2" type="text" class="inptxt1 w400" id="r2" size="80" value="<%=r2%>"></td>
                  </tr>
                  <tr style="display:<%If r_gu=1 Then response.write"none" End if%>;" id="mview_divList3">
                    <th>3�� �׸�</th>
                    <td>
                      <input name="r3" type="text" class="inptxt1 w400" id="r3" size="80" value="<%=r3%>"></td>
                  </tr>
                  <tr style="display:<%If r_gu=1 Then response.write"none" End if%>;" id="mview_divList4">
                    <th>4�� �׸�</th>
                    <td>
                      <input name="r4" type="text" class="inptxt1 w400" id="r4" size="80" value="<%=r4%>"></td>
                  </tr>
                  <tr style="display:<%If r_gu=1 Then response.write"none" End if%>;" id="mview_divList5">
                    <th>5�� �׸�</th>
                    <td>
                      <input name="r5" type="text" class="inptxt1 w400" id="r5" size="80" value="<%=r5%>"></td>
                  </tr>
                  <tr style="display:<%If r_gu=1 Then response.write"none" End if%>;" id="mview_divList6">
                    <th>6�� �׸�</th>
                    <td>
                      <input name="r6" type="text" class="inptxt1 w400" id="r6" size="80" value="<%=r6%>"></td>
                  </tr>
                  <tr style="display:<%If r_gu=1 Then response.write"none" End if%>;" id="mview_divList7">
                    <th>7�� �׸�</th>
                    <td>
                      <input name="r7" type="text" class="inptxt1 w400" id="r7" size="80" value="<%=r7%>"></td>
                  </tr>
                  <tr style="display:<%If r_gu=1 Then response.write"none" End if%>;" id="mview_divList8">
                    <th>8�� �׸�</th>
                    <td>
                      <input name="r8" type="text" class="inptxt1 w400" id="r8" size="80" value="<%=r8%>"></td>
                  </tr>
                  <tr style="display:<%If r_gu=1 Then response.write"none" End if%>;" id="mview_divList9">
                    <th>9�� �׸�</th>
                    <td>
                      <input name="r9" type="text" class="inptxt1 w400" id="r9" size="80" value="<%=r9%>"></td>
                  </tr>
                  <tr style="display:<%If r_gu=1 Then response.write"none" End if%>;" id="mview_divList10">
                    <th>10�� �׸�</th>
                    <td>
                      <input name="r10" type="text" class="inptxt1 w400" id="r10" size="80" value="<%=r10%>"></td>
                  </tr>			
				</tbody>
			</table>
</form>

		<div class="rbtn">
			<a href="javascript:input_quiz();" class="btn">�����ϱ�</a>
			<a href="list.asp" class="btn trans">��Ϻ���</a>		
		</div>

	</div>
</div>


</body>
</html>

<!-- #include file = "../authpg_2.asp" -->

