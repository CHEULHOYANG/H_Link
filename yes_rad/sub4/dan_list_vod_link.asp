<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/dbcon.asp" -->
<!--#include file="../main/top.asp"-->

<script language="javascript">

function vod_link_ch(){

	var f = window.document.regfm;

	if(f.link1.value == ""){
	alert("������ �ּҸ� �־��ּ���");
	return;
	}

	if(f.link2.value == ""){
	alert("������ �ּҸ� �־��ּ���");
	return;
	}

	f.submit();
		
}
</script>

<div class="container">
	<!--#include file="left.asp"-->
	<div class="content">
		<h2 class="cTit"><span class="bullet"></span>�������ּ� �ϰ�����</h2>

<form name="regfm" action="dan_list_vod_link_ok.asp" method="post">
		<table class="ftbl mb50" style="width:100%">
				<colgroup>
				<col style="width:20%" />
				<col style="width:80%" />
				</colgroup>
				<tbody>					
					<tr>
						<th>�������ּ�</th>
						<td><input type="text"  name="link1" class="inptxt1 w400" placeholder="������ ��" > -> <input type="text"  name="link2" class="inptxt1 w400" placeholder="������ ��" ></td>
					</tr>		
				</tbody>
			</table>
</form>

		<div class="rbtn">
			<a href="javascript:vod_link_ch();" class="btn">�����ϱ�</a>
		</div>

<div class="caution"><p>�ش� ����� �������ּҰ� ����ɰ�� �ѹ��� ��ȯ�� ���� ����Դϴ�. <strong>�ȳ�</strong>�̶�� ���ڸ� <strong>�ȳ��ϼ���</strong>�� �����ϴ� ����̶�� ���ø� �˴ϴ�.</p></div>
<div class="caution"><p>����� �ϰ������� ������ ���ǿ� �ּҰ� ������ �ǹǷ� <font color='#cc0000'>������ �Ұ���</font>�մϴ�. �� Ȯ���� ��Ȯ�� ������ֽñ� �ٶ��ϴ�.</p></div>
<div class="caution"><p>������ ����  <strong>http://111.111.111.1111/test/test.mp4</strong> �ΰ�� ������ ���� <strong>http://test.yesoft.net/test/test.mp4</strong> �ΰ�� ������ ������ <strong>http://111.111.111.1111/</strong>�� �Է� ������ ������ <strong>http://test.yesoft.net/</strong> �� �Է����ֽø� �˴ϴ�.</p></div>



	</div>
</div>


</body>
</html>
<!-- #include file = "../authpg_2.asp" -->