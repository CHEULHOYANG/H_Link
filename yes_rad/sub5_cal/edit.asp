<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/dbcon.asp" -->
<%

dim sid,sql,rs,board_count,idx,title,bg_color,font_color,gu,s_type,m_level,bun,i

if len(request("idx")) > 0 then
	sql = "select title,gu,sid,s_type,m_level,sid,bun,idx from cal_mast where idx = "& request("idx")
else
	sql = "select title,gu,sid,s_type,m_level,sid,bun,idx from cal_mast where sid = '"& request("sid") &"'"
end if
set rs=db.execute(sql)

if rs.eof or rs.bof then
	response.write"<script>"
	response.write"alert('��ϵ� �����Ͱ� �����ϴ�.');"
	response.write"history.back();"	
	response.write"</script>"
	response.end
else
	title = rs(0)
	gu = rs(1)
	sid = rs(2)
	s_type = rs(3)
	m_level = rs(4)
	sid = rs(5)
	bun = rs(6)
	idx = rs(7)
	rs.close
end if
%>


<!--#include file="../main/top.asp"-->
<script>
function cal_up(idx){

	
	var a1 = idx;

		$.ajax({
			url: "../../xml/cal_up.asp",
			type:"POST",
			data:{"key":"<%=sid%>|"+a1+""},
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


function cal_down(idx){

	
	var a1 = idx;

		$.ajax({
			url: "../../xml/cal_down.asp",
			type:"POST",
			data:{"key":"<%=sid%>|"+a1+""},
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
	
function cal_del(idx){
	
	var bool = confirm("�����Ͻðڽ��ϱ�?");
	if (bool){
	
	var a1 = idx;

		$.ajax({
			url: "../../xml/cal_del.asp",
			type:"POST",
			data:{"key":"<%=sid%>|"+a1+""},
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

}

function cal_gu_mast(){
	var f = window.document.form;
	if(f.title.value==""){
	alert("�з����� �Է����ּ���.");
	f.title.focus();
	return;
	}
	if(f.bg_color.value==""){
	alert("�����÷��� �������ּ���.");
	f.bg_color.focus();
	return;
	}
	if(f.font_color.value==""){
	alert("��Ʈ�÷��� �������ּ���.");
	f.font_color.focus();
	return;
	}	


var a1 = f.title.value;
var a2 = f.bg_color.value;
var a3 = f.font_color.value;

		$.ajax({
			url: "../../xml/cal_input.asp",
			type:"POST",
			data:{"key":"<%=sid%>|"+a1+"|"+a2+"|"+a3+""},
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

function cal_gu_edit(idx){
	
	var f = eval("document.form"+idx);
	if(f.title.value==""){
	alert("�з����� �Է����ּ���.");
	f.title.focus();
	return;
	}
	if(f.bg_color.value==""){
	alert("�����÷��� �������ּ���.");
	f.bg_color.focus();
	return;
	}
	if(f.font_color.value==""){
	alert("��Ʈ�÷��� �������ּ���.");
	f.font_color.focus();
	return;
	}	


var a1 = f.title.value;
var a2 = f.bg_color.value;
var a3 = f.font_color.value;
var a4 = idx

		$.ajax({
			url: "../../xml/cal_edit.asp",
			type:"POST",
			data:{"key":"<%=sid%>|"+a1+"|"+a2+"|"+a3+"|"+a4+""},
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

function cal_input(){
	var f = window.document.fm;
	if(f.title.value==""){
	alert("���������� �Է����ּ���.");
	f.title.focus();
	return;
	}
	f.submit();
}

function cal_display(flag){

	playArea.style.display = "none";

	switch (flag)
	{
		case 0: playArea.style.display = ""; break;
		case 1: playArea.style.display = "none"; break;

	}
} 
</script>

<div class="container">
	<!--#include file="left.asp"-->
	<div class="content">
		<h2 class="cTit"><span class="bullet"></span>��������</h2>

<form action="edit_ok.asp" method="post" name="fm">	
<input type="hidden" name="idx" value="<%=idx%>">	
<input type="hidden" name="page" value="<%=request("page")%>">	
		<table class="ftbl mb50" style="width:100%">
				<colgroup>
				<col style="width:20%" />
				<col style="width:80%" />
				</colgroup>
				<tbody>
					<tr>
						<th>��������</th>
						<td><input name="title" type="text" class="inptxt1 w400" id="title" value="<%=title%>"></td>
					</tr>
					<tr>
						<th>������Ų����</th>
						<td><input name="gu" type="radio" value="0" <%if gu = 0 then response.write"checked" end if%>> 
                �޷���&nbsp;&nbsp;
                <input type="radio" name="gu" value="1" <%if gu = 1 then response.write"checked" end if%>> 
                �����</td>
					</tr>
					<tr>
						<th>����</th>
						<td><input name="bun" type="radio" value="0" <%if bun = 0 then response.write"checked" end if%> onClick="cal_display(0);" > ���&nbsp;&nbsp;
<input type="radio" name="bun" value="1" <%if bun = 1 then response.write"checked" end if%> onClick="cal_display(1);" > �̻��</td>
					</tr>
					<tr>
						<th>ǥ����¼���</th>
						<td><input name="s_type" type="radio" value="0" <%if s_type = 0 then response.write"checked" end if%>> �з���&nbsp;&nbsp;
<input type="radio" name="s_type" value="1" <%if s_type = 1 then response.write"checked" end if%>> ����&nbsp;&nbsp;
                <input type="radio" name="s_type" value="2" <%if s_type = 2 then response.write"checked" end if%>> �з���+����</td>
					</tr>
				</tbody>
			</table>
</form>

		<div class="rbtn">
			<a href="javascript:cal_input();" class="btn">�����ϱ�</a>
			<a href="list.asp" class="btn trans">��Ϻ���</a>		
		</div>

<div id="playArea" style="display:<%if bun = 1 then response.write"none" end if%>;">
		<table class="tbl" style="width:100%">
			<colgroup>
			<col style="width:15%" />
			<col />
			<col style="width:20%" />
			<col style="width:20%" />
			<col style="width:15%" />
			</colgroup>
			<thead>
				<tr>
					<th>����</th>	
					<th>�з���</th>
					<th>�����÷�</th>
					<th>�����÷�</th>	
					<th>���</th>								
				</tr>				
			</thead>
			<tbody>
<form name="form" method="post">	
				<tr>
					<td>�з��߰�</td>
					<td><input name="title" type="text" class="inptxt1" id="title" size="40"></td>
					<td><input name="bg_color" type="text" class="inptxt1 w100" id="bg_color" size="7" >&nbsp;<a href="#" onClick="javascript:window.open('color1.asp?fname=form','color','width=400,height=350,menubar=no,scrollbars=no');" class="btns trans">����ǥ</a></td>
					<td><input name="font_color" type="text" class="inptxt1 w100" id="font_color" size="7" >&nbsp;<a href="#" onClick="javascript:window.open('color2.asp?fname=form','color','width=400,height=350,menubar=no,scrollbars=no');"  class="btns trans">����ǥ</a></td>
					<td><a href="javascript:cal_gu_mast();" class="btns trans">���</a></td>
				</tr>
</form>

 <%

		sql="select count(idx) from cal_gu_mast where sid = '"& sid &"'"
		set rs=db.execute(sql)
		
		board_count = rs(0)
		  
		sql="select idx,title,bg_color,font_color from cal_gu_mast where sid = '"& sid &"' order by ordnum asc,idx desc"
		set rs=db.execute(sql)
		if rs.eof or rs.bof then
		else
		i=1
		do until rs.eof

idx = rs(0)
title = rs(1)
bg_color = rs(2)
font_color = rs(3)
%>
<form name="form<%=idx%>" method="post">	
				<tr>
					<td><%if i > 1 then%><a href="javascript:cal_up('<%=idx%>');"><img src="../rad_img/a_up.gif" width="8" height="8" border="0"></a>&nbsp;<%end if%><%if board_count <> i then%><a href="javascript:cal_down('<%=idx%>');"><img src="../rad_img/a_down.gif" width="8" height="8" border="0"></a><%end if%></td>
					<td><input name="title" type="text" class="inptxt1" id="title" size="40" value="<%=title%>"></td>
					<td><input name="bg_color" type="text" class="inptxt1 w100" id="bg_color" size="7" value="<%=bg_color%>" >&nbsp;<a href="#" onClick="javascript:window.open('color1.asp?fname=form<%=idx%>','color','width=400,height=350,menubar=no,scrollbars=no');" class="btns trans">����ǥ</a></td>
					<td><input name="font_color" type="text" class="inptxt1 w100" id="font_color" size="7" value="<%=font_color%>">&nbsp;<a href="#" onClick="javascript:window.open('color2.asp?fname=form<%=idx%>','color','width=400,height=350,menubar=no,scrollbars=no');"  class="btns trans">����ǥ</a></td>
					<td><a href="javascript:cal_edit('<%=idx%>');" class="btns trans">����</a>&nbsp;<a href="javascript:cal_del('<%=idx%>');" class="btns"
>����</a></td>
				</tr>
</form>
<%           
		rs.movenext
		i=i+1
		loop
		rs.close
		end if
%>

			</tbody>
		</table>
</div>


	</div>
</div>
</body>
</html>
<!-- #include file = "../authpg_2.asp" -->