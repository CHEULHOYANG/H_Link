<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/dbcon.asp" -->
<%
Dim idx,intpg
Dim gbnS,strPart,strSearch
Dim varPage
Dim sql,dr,isRecod,isRows,isCols,rs
dim icon_count,jj
Dim strnm,strteach,tinfo,intprice,intgigan,catenm,totalnum,categbn,strSajin,inginum,icon,book_idx,sub_title,teach_id,mem_group,ordn,step_check,ca1,ca2,state

idx = Request("idx")
intpg = Request("intpg")
gbnS = Request("gbnS")
strPart = Request("strPart")
strSearch = Request("strSearch")

varPage = "gbnS=" & gbnS & "&strPart=" & strPart & "&strSearch=" & strSearch

sql = "select strnm,strteach,tinfo,intprice,intgigan,catenm=(select bname from dancate where idx=categbn),categbn,totalnum,sajin,inginum,icon,book_idx,sub_title,teach_id,mem_group,ordn,step_check,ca1,ca2,state from lecturTab where idx=" & idx
set dr = db.execute(sql)

If dr.eof Or dr.bof Then

	response.write"<script>"
	response.write"alert('�����Ϳ���!!');"
	response.write"history.back();"
	response.write"</script>"
	response.end

Else

	strnm = dr(0)
	strteach = dr(1)
	tinfo = dr(2)
	intprice = dr(3)
	intgigan = dr(4)
	catenm = dr(5)
	categbn = dr(6)
	totalnum = dr(7)
	strSajin = dr(8)
	inginum = dr(9)
	icon = dr(10)
	book_idx = dr(11)
	sub_title = dr(12)
	teach_id = dr(13)
	mem_group = dr(14)
	ordn = dr(15)
	step_check = dr(16)
	ca1 = dr(17)
	ca2 = dr(18)
	state = dr(19)

dr.close 
End if
%>
<!--#include file="../main/top.asp"-->

<script type="text/javascript" src="/nicedit/nicEdit.js"></script>
<script type="text/javascript">
bkLib.onDomLoaded(function() {
	new nicEditor({fullPanel : true}).panelInstance('tinfo');
});
</script>

<script language="javascript">
function NumKeyOnly(){
	if((event.keyCode<48)||(event.keyCode>57)) event.returnValue=false;
}
function cate_select(){

	var f = window.document.regfm;
	var a1 = f.ca1.value;

	if(a1 == "0"){
		alert("�з��� �������ּ���.");
		_data = "";
		$('#playArea').html(_data);	
		return;
	}

		$.ajax({
			url: "../../xml/dan_cate.asp",
			type:"POST",
			data:{"key":""+a1+""},
			dataType:"text",
			cache:false,
			processData:true,
			success:function(_data){								
				$('#playArea').html(_data);						
			},
			error:function(xhr,textStatus){
			alert("[����]����:"+xhr.status+"                                     ");
			}	
		});	
		
}
function go2Reg(theform){
	var clmn;
	clmn = theform.strnm;
	if(clmn.value==""){
		alert("���¸��� �Է��ϼ���!");
		clmn.focus();
		return;
	}
	if(clmn.value.replace(/ /g,"")==""){
		alert("���¸��� �Է��ϼ���!");
		clmn.select();
		return;
	}

	clmn = theform.ca1;
	if(clmn.value=="0"){
		alert("�з��� �������ּ���!");
		return;
	}

	clmn = theform.strteach;
	if(clmn.value==""){
		alert("������� �Է��ϼ���!");
		clmn.focus();
		return;
	}
	if(clmn.value.replace(/ /g,"")==""){
		alert("������� �Է��ϼ���!");
		clmn.select();
		return;
	}

	clmn = theform.intprice;
	if(clmn.value==""){
		alert("�����Ḧ �Է��ϼ���!");
		clmn.focus();
		return;
	}

	clmn = theform.intgigan;
	if(clmn.value==""){
		alert("�����Ⱓ�� �Է��ϼ���!");
		clmn.focus();
		return;
	}

	clmn = theform.sajin
	if(clmn.value){
		 if(!clmn.value.match(/\.(gif|jpg|png)$/i)) {
		 	alert("������ �̹����� �׸�����(*.gif,*.jpg,*.png)�� ����� �� �ֽ��ϴ�!");
		 	clmn.select();
		 	return;
		 }
	}

	clmn = theform.tinfo;
	clmn.value = nicEditors.findEditor('tinfo').getContent();

	theform.submit();
}

function book_add(idx){

	if (document.regfm.book_idx.value.indexOf(","+idx+"") == -1) {
		document.regfm.book_idx.value = ""+document.regfm.book_idx.value+","+idx+"";
	}
	else
	{	
		var bool = confirm("�̵̹���� ��ǰ�Դϴ�. ��������� �����ϰڽ��ϱ�?");
		if (bool){
			document.regfm.book_idx.value = document.regfm.book_idx.value.replace(","+idx+"","");
		}
	}
	
	document.regfm.bookselected[0].selected = true;
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

function ModChange(obj1,obj2){
	obj1.style.display = obj1.style.display == "none"  ? "block" : "none";
	obj2.style.display = obj2.style.display == "none"  ? "block" : "none";
}

function AllCheck(thisimg,chekID){
	if(chekID){
		var srcAry = thisimg.src.split("/");
		if(srcAry[srcAry.length-1] == "noncheck.gif"){
			thisimg.src = "../rad_img/allcheck.gif";
			isChecked(true,chekID);
		}else{
			thisimg.src = "../rad_img/noncheck.gif";
			isChecked(false,chekID);
		}
	}
}

function isChecked(cmd,chekID){
	var chekLen=chekID.length;
	if(chekLen){
		for (i=0;i<chekLen;i++){
			chekID[i].checked=cmd;
		}
	}
	else{
		chekID.checked=cmd;
	}
}

function delteAll(chkobj){
	if(chkobj){
		var checkgbn = true;
		if(chkobj.length){
			for(i=0;i<chkobj.length;i++){
				if(chkobj[i].checked){
					checkgbn = false;
					break;
				}
			}
		}else{
			if(chkobj.checked){
				checkgbn = false;
			}
		}

		if(checkgbn){
			alert("�����Ͻ� ���Ǹ� �������ּ���!");
			return;
		}

		delok = confirm("üũ�� ���Ǹ� �����մϴ�");
		if(delok){
			var secidAry = "";
			if(chkobj.length){
				for(j=0;j<chkobj.length;j++){
					if(chkobj[j].checked){
						secidAry += chkobj[j].value + "|";
					}
				}
			}
			else{
				if(chkobj.checked){
					secidAry += chkobj.value + "|";
				}
			}

			delSection('<%=idx%>',secidAry);
		}
	}
}
function go2SecNyong(idxnn){
	location.href="sec_mody.asp?idxnn=" + idxnn + "&idx=<%=idx%>&intpg=<%=intpg%>&<%=varPage%>";
}

function delDan(){
	var delok = confirm("�ܰ��� �����Ͻðڽ��ϱ�?\n\n�� �ܰ��� �ش�� ��� ���ǵ� ���� �˴ϴ�.                                                ");
	if(delok){
		location.href="dan_delete.asp?idx=<%=idx%>";
	}
}


function setFreeMove(chekobj,Lidx){	//���ü���
	var freGbn = "0";
	var freMsg = "���ú��⸦ �����մϴ�";
	var freCheck = true;
	
	if(chekobj.checked){
		freGbn = "1";
		freMsg = "���÷�  �����մϴ�."
		freCheck = false
	} 
	
	freok = confirm(freMsg);
	if(freok){
		var params = "key=" + escape(chekobj.value + "|" + freGbn + "|" + Lidx);
		sndReq("sub2xml/sec_free_xml.asp",params,vIewSection,"POST");
	}else{
		chekobj.checked = freCheck;
	}	
}

function setOrder(ordGbn,idxn,ordn,mxn,Lidx){	//ȸ�� ���� ����
	var params;
	var sndvalue;
	var flg = false;
	
	if(ordGbn=="up"){
		if(parseInt(ordn,10) > 1){
			sndvalue = "1|" + idxn + "|" + ordn + "|" + Lidx;
			flg = true;
		}
	}
	else{
		if(parseInt(ordn,10) < parseInt(mxn,10)){
			sndvalue = "2|" + idxn + "|" + ordn + "|" + Lidx;
			flg = true;
		}
	}
	
	if(flg){
			params = "key=" + escape(sndvalue);
			sndReq("sub2xml/sec_order_xml.asp",params,vIewSection,"POST");
	}	
}

function delSection(Lidx,idxAry){		//����
	params = "key=" + escape(Lidx) + "&Sidx=" + escape(idxAry);
	sndReq("sub2xml/sec_del_xml.asp",params,vIewSection,"POST");
	//location.href="sec_del_xml.asp?" + params;
}

function vIewSection(){
	if(objXmlhttp.readyState == 4){
		if(objXmlhttp.status==200){
			var xmlDoc = objXmlhttp.responseXML;
			var objRows = xmlDoc.getElementsByTagName("isrows").item(0);
			var objCols = objRows.getElementsByTagName("iscols");
			var strinHm = objCols.item(0).firstChild.nodeValue;
			alert(strinHm);
			document.getElementById("subPan").innerHTML = strinHm;
		}else{
			alert("��Ʈ�� ���� : �����ڿ��� �����ϼ���!");
		}
	}	
}
</script>

<div class="container">
	<!--#include file="left.asp"-->
	<div class="content">
		<h2 class="cTit"><span class="bullet"></span>�ܰ����°���</h2>

<form name="regfm" action="dan_modfy.asp" enctype="multipart/form-data" method="post">
<input type="hidden" name="idx" value="<%=idx%>">
<input type="hidden" name="intpg" value="<%=intpg%>">
<input type="hidden" name="gbnS" value="<%=gbnS%>">
<input type="hidden" name="strPart" value="<%=strPart%>">
<input type="hidden" name="strSearch" value="<%=strSearch%>">
<input type="hidden" name="strSajin" value="<%=strSajin%>">

<input type="hidden" name="sca1" value="<%=request("ca1")%>">
<input type="hidden" name="sca2" value="<%=request("ca2")%>">

		<table class="ftbl mb50" style="width:100%">
				<colgroup>
				<col style="width:20%" />
				<col style="width:80%" />
				</colgroup>
				<tbody>
					<tr>
						<th>����</th>
						<td><input type="radio"  name="state" value="0" <%If state=0 Then Response.write"checked" End if%> > �ƴϿ�
						  <input type="radio"  name="state" value="1" <%If state=1 Then Response.write"checked" End if%> > ��
                          <span class="stip">* ���¸�Ͽ��� ����� �ֽ��ϴ�.</span></td>
					</tr>
					<tr>
						<th>�������</th>
						<td><input type="radio"  name="step_check" value="0" <%If step_check=0 Then Response.write"checked" End if%> > �ƴϿ�
						  <input type="radio"  name="step_check" value="1" <%If step_check=1 Then Response.write"checked" End if%> > ��
                          <span class="stip">* ���¼��������� �����ϷḦ �ؾ� ���� ���°� ������ �˴ϴ�.</span></td>
					</tr>
					<tr>
						<th>����</th>
						<td><input type="text"  name="ordn" class="inptxt1 w60" value="<%=ordn%>" ></td>
					</tr>
					<tr>
						<th>������û���� ȸ���׷�</th>
						<td><%
sql = "select idx,title from group_mast where gu = 0 "
set rs=db.execute(sql)

if rs.eof or rs.bof then
else
do until rs.eof
%>
<input type="checkbox" name="mem_group" id="mem_group" value="<%=rs(0)%>" <%if instr(mem_group,", "& rs(0) &",") then response.write"checked" end if%> /> <%=rs(1)%>&nbsp;<%
rs.movenext
loop
rs.close
end if
%>
<br /><span class="stip">* üũ�� �ش� �׷쿡 ȸ���鸸 ������û�� �����մϴ�. �׷������ ȸ���������� �����մϴ�.</span></td>
					</tr>
					<tr>
						<th>���¸�</th>
						<td><input type="text"  name="strnm" class="inptxt1 w400"  value="<%=strnm%>"></td>
					</tr>
					<tr>
						<th>��������</th>
						<td><input type="text"  name="sub_title" class="inptxt1 w400"  value="<%=sub_title%>"></td>
					</tr>
					<tr>
						<th>ī�װ�</th>
						<td><select name="ca1" class="seltxt w200" onChange="cate_select();">
  <option value="0">����</option>
<%
sql="select idx,title from dan_category where deep=0 order by ordnum asc,idx desc"
set rs=db.execute(sql)
if rs.eof or rs.bof then
else
do until rs.eof
%>
      <option value="<%=rs(0)%>" <%If ca1 = rs(0) Then response.write"selected" End if%>><%=rs(1)%></option>
<%
rs.movenext
Loop
rs.close
end if
%>
    </select>&nbsp;<span id="playArea"><%If ca1 > 0 then%><select name="ca2" class="seltxt w200">
  <option value="0" <%If ca2 = 0 Then response.write"selected" End if%>>�з��������ϼ���.</option>
<%
sql="select idx,title from dan_category where deep=1 and uidx="& ca1 &" order by ordnum asc,idx desc"
set rs=db.execute(sql)
if rs.eof or rs.bof then
else
do until rs.eof
%>
      <option value="<%=rs(0)%>" <%If ca2 = rs(0) Then response.write"selected" End if%>><%=rs(1)%></option>
<%
rs.movenext
Loop
rs.close
end if
%>
    </select><%End if%></span></td>
					</tr>
					<tr>
						<th>��������</th>
						<td><input type="text"  name="strteach" class="inptxt1 w100" placeholder="�����" value="<%=strteach%>"> / <input  name="teach_id" type="text" class="inptxt1 w100" id="teach_id" placeholder="������̵�" value="<%=teach_id%>" ></td>
					</tr>
					<tr>
						<th>��������</th>
						<td><input type="text"  name="intprice" class="inptxt1 w100" placeholder="������" onKeyPress="NumKeyOnly();" onKeyUp="this.value = FormatCutterny(this.value);" value="<%=formatnumber(intprice,0)%>"> �� / <input type="text"  name="intgigan" class="inptxt1 w100" maxlength="3" onKeyPress="NumKeyOnly();" placeholder="�����Ⱓ" value="<%=intgigan%>"> ��</td>
					</tr>
					<tr>
						<th>���Ǿ�����</th>
						<td><%
				  sql = "select name,icon from icon_mast order by idx desc"
				  set rs=db.execute(sql)
				  
				  if rs.eof or rs.bof then
				  else
				  do until rs.eof%><input name="icon" type="checkbox" id="icon" value="<%=rs(1)%>" <%if instr(icon,", "& rs(1) &",") then response.write"checked" end if%>> <img src="/ahdma/logo/<%=rs(1)%>" align="absmiddle">&nbsp;
                    <%
rs.movenext
loop
rs.close
end if
%></td>
					</tr>
					<tr>
						<th>������ǰ����</th>
						<td><input  name="book_idx" type="text" id="book_idx" readonly class="inptxt1 w400" value="<%=book_idx%>"><p style="height:10px"></p>
						<select name="bookselected" id="bookselected" onChange="book_add(this.value);" class="seltxt w400">
                              <option value="">�������ּ���</option>
                              <% 
							  sql = "select idx,title,price1 from book_mast order by idx desc"
							  set rs=db.execute(sql)
							  
							  if rs.eof or rs.bof then
							  else
							  do until rs.eof %>
                              <option value="<%=rs(0)%>"><%=rs(0)%>. <%=rs(1)%> (<%=FormatNumber(rs(2),0)%>��)</option>
                              <% rs.movenext
							  loop
							  rs.close
								end if %>
                          </select> <span class="stip">* ���� ��ǰ�� 2�� �����Ͻø� ������ �˴ϴ�.</span></td>
					</tr>
					<tr>
						<th>�̹���</th>
						<td><input type="file" name="sajin" class="inptxt1 w200"  >   <span class="stip">* ������� 4:3���·� png,jpg,gif�� ����</span> <%If Len(strSajin) > 0 And strSajin <> "noimg.gif" Then%><p style="height:10px"></p><img src="/ahdma/studimg/<%=strSajin%>" width="150px">&nbsp;<input type='checkbox' name='check_del' id='checkbox' value='1'/> ����<%End if%></td>
					</tr>
					<tr>
						<th>����ǥ��</th>
						<td><input type="checkbox" name="inginum" value="1" <% if inginum = 1 then response.write " checked" %>> �ش� ���Ǹ� ���ο� ǥ���մϴ�</td>
					</tr>
					<tr>
						<th>���ǳ���</th>
						<td><a href="javascript:popenWindow('/nicedit/upimg.asp?box=tinfo','390','290');"><img src="/nicedit/bt1.gif" border="0"></a><a href="javascript:popenWindow('/nicedit/vod.asp?box=tinfo','390','290');"><img src="/nicedit/bt2.gif" border="0"></a><a href="javascript:popenWindow('/nicedit/files.asp?box=tinfo','390','290');"><img src="/nicedit/bt3.gif" border="0"></a><textarea name="tinfo" id="tinfo" rows="2" cols="20" style="width:800px; height:200px;"><%=tinfo%></textarea></td>
					</tr>
				</tbody>
			</table>
</form>

		<div class="rbtn">
			<a href="javascript:go2Reg(regfm);" class="btn">����</a>
			<a href="javascript:delDan();" class="btn">����</a>
			<a href="dan_list.asp?intpg=<%=intpg%>&gbnS=<%=gbnS%>&strPart=<%=strPart%>&strSearch=<%=strSearch%>&ca1=<%=request("ca1")%>&ca2=<%=request("ca2")%>" class="btn trans">��Ϻ���</a>		
		</div>


	</div>
</div>



</body>
</html>
<!-- #include file = "../authpg_2.asp" -->