<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/dbcon.asp" -->
<%
dim idx
idx = Request("idx")

dim sql,dr
sql = "select id,name from member where idx=" & idx
set dr = db.execute(sql)

dim id,name
id = dr(0)
name = dr(1)
dr.close
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title>�������</title>
<link rel="stylesheet" type="text/css" href="../rad_img/pop.css" />
<script language="javascript" src="../../include/jquery.js"></script>
<script language="javascript" src="../../include/xmlhttp.js"></script>
<script language="javascript">

function set_cate1(idx){

	if (document.fm.buygbn.value==0)
	{

			var a = "<select name='categbn' id='categbn' style='width:170px;' onChange='set_cate1(this,value);' class='seltxt'><option value='0'>����</option></select>";
			var b = "<select name='tabidx' id='tabidx' style='width:290px;' class='seltxt'><option value='0'>����</option></select>";

			$('#ca2_area1').html(a);
			$('#ca3_area1').html(b);

	alert('�з��� �������ּ���!!');
	return;

	}

		$.ajax({
			url: "set_cate1.asp",
			type:"POST",
			data:{"key":idx},
			dataType:"text",
			cache:false,
			processData:true,
			success:function(_data){

			var a = "<select name='categbn' id='categbn' style='width:170px;' onChange='set_cate1(this,value);' class='seltxt'><option value='0'>����</option></select>";
			var b = "<select name='tabidx' id='tabidx' style='width:290px;' class='seltxt'><option value='0'>����</option></select>";

			$('#ca2_area1').html(a);
			$('#ca3_area1').html(b);

				$('#ca2_area1').html(_data);
			},
			error:function(xhr,textStatus){
			alert("[����]����:"+xhr.status+"                                     ");
			}	
		});		
}

function set_cate2(key){
		$.ajax({
			url: "set_cate2.asp",
			type:"POST",
			data:{"key":key,"keygbn":document.fm.buygbn.value},
			dataType:"text",
			cache:false,
			processData:true,
			success:function(_data){

			var b = "<select name='tabidx' id='tabidx' style='width:290px;' class='seltxt'><option value='0'>����</option></select>";

			$('#ca3_area1').html(b);

				$('#ca3_area1').html(_data);
			},
			error:function(xhr,textStatus){
			alert("[����]����:"+xhr.status+"                                     ");
			}	
		});		
}

function NumKeyOnly(){
	if((event.keyCode<48)||(event.keyCode>57)) event.returnValue=false;
}

function go2In(thefm){
	var clmn;
	clmn = thefm.buygbn;
	if(clmn.value=="0"){
		alert("���ºз��� �������ּ���!");
		clmn.focus();
		return;
	}

	clmn = thefm.categbn;
	if(clmn.value=="0"){
		alert("ī�װ��� �������ּ���!");
		clmn.focus();
		return;
	}

	if(thefm.buygbn[2].selected || thefm.buygbn[3].selected){
		clmn = thefm.tabidx;
		if(clmn.value=="0"){
			alert("�ܰ� �Ǵ� ������ �������ּ���!");
			clmn.focus();
			return;
		}
	}

	clmn = thefm.intgigan;
	if(clmn.value==""){
		alert("���ǱⰣ�� �Է��ϼ���!");
		clmn.focus();
		return;
	}

	clmn = thefm.paytype;
	if(clmn.value=="0"){
		alert("��������� �������ּ���!");
		clmn.focus();
		return;
	}

	document.fm.submit();
}
</script>
</head>
<body>

<div class="laypop">
	<div class="lay_tit">
		<h2>���� ���</h2>
		<a href="javascript:self.close();" class="btn_close"><img src="../rad_img/img/btn_close.png" alt="â�ݱ�" /></a>
	</div>
	<div class="lay_cont">
<form name="fm" method="post" action="setin_ok.asp">
<input type="hidden" name="idx" value="<%=idx%>">
		<table class="ptbl" style="width:656px">
			<colgroup>
			<col style="width:22%" />
			<col style="width:78%" />
			</colgroup>
			<tbody>
				<tr>
					<th>�з�����</th>
					<td><select name="buygbn" id="buygbn" onChange="set_cate1(this.value);" class='seltxt'>
					<option value="0">�з�����</option>
					<option value="1">�����н�</option>
					<option value="2">��������</option>
					<option value="3">�ܰ�����</option>
				</select>
				<span id="ca2_area1"><select name='categbn' id='categbn' style='width:170px;' onChange='set_cate1(this,value);' class='seltxt'><option value='0'>����</option></select></span></td>
				</tr>
				<tr>
					<th>���¼���</th>
					<td><span id="ca3_area1"><select name='tabidx' id='tabidx' style='width:290px;' class='seltxt'><option value='0'>����</option></select></span></td>
				</tr>
				<tr>
					<th>���ǽ�����</th>
					<td><input type="text" name="strsday" id="strsday" class="inptxt" size="10" readonly value="<%=date%>" style='width:110px;'></td>
				</tr>
				<tr>
					<th>���ǱⰣ</th>
					<td><input type="text"  name="intgigan" class="inptxt" size="5" maxlength="3" value="" onKeyPress="NumKeyOnly();" style='width:50px;'> ��</td>
				</tr>
				<tr>
					<th>�������</th>
					<td><select name="paytype" id="paytype" class="seltxt">
					<option value="0">�� ��</option>
					<option value="1">�������Ա�</option>
					<option value="2">�ſ�ī��</option>
					<option value="3">�ڵ���</option>
					<option value="4">�ǽð�������ü</option>
					<option value="5">����</option>
				</select></td>
				</tr>
			</tbody>
		</table>
</form>
		<div class="btn_wrap bw1">
			<a href="javascript:go2In(fm);" class="btn_pop red">����ϱ�</a>
		</div>
	</div>		
</div>

</body>
</html>
<link rel="stylesheet" href="../../include/pikaday.css">
<script src="../../include/moment.js"></script>
<script src="../../include/pikaday.js"></script>

<script>
    var picker = new Pikaday(
    {
        field: document.getElementById('strsday'),
        firstDay: 1,
		format: "YYYY-MM-DD",
        minDate: new Date('<%=left(date(),4)-10%>-01-01'),
        maxDate: new Date('<%=left(date(),4)+10%>-12-31'),
        yearRange: [<%=left(date(),4)-10%>,<%=left(date(),4)+10%>]
    });
</script>
<!-- #include file = "../authpg_2.asp" -->