<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/dbcon.asp" -->
<%
Dim idx,intpg,idxnn
Dim gbnS,varPage
Dim sql,dr
dim sectioname,ordnum,strtime,movlink,flshlink,lecsum,lecsrc,freegbn,movlink1,movlink2,freelink,view_count,view_time,freelink1
Dim video1,video2,video3,video4,video5
dim strnm,mckey


idxnn = Request("idxnn")
idx = Request("idx")
intpg = Request("intpg")
gbnS = Request("gbnS")
varPage = "gbnS=" & gbnS

sql = "select strnm from lecturTab where idx=" & idx
set dr = db.execute(sql)

If dr.eof Or dr.bof Then
	strnm = "������"
Else
	strnm = dr(0)
dr.close
End if

sql = "select strnm,ordnum,strtime,movlink,flshlink,lecsum,lecsrc,freegbn,movlink1,movlink2,freelink,view_count,view_time,freelink1,video1,video2,video3,video4,video5,mckey from sectionTab where idx=" & idxnn
set dr = db.execute(sql)

If dr.eof Or dr.bof Then

	response.write"<script>"
	response.write"alert('�����Ϳ���!!');"
	response.write"history.back();"
	response.write"</script>"
	response.end

Else

	sectioname = dr(0)
	ordnum = dr(1)
	strtime = split(dr(2),":")
	movlink = dr(3)
	flshlink = dr(4)
	lecsum = dr(5)
	lecsrc = dr(6)
	freegbn = dr(7)
	movlink1 = dr(8)
	movlink2 = dr(9)
	freelink = dr(10)
	view_count = dr(11)
	view_time = dr(12)
	freelink1 = dr(13)
	video1 = dr(14)
	video2 = dr(15)
	video3 = dr(16)
	video4 = dr(17)
	video5 = dr(18)
	mckey = dr(19)

dr.close
End if
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
	//	alert("������/�÷���/MP4��ũ �� �ϳ��� �ݵ�� �Է��ϼž� �մϴ�!");
	//	theform.movlink.focus();
	//	return;
	//}


theform.submit();
}

function DelF(chkobj){

	if(chkobj.checked){
		var selectgbn;
		if(chkobj.value == "sum"){
			selectgbn = "���ǿ��� ����";
		}else{
			selectgbn = "���Ǽҽ� ����";
		}

		delok = confirm(selectgbn + "�� �����Ͻðڽ��ϱ�?");
		if(delok){
			location.href="sec_file_del.asp?idx=<%=idx%>&idxnn=<%=idxnn%>&intpg=<%=intpg%>&<%=varPage%>&clmn=" + chkobj.value;
		}
		else{
			chkobj.checked = delok;
		}
	}
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

<form name="regfm" action="sec_mody_ok.asp" method="post" style="display:inline;">
<input type="hidden" name="idx" value="<%=idx%>">
<input type="hidden" name="intpg" value="<%=intpg%>">
<input type="hidden" name="gbnS" value="<%=gbnS%>">
<input type="hidden" name="idxnn" value="<%=idxnn%>">
<input type="hidden" name="strPart" value="<%=request("strPart")%>">
<input type="hidden" name="strSearch" value="<%=request("strSearch")%>">

			<table class="ftbl mb50" style="width:100%">
				<colgroup>
				<col style="width:20%" />
				<col style="width:30%" />
				<col style="width:20%" />
				<col style="width:30%" />
				</colgroup>
				<tbody>
					<tr>
							<th><strong><font color="#000000">���ñ���</font></strong></th>
							<td colspan="3">
							<input type="radio"<% if int(freegbn) = 1 then response.write " checked" %> name="freegbn" value="1"> ���ü���
							<input type="radio"<% if int(freegbn) = 0 then response.write " checked" %> name="freegbn" value="0"> ��������</td>
					</tr>
					<tr>
						<th>��� Ƚ������</th>
						<td><input  name="view_count" type="text" class="inptxt1 w30" id="view_count" onKeyPress="NumKeyOnly();" value="<%=view_count%>"  size="3" >
                            ȸ <span class="stip">* 0 ���Ѿ���</span></td>
						<th>��� �ð�����</th>
						<td><input  name="view_time" type="text" class="inptxt1 w30" id="view_time" onKeyPress="NumKeyOnly();" value="<%=view_time%>"  size="5" > �� <span class="stip">* 0 ���Ѿ���</span></td>
					</tr>
					<tr>
						<th>��������</th>
						<td colspan="3"><input type="text"  name="strnm" class="inptxt1 w400" value="<%=sectioname%>"></td>
					</tr>
					<tr>
						<th>���ǽð�</th>
						<td colspan="3"><input type="text"  name="time1" class="inptxt1 w30" size="3" maxlength="3" onKeyPress="NumKeyOnly();" value="<%=strtime(0)%>"> �� : <input type="text"  name="time2" class="inptxt1 w30" size="3" maxlength="2" onKeyPress="NumKeyOnly();" value="<% if len(strtime(1)) = 0 then response.write "00" else response.write strtime(1) end if%>"> ��</td>
					</tr>

					<tr>
						<th>�ݷ������� �̵��������Ű</th>
						<td colspan="3"><input type="text"  name="mckey" class="inptxt1 w400" value="<%=mckey%>"> <span class="stip">* �ݷ��� �ܼ��� ä�� ������ -> ������ �� �������� Ȯ��</span></td>
					</tr>

					<tr>
						<th><font color='#ff6633'>������ Player1</font><br>(MP4��ũ PC��)</th>
						<td colspan="3"><input type="text"  name="movlink" class="inptxt1" style="width:400px;" value="<%=movlink%>"> <a href="<%=movlink%>" target="_blank" class="fbtn2">�̸�����</a> <a href="../sub1/list.asp" class="fbtn">��뼳���ϱ�</a> <br/><span class="stip">* ��������ü �ּҸ� �־��ּ���.</span></td>
					</tr>		
					<tr>
						<th><font color='#ff6633'>������ Player1</font><br>(MP4��ũ ����Ͽ�)</th>
						<td colspan="3"><input type="text"  name="movlink1" class="inptxt1" style="width:400px;" value="<%=movlink1%>"> <a href="<%=movlink1%>" target="_blank" class="fbtn2">�̸�����</a> <br/><span class="stip">* ��������ü �ּҸ� �־��ּ���.</span></td>
					</tr>

					<tr>
						<th><font color='#cc0000'>������ Player2</font><br>(�ػ� 1080p�� MP4��ũ)</th>
						<td colspan="3"><input type="text"  name="video1" class="inptxt1" style="width:400px;" value="<%=video1%>"> <a href="<%=video1%>" target="_blank" class="fbtn2">�̸�����</a> <a href="../sub1/list.asp" class="fbtn">��뼳���ϱ�</a> <br/><span class="stip">* �ش� �κ��� ������ Player 2������ �ػ󵵺��� �����ϸ� �̻��� ������ Player 1�� �ּҷ� �÷��̾�2���� ���� ����ϰ� �˴ϴ�.</span></td>
					</tr>		
					<tr>
						<th><font color='#cc0000'>������ Player2</font><br>(�ػ� 720p�� MP4��ũ)</th>
						<td colspan="3"><input type="text"  name="video2" class="inptxt1" style="width:400px;" value="<%=video2%>"> <a href="<%=video2%>" target="_blank" class="fbtn2">�̸�����</a></td>
					</tr>		
					<tr>
						<th><font color='#cc0000'>������ Player2</font><br>(�ػ� 540p�� MP4��ũ)</th>
						<td colspan="3"><input type="text"  name="video3" class="inptxt1" style="width:400px;" value="<%=video3%>"> <a href="<%=video3%>" target="_blank" class="fbtn2">�̸�����</a></td>
					</tr>		
					<tr>
						<th><font color='#cc0000'>������ Player2</font><br>(�ػ� 360p�� MP4��ũ)</th>
						<td colspan="3"><input type="text"  name="video4" class="inptxt1" style="width:400px;" value="<%=video4%>"> <a href="<%=video4%>" target="_blank" class="fbtn2">�̸�����</a></td>
					</tr>		
					<tr>
						<th><font color='#cc0000'>������ Player2</font><br>(�ػ� 240p�� MP4��ũ)</th>
						<td colspan="3"><input type="text"  name="video5" class="inptxt1" style="width:400px;" value="<%=video5%>"> <a href="<%=video5%>" target="_blank" class="fbtn2">�̸�����</a></td>
					</tr>		

					<tr>
						<th>�ܺθ�ũ�ҽ�(��)</th>
						<td colspan="3"><textarea name="freelink" rows="5" class="inptxt1" style="width:600px;height:80px"><%=freelink%></textarea>
                            <br /><span class="stip">* ������������ ����930px * ���� 530px�� �����ּ���. embed src �� iframe ������ �ҽ��� �������ּ���.</span></td>
					</tr>
					<tr>
						<th>�ܺθ�ũ�ҽ�(�����)</th>
						<td colspan="3"><textarea name="freelink1" rows="5" class="inptxt1" style="width:600px;height:80px"><%=freelink1%></textarea>
						<br /><span class="stip">* ������������ ���� 100% * ���� 100%�� �����ּ���. embed src �� iframe ������ �ҽ��� �������ּ���.</span></td>
					</tr>
					<tr>
						<th>��������#1(�����ּ�)</th>
						<td colspan="3"><input type="text"  name="lecsum" class="inptxt1" style="width:400px;" value="<%=lecsum%>"> <span class="stip">* ������ ������ ���ε� �Ͻ��� ��ü ��θ� �ۼ����ּ���</span></td>
					</tr>
					<tr>
						<th>��������#2(�����ּ�)</th>
						<td colspan="3"><input type="text"  name="lecsrc" class="inptxt1" style="width:400px;" value="<%=lecsrc%>"> <span class="stip">* ������ ������ ���ε� �Ͻ��� ��ü ��θ� �ۼ����ּ���</span></td>
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