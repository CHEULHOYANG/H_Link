<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/dbcon.asp" -->
<%
Dim dr,rownum,isRecod,isRows,isCols
dim rs,sql,rs1,sql1
dim name,idx
dim name1,idx1
dim name2,idx2
%>
<!-- #include file = "../main/top.asp" -->
<script type="text/javascript" src="/nicedit/nicEdit.js"></script>
<script type="text/javascript">
bkLib.onDomLoaded(function() {
	new nicEditor({fullPanel : true}).panelInstance('content');
});
</script>

<script>
function input_quiz(){
	var f = window.document.fm;

	if(f.ca1.value == "0"){
	alert("ī�װ��� �������ּ���.");
	return;
	}
	
	if(f.cca1.value != "0"){
	
		if(f.cca1.value=="0"){
		alert("���¸� �������ּ���.");
		return;
		}
		if(f.cca2.value=="0"){
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
			url: "../../xml/quiz_cate.asp",
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

<form action="input_ok.asp" method="post" name="fm" enctype="multipart/form-data">
		<table class="ftbl mb50" style="width:100%">
				<colgroup>
				<col style="width:20%" />
				<col style="width:80%" />
				</colgroup>
				<tbody>
					<tr>
						<th>�������</th>
						<td><input name="state" type="radio" value="0" checked > �ƴϿ�(����)
<input type="radio" name="state" value="1" > ��(�̳���)</td>
					</tr>
					<tr>
						<th>���ἳ��</th>
						<td><input name="price" type="radio" value="0" checked > ����
<input type="radio" name="price" value="1" > �����н�ȸ���� Ǯ�̰��� (���±���ȸ���� ����)
<input type="radio" name="price" value="2" > ������ȣ��� <input name="sec" type="text" class="inptxt1 w200" id="sec" size="20"></td>
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
                                  <input type="checkbox" name="mem_group" id="mem_group" value="<%=rs(0)%>" /> <%=rs(1)%>&nbsp;
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
  <option value="0">����</option>
<%
sql="select idx,title from quiz_category where deep=0 order by ordnum asc,idx desc"
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
						<th>���¼���</th>
						<td><select name='cca1' onChange='cate_select1()' class="seltxt w200">
                          <option value="0">�̼���</option>
                          <%
											sql="select idx,strnm from LecturTab order by idx"
											set rs=db.execute(sql)
											if rs.eof or rs.bof then
											else
											do until rs.eof
											idx=rs(0)
											name=rs(1)											
											%>
                          <option value="<%=idx%>"><%=name%></option>
                          <%
											rs.movenext
											Loop
											rs.close
											end if
											%>
                        </select>&nbsp;<span id="playArea1"></span> <span class="stip">* ���¼��ý� �ش簭�¸� �����ø� Ǯ�̰��� (��ɻ��� ��������� �Ͽ� �������� �̳����ϴ°� �����ϴ�)</span></td>
					</tr>
					<tr>
						<th>����������</th>
						<td><input name="title" type="text" class="inptxt1 w400" id="title" size="80"></td>
					</tr>
					<tr>
						<th>�ݺ�Ǯ����</th>
						<td><input name="munje_repeat" type="radio" value="0" checked> ��
                        <input type="radio" name="munje_repeat" value="1"> �ƴϿ�(1ȸ��Ǯ������)</td>
					</tr>
					<tr>
						<th>�ð�����</th>
						<td><input name="munje_date1" type="radio" value="0" checked> �̻��
<input type="radio" name="munje_date1" value="1">  �����
<input class="sdate" id="sdate" value="<%=Date()%>" name="sdate" readonly style="width:80px;border: 1px solid #dedfde;height:22px;" /> ��
<select name="munje_time1" class="seltxt" id="munje_time1">
  <option value="0" selected>������</option>
  <option value="01:00">01:00</option>
  <option value="02:00">02:00</option>
  <option value="03:00">03:00</option>
  <option value="04:00">04:00</option>
  <option value="05:00">05:00</option>
  <option value="06:00">06:00</option>
  <option value="07:00">07:00</option>
  <option value="08:00">08:00</option>
  <option value="09:00">09:00</option>
  <option value="10:00">10:00</option>
  <option value="11:00">11:00</option>
  <option value="12:00">12:00</option>
  <option value="13:00">13:00</option>
  <option value="14:00">14:00</option>
  <option value="15:00">15:00</option>
  <option value="16:00">16:00</option>
  <option value="17:00">17:00</option>
  <option value="18:00">18:00</option>
  <option value="19:00">19:00</option>
  <option value="20:00">20:00</option>
  <option value="21:00">21:00</option>
  <option value="22:00">22:00</option>
  <option value="23:00">23:00</option>
</select>
~
<select name="munje_time2" class="seltxt" id="munje_time2">
  <option value="0" selected>������</option>
  <option value="01:00">01:00</option>
  <option value="02:00">02:00</option>
  <option value="03:00">03:00</option>
  <option value="04:00">04:00</option>
  <option value="05:00">05:00</option>
  <option value="06:00">06:00</option>
  <option value="07:00">07:00</option>
  <option value="08:00">08:00</option>
  <option value="09:00">09:00</option>
  <option value="10:00">10:00</option>
  <option value="11:00">11:00</option>
  <option value="12:00">12:00</option>
  <option value="13:00">13:00</option>
  <option value="14:00">14:00</option>
  <option value="15:00">15:00</option>
  <option value="16:00">16:00</option>
  <option value="17:00">17:00</option>
  <option value="18:00">18:00</option>
  <option value="19:00">19:00</option>
  <option value="20:00">20:00</option>
  <option value="21:00">21:00</option>
  <option value="22:00">22:00</option>
  <option value="23:00">23:00</option>
</select>
���� ������ Ǯ���ֽ��ϴ�.</td>
					</tr>
					<tr>
						<th>�������</th>
						<td><input name="munje_bang1" type="radio" value="0" checked>
                      ���������� Ǯ��
                      <input type="radio" name="munje_bang1" value="1"> 
                      ����Ǯ��</td>
					</tr>
					<tr>
						<th>Ǯ�̹��</th>
						<td><input name="munje_bang2" type="radio" value="0" checked>
��繮�� �ѹ��� Ǯ��
<input type="radio" name="munje_bang2" value="1"> 
�ѹ����� Ǯ��</td>
					</tr>
					<tr>
						<th>ǥ�⼳��</th>
						<td><input name="admin_gu" type="checkbox" id="admin_gu" value="1"> ��õ����
                      <input name="admin_gu" type="checkbox" id="admin_gu" value="2"> �α⹮�� 
                      <input name="admin_gu" type="checkbox" id="admin_gu" value="3"> ��������</td>
					</tr>
					<tr>
						<th>Ǯ�̰������</th>
						<td><input name="sungjuk_show" type="radio" value="0" checked> �ٷΰ���
<input type="radio" name="sungjuk_show" value="1"> �̰���</td>
					</tr>
					<tr>
						<th>Ǯ�̽ð�</th>
						<td><input name="munje_end_time" type="text" class="inptxt1 w60" id="munje_end_time" onKeyUp="onlynum(fm.munje_end_time);" value="60" size="8">
�� &nbsp; <span class="stip">2�ð��ϰ�� 120������ �Է��Ͻø� �˴ϴ�. ����ð� 5���� ��������˸�</span></td>
					</tr>
					<tr>
						<th>���״�亯����</th>
						<td><input name="munje_gesu" type="radio" value="2" checked> 2��
					  <input name="munje_gesu" type="radio" value="3"> 3��
					  <input name="munje_gesu" type="radio" value="4"> 4��
                      <input type="radio" name="munje_gesu" value="5">  5��</td>
					</tr>
					<tr>
						<th>���ô亯����</th>
						<td><input name="munje_gu" type="radio" value="0" checked> ����(1,2,3,4,5)&nbsp;
                      <input name="munje_gu" type="radio" value="1"> �ѱ�(��,��,��,��,��)&nbsp;
                      <input name="munje_gu" type="radio" value="2"> ����(A,B,C,D,E)</td>
					</tr>
					<tr>
						<th>����������</th>
						<td><a href="javascript:popenWindow('/nicedit/upimg.asp?box=content','390','290');"><img src="../../nicedit/bt1.gif" border="0"></a><a href="javascript:popenWindow('/nicedit/vod.asp?box=content','390','290');"><img src="../../nicedit/bt2.gif" border="0"></a><a href="javascript:popenWindow('/nicedit/files.asp?box=content','390','290');"><img src="../../nicedit/bt3.gif" border="0"></a><textarea name="content" id="content" rows="2" cols="20" style="width:600px; height:200px;"></textarea></td>
					</tr>
					<tr>
						<th>÷������</th>
						<td><input type="file" name="File3" class="inptxt1 w200" size="20" >
                      <span class="stip">* ������ Ǭ�� �ٿ�޾ƺ��� �ִ� �ڷ������Դϴ�.</span></td>
					</tr>
				</tbody>
			</table>
</form>

		<div class="rbtn">
			<a href="javascript:input_quiz();" class="btn">�����ϱ�</a>
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