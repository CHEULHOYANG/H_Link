<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/dbcon.asp" -->
<!--#include file="../main/top.asp"-->

<script language="javascript">
function go2BannerReg(){
	var clmn;
	var f = document.fm;
	clmn = f.bangbn;
	 var chked = true;
	 for(i=0;i<clmn.length;i++){
	 	if(clmn[i].checked){
	 		chked = false;
	 		break;
	 	}
	 }

	 if(chked){
	 	alert("�����ġ�� �������ּ���!");
	 	return;
	 }

	clmn = document.all.keygbn;
	 if(!clmn.value){
		alert("����� �������� �������ּ���!");
		return;
	}

	clmn = f.fileb;
	 if(!clmn.value){
	 	alert("�̹��������� ÷�� ���ּ���!");
	 	return;
	 }

	 if(!clmn.value.match(/\.(gif|jpg|swf|png)$/i)){
	 	alert("��������� �÷���(swf),�̹���(gif,jpg,png) ���ϸ� ����Ͻ� �� �ֽ��ϴ�.");
	 	clmn.select();
	 	return;
	 }
	 fm.submit();
}

function thisAreaView(){
	var args = thisAreaView.arguments;
	var cheknum = parseInt(args[0].value,10);

	var obj1
	obj1 = document.all.applyBan;
	obj2 = document.all.bstsize;

	var inHtm = "";
	inHtm +="";

	switch(cheknum){
		case 1:
			inHtm +="<input name=\"areagbn\" type=\"radio\" value=\"010\" onclick=\"areaRidoIn(this);\"> ����#1(������)&nbsp;&nbsp;";
			inHtm +="<input name=\"areagbn\" type=\"radio\" value=\"011\" onclick=\"areaRidoIn(this);\"> ����#2(1��)&nbsp;&nbsp;";
			inHtm +="<input name=\"areagbn\" type=\"radio\" value=\"012\" onclick=\"areaRidoIn(this);\"> ����#3(1��)&nbsp;&nbsp;";
			inHtm +="<input name=\"areagbn\" type=\"radio\" value=\"013\" onclick=\"areaRidoIn(this);\"> �ΰ������(1��)&nbsp;&nbsp;";
			document.all.keygbn.value="";
			break;
		case 2:
			inHtm +="<input name=\"areagbn\" type=\"radio\" value=\"041\" onclick=\"areaRidoIn(this);\"> ���ǽǿ���&nbsp;&nbsp;";
			inHtm +="<input name=\"areagbn\" type=\"radio\" value=\"042\" onclick=\"areaRidoIn(this);\"> �п��Ұ�����&nbsp;&nbsp;";
			inHtm +="<input name=\"areagbn\" type=\"radio\" value=\"043\" onclick=\"areaRidoIn(this);\"> �ڷ�ǿ���&nbsp;&nbsp;";
			inHtm +="<input name=\"areagbn\" type=\"radio\" value=\"044\" onclick=\"areaRidoIn(this);\"> Ŀ�´�Ƽ����&nbsp;&nbsp;";
			inHtm +="<input name=\"areagbn\" type=\"radio\" value=\"045\" onclick=\"areaRidoIn(this);\"> �����Ϳ���&nbsp;&nbsp;";
			inHtm +="<input name=\"areagbn\" type=\"radio\" value=\"046\" onclick=\"areaRidoIn(this);\"> ��������������&nbsp;&nbsp;";
			inHtm +="<input name=\"areagbn\" type=\"radio\" value=\"047\" onclick=\"areaRidoIn(this);\"> �׽�Ʈ����&nbsp;&nbsp;";
			inHtm +="<input name=\"areagbn\" type=\"radio\" value=\"048\" onclick=\"areaRidoIn(this);\"> �����Կ���&nbsp;&nbsp;";
			inHtm +="<input name=\"areagbn\" type=\"radio\" value=\"061\" onclick=\"areaRidoIn(this);\"> ����Ұ�����&nbsp;&nbsp;";
			document.all.keygbn.value="";
			break;
	}
	inHtm +="";

	obj1.innerHTML = inHtm;
	obj2.innerHTML = "";
	document.all.key.value=cheknum;
}

function areaRidoIn(){
	var argss = areaRidoIn.arguments;
	var inSize = "";
	var chekedvalue = argss[0].value;
	//document.fm.areagbn.value = chekedvalue;
	document.all.keygbn.value=chekedvalue;

	var inSize = "";
	obj2 = document.all.bstsize;

	switch(chekedvalue){
		case "010":
			inSize = "width = 1080 , height = 380";
			break;
		case "011":
			inSize = "width = 190 , height = 300";
			break;
		case "012":
			inSize = "width = 190 , height = 300";
			break;
		case "013":
			inSize = "width = 260 , height = 70";
			break;

		case "041":
			inSize = "width = 200";
			break;	
		case "042":
			inSize = "width = 200";
			break;
		case "043":
			inSize = "width = 200";
			break;
		case "044":
			inSize = "width = 200";
			break;
		case "045":
			inSize = "width = 200";
			break;
		case "046":
			inSize = "width = 200";
			break;
		case "047":
			inSize = "width = 200";
			break;
		case "048":
			inSize = "width = 200";
			break;

		case "051":
			inSize = "width = 780";
			break;	
		case "052":
			inSize = "width = 780";
			break;
		case "053":
			inSize = "width = 780";
			break;
		case "054":
			inSize = "width = 780";
			break;
		case "055":
			inSize = "width = 780";
			break;
		case "056":
			inSize = "width = 780";
			break;
		case "057":
			inSize = "width = 780";
			break;
		case "058":
			inSize = "width = 780";
			break;
		case "060":
			inSize = "width = 780";
			break;
			
		default:
			inSize = "width = 285 , height = 255";
			break;
	}

	obj2.innerHTML = inSize;
}
</script>
</head>

<input type="hidden" name="key">
<input type="hidden" name="keygbn">

<div class="container">
	<!--#include file="left.asp"-->
	<div class="content">
		<h2 class="cTit"><span class="bullet"></span>��ʼ���</h2>

<form name="fm" method="post" action="banner_write_ok.asp" enctype="multipart/form-data">
<input type="hidden" name="upgbn" value="0">
		<table class="ftbl mb50" style="width:100%">
				<colgroup>
				<col style="width:20%" />
				<col style="width:80%" />
				</colgroup>
				<tbody>
					<tr>
						<th>�����ġ</th>
						<td><input name="bangbn" type="radio" value="1" onClick="thisAreaView(this);"> ����&nbsp;&nbsp;&nbsp;<input name="bangbn" type="radio" value="2" onClick="thisAreaView(this);"> ����</td>
					</tr>
					<tr>
						<th>������ġ</th>
						<td ID="applyBan"></td>
					</tr>
					<tr>
						<th>�������</th>
						<td><input type="file" name="fileb" size="30" class="inptxt1 w400" > <p class="stip">���������� : <span ID="bstsize">&nbsp;</span></p></td>
					</tr>
					<tr>
						<th>�����ּ�</th>
						<td><input type="text" name="banner_url" class="inptxt1 w400" ></td>
					</tr>
					<tr>
						<th>��ʼ���</th>
						<td><input type="text" name="title" class="inptxt1 w400"></td>
					</tr>
					<tr>
						<th>��ʹ����÷�</th>
						<td><input type="text" name="bgcolor" class="inptxt1 w100"> <span class="stip">* �����÷��� �ʿ��Ұ�� ��� �������Ʈ (https://html-color-codes.info/Korean/)</span></td>
					</tr>		
					<tr>
						<th>��ʼ���</th>
						<td><input name="ordnum" type="text" class="inptxt1 w100" id="ordnum" value="0" > <span class="stip">0�� �� ���� �����ϴ�. </td>
					</tr>	
					<tr>
						<th>���Ÿ��</th>
						<td><input name="target" type="radio" value="_self" checked> 
����â&nbsp;&nbsp;&nbsp;
  <input type="radio" name="target" value="_blank"> 
��â</td>
					</tr>						
				</tbody>
			</table>
</form>


		<div class="rbtn">
			<a href="javascript:go2BannerReg()" class="btn trans">�����ϱ�</a>		
			<a href="banner_list.asp" class="btn">�������</a>
		</div>

	</div>
</div>

</body>
</html>
<!-- #include file = "../authpg_2.asp" -->