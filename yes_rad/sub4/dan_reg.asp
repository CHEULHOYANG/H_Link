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
set dr = Nothing

Dim ordn

sql = "select top 1 ordn from LecturTab order by ordn desc"
Set rs=db.execute(sql)

If rs.eof Or rs.bof Then
	ordn = 0
Else
	ordn = rs(0) + 1
rs.close
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
</script>

<div class="container">
	<!--#include file="left.asp"-->
	<div class="content">
		<h2 class="cTit"><span class="bullet"></span>�ܰ����°���</h2>

<form name="regfm" action="dan_reg_ok.asp" method="post" enctype="multipart/form-data">
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
                          <span class="stip">* ���¸�Ͽ��� ����� �ֽ��ϴ�.</span></td>
					</tr>
					<tr>
						<th>�������</th>
						<td><input type="radio"  name="step_check" value="0" checked > �ƴϿ�
						  <input type="radio"  name="step_check" value="1" > ��
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
<input type="checkbox" name="mem_group" id="mem_group" value="<%=rs(0)%>" /> <%=rs(1)%>&nbsp;<%
rs.movenext
loop
rs.close
end if
%>
<br /><span class="stip">* üũ�� �ش� �׷쿡 ȸ���鸸 ������û�� �����մϴ�. �׷������ ȸ���������� �����մϴ�.</span></td>
					</tr>
					<tr>
						<th>���¸�</th>
						<td><input type="text"  name="strnm" class="inptxt1 w400"  ></td>
					</tr>
					<tr>
						<th>��������</th>
						<td><input type="text"  name="sub_title" class="inptxt1 w400"  ></td>
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
      <option value="<%=rs(0)%>"><%=rs(1)%></option>
<%
rs.movenext
Loop
rs.close
end if
%>
    </select>&nbsp;<span id="playArea"></span></td>
					</tr>
					<tr>
						<th>��������</th>
						<td><input type="text"  name="strteach" class="inptxt1 w100" placeholder="�����"> / <input  name="teach_id" type="text" class="inptxt1 w100" id="teach_id" placeholder="������̵�"></td>
					</tr>
					<tr>
						<th>��������</th>
						<td><input type="text"  name="intprice" class="inptxt1 w100" placeholder="������" onKeyPress="NumKeyOnly();" onKeyUp="this.value = FormatCutterny(this.value);"> �� / <input type="text"  name="intgigan" class="inptxt1 w100" maxlength="3" onKeyPress="NumKeyOnly();" placeholder="�����Ⱓ"> ��</td>
					</tr>
					<tr>
						<th>���Ǿ�����</th>
						<td><%
				  sql = "select name,icon from icon_mast order by idx desc"
				  set rs=db.execute(sql)
				  
				  if rs.eof or rs.bof then
				  else
				  do until rs.eof%><input name="icon" type="checkbox" id="icon" value="<%=rs(1)%>"> <img src="/ahdma/logo/<%=rs(1)%>" align="absmiddle">&nbsp;
                    <%
rs.movenext
loop
rs.close
end if
%></td>
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
						<td><input type="file" name="sajin" class="inptxt1 w200"  >  <span class="stip">* ������� 4:3���·� png,jpg,gif�� ����</span></td>
					</tr>
					<tr>
						<th>����ǥ��</th>
						<td><input type="checkbox" name="inginum" value="1"> �ش� ���Ǹ� ���ο� ǥ���մϴ�</td>
					</tr>
					<tr>
						<th>���ǳ���</th>
						<td><a href="javascript:popenWindow('/nicedit/upimg.asp?box=tinfo','390','290');"><img src="/nicedit/bt1.gif" border="0"></a><a href="javascript:popenWindow('/nicedit/vod.asp?box=tinfo','390','290');"><img src="/nicedit/bt2.gif" border="0"></a><a href="javascript:popenWindow('/nicedit/files.asp?box=tinfo','390','290');"><img src="/nicedit/bt3.gif" border="0"></a><textarea name="tinfo" id="tinfo" rows="2" cols="20" style="width:800px; height:200px;"></textarea></td>
					</tr>
				</tbody>
			</table>
</form>

		<div class="rbtn">
			<a href="javascript:go2Reg(regfm);" class="btn">�����ϱ�</a>
			<a href="dan_list.asp" class="btn trans">��Ϻ���</a>		
		</div>

	</div>
</div>


</body>
</html>
<!-- #include file = "../authpg_2.asp" -->