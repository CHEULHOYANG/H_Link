<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/dbcon.asp" -->
<%
Dim sql,dr
Dim info1,info2,info3,info4,info5,info6,info7

sql = "select top 1 info1,info2,info3,info4,info5,info6,info7 from m_config"
set dr = db.execute(sql)

if dr.eof or dr.bof then

	info1 = ""
	info2 = ""
	info3 = ""
	info4 = ""
	info5 = ""
	info6 = ""
	info7 = ""
	
else

	info1 = dr(0)
	info2 = dr(1)
	info3 = dr(2)
	info4 = dr(3)
	info5 = dr(4)
	info6 = dr(5)
	info7 = dr(6)

dr.close
end if

%>
<!--#include file="../main/top.asp"-->

<div class="container">
	<!--#include file="left.asp"-->
	<div class="content">
		<h2 class="cTit"><span class="bullet"></span>�����������</h2>

<form name="form1" method="post" action="mobile_ok.asp" enctype="multipart/form-data">
		<table class="ftbl mb50" style="width:100%">
				<colgroup>
				<col style="width:20%" />
				<col style="width:80%" />
				</colgroup>
				<tbody>
					<tr>
						<th>�ΰ�</th>
						<td><input name="file2" type="file" class="inptxt1 w400" id="file2" >&nbsp;&nbsp;<%if len(info6) > 0 then response.write"<input type='checkbox' name='check_del2' value='1'>&nbsp;����" end if%> <span class="stip">jpg,png,gif 120pxX40px</span></td>
					</tr>
					<tr>
						<th>�ٷΰ�������ܵ��</th>
						<td><input name="file1" type="file" class="inptxt1 w400" id="file1" value="" >&nbsp;&nbsp;<%if len(info1) > 0 then response.write"<input type='checkbox' name='check_del1' value='1'>&nbsp;����" end if%><span class="stip">* png���ϸ����� 72pxX72px</span></td>
					</tr>
					<tr>
						<th>����Ʈ�ּ�</th>
						<td><input name="info2" type="text" class="inptxt1 w400" id="info2" value="<%=info2%>" ></td>
					</tr>
					<tr>
						<th>��ǥ��ȣ</th>
						<td><input name="info3" type="text" class="inptxt1 w200" id="info3" value="<%=info3%>" ></td>
					</tr>
					<tr>
						<th>ȸ���ּ�</th>
						<td><input name="info4" type="text" class="inptxt1 w400" id="info4" value="<%=info4%>" ></td>
					</tr>
					<tr>
						<th>����Ʈ��</th>
						<td><input name="info5" type="text" class="inptxt1 w400" id="info5" value="<%=info5%>" ></td>
					</tr>

					<tr>
						<th>����ƮŸ��Ʋ</th>
						<td><input name="info7" type="text" class="inptxt1 w400" id="info7" value="<%=info7%>" ></td>
					</tr>
				</tbody>
			</table>
</form>

		<div class="rbtn">
			<a href="javascript:document.form1.submit();" class="btn trans">�����ϱ�</a>		
		</div>

		<div class="caution"><p>��������� ���Ǵ� �ΰ� �ϴ� ī�Ƕ���Ʈ�� �����ϽǼ� �ֽ��ϴ�.</p></div>
		<div class="caution"><p>�ּҴ� http://�� ������ ��ü �ּҸ� �Է����ּ���.</p></div>

	</div>
</div>

</table>
</body>
</html>
<!-- #include file = "../authpg_2.asp" -->