<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/dbcon.asp" -->
<%
Dim sql,dr,isRecod,isRows,isCols,rs

''TempAry Table �ʱ�ȭ
db.execute("delete TempAry")
%>
<!--#include file="../main/top.asp"-->

<script type="text/javascript" src="/nicedit/nicEdit.js"></script>
<script type="text/javascript">
bkLib.onDomLoaded(function() {
	new nicEditor({fullPanel : true}).panelInstance('strheader');
});
</script>

<script language="javascript">
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

function NumKeyOnly(){
	if((event.keyCode<48)||(event.keyCode>57)) event.returnValue=false;
}

function go2Reg(theform){
	var clmn;
	clmn = theform.strnm;
	if(clmn.value==""){
		alert("�������� �Է��ϼ���!");
		clmn.focus();
		return;
	}
	if(clmn.value.replace(/ /g,"")==""){
		alert("�������� �Է��ϼ���!");
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
		 if(!clmn.value.match(/\.(gif|jpg|bmp)$/i)) {
		 	alert("Ÿ��Ʋ �̹����� �׸�����(*.gif,*.jpg,*.bmp)�� ����� �� �ֽ��ϴ�!");
		 	clmn.select();
		 	return;
		 }

	}

	clmn = theform.gbn;
	if(clmn.value==""){
		alert("ī�װ��� �����ϼ���!");
		clmn.focus();
		return;
	}

	clmn = theform.strheader;
	clmn.value = nicEditors.findEditor('strheader').getContent();

	clmn = theform.projectLectures;
	for(i=0; i<clmn.options.length; i++){
		clmn.options[i].selected=true;
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

function addItem(theform){
	var leftobj = theform.lectureList;
	var rightobj = theform.projectLectures;
	var flg = leftobj.length;
	if(flg < 1){
		alert("��ϵ� �ܰ����°� ���⶧���� Ŀ��ŧ���� �߰��� �� �����ϴ�.");
	}
	else{
		var selectstr = "";
		for(ii=0;ii<leftobj.length;ii++){
			if(leftobj.options[ii].selected){
				selectstr += leftobj.options[ii].value + ",";
			}
		}

		if(selectstr==""){
			alert("Ŀ��ŧ���� �߰��� ���¸� ���� �ܰ���Ͽ��� �����ϼ���!");
			return;
		}
		var params = "key=" + escape(selectstr);
		sndReq("selectin_xml.asp",params,leftView,"POST");
	}
}

function removeItem(theform){
	with(theform){

		var rightobj = projectLectures;
		var selectstr = "";

		for(ii=0;ii<rightobj.length;ii++){
			if(rightobj.options[ii].selected){
				selectstr += rightobj.options[ii].value + ",";
			}
		}

		if(selectstr==""){
			alert("������ ���¸� �����ϼ���!");
			return;
		}
		var params = "key=" + escape(selectstr);
		sndReq("selectout_xml.asp",params,leftView,"POST");
	}
}

function upItem(theform){
	with(theform){
		num=projectLectures.selectedIndex;
		if(num==-1){
			alert('�̵��� ���¸� �����ϼ���!');
			return;
		}

		if(num==0){
			return;
		}

		temp1=projectLectures.options[num].value;
		temp2=projectLectures.options[num].text;
		projectLectures.options[num].value=theform.projectLectures.options[num-1].value;
		projectLectures.options[num].text=theform.projectLectures.options[num-1].text;
		projectLectures.options[num-1].value=temp1;
		projectLectures.options[num-1].text=temp2;
		projectLectures.selectedIndex=num-1;
	}
}

function downItem(theform){
	with(theform){
		num=projectLectures.selectedIndex;
		if(num==-1){
			alert('�̵��� ���¸� �����ϼ���!');
			return;
		}
		if(num==projectLectures.options.length-1){
			return;
		}

		temp1=projectLectures.options[num+1].value;
		temp2=projectLectures.options[num+1].text;
		projectLectures.options[num+1].value=theform.projectLectures.options[num].value;
		projectLectures.options[num+1].text=theform.projectLectures.options[num].text;
		projectLectures.options[num].value=temp1;
		projectLectures.options[num].text=temp2;
		projectLectures.selectedIndex=num+1;
	}
}

function spredSelect(cateidx){
	var params = "key=" + escape(cateidx);
	sndReq("dan_list_xml.asp",params,selectView,"POST");
}

function selectView(){
	if(objXmlhttp.readyState == 4){
		if(objXmlhttp.status==200){
			var xmlDoc = objXmlhttp.responseXML;
			var objRows = xmlDoc.getElementsByTagName("isrows").item(0);
			var objCols = objRows.getElementsByTagName("iscols");
			var strinHm = objCols.item(0).firstChild.nodeValue;
			document.getElementById("dnSelect").innerHTML = strinHm;
		}else{
			alert("error");
		}
	}
}

function leftView(){
	if(objXmlhttp.readyState == 4){
		if(objXmlhttp.status==200){
			var xmlDoc = objXmlhttp.responseXML;
			var objRows = xmlDoc.getElementsByTagName("isrows").item(0);
			var objCols = objRows.getElementsByTagName("iscols");
			var strinHm = objCols.item(0).firstChild.nodeValue;
			document.getElementById("dnSeleced").innerHTML = strinHm;
		}else{
			alert("error");
		}
	}
}
</script>

<div class="container">
	<!--#include file="left.asp"-->
	<div class="content">
		<h2 class="cTit"><span class="bullet"></span>��Ű�����°���</h2>

<form name="regfm" action="mst_reg_ok.asp" method="post" enctype="multipart/form-data" style="display:inline;"> 
			<table class="ftbl mb50" style="width:100%">
				<colgroup>
				<col style="width:20%" />
				<col style="width:80%" />
				</colgroup>
				<tbody>
					<tr>
						<th>����</th>
						<td><input type="radio"  name="state" value="0" checked > �ƴϿ�
						  <input type="radio"  name="state" value="1" > ��
                          <span class="stip">* ���¸�Ͽ��� ����� �ֽ��ϴ�</span></td>
					</tr>
					<tr>
						<th>������û����</th>
						<td><%
sql = "select idx,title from group_mast where gu = 0 "
set rs=db.execute(sql)

if rs.eof or rs.bof then
else
do until rs.eof
%>
<input type="checkbox" name="mem_group" id="mem_group" value="<%=rs(0)%>" /> <%=rs(1)%>&nbsp;<%
rs.movenext
loop
rs.close
end if
%>
							<span class="stip">* üũ�� �ش� �׷쿡 ȸ���鸸 ������û�� �����մϴ�.</span></td>
					</tr>
					<tr>
						<th>ī�װ�</th>
						<td><select name="gbn" class="seltxt w200">
								<option value="">ī�װ�����</option><% sql = "select idx,bname from mscate order by idx"
								set dr = db.execute(sql)
								if Not dr.bof or Not dr.Eof then
								do until dr.eof %>
								<option value="<%=dr(0)%>"><%=dr(1)%></option><% dr.MoveNext
								Loop
								end if
								dr.close %>
							</select></td>
					</tr>
					<tr>
						<th>������</th>
						<td><input type="text"  name="strnm" class="inptxt1 w400" ></td>
					</tr>
					<tr>
						<th>��������</th>
						<td><input type="text"  name="sub_title" class="inptxt1 w400" ></td>
					</tr>
					<tr>
						<th>��������</th>
						<td><input type="text"  name="intprice" class="inptxt1 w100" placeholder="������" onKeyPress="NumKeyOnly();" onKeyUp="this.value = FormatCutterny(this.value);"> �� / <input type="text"  name="intgigan" class="inptxt1 w100" maxlength="3" onKeyPress="NumKeyOnly();" placeholder="�����Ⱓ"> ��</td>
					</tr>

					<tr>
						<th>������ǰ����</th>
						<td><input  name="book_idx" type="text" id="book_idx" readonly class="inptxt1 w400"><p style="height:10px"></p>
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
						<td><input type="file"  name="sajin" class="inptxt1 w200" > <span class="stip">* ������� 4:3���·� png,jpg,gif�� ����</span></td>
					</tr>

					<tr>
						<th>����ǥ��</th>
						<td> <input type="checkbox"  name="recom" value="1">  ������������ ǥ�� (<input type="text"  name="teacher" class="inptxt1 w200" placeholder="����ǥ�ó���">)</td>
					</tr>
					<tr>
						<th>���Ǿ�����</th>
						<td><%
				  sql = "select name,icon from icon_mast order by idx desc"
				  set rs=db.execute(sql)
				  
				  if rs.eof or rs.bof then
				  else
				  do until rs.eof%><input name="icon" type="checkbox" id="icon" value="<%=rs(1)%>"> <img src="../../ahdma/logo/<%=rs(1)%>" align="absmiddle">&nbsp;
                    <%
rs.movenext
loop
rs.close
end if
%></td>
					</tr>
					<tr>
						<th>����</th>
						<td><a href="javascript:popenWindow('/nicedit/upimg.asp?box=strheader','390','290');"><img src="/nicedit/bt1.gif" border="0"></a><a href="javascript:popenWindow('/nicedit/vod.asp?box=strheader','390','290');"><img src="/nicedit/bt2.gif" border="0"></a><a href="javascript:popenWindow('/nicedit/files.asp?box=strheader','390','290');"><img src="/nicedit/bt3.gif" border="0"></a>
                          <textarea name="strheader" id="strheader" rows="2" cols="20" style="width:600px; height:200px;"></textarea></td>
					</tr>
				</tbody>
			</table>

			<table width="100%" cellpadding="0" cellspacing="0">
						<tr height="25">
							<td width="44%"><select onChange="spredSelect(this.value);" class="seltxt w300">
							<option value="0">�ܰ�������</option><% sql = "select idx,title from dan_category where deep=0 order by ordnum asc,idx desc"
							set dr = db.execute(sql)
							if not dr.bof or not dr.eof then
							do until dr.eof %>
							<option value="<%=dr(0)%>"><%=dr(1)%></option><% dr.moveNext
							Loop
							end if %>
							</select></td>
							<td width="11%"></td>
							<td width="45%">��Ű�� �������� �ܰ�</td>
						</tr><% sql = "select idx,strnm from LecturTab order by strnm"
							set dr = db.execute(sql)
							if not dr.Bof or Not dr.Eof then
								isRecod = True
								isRows = split(dr.GetString(2),chr(13))
							end if %>
						<tr>
							<td valign="top" ID="dnSelect">
							<select name="lectureList" size="15" multiple style="width:100%;height:400px" class="seltxt" ondblclick="addItem(this.form);"><% if isRecod then
							for ii = 0 to UBound(isRows) - 1
							isCols = split(isRows(ii),chr(9)) %>
								<option value="<%=isCols(0)%>"><%=isCols(1)%></option><% Next
								end if %>
							</select>							</td>
							<td>
							<table width="100%" border="0" cellpadding="0" cellspacing="0">
								<tr height="25">
									<td height="35" align="center" ><input type="button" value="��Ű���� �߰�" class="btns" style="width:80px;" onClick="addItem(this.form);"></td>
								</tr>
								<tr height="25">
									<td height="35" align="center" ><input type="button" value="�߰� ����" class="btnss" style="width:80px;" onClick="removeItem(this.form);"></td>
								</tr>
								<tr height="25">
									<td height="35" align="center" ><input type="button" value="���Ŀø��� ��" class="btnss" style="width:80px;" onClick="upItem(this.form);"></td>
								</tr>
								<tr height="25">
									<td height="35" align="center" ><input type="button" value="���ĳ����� ��" class="btnss" style="width:80px;" onClick="downItem(this.form);"></td>
								</tr>
							</table>							</td>
							<td valign="top" ID="dnSeleced">
								<select name="projectLectures" size="15" multiple style="width:100%;height:400px" class="seltxt" ondblclick="removeItem(this.form);">
								</select>							</td>
						</tr>
					</table>


</form>

<p style="height:10px"></p>
<div class="caution"><p>������ �ܰ��� Ŭ���� <u>[��Ű���� �߰�]</u> �� �����ֽø� �ش� ��Ű���� ������ �˴ϴ�.</p></div>
<div class="caution"><p>������ ��ϵ� �ܰ��� Ŭ���� <u>[�߰� ����]</u> �� �����ֽø� ��ϵ� �ܰ����� ������ �˴ϴ�.</p></div>
<div class="caution"><p>������ ��ϵ� �ܰ� ������ <u>[���Ŀø��� / ���ĳ�����]</u> �� ������ �����մϴ�.</p></div>

<p style="height:10px"></p>
		<div class="rbtn">
			<a href="javascript:go2Reg(regfm);" class="btn">�����ϱ�</a>
			<a href="mst_list.asp" class="btn trans">��Ϻ���</a>		
		</div>

	</div>
</div>


</body>
</html>
<!-- #include file = "../authpg_2.asp" -->