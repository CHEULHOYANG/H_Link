<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/dbcon.asp" -->
<%
Dim dr,rownum,isRecod,isRows,isCols
dim rs,sql,rs1,sql1
dim name,idx
dim name1,idx1
dim name2,idx2
dim title,content,ca1,ca2,ca3,price,admin_gu,munje_total,munje_gesu,munje_gu,munje_dap,munje_img,munje_haedap,munje_attach,munje_listen,munje_repeat,munje_date1,munje_date2
dim munje_time1,munje_time2,munje_bang1,munje_bang2,munje_end_time,sungjuk_show,tca1,tca2,mem_group,sec,state

idx=request("idx")

sql="select idx,title,content,ca1,ca2,ca3,price,admin_gu,munje_total,munje_gesu,munje_gu,munje_dap,munje_img,munje_haedap,munje_attach,munje_listen,munje_repeat,munje_date1,munje_date2,munje_time1,munje_time2,munje_bang1,munje_bang2,munje_end_time,sungjuk_show,tca1,tca2,mem_group,sec,state from quiz_munje where idx = '"& idx &"'"
set rs=db.execute(sql)

if rs.eof or rs.bof Then

	response.write"<script>"
	response.write"alert('�������� �ʴ� �Խù��Դϴ�.');"
	response.write"history.back();"
	response.write"</script>"
	response.end

Else

	idx = rs(0)
	title = rs(1)
	content = rs(2)
	ca1 = rs(3)
	ca2 = rs(4)
	ca3 = rs(5)
	price = rs(6)
	admin_gu = rs(7)
	munje_total = rs(8)
	munje_gesu = rs(9)
	munje_gu = rs(10)
	munje_dap = rs(11)
	munje_img = rs(12)
	munje_haedap = rs(13)
	munje_attach = rs(14)
	munje_listen = rs(15)
	munje_repeat = rs(16)
	munje_date1 = rs(17)
	munje_date2 = rs(18)
	munje_time1 = rs(19)
	munje_time2 = rs(20)
	munje_bang1 = rs(21)
	munje_bang2 = rs(22)
	munje_end_time = rs(23)
	sungjuk_show = rs(24)
	tca1 = rs(25)
	tca2 = rs(26)
	mem_group = rs(27)
	sec = rs(28)
	state = rs(29)

rs.close
end if
%>
<!-- #include file = "../main/top.asp" -->
<script type="text/javascript" src="/nicedit/nicEdit.js"></script>
<script type="text/javascript">
bkLib.onDomLoaded(function() {
	new nicEditor({fullPanel : true}).panelInstance('content');
});
</script>

<script>
function cate_select1(){

	var f = window.document.fm;
	var a1 = f.cca1.value;

	if(a1 == "0"){
		alert("�з����� �������ּ���.");
		_data = "";
		$('#playArea1').html(_data);	
		return;
	}

		$.ajax({
			url: "/xml/quiz_section.asp",
			type:"POST",
			data:{"key":""+a1+""},
			dataType:"text",
			cache:false,
			processData:true,
			success:function(_data){								
				$('#playArea1').html(_data);						
			},
			error:function(xhr,textStatus){
			alert("[����]����:"+xhr.status+"                                     ");
			}	
		});	
		
}
function cate_select(){

	var f = window.document.fm;
	var a1 = f.ca1.value;

	if(a1 == "0"){
		alert("�з����� �������ּ���.");
		_data = "";
		$('#playArea').html(_data);	
		return;
	}

		$.ajax({
			url: "/xml/quiz_cate.asp",
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

function edit_quiz(){

	var f = window.document.fm;

	if(f.ca1.value == "0"){
	alert("ī�װ��� �������ּ���.");
	return;
	}

	if(f.cca1.value != "0"){
	
		if(f.cca1.value==""){
		alert("���¸� �������ּ���.");
		return;
		}
		if(f.cca2.value=="value"){
		alert("���Ǹ� �������ּ���.");
		return;
		}
		if(f.cca2.value==""){
		alert("���Ǹ� �������ּ���.");
		return;
		}

	}

	if(f.title.value==""){
	alert("������������ �Է����ּ���.");
	f.title.focus();
	return;
	}

	clmn = f.content;
	clmn.value = nicEditors.findEditor('content').getContent();

	f.submit();
}

function check_upload(objtext1) {
  var ext = objtext1.value;
  ext = ext.substring(ext.length-3,ext.length);
  ext = ext.toLowerCase();
  if ((ext != 'jpg') &&(ext != 'gif')){
    alert('�ش������� ���ε尡 �Ұ����մϴ�.\n\n���ε� �������� jpg,gif');
	ext = "";
    return ;	 }

}  

function check_upload1(objtext1) {
  var ext = objtext1.value;
  ext = ext.substring(ext.length-3,ext.length);
  ext = ext.toLowerCase();
  if ((ext != 'mp3')){
    alert('�ش������� ���ε尡 �Ұ����մϴ�.\n\n���ε� �������� mp3����');
	ext = "";
    return;	 }
} 

function onlynum(objtext1){
				var inText = objtext1.value;
				var ret;
				for (var i = 0; i < inText.length; i++) {
				    ret = inText.charCodeAt(i);
					if (!((ret > 47) && (ret < 58)))  {
						alert("���ڸ��� �Է����ּ���.");
						objtext1.value = "";
						objtext1.focus();
						return false;
					}
				}
				return true;
			}
</script>

<div class="container">
	<!--#include file="left.asp"-->
	<div class="content">
		<h2 class="cTit"><span class="bullet"></span>����������</h2>

<form action="edit_ok.asp" method="post" name="fm" enctype="multipart/form-data">
<input type="hidden" name="idx" value="<%=request("idx")%>">
<input type="hidden" name="page" value="<%=request("page")%>">
<input type="hidden" name="searchpart" value="<%=request("searchpart")%>">
<input type="hidden" name="searchstr" value="<%=request("searchstr")%>">

		<table class="ftbl mb50" style="width:100%">
				<colgroup>
				<col style="width:20%" />
				<col style="width:80%" />
				</colgroup>
				<tbody>
					<tr>
						<th>�������</th>
						<td><input name="state" type="radio" value="0" <%if state=0 then response.write"checked" end if%> > �ƴϿ�(����)
<input type="radio" name="state" value="1" <%if state=1 then response.write"checked" end if%> > ��(�̳���)</td>
					</tr>
					<tr>
						<th>���ἳ��</th>
						<td><input name="price" type="radio" value="0" <%if price=0 then response.write"checked" end if%> > ����
<input type="radio" name="price" value="1" <%if price=1 then response.write"checked" end if%> > �����н�ȸ���� Ǯ�̰��� (���±���ȸ���� ����)
<input type="radio" name="price" value="2" <%if price=2 then response.write"checked" end if%> > ������ȣ��� <input name="sec" type="text" class="inptxt1 w200" id="sec" size="20"></td>
					</tr>

					<tr>
						<th>����׷켳��</th>
						<td><%
sql = "select idx,title from group_mast where gu = 0 "
set rs=db.execute(sql)

if rs.eof or rs.bof then
else
do until rs.eof
%>
                                  <input type="checkbox" name="mem_group" id="mem_group" value="<%=rs(0)%>" <%if instr(mem_group,", "& rs(0) &",") then response.write"checked" end if%> /> <%=rs(1)%>&nbsp;
                        <%
rs.movenext
loop
rs.close
end if
%></td>
					</tr>
					<tr>
						<th>ī�װ�</th>
						<td><select name="ca1" class="seltxt w200" onChange="cate_select();">
  <option value="0" <%If tca1 = 0 Then response.write"selected" End if%>>����</option>
<%
sql="select idx,title from quiz_category where deep=0 order by ordnum asc,idx desc"
set rs=db.execute(sql)
if rs.eof or rs.bof then
else
do until rs.eof
%>
      <option value="<%=rs(0)%>" <%If tca1=rs(0) Then response.write"selected" End if%>><%=rs(1)%></option>
<%
rs.movenext
Loop
rs.close
end if
%>
    </select>&nbsp;<span id="playArea"><%
sql="select idx,title from quiz_category where deep=1 and uidx="& tca1 &" order by ordnum asc,idx desc"
set rs=db.execute(sql)

If rs.eof Or rs.bof Then
else
%>
<select name="ca2" class="seltxt w200">
<option value="0" <%If tca2 = 0 Then response.write"selected" End if%>>����</option>
<%
do until rs.eof
%>
      <option value="<%=rs(0)%>" <%If Int(rs(0)) = Int(tca2) Then response.write"selected" End if%>><%=rs(1)%></option>
<%
rs.movenext
Loop
rs.close
%>
</select><%End if%></span></td>
					</tr>


					<tr>
						<th>���¼���</th>
						<td><select name='cca1' onChange='cate_select1()' class="seltxt w200">
                          <option value="0" <%if int(ca1) = 0 then response.write"selected" end if%>>�̼���</option>
                          <%
											sql="select idx,strnm from LecturTab order by idx"
											set rs=db.execute(sql)
											if rs.eof or rs.bof then
											else
											do until rs.eof
											idx=rs(0)
											name=rs(1)											
											%>
                          <option value="<%=idx%>" <%if int(ca1) = int(idx) then response.write"selected" end if%>><%=name%></option>
                          <%
											rs.movenext
											Loop
											rs.close
											end if
											%>
                        </select>&nbsp;<span id="playArea1"><%
sql="select idx,strnm from sectionTab where l_idx="& ca1 &" order by ordnum"
set rs=db.execute(sql)

If rs.eof Or rs.bof Then
else
%>
<select name="cca2" class="seltxt w200">
<option value="0">����</option>
<%
do until rs.eof
%>
<option value="<%=rs(0)%>" <%if int(ca2) = int(rs(0)) then response.write"selected" end if%>><%=rs(1)%></option>
<%
rs.movenext
Loop
rs.close
%>
</select>
<%End if%></span> <span class="stip">* ���¼��ý� �ش簭�¸� �����ø� Ǯ�̰��� (��ɻ��� ��������� �Ͽ� �������� �̳����ϴ°� �����ϴ�)</span></td>
					</tr>
					<tr>
						<th>����������</th>
						<td><input name="title" type="text" class="inptxt1 w400" id="title" value="<%=title%>" ></td>
					</tr>
					<tr>
						<th>�ݺ�Ǯ����</th>
						<td><input name="munje_repeat" type="radio" value="0" <%if munje_repeat=0 then response.write"checked" end if%>> ��
                        <input type="radio" name="munje_repeat" value="1" <%if munje_repeat=1 then response.write"checked" end if%>> �ƴϿ�(1ȸ��Ǯ������)</td>
					</tr>
					<tr>
						<th>�ð�����</th>
						<td><input name="munje_date1" type="radio" value="0" <%if munje_date1=0 then response.write"checked" end if%>> �̻��
<input type="radio" name="munje_date1" value="1" <%if munje_date1=1 then response.write"checked" end if%>>  �����
<input class="sdate" id="sdate" value="<%=munje_date2%>" name="sdate" readonly style="width:80px;border: 1px solid #dedfde;height:22px;" /> ��
<select name="munje_time1" class="seltxt" id="munje_time1">
  <option value="0" <%if munje_time1="0" then response.write"selected" end if%>>������</option>
  <option value="01:00" <%if munje_time1="01:00" then response.write"selected" end if%>>01:00</option>
  <option value="02:00" <%if munje_time1="02:00" then response.write"selected" end if%>>02:00</option>
  <option value="03:00" <%if munje_time1="03:00" then response.write"selected" end if%>>03:00</option>
  <option value="04:00" <%if munje_time1="04:00" then response.write"selected" end if%>>04:00</option>
  <option value="05:00" <%if munje_time1="05:00" then response.write"selected" end if%>>05:00</option>
  <option value="06:00" <%if munje_time1="06:00" then response.write"selected" end if%>>06:00</option>
  <option value="07:00" <%if munje_time1="07:00" then response.write"selected" end if%>>07:00</option>
  <option value="08:00" <%if munje_time1="08:00" then response.write"selected" end if%>>08:00</option>
  <option value="09:00" <%if munje_time1="09:00" then response.write"selected" end if%>>09:00</option>
  <option value="10:00" <%if munje_time1="10:00" then response.write"selected" end if%>>10:00</option>
  <option value="11:00" <%if munje_time1="11:00" then response.write"selected" end if%>>11:00</option>
  <option value="12:00" <%if munje_time1="12:00" then response.write"selected" end if%>>12:00</option>
  <option value="13:00" <%if munje_time1="13:00" then response.write"selected" end if%>>13:00</option>
  <option value="14:00" <%if munje_time1="14:00" then response.write"selected" end if%>>14:00</option>
  <option value="15:00" <%if munje_time1="15:00" then response.write"selected" end if%>>15:00</option>
  <option value="16:00" <%if munje_time1="16:00" then response.write"selected" end if%>>16:00</option>
  <option value="17:00" <%if munje_time1="17:00" then response.write"selected" end if%>>17:00</option>
  <option value="18:00" <%if munje_time1="18:00" then response.write"selected" end if%>>18:00</option>
  <option value="19:00" <%if munje_time1="19:00" then response.write"selected" end if%>>19:00</option>
  <option value="20:00" <%if munje_time1="20:00" then response.write"selected" end if%>>20:00</option>
  <option value="21:00" <%if munje_time1="21:00" then response.write"selected" end if%>>21:00</option>
  <option value="22:00" <%if munje_time1="22:00" then response.write"selected" end if%>>22:00</option>
  <option value="23:00" <%if munje_time1="23:00" then response.write"selected" end if%>>23:00</option>
</select>
~
<select name="munje_time2" class="seltxt" id="munje_time2">
  <option value="0" <%if munje_time2="0" then response.write"selected" end if%>>������</option>
  <option value="01:00" <%if munje_time2="01:00" then response.write"selected" end if%>>01:00</option>
  <option value="02:00" <%if munje_time2="02:00" then response.write"selected" end if%>>02:00</option>
  <option value="03:00" <%if munje_time2="03:00" then response.write"selected" end if%>>03:00</option>
  <option value="04:00" <%if munje_time2="04:00" then response.write"selected" end if%>>04:00</option>
  <option value="05:00" <%if munje_time2="05:00" then response.write"selected" end if%>>05:00</option>
  <option value="06:00" <%if munje_time2="06:00" then response.write"selected" end if%>>06:00</option>
  <option value="07:00" <%if munje_time2="07:00" then response.write"selected" end if%>>07:00</option>
  <option value="08:00" <%if munje_time2="08:00" then response.write"selected" end if%>>08:00</option>
  <option value="09:00" <%if munje_time2="09:00" then response.write"selected" end if%>>09:00</option>
  <option value="10:00" <%if munje_time2="10:00" then response.write"selected" end if%>>10:00</option>
  <option value="11:00" <%if munje_time2="11:00" then response.write"selected" end if%>>11:00</option>
  <option value="12:00" <%if munje_time2="12:00" then response.write"selected" end if%>>12:00</option>
  <option value="13:00" <%if munje_time2="13:00" then response.write"selected" end if%>>13:00</option>
  <option value="14:00" <%if munje_time2="14:00" then response.write"selected" end if%>>14:00</option>
  <option value="15:00" <%if munje_time2="15:00" then response.write"selected" end if%>>15:00</option>
  <option value="16:00" <%if munje_time2="16:00" then response.write"selected" end if%>>16:00</option>
  <option value="17:00" <%if munje_time2="17:00" then response.write"selected" end if%>>17:00</option>
  <option value="18:00" <%if munje_time2="18:00" then response.write"selected" end if%>>18:00</option>
  <option value="19:00" <%if munje_time2="19:00" then response.write"selected" end if%>>19:00</option>
  <option value="20:00" <%if munje_time2="20:00" then response.write"selected" end if%>>20:00</option>
  <option value="21:00" <%if munje_time2="21:00" then response.write"selected" end if%>>21:00</option>
  <option value="22:00" <%if munje_time2="22:00" then response.write"selected" end if%>>22:00</option>
  <option value="23:00" <%if munje_time2="23:00" then response.write"selected" end if%>>23:00</option>
</select>
���� ������ Ǯ���ֽ��ϴ�.</td>
					</tr>
					<tr>
						<th>�������</th>
						<td><input name="munje_bang1" type="radio" value="0" <%if munje_bang1=0 then response.write"checked" end if%>>
                      ���������� Ǯ��
                      <input type="radio" name="munje_bang1" value="1" <%if munje_bang1=1 then response.write"checked" end if%>> 
                      ����Ǯ��</td>
					</tr>
					<tr>
						<th>Ǯ�̹��</th>
						<td><input name="munje_bang2" type="radio" value="0" <%if munje_bang2=0 then response.write"checked" end if%>>
��繮�� �ѹ��� Ǯ��
<input type="radio" name="munje_bang2" value="1" <%if munje_bang2=1 then response.write"checked" end if%>> 
�ѹ����� Ǯ��</td>
					</tr>
					<tr>
						<th>ǥ�⼳��</th>
						<td><input name="admin_gu" type="checkbox" id="admin_gu" value="1" <%if instr(admin_gu,"1") then response.write"checked" end if%>> ��õ����
                      <input name="admin_gu" type="checkbox" id="admin_gu" value="2" <%if instr(admin_gu,"2") then response.write"checked" end if%>> �α⹮�� 
                      <input name="admin_gu" type="checkbox" id="admin_gu" value="3" <%if instr(admin_gu,"3") then response.write"checked" end if%>> ��������</td>
					</tr>
					<tr>
						<th>Ǯ�̰������</th>
						<td><input name="sungjuk_show" type="radio" value="0" <%if sungjuk_show = 0 then response.write"checked" end if%>> �ٷΰ���
<input type="radio" name="sungjuk_show" value="1" <%if sungjuk_show = 1 then response.write"checked" end if%>> �̰���</td>
					</tr>
					<tr>
						<th>Ǯ�̽ð�</th>
						<td><input name="munje_end_time" type="text" class="inptxt1 w60" id="munje_end_time" onKeyUp="onlynum(fm.munje_end_time);" value="<%=munje_end_time%>" size="8">
�� &nbsp; <span class="stip">2�ð��ϰ�� 120������ �Է��Ͻø� �˴ϴ�. ����ð� 5���� ��������˸�</span></td>
					</tr>
					<tr>
						<th>���״�亯����</th>
						<td><input name="munje_gesu" type="radio" value="2" <%if munje_gesu=2 then response.write"checked" end if%>> 2��
					  <input name="munje_gesu" type="radio" value="3" <%if munje_gesu=3 then response.write"checked" end if%>> 3��
					  <input name="munje_gesu" type="radio" value="4" <%if munje_gesu=4 then response.write"checked" end if%>> 4��
                      <input type="radio" name="munje_gesu" value="5" <%if munje_gesu=5 then response.write"checked" end if%>>  5��</td>
					</tr>
					<tr>
						<th>���ô亯����</th>
						<td><input name="munje_gu" type="radio" value="0" <%if munje_gu=0 then response.write"checked" end if%>> ����(1,2,3,4,5)&nbsp;
                      <input name="munje_gu" type="radio" value="1" <%if munje_gu=1 then response.write"checked" end if%>> �ѱ�(��,��,��,��,��)&nbsp;
                      <input name="munje_gu" type="radio" value="2" <%if munje_gu=2 then response.write"checked" end if%>> ����(A,B,C,D,E)</td>
					</tr>
					<tr>
						<th>����������</th>
						<td><a href="javascript:popenWindow('/nicedit/upimg.asp?box=content','390','290');"><img src="../../nicedit/bt1.gif" border="0"></a><a href="javascript:popenWindow('/nicedit/vod.asp?box=content','390','290');"><img src="../../nicedit/bt2.gif" border="0"></a><a href="javascript:popenWindow('/nicedit/files.asp?box=content','390','290');"><img src="../../nicedit/bt3.gif" border="0"></a><textarea name="content" id="content" rows="2" cols="20" style="width:600px; height:200px;"><%=content%></textarea></td>
					</tr>
					<tr>
						<th>÷������</th>
						<td><input type="file" name="File3" class="inptxt1 w200" size="20" >
						<%if Len(munje_attach) > 0 then%><input name="file3_del" type="checkbox" id="file3_del" value="Y">  ���� (��������:<a href="download.asp?filename=<%=munje_attach%>"><%=munje_attach%></a>)<%end if%>
                      <span class="stip">* ������ Ǭ�� �ٿ�޾ƺ��� �ִ� �ڷ������Դϴ�.</span></td>
					</tr>
				</tbody>
			</table>
</form>

		<div class="rbtn">
			<a href="javascript:edit_quiz();" class="btn">�����ϱ�</a>
			<a href="list.asp" class="btn trans">��Ϻ���</a>		
		</div>

	</div>
</div>

</body>
</html>

<!-- #include file = "../authpg_2.asp" -->

<link rel="stylesheet" href="../../include/pikaday.css">
<script src="../../include/moment.js"></script>
<script src="../../include/pikaday.js"></script>

<script>
    var picker = new Pikaday(
    {
        field: document.getElementById('sdate'),
        firstDay: 1,
		format: "YYYY-MM-DD",
        minDate: new Date('<%=left(date(),4)-10%>-01-01'),
        maxDate: new Date('<%=left(date(),4)+10%>-12-31'),
        yearRange: [<%=left(date(),4)-10%>,<%=left(date(),4)+10%>]
    });
</script>