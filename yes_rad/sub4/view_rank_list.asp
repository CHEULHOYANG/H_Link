<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/dbcon.asp" -->
<%
Dim sql,dr,isRecod,isRows,isCols,rs1
Dim intpg,blockPage,pagecount,recordcount,lyno
Dim gbnS,strsday,streday,strPart,strSearch
Dim varPage
Dim v_time,v_date,time1,time2,v_title
dim v1,h,m,s,rs,i
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="../rad_img/pop.css" type="text/css">

<script language="javascript">
function close_layervv() {
	parent.close_layer();
}
</script>

</head>
<body>

<div class="laypop">
	<div class="lay_tit">
		<h2>���� �ۼ��ϱ�</h2>
		<a href="" class="btn_close"><img src="../rad_img/img/btn_close.png" alt="â�ݱ�" /></a>
	</div>
	<div class="lay_cont">
		<div class="write_box">
			<select id="select" class="seltxt mb8">
				<option>����+����</option>
				<option>��ü�˻�</option>
			</select>
			<textarea name="textarea" id="textarea" cols="45" rows="5"></textarea>
			<div class="write_btm">
				<a href="" class="wico">�ؽ��±׵��</a><a href="" class="wico wi1">���ϵ��</a>
				<a href="" class="wtxt"><input type="checkbox" name="checkbox" id="checkbox" /> �͸�</a>
			</div>
		</div>
		<div class="btn_wrap">
			<a href="" class="btn_pop">â�ݱ�</a>
		</div>
	</div>		
</div>
</body>
</html>
<!-- #include file = "../authpg_2.asp" -->