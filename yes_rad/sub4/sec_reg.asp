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
	clmn = theform.strnm;
	if(clmn.value==""){
		alert("���������� �Է����ּ���!");
		clmn.focus();
		return;
	}
	if(clmn.value.replace(/ /g,"")==""){
		alert("���������� �Է����ּ���!");
		clmn.select();
		return;
	}

	var dtgbn;
	clmn = theform.movlink;
	if(clmn.value){
		dtgbn = CheckDot(clmn.value);
		if(!dtgbn.match(/(wmv|mp4)$/i)){
			alert("������������ Ȯ�����ּ���!!\n\n*.mp4 ���ϸ� ��ũ�� �����մϴ�.");
			clmn.select();
			return;
		}
	}
	mlink = clmn.value;

	clmn = theform.movlink1;
	if(clmn.value){
		dtgbn = CheckDot(clmn.value);
		if(!dtgbn.match(/(mp4)$/i)){
			alert("������������ Ȯ�����ּ���!!\n\n*.mp4 ���ϸ� ��ũ�� �����մϴ�.");
			clmn.select();
			return;
		}
	}
	mp4link = clmn.value;

	//if(mlink.replace(/ /g,"") == "" && flink.replace(/ /g,"") == "" && mp4link.replace(/ /g,"") == ""){
	//	alert("������ �����̳� �÷��� ���� �� �ϳ��� �ݵ�� �Է��ϼž� �մϴ�!");
	//	theform.movlink.focus();
	//	return;
	//}

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
		<h2 class="cTit"><span class="bullet"></span>���ǵ��</h2>
<form name="regfm" action="sec_reg_ok.asp" method="post" style="display:inline;">
			  <input type="hidden" name="idx" value="<%=idx%>">
			  <input type="hidden" name="intpg" value="<%=intpg%>">
			  <input type="hidden" name="strPart" value="<%=strPart%>">
			  <input type="hidden" name="gbnS" value="<%=gbnS%>">
			  <input type="hidden" name="strSearch" value="<%=strSearch%>">
			<table class="ftbl mb50" style="width:100%">
				<colgroup>
				<col style="width:20%" />
				<col style="width:30%" />
				<col style="width:20%" />
				<col style="width:30%" />
				</colgroup>
				<tbody>
					<tr>
						<th>��ϱ���</th>
						<td colspan="3"><input name="radio" type="radio" id="radio" onClick="self.location.href='sec_reg.asp?idx=<%=request("idx")%>&intpg=<%=request("intpg")%>&gbnS=<%=request("gbnS")%>&strPart=<%=request("strPart")%>&strSearch=<%=request("strsearch")%>';" value="radio" checked>
�������
<input name="radio" type="radio" id="radio2" value="radio" onClick="self.location.href='sec_reg_auto.asp?idx=<%=request("idx")%>&intpg=<%=request("intpg")%>&gbnS=<%=request("gbnS")%>&strPart=<%=request("strPart")%>&strSearch=<%=request("strsearch")%>';">
�뷮���</td>
					</tr>
					<tr>
						<th>�ݺ� ��ϼ���</th>
						<td colspan="3"><select name="i" id="i" class="seltxt w60">
                            <%for i = 1 to 100%>
						      <option value="<%=i%>"><%=i%></option>
                             <%next%> 
						      </select> <span class="stip">* ������ ���Ǹ� �����Ͻ� ��ŭ �ݺ�����մϴ�.</span></td>
					</tr>
					<tr>
						<th>��� Ƚ������</th>
						<td><input  name="view_count" type="text" class="inptxt1 w30" id="view_count" onKeyPress="NumKeyOnly();" value="0" size="3" >
                            ȸ <span class="stip">* 0 ���Ѿ���</span></td>
						<th>��� �ð�����</th>
						<td><input  name="view_time" type="text" class="inptxt1 w30" id="view_time" onKeyPress="NumKeyOnly();" value="0" size="5" > �� <span class="stip">* 0 ���Ѿ���</span></td>
					</tr>
					<tr>
						<th>��������</th>
						<td colspan="3"><input type="text"  name="strnm" class="inptxt1 w400"></td>
					</tr>
					<tr>
						<th>���ǽð�</th>
						<td colspan="3"><input type="text"  name="time1" class="inptxt1 w30" size="3" maxlength="3" onKeyPress="NumKeyOnly();"> �� : <input type="text"  name="time2" class="inptxt1 w30" size="3" maxlength="2" onKeyPress="NumKeyOnly();"> �� </td>
					</tr>

					<tr>
						<th>�ݷ������� �̵��������Ű</th>
						<td colspan="3"><input type="text"  name="mckey" class="inptxt1 w400"> <span class="stip">* �ݷ��� �ܼ��� ä�� ������ -> ������ �� �������� Ȯ��</span></td>
					</tr>

					<tr>
						<th><font color='#ff6633'>������ Player1</font><br>(MP4��ũ PC��)</th>
						<td colspan="3"><input type="text"  name="movlink" class="inptxt1" style="width:400px;" > <a href="../sub1/list.asp" class="fbtn">��뼳���ϱ�</a> <span class="stip">* ��������ü �ּҸ� �־��ּ���.</span></td>
					</tr>		
					<tr>
						<th><font color='#ff6633'>������ Player1</font><br>(MP4��ũ ����Ͽ�)</th>
						<td colspan="3"><input type="text"  name="movlink1" class="inptxt1" style="width:400px;" > <span class="stip">* ��������ü �ּҸ� �־��ּ���.</span></td>
					</tr>


					<tr>
						<th><font color='#cc0000'>������ Player2</font><br>(�ػ� 1080p�� MP4��ũ)</th>
						<td colspan="3"><input type="text"  name="video1" class="inptxt1" style="width:400px;" > <a href="../sub1/list.asp" class="fbtn">��뼳���ϱ�</a> 
						<br/><span class="stip">* �ش� �κ��� ������ Player 2������ �ػ󵵺��� �����ϸ� �̻��� ������ Player 1�� �ּҷ� �÷��̾�2���� ���� ����ϰ� �˴ϴ�.</span></td>
					</tr>		
					<tr>
						<th><font color='#cc0000'>������ Player2</font><br>(�ػ� 720p�� MP4��ũ)</th>
						<td colspan="3"><input type="text"  name="video2" class="inptxt1" style="width:400px;" > <span class="stip">* ��������ü �ּҸ� �־��ּ���.</span></td>
					</tr>		
					<tr>
						<th><font color='#cc0000'>������ Player2</font><br>(�ػ� 540p�� MP4��ũ)</th>
						<td colspan="3"><input type="text"  name="video3" class="inptxt1" style="width:400px;" > <span class="stip">* ��������ü �ּҸ� �־��ּ���.</span></td>
					</tr>		
					<tr>
						<th><font color='#cc0000'>������ Player2</font><br>(�ػ� 360p�� MP4��ũ)</th>
						<td colspan="3"><input type="text"  name="video4" class="inptxt1" style="width:400px;" > <span class="stip">* ��������ü �ּҸ� �־��ּ���.</span></td>
					</tr>		
					<tr>
						<th><font color='#cc0000'>������ Player2</font><br>(�ػ� 240p�� MP4��ũ)</th>
						<td colspan="3"><input type="text"  name="video5" class="inptxt1" style="width:400px;" > <span class="stip">* ��������ü �ּҸ� �־��ּ���.</span></td>
					</tr>		

					<tr>
						<th>�ܺθ�ũ�ҽ�(��)</th>
						<td colspan="3"><textarea name="freelink" rows="5" class="inptxt1" style="width:470px;height:50px"></textarea>
                            <span class="stip">* ������������ ����930px * ���� 530px�� �����ּ���</span></td>
					</tr>
					<tr>
						<th>�ܺθ�ũ�ҽ�(�����)</th>
						<td colspan="3"><textarea name="freelink1" rows="5" class="inptxt1" style="width:470px;height:50px"></textarea>
						<span class="stip">* ������������ ���� 100% * ���� 100%�� �����ּ���</span></td>
					</tr>
					<tr>
						<th>��������#1(�����ּ�)</th>
						<td colspan="3"><input type="text"  name="lecsum" class="inptxt1" style="width:400px;"> <span class="stip">* ������ ������ ���ε� �Ͻ��� ��ü ��θ� �ۼ����ּ���</span></td>
					</tr>
					<tr>
						<th>��������#2(�����ּ�)</th>
						<td colspan="3"><input type="text"  name="lecsrc" class="inptxt1" style="width:400px;"> <span class="stip">* ������ ������ ���ε� �Ͻ��� ��ü ��θ� �ۼ����ּ���</span></td>
					</tr>
				</tbody>
			</table>
</form>

		<div class="rbtn">
			<a href="javascript:go2RegFM(regfm);" class="btn">�����ϱ�</a>
			<a href="sec_list.asp?idx=<%=idx%>&intpg=<%=intpg%>&<%=varPage%>" class="btn trans">��Ϻ���</a>		
		</div>

	</div>
</div>


</body>
</html>
<!-- #include file = "../authpg_2.asp" -->