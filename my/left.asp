	<div class="nlnbWrap">
		<h2><%=t_menu8%></h2>
		<div class="nlnb">
			<dl>
				<dt><a href="01_main.asp">���Ű��¸��</a></dt>
				<dd><a href="01_main.asp">���Ű��¸��</a>
					<a href="02_paylist.asp">��������</a>
					<a href="07_coupon.asp">��������������</a>
					<a href="10_end_paper.asp">���������</a></dd>
			</dl>
			<dl>
				<dt><a href="03_bguny.asp">��ٱ���</a></dt>
			</dl>

<%If Len(t_menu4) > 0 then%>
			<dl>
				<dt><a href="08_list.asp">�ֹ�/�����ȸ</a></dt>
			</dl>
<%End if%>
<%If Len(t_menu5) > 0 then%>
			<dl>
				<dt><a href="09_quiz_result.asp">����Ǯ�̰��</a></dt>
			</dl>
<%End if%>

			<dl>
				<dt><a href="04_qlist.asp">�Խñ� ����</a></dt>
				<dd><a href="04_qlist.asp">�������� �亯</a>
				<a href="13_list.asp"><%=t_menu6%> �Խñ�</a>
				<a href="14_list.asp"><%=t_menu3%> �Խñ�</a></dd>
			</dl>

			<dl>
				<dt><a href="05_myinfo.asp">ȸ������</a></dt>
				<dd><a href="05_myinfo.asp">ȸ����������</a>
				<a href="11_mileage.asp">�����ݳ���</a>
				<a href="12_cal.asp">�⼮��Ȳ</a>
					<a href="06_myinfo_out.asp">ȸ��Ż��</a></dd>
			</dl>
		</div>

		<!-- #include file="../include/left2.asp" -->

		<!--  ��ʽ���   -->
			<div style="text-align:center;">
			<% 
			sql = "select banner,banner_url,filegbn,target from banner where areagbn='046' order by  ordnum asc , idx desc"
			set dr = db.execute(sql)
			if not dr.bof or not dr.eof then
			do until dr.eof 
			response.write ""& BannerOutput(dr(0),dr(1),dr(2),200,dr(3)) &"<br /><br />"
			dr.movenext
			Loop
			end if
			dr.close %>					
			</div>
		<!--  ��ʳ�  -->

	</div>