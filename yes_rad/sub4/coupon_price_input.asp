<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/dbcon.asp" -->
<%
Dim sql,dr,isRecod,isRows,isCols,rs
sql = "select idx,bname from dancate order by ordnum"
set dr = db.execute(sql)
if Not dr.bof or Not dr.Eof then
	isRecod = True
	isRows = split(dr.GetString(2),chr(13))
end if
dr.close
set dr = nothing
%>
<!--#include file="../main/top.asp"-->

<script language="javascript">
function NumKeyOnly(){
	if((event.keyCode<48)||(event.keyCode>57)) event.returnValue=false;
}

function go2Reg(theform){

	var clmn;

	clmn = theform.file;
	if(clmn.value==""){
		alert("��������� �Էµ� ���������� �������ּ���.");
		return;
	}

	theform.submit();
}

function FormatCutterny(number){
	var rValue = "";
	var EnableChar = "0123456789";
	var Chr='';
	var EnableNumber = '';

	for (i=0;i<number.length;i++) {
		Chr = number.charAt(i);
		if (EnableChar.indexOf(Chr) != -1){
			EnableNumber += Chr;
		}
	}

	var ABSNumber = '';
	ABSNumber = EnableNumber;

	if (ABSNumber.length < 4) {			//�ѱ��̰� 3���ϸ� Ż��
		rValue = ABSNumber;
		return rValue;
	}

	var ReverseWords = '';			//ReverseWords : �������� '-'�� ������ ���ڿ�

	for(i=ABSNumber.length;i>=0;i--){
			ReverseWords += ABSNumber.charAt(i);
	}

	rValue = ReverseWords.substring(0, 3);

	var dotCount = ReverseWords.length/3-1;
	for (j=1;j<=dotCount;j++){
		for(i=0;i<ReverseWords.length;i++){
			if (i==j*3)
				rValue+=","+ReverseWords.substring(i, i+3)
		}
	}

	var elseN = ReverseWords.length%3;
	if (elseN!=0){
		rValue+= ","+ReverseWords.substring(ReverseWords.length-elseN,ReverseWords.length)
	}

	ReverseWords = rValue;
	rValue = '';
	for(i=ReverseWords.length;i>=0;i--){
			rValue += ReverseWords.charAt(i);
	}

	return rValue;
}
</script>

<div class="container">
	<!--#include file="left.asp"-->
	<div class="content">
		<h2 class="cTit"><span class="bullet"></span>�����������</h2>

<form name="regfm" action="coupon_price_ok.asp" method="post" enctype="multipart/form-data">
<input type="hidden" name="gu" value="<%=request("gu")%>">
		<table class="ftbl mb50" style="width:100%">
				<colgroup>
				<col style="width:20%" />
				<col style="width:80%" />
				</colgroup>
				<tbody>
					<tr>
						<th>��������</th>
						<td><input name="file" type="file" class="inptxt1" id="file" style="width:350px;" maxlength="50"> <a href="/xls_sample.zip" class="fbtn">�������ϴٿ�</a></td>
					</tr>
					<tr>
						<th>��ȿ�Ⱓ</th>
						<td><input name="end_date" type="text" class="inptxt1 w100" id="end_date" readonly value="<%=Date()%>"></td>
					</tr>
					
				</tbody>
			</table>

		<div class="rbtn">
			<a href="javascript:go2Reg(regfm);" class="btn">�����ϱ�</a>
		</div>

		<div class="caution"><p>���������� xls���Ϸ� ����</p></div>
		<div class="caution"><p>���ٿ� �ϳ��� A ������ȣ , B ���αݾ׼����� �Է�</p></div>
		<div class="caution"><p>��Ʈ�̸��� �� Sheet1�� ������ּ���</p></div>

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
        field: document.getElementById('end_date'),
        firstDay: 1,
		format: "YYYY-MM-DD",
        minDate: new Date('<%=left(date(),4)-10%>-01-01'),
        maxDate: new Date('<%=left(date(),4)+10%>-12-31'),
        yearRange: [<%=left(date(),4)-10%>,<%=left(date(),4)+10%>]
    });
</script>

<!-- #include file = "../authpg_2.asp" -->