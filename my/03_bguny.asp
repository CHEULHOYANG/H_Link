<!-- #include file="../include/set_loginfo.asp" -->
<% if isUsr then %>
<!-- #include file="../include/dbcon.asp" -->
<%
Dim nowPage : nowPage = Request("URL")
Dim sPattern : sPattern = "[<][^>]*[>]"

Public Function RegExpReplace(byval Patrn,byval  TrgtStr,byval RplcStr)
	Dim ObjRegExp
	On Error Resume Next
	Set ObjRegExp = New RegExp
	ObjRegExp.Pattern = Patrn
	ObjRegExp.Global = True
	ObjRegExp.IgnoreCase = True
	RegExpReplace = ObjRegExp.Replace(TrgtStr, RplcStr)
	Set ObjRegExp = Nothing
End Function

Function cutStr(str, cutLen)
	Dim strLen, strByte, strCut, strRes, char, i
	strLen = 0
	strByte = 0
	strLen = Len(str)
	for i = 1 to strLen
		char = ""
		strCut = Mid(str, i, 1)
		char = Asc(strCut)
		char = Left(char, 1)
		if char = "-" then
			strByte = strByte + 2
		else
			strByte = strByte + 1
		end if
		if cutLen < strByte then
			strRes = strRes & ".."
			exit for
		else
			strRes = strRes & strCut
		end if
	next
	cutStr = strRes
End Function
%>
<!-- #include file="../include/head1.asp" -->

<script language="javascript">
function imgBrdStyle(flg,imobj){
	if(flg){
		imobj.style.border="solid 2px #FF6600";
	}
	else{
		imobj.style.border="none";
	}
}

function AryDanBuy(n){

		var chkAry = document.fm["II"];
		var chkAry1 = document.fm["JJ"];		
		var strbxt = "";
		var strbxt1 = "";
		var ckS=0;

		var ii_count = document.fm.ii_count.value;
		var jj_count = document.fm.jj_count.value;

		var tocheck = parseInt(ii_count) + parseInt(jj_count);

		//���°� 0�̸�
		if (parseInt(ii_count) == 0){
			ckS=0;
		}
		else if(parseInt(ii_count) == 1)
		{
			if(document.fm.II.checked == false) ckS++;
		}
		else
		{
				for(var i=0; i < chkAry.length; i++){
					if(fm["II"][i].checked == true) {
						break;
					}
					else {
					ckS++;
					}
				}			
		}
		//���簡 0�̸�
		if (parseInt(jj_count) == 0){
			ckS = ckS +0;
		}
		else if(parseInt(jj_count) == 1)
		{
			if(document.fm.JJ.checked == false) ckS++;
		}
		else
		{
				for(var i=0; i < chkAry1.length; i++){
					if(fm["JJ"][i].checked == true) {
						break;
					}
					else {
					ckS++;
					}
				}			
		}

		if(ckS==tocheck){
			alert(' �����Ͻ� ��ǰ�� �������ּ���!!');
			return;
		}

		if(parseInt(ii_count) > 0){
			if(parseInt(ii_count) == 1){
				if(document.fm.II.checked == true) strbxt += document.fm.II.value + ",";
			}
			else
			{
				for(var i=0; i < chkAry.length; i++){
					if(fm["II"][i].checked == true) strbxt += chkAry[i].value + ",";
				}
			}
		}

		if(parseInt(jj_count) > 0){
			if(parseInt(jj_count) == 1){
				if(document.fm.JJ.checked == true) strbxt1 += document.fm.JJ.value + ",";
			}
			else
			{
				for(var i=0; i < chkAry1.length; i++){
					if(fm["JJ"][i].checked == true) strbxt1 += chkAry1[i].value + ",";
				}
			}
		}

		var strbxtLen = strbxt.split(",");
		if(strbxtLen.length - 1 > 10){
			alert("�ܰ� ������û�� �ִ� 10�� ��������� ��û�Ͻ� �� �ֽ��ϴ�");
			return;
		}
		

		var params = "key="+encodeURIComponent(strbxt)+"&key1="+encodeURIComponent(strbxt1);
		sndReq("../study/danbuyxml.asp",params,setBuy,"POST");
		//self.location.href='danbuyxml.asp?'+params;
}

function setBuy(){
	if(objXmlhttp.readyState == 4){
		if(objXmlhttp.status==200){
			var xmlDoc = objXmlhttp.responseXML;
			var obj = xmlDoc.getElementsByTagName("isrows");
			var flg =eval(obj[0].getAttribute("flg"));
			var bygbn = obj[0].getAttribute("errgbn");

			if(flg){
				alert("���� �߻� : �α������� �ʾҰų�, ��Ʈ������");
			}else{

				if(parseInt(bygbn,10) > 0){
					alert("�����̾�  ���Ǹ� �����ϰ� �����Ƿ� �ܰ� ���Ǹ� �����Ͻ� �ʿ䰡 �����ϴ�!");
					return;
				}
				document.fm.action='../elpay/pay_dan.asp';
				document.fm.submit();
				//location.href="../elpay/pay_dan.asp";
			}

		}else{
			alert("��Ʈ�� ���� : �����ڿ��� �����ϼ���!");
		}
	}
}

function go2Mst(idxn){
		var params = "key=" + encodeURIComponent(idxn);
		sndReq("../study/packagebuyxml.asp",params,setMstBuy,"POST");
}

function setMstBuy(){
	if(objXmlhttp.readyState == 4){
		if(objXmlhttp.status==200){
			var xmlDoc = objXmlhttp.responseXML;
			var obj = xmlDoc.getElementsByTagName("isrows");
			var flg =eval(obj[0].getAttribute("flg"));
			var bygbn = obj[0].getAttribute("errgbn");
			bygbn = parseInt(bygbn,10);

			if(flg && bygbn == 3 ){
				location.href="../elpay/pay_mst.asp";
			}else{
				var strMsg = "";
				switch(bygbn){
					case 0:
						strMsg = "Error : �α��� ���� �ʾҰų�, ��Ʈ������";
						break;
					case 1:
						strMsg = "�����̾��� �����ϰ� �����Ƿ� �������Ǹ� �����Ͻ� �ʿ�����ϴ�!";
						break;
					case 2:
						strMsg = "���� ���� ���� �����̰ų� �Աݴ������ �����Դϴ�!";
						break;
				}
				alert(strMsg);
			}
		}else{
			alert("��Ʈ�� ���� : �����ڿ��� �����ϼ���!");
		}
	}
}

function check_del(theForm){

		var chkAry = document.fm["II"];
		var chkAry1 = document.fm["JJ"];		
		var strbxt = "";
		var strbxt1 = "";
		var ckS=0;

		var ii_count = document.fm.ii_count.value;
		var jj_count = document.fm.jj_count.value;

		var tocheck = parseInt(ii_count) + parseInt(jj_count);

		//���°� 0�̸�
		if (parseInt(ii_count) == 0){
			ckS=0;
		}
		else if(parseInt(ii_count) == 1)
		{
			if(document.fm.II.checked == false) ckS++;
		}
		else
		{
				for(var i=0; i < chkAry.length; i++){
					if(fm["II"][i].checked == true) {
						break;
					}
					else {
					ckS++;
					}
				}			
		}
		//���簡 0�̸�
		if (parseInt(jj_count) == 0){
			ckS = ckS +0;
		}
		else if(parseInt(jj_count) == 1)
		{
			if(document.fm.JJ.checked == false) ckS++;
		}
		else
		{
				for(var i=0; i < chkAry1.length; i++){
					if(fm["JJ"][i].checked == true) {
						break;
					}
					else {
					ckS++;
					}
				}			
		}

		if(ckS==tocheck){
			alert(' �����Ͻ� ��ǰ�� �������ּ���!!');
			return;
		}

		var bool = confirm("�����Ͻðڽ��ϱ�?");
		if (bool){
			document.fm.action="wishdel.asp"
			document.fm.submit();
		}	
} 



function go2Mst(ctgbn,idxn){
		var params = "key=" + encodeURIComponent(idxn);
		sndReq("../study/packagebuyxml.asp",params,setMstBuy,"POST");
}

function setMstBuy(){
	if(objXmlhttp.readyState == 4){
		if(objXmlhttp.status==200){
			var xmlDoc = objXmlhttp.responseXML;
			var obj = xmlDoc.getElementsByTagName("isrows");
			var flg =eval(obj[0].getAttribute("flg"));
			var bygbn = obj[0].getAttribute("errgbn");
			bygbn = parseInt(bygbn,10);

			if(flg && bygbn == 3 ){
				location.href="../elpay/pay_mst.asp";
			}else{
				var strMsg = "";
				switch(bygbn){
					case 0:
						strMsg = "Error : �α��� ���� �ʾҰų�, ��Ʈ������";
						break;
					case 1:
						strMsg = "�����̾��� �����ϰ� �����Ƿ� �������¸� �����Ͻ� �ʿ�����ϴ�!";
						break;
					case 2:
						strMsg = "���� ���� ���� �����̰ų� �Աݴ������ �����Դϴ�!";
						break;
				}
				alert(strMsg);
			}
		}else{
			alert("��Ʈ�� ���� : �����ڿ��� �����ϼ���!");
		}
	}
}

function Mstdel(idx){
		var bool = confirm("������ ��ٱ��Ͽ��� �����Ͻðڽ��ϱ�?");
		if (bool){
			self.location.href="wishdel_mst.asp?idx="+idx+"";
		}	
}
</script>

<!-- #include file="../include/top.asp" -->

<div class="smain">    
	<!-- #include file="left.asp" -->
    <div class="content">
    	<div class="cont_tit">
        	<h3>��ٱ���</h3>
        </div>
        <div class="scont">

<form name="fm" method="post">
				<table class="btbl mb80" style="width:830px">
					<colgroup>
						<col style="width:15%" />
						<col style="width:10%" />
						<col style="width:45%" />						
						<col style="width:10%" />
						<col style="width:15%" />
					</colgroup>
					<thead>
						<tr>
							<th>����</th>								
							<th>����</th>
							<th>����/����</th>
							<th>����</th>
							<th>�ݾ�</th>		
						</tr>				
					</thead>
					<tbody>
<%
Dim rs,rs1,bc,ba

ba = 0
bc = 0

sql = "select idx,buygbn,tabidx from wish_list where userid='" & str_User_ID & "' and buygbn = 1 order by regdate desc"
Set rs=db.execute(sql)

If rs.eof Or rs.bof Then
Else
Do Until rs.eof


If rs(1) = 1 Then
	sql = "select strnm,intprice,gbn from lectmast where idx = "& rs(2)
End If
If rs(1) = 2 Then
	sql = "select strnm,intprice,categbn from lecturtab where idx = "& rs(2)
End If
If rs(1) = 3 Then
	sql = "select title,price1 from book_mast where idx = "& rs(2)
End If
	Set rs1 = db.execute(sql)

	If rs1.eof Or rs1.bof Then
	else
%>
				<tr>
					<td><%If rs(1) = 1 Then%><a href="javascript:Mstdel('<%=rs(0)%>');" class="mmmini">����</a> <a href="javascript:go2Mst('<%=rs1(2)%>','<%=rs(2)%>');" class="mmmini">����</span><%End if%><%If rs(1) = 3 Then%><%bc = bc + 1%><input type="checkbox" name="JJ" value="<%=rs(2)%>"><%End if%><%If rs(1)=2 then%><%ba = ba + 1%><input type="checkbox" name="II" value="<%=rs(2)%>"><%End if%></td>
					<td><%If rs(1) = 1 Then response.write"����" End if%><%If rs(1) = 2 Then response.write"�ܰ�" End if%><%If rs(1) = 3 Then response.write"����" End if%></td>
					<td class="tl"><a href="<%If rs(1) = 1 Then response.write"../study/class_view.asp?categbn="& rs1(2) &"&idx="& rs(2) &"" End if%><%If rs(1) = 2 Then response.write"../study/dan_view.asp?idx="& rs(2) &"" End if%><%If rs(1) = 3 Then response.write"../book/content.asp?idx="& rs(2) &"" End if%>" target="_blank"><%=rs1(0)%></a></td>					
					<td><%If rs(1) = 3 Then%><select name="gcount<%=rs(2)%>" id="gcount<%=rs(2)%>" class="seltxt3 w50">
  <option value="1">1</option>
  <option value="2">2</option>
  <option value="3">3</option>
  <option value="4">4</option>
  <option value="5">5</option>
  <option value="6">6</option>
  <option value="7">7</option>
  <option value="8">8</option>
  <option value="9">9</option>
  <option value="10">10</option>
</select><%else%>1<%End if%></td>
					<td><strong class="fr"><%=formatnumber(rs1(1),0)%></strong>��</td>
				</tr>
<%
	rs1.close
	End If
	
rs.movenext
Loop
rs.close
End if

ba = 0
bc = 0

sql = "select idx,buygbn,tabidx from wish_list where userid='" & str_User_ID & "' and buygbn > 1 order by regdate desc"
Set rs=db.execute(sql)

If rs.eof Or rs.bof Then
Else
Do Until rs.eof


If rs(1) = 1 Then
	sql = "select strnm,intprice,gbn from lectmast where idx = "& rs(2)
End If
If rs(1) = 2 Then
	sql = "select strnm,intprice,categbn from lecturtab where idx = "& rs(2)
End If
If rs(1) = 3 Then
	sql = "select title,price1 from book_mast where idx = "& rs(2)
End If
	Set rs1 = db.execute(sql)

	If rs1.eof Or rs1.bof Then
	else
%>
				<tr>
					<td><%If rs(1) = 3 Then%><%bc = bc + 1%><input type="checkbox" name="JJ" value="<%=rs(2)%>"><%End if%><%If rs(1)=2 then%><%ba = ba + 1%><input type="checkbox" name="II" value="<%=rs(2)%>"><%End if%></td>
					<td><%If rs(1) = 1 Then response.write"����" End if%><%If rs(1) = 2 Then response.write"�ܰ�" End if%><%If rs(1) = 3 Then response.write"����" End if%></td>
					<td class="tl"><a href="<%If rs(1) = 1 Then response.write"../study/class_view.asp?categbn="& rs1(2) &"&idx="& rs(2) &"" End if%><%If rs(1) = 2 Then response.write"../study/dan_view.asp?idx="& rs(2) &"" End if%><%If rs(1) = 3 Then response.write"../book/content.asp?idx="& rs(2) &"" End if%>" target="_blank"><%=rs1(0)%></a></td>					
					<td><%If rs(1) = 3 Then%><select name="gcount<%=rs(2)%>" id="gcount<%=rs(2)%>" class="seltxt3 w50">
  <option value="1">1</option>
  <option value="2">2</option>
  <option value="3">3</option>
  <option value="4">4</option>
  <option value="5">5</option>
  <option value="6">6</option>
  <option value="7">7</option>
  <option value="8">8</option>
  <option value="9">9</option>
  <option value="10">10</option>
</select><%else%>1<%End if%></td>
					<td><strong class="fr"><%=formatnumber(rs1(1),0)%></strong>��</td>
				</tr>
<%
	rs1.close
	End If
	
rs.movenext
Loop
rs.close
End if
%>
					</tbody>
				</table>
<input type="hidden" name="ii_count" value="<%=ba%>">
<input type="hidden" name="jj_count" value="<%=bc%>">
</form>

			<div class="rbtn">
				<a href="javascript:check_del(document.frmlist);" class="mbtn">����</a><a href="javascript:AryDanBuy(<%=bc%>);" class="mbtn red">���ð���</a>
			</div>

        </div>
    </div>
</div>

<!-- #include file="../include/bottom.asp" -->
<% else %><!-- #include file = "../include/false_pg.asp" -->
<% end if %>