<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/dbcon.asp" -->
<%
Dim idx,intpg
Dim strPart,varPage,strSearch,gbnS
Dim sql,dr,i

idx = Request("idx")
intpg = Request("intpg")
strPart = Request("strPart")
strSearch = Request("strSearch")
gbnS = Request("gbnS")
varPage = "strPart=" & strPart & "&strSearch=" & strSearch & "&gbnS=" & gbnS

sql = "select strnm from lecturTab where idx=" & idx
set dr = db.execute(sql)
dim strnm
strnm = dr(0)
dr.close
%>
<!--#include file="../main/top.asp"-->

<script language="javascript">
function NumKeyOnly(){
	if((event.keyCode<48)||(event.keyCode>57)) event.returnValue=false;
}

function go2RegFM(theform){

	var clmn;
	
	clmn = theform.file;
	if(clmn.value==""){
		alert("�뷮��������� �������ּ���!");
		clmn.focus();
		return;
	}

theform.submit();
}

function CheckDot(str){
	var tempAry = str.split(".");
	var arynum = tempAry.length - 1;

	var retrunValue = "none";

	if(arynum > 0){
		retrunValue = tempAry[arynum];
	}
return retrunValue;
}
</script>

<div class="container">
	<!--#include file="left.asp"-->
	<div class="content">
		<h2 class="cTit"><span class="bullet"></span>�뷮 ���ǵ��</h2>
<form name="regfm" action="sec_reg_auto_ok.asp" method="post" enctype="multipart/form-data">
			  <input type="hidden" name="idx" value="<%=idx%>">
			  <input type="hidden" name="intpg" value="<%=intpg%>">
			  <input type="hidden" name="strPart" value="<%=strPart%>">
			  <input type="hidden" name="gbnS" value="<%=gbnS%>">
			  <input type="hidden" name="strSearch" value="<%=strSearch%>">
		<table class="ftbl mb50" style="width:100%">
				<colgroup>
				<col style="width:20%" />
				<col style="width:80%" />
				</colgroup>
				<tbody>
					<tr>
						<th>��ϱ���</th>
						<td><input type="radio" name="radio" id="radio" value="radio" onClick="self.location.href='sec_reg.asp?idx=<%=request("idx")%>&intpg=<%=request("intpg")%>&gbnS=<%=request("gbnS")%>&strPart=<%=request("strPart")%>&strSearch=<%=request("strsearch")%>';">
						    �������
						    <input name="radio" type="radio" id="radio2" value="radio" checked onClick="self.location.href='sec_reg_auto.asp?idx=<%=request("idx")%>&intpg=<%=request("intpg")%>&gbnS=<%=request("gbnS")%>&strPart=<%=request("strPart")%>&strSearch=<%=request("strsearch")%>';"> 
						    �뷮���</td>
					</tr>
					<tr>
						<th>��������</th>
						<td><input name="file" type="file" class="inptxt1 w300" id="file" > <a href="/xls_sample.zip" target="_blank" class="fbtn">�������ϴٿ�ε�</a></td>
					</tr>
				</tbody>
			</table>
</form>

		<div class="rbtn">
			<a href="javascript:go2RegFM(regfm);" class="btn">����ϱ�</a>
			<a href="sec_list.asp?idx=<%=idx%>&intpg=<%=intpg%>&<%=varPage%>" class="btn trans">��Ϻ���</a>		
		</div>

	</div>
</div>


</body>
</html>
<!-- #include file = "../authpg_2.asp" -->