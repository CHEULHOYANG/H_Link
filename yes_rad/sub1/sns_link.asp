<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/dbcon.asp" -->
<%
Dim sql,dr
Dim sns_id1,sns_id2,sns_id3,sns_id4,sns_id5
Dim sns_link1,sns_link2,sns_link3,sns_link4,sns_link5

sql = "select top 1 sns_id1,sns_id2,sns_id3,sns_id4,sns_id5,sns_link1,sns_link2,sns_link3,sns_link4,sns_link5 from site_info"
set dr = db.execute(sql)

if dr.eof or dr.bof then
else

	sns_id1 = dr(0)
	sns_id2 = dr(1)
	sns_id3 = dr(2)
	sns_id4 = dr(3)
	sns_id5 = dr(4)
	sns_link1 = dr(5)
	sns_link2 = dr(6)
	sns_link3 = dr(7)
	sns_link4 = dr(8)
	sns_link5 = dr(9)

dr.close
end if

%>
<!--#include file="../main/top.asp"-->

<div class="container">
	<!--#include file="left.asp"-->
	<div class="content">
		<h2 class="cTit"><span class="bullet"></span>SNS��ũ����</h2>

<form name="form1" method="post" action="sns_link_ok.asp">

		<table class="tbl" style="width:100%">
			<colgroup>
			<col style="width:20%" />
			<col style="width:40%" />
			<col style="width:40%" />
			</colgroup>
			<thead>
				<tr>
					<th>����</th>	
					<th>���̵�</th>
					<th>��ũ</th>						
				</tr>				
			</thead>
			<tbody>
				<tr>
					<th>kakaotalk</th>
					<td><input type="text" name="sns_id1" class="inptxt1 w200" value="<%=sns_id1%>" ></td>
					<td><input type="text" name="sns_link1" class="inptxt1 w400" value="<%=sns_link1%>" ></td>
				</tr>
				<tr>
					<th>instagram</th>
					<td><input type="text" name="sns_id2" class="inptxt1 w200" value="<%=sns_id2%>" ></td>
					<td><input type="text" name="sns_link2" class="inptxt1 w400" value="<%=sns_link2%>" ></td>
				</tr>
				<tr>
					<th>blog</th>
					<td><input type="text" name="sns_id3" class="inptxt1 w200" value="<%=sns_id3%>" ></td>
					<td><input type="text" name="sns_link3" class="inptxt1 w400" value="<%=sns_link3%>" ></td>
				</tr>
				<tr>
					<th>naver</th>
					<td><input type="text" name="sns_id4" class="inptxt1 w200" value="<%=sns_id4%>" ></td>
					<td><input type="text" name="sns_link4" class="inptxt1 w400" value="<%=sns_link4%>" ></td>
				</tr>
				<tr>
					<th>�ӽ�</th>
					<td><input type="text" name="sns_id5" class="inptxt1 w200" value="<%=sns_id5%>" ></td>
					<td><input type="text" name="sns_link5" class="inptxt1 w400" value="<%=sns_link5%>" ></td>
				</tr>
			</tbody>
		</table>

</form>

		<div class="rbtn">
			<a href="javascript:document.form1.submit();" class="btn">�����ϱ�</a>
		</div>

		<div class="caution"><p>�ش� ����� �����λ����� ����� ������������ �ֽ��ϴ�.</p></div>
		<div class="caution"><p>��ũ�ּҴ� ��Ȯ�� ��ü�ּҸ� �Է����ֽñ� �ٶ��ϴ�.</p></div>

	</div>
</div>

</body>
</html>
<!-- #include file = "../authpg_2.asp" -->