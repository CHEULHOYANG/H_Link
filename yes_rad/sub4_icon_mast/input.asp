<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/dbcon.asp" -->
<!--#include file="../main/top.asp"-->
<script>
function icon_input(){	
	var f = window.document.banner;	
	if(f.file.value==""){
	alert("����Ͻ� �������� jpg,png,gif�߿� �ϳ��� �������ּ���.");
	f.file.focus();
	return;
	}
	if(f.name.value==""){
	alert("�����ܸ�Ī�� �Է����ּ���.");
	f.name.focus();
	return;
	}				
	f.submit();
}

function icon_edit(){	
	var f = window.document.banner;	
	if(f.name.value==""){
	alert("�����ܸ�Ī�� �Է����ּ���.");
	f.name.focus();
	return;
	}				
	f.submit();
}
</script>

<div class="container">
	<!--#include file="left.asp"-->
	<div class="content">
		<h2 class="cTit"><span class="bullet"></span>���Ǿ����ܼ���</h2>
<form name="banner" method="post" action="input_ok.asp" enctype="multipart/form-data">
		<table class="ftbl mb50" style="width:100%">
				<colgroup>
				<col style="width:20%" />
				<col style="width:80%" />
				</colgroup>
				<tbody>
					<tr>
						<th>������ �̹���</th>
						<td><input type="file" name="file" size="30" class="inptxt1 w300"></td>
					</tr>
					<tr>
						<th>������ �̸�</th>
						<td><input name="name" type="text" class="inptxt1 w300" id="name"></td>
					</tr>					
				</tbody>
			</table>
</form>

		<div class="rbtn">
			<a href="javascript:icon_input();" class="btn">�����ϱ�</a>
			<a href="list.asp" class="btn trans">��Ϻ���</a>		
		</div>

	</div>
</div>

</body>
</html>
<!-- #include file = "../authpg_2.asp" -->