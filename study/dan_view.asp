<!-- #include file="../include/set_loginfo.asp" -->
<!-- #include file="../include/dbcon.asp" -->
<%
Dim nowPage : nowPage = Request("URL")
Dim dntGbn : dntGbn = request("dntGbn")
Dim dntNm
Dim idx
Dim v_time,rs,v_date,time1,time2
Dim v1,h,m,s
Dim icon,icon_count,jj
Dim check_time,check_time1,quiz_count,end_check
Dim ca1_name,ca2_name
Dim player1_check,player2_check,player3_check

sql = "select player1,player2,player3 from site_info"
Set rs=db.execute(sql)

If rs.eof Or rs.bof Then
	player1_check = "Y"
	player2_check = "Y"
	player3_check = "Y"
Else
	player1_check = rs(0)
	player2_check = rs(1)
	player3_check = rs(2)
rs.close
End if

dim strnm,strteach,tinfo,intprice,intgigan,totalnum,sajin,bcod,dbcate,book_idx,sub_title,mem_group,step_check_gu

idx = request("idx")

db.execute("update LecturTab set readnum=readnum+1 where idx=" & idx)

sql = "select strnm,strteach,intprice,intgigan,totalnum,sjin=case sajin when 'noimg.gif' then 'noimage.gif' else sajin end,ca1,tinfo,icon,book_idx,sub_title,mem_group,step_check,ca1,ca2 from LecturTab where idx=" & idx
set dr = db.execute(sql)

If dr.eof Or dr.bof Then

	Response.write"<script>"
	Response.write"alert('DB����');"
	Response.write"history.back();"
	Response.write"</script>"
	Response.End
	
Else

	strnm = dr(0)
	strteach = dr(1)
	intprice = dr(2)
	intgigan = dr(3)
	totalnum = dr(4)
	sajin = dr(5)
	dbcate = dr(6)
	tinfo = dr(7)
	icon = dr(8)
	book_idx = dr(9)
	sub_title = dr(10)
	mem_group = dr(11)
	step_check_gu = dr(12)
	ca1 = dr(13)
	ca2 = dr(14)

dr.close
End if

	sql = "select title from dan_category where idx=" & ca1
	set dr = db.execute(sql)

	If dr.eof Or dr.bof Then
		ca1_name = ""
	Else	
		ca1_name = dr(0)
	dr.close
	End if

If ca2 > 0 Then

	sql = "select title from dan_category where idx=" & ca2
	set dr = db.execute(sql)

	If dr.eof Or dr.bof Then
		ca2_name = ""
	Else	
		ca2_name = dr(0)
	dr.close
	End If
	
End if

Dim varPage : varPage = "ca1=" & Request("ca1") & "&ca2=" & Request("ca2") & "&idx=" & Request("idx")

If Len(mem_group) > 3 Then

	sql = "select sp1 from member where id = '"& str_User_ID &"'"
	Set dr = db.execute(sql)

	If dr.eof Or dr.bof Then

			response.redirect "../member/login.asp?str__Page="& server.urlencode(nowPage) &"?"& server.urlencode(varPage) &""
			response.End

	Else

		if instr(mem_group,", "& dr(0) &",") Then
		else

			response.write"<script>"
			response.write"alert('�ش� ���´� ���������� ���� ȸ���� ������ �����մϴ�.');"
			response.write"history.back();"
			response.write"</script>"
			response.End
			
		End If
		
	dr.close
	End if

End if

sql = "select count(idx) from sectionTab where l_idx=" & idx
set dr = db.execute(sql)

totalnum = dr(0)
dr.close

''***********************************************************************************************************************
''���� ������ üũ
Dim precheck : precheck = 0
Dim dancheck : dancheck = 0

if isUsr then

	''�����̾� ���¸� ����� üũ

	Dim order_mast_idx

	sql = "select top 1 idx from order_mast where id='" & str_User_ID & "' and buygbn = 0 and DateDiff(day,GetDate(),sday) <=0 and DateDiff(day,GetDate(),eday) >= 0 and state=0 and holdgbn=0 order by idx desc"
	set dr = db.execute(sql)

	If dr.eof Or dr.bof Then
		order_mast_idx = 0
	else
		order_mast_idx = dr(0)
	dr.close
	End if

	Dim primcnt
	sql = "select count(idx) from order_mast where id='" & str_User_ID & "' and buygbn = 0 and DateDiff(day,GetDate(),sday) <=0 and DateDiff(day,GetDate(),eday) >= 0 and state=0 and holdgbn=0"
	set dr = db.execute(sql)
	primcnt = dr(0)
	dr.close
	


	if int(primcnt) > 0 Then
		precheck = 1
	else

		''�����ϴ� ���� �ӿ� ���Ե� �ܰ� ����
		dim dancnt
		sql = "select count(idx) from order_mast where id='" & str_User_ID & "' and state=0 and  buygbn=1 and tabidx in (select mastidx from LectAry where lectidx=" & idx & ")"
		set dr = db.execute(sql)
		dancnt = dr(0)
		dr.close

		if int(dancnt) > 0 then
			dancheck = 1
		else

			dim ddn
			sql = "select count(idx) from order_mast where id='" & str_User_ID & "' and state=0 and buygbn=2 and tabidx=" & idx
			set dr = db.execute(sql)
			ddn = dr(0)
			dr.close

			if int(ddn) > 0 then
				dancheck = 1
			end if

		end if

	end if

end If
''***********************************************************************************************************************

Dim step_check(10000)

step_check(0) = 1
 %>
<!-- #include file="../include/head1.asp" -->

<script language="javascript">
function go2ViewerPlay(flg,intUnm,keynm){
	if(flg){
		alert("�α��� �Ͻ� �� �̿��ϼ���!");
		return;
	}
<%If precheck = 1 Or dancheck = 1 Then%>
	var urlnm="/viwer/viewer_ready.asp?order_mast_idx=<%=order_mast_idx%>&gbn=" + keynm + "&plidx=" + intUnm;
	var sFeatures = "width=980,height=560,top=0,left=0,scrollbars=no,resizable=no,titlebar=no";
	var k = window.open(urlnm, "viewpg", sFeatures);
	k.focus();
<%else%>
		alert("���������� ���ų� �������� �����Դϴ�!");
		return;
<%end if%>
}
function go2ViewerPlay_n(flg,intUnm,keynm){
	if(flg){
		alert("�α��� �Ͻ� �� �̿��ϼ���!");
		return;
	}
<%If precheck = 1 Or dancheck = 1 Then%>
	var urlnm="/viwer/viewer_ready_n.asp?order_mast_idx=<%=order_mast_idx%>&gbn=" + keynm + "&plidx=" + intUnm;
	var sFeatures = "width=980,height=560,top=0,left=0,scrollbars=no,resizable=no,titlebar=no";
	var k = window.open(urlnm, "viewpg", sFeatures);
	k.focus();
<%else%>
		alert("���������� ���ų� �������� �����Դϴ�!");
		return;
<%end if%>
}
</script>

<!-- #include file="../include/top.asp" -->

<div class="smain">  
	<!-- #include file="left.asp" -->

    <div class="content">
    	<div class="cont_tit">
        	<h3><%=strnm%></h3>
        </div>

<input type="hidden" name="II" value="<%=idx%>">
        <div class="scont">
<form name="fm" method="post">
            <table class="ftbl" style="width:830px">
                    <colgroup>
                    <col style="width:15%" />
                    <col style="width:35%" />
                    <col style="width:15%" />
					<col style="width:35%" />
                    </colgroup>
                    <thead>
							<tr>
								<th>����</th>
								<td><%=strteach%></td>
								<th>���±���</th>
								<td><%=totalnum%>��</td>
							</tr>
							<tr>
								<th>������</th>
								<td><span class="fr"><%=formatnumber(intprice,0)%>��</span></td>
								<th>�����Ⱓ</th>
								<td><%=intgigan%>��</td>
							</tr>
                    </thead>
                    <tbody>
<%If precheck = 1 Or dancheck = 1 Then
else%>
                        <tr>
                            <th>����</th>
                            <td colspan="3"><input type="checkbox" name="II" id="II" value="<%=idx%>" checked/>&nbsp;<strong><font color='#000000'>[����] <%=strnm%></font></strong>&nbsp;&nbsp;<strong class="fr"><%=formatnumber(intprice,0)%></strong>��<%
Dim bcount,i,book_pop
				
				book_pop = book_idx
				book_idx = split(book_idx,",")
				bcount = ubound(book_idx)

	If bcount > 0 then
		For i = 1 To bcount

				sql = "select price1,title,idx from book_mast where state = 0 and idx = "& book_idx(i)
				Set rs=db.execute(sql)

				If rs.eof Or rs.bof Then
				bcount = bcount - 1
				else
%><br /><input type="checkbox" name="JJ" id="JJ" value="<%=rs(2)%>" checked/>&nbsp;<strong>[����] <a href="/book/content.asp?idx=<%=rs(2)%>" target="_blank"><%=rs(1)%></a></strong>&nbsp;&nbsp;<strong class="fr"><%=formatnumber(rs(0),0)%></strong>��<%
				rs.close
				End if
		Next
	End if

If bcount < 0 Then bcount = 0
%></td>
                        </tr>
<%End if%>
                    </tbody>
                </table>
<input type="hidden" name="ii_count" value="1">
<input type="hidden" name="jj_count" value="<%=bcount%>">
</form>

			<div class="rbtn">
				<a href="dan_list.asp?ca1=<%=ca1%>&ca2=<%=ca2%>" class="mbtn">�������</a>
				<%If precheck = 1 Or dancheck = 1 Then%>
<%If precheck = 1 Then%>
<%
sql = "select top 1 idx from quiz_munje where ca1 = "& idx &" and ca2 = 0 order by idx desc"
Set rs=db.execute(sql)

If rs.eof Or rs.bof Then
Else
	Response.write "<a href=""javascript:quiz_pop("& rs(0) &");"" class=""mbtn red"">���躸��</a>"
rs.close
End If
%>
<%End if%>
<%If dancheck = 1 Then%>
				<a href="/my/01_buy_dan_view.asp?idx=<%=idx%>" class="mbtn red">���Ǻ���</a>
<%End if%>
				<%else%>
				<a href="javascript:AryDanBuy(<%=strProg%>,<%=bcount%>);" class="mbtn red">������û</a><a href="javascript:AryDanBaguy(<%=strProg%>,<%=bcount%>);" class="mbtn grey">��ٱ���</a>
				<%End if%>
			</div>

<%
If precheck = 1 Or dancheck = 1 Then
else
%>
            <h3 class="stit">���¼���</h3>
            <ul class="detail">
					<li><%=tinfo%></li>
			</ul>
<%End if%>

            <h3 class="stit">���±���</h3>
            <table class="btbl" style="width:830px">
					<colgroup>
<%If precheck = 1 then%>
						<col style="width:10%" />
						<col style="width:40%" />
						<col style="width:10%" />
						<col style="width:40%" />
<%else%>
						<col style="width:10%" />
						<col style="width:62%" />
						<col style="width:13%" />
						<col style="width:15%" />
<%End if%>
					</colgroup>
					<thead>
						<tr>
<%If precheck = 1 then%>
							<th>ȸ��</th>								
							<th>���Ǹ�</th>
							<th>���ǽð�</th>
							<th>���Ǻ���</th>
<%else%>
							<th>ȸ��</th>								
							<th>���Ǹ�</th>
							<th>���ǻ���</th>
							<th>���ǽð�</th>
<%End if%>
						</tr>				
					</thead>
					<tbody>
<%
sql = "select idx,strnm,ordnum,strtime,lecsum,lecsrc,freegbn,mckey,movlink,movlink1,freelink,isnull(dbo.function_quiz_munje_count(idx),0),dbo.function_view_mast_check1('"& str_User_ID &"',idx),dbo.function_view_mast_check2('"& str_User_ID &"',idx),dbo.function_view_mast_check3('"& str_User_ID &"',idx),dbo.function_view_mast_check4('"& str_User_ID &"',idx) from sectionTab where l_idx=" & idx & " order by ordnum"
set dr = db.execute(sql)

If dr.eof Or dr.bof Then
Else
ii = 0
Do Until dr.eof

check_time1 = 0
step_check(ii+1) = 0

If step_check_gu = 0 Then step_check(ii) = 1

quiz_count = dr(11)
v_time = dr(12)
v_date = dr(13)
end_check = dr(15)

check_time  = split(dr(3),":")
check_time1 = (int(check_time(0)) * 60) + int(check_time(1))

If end_check = 0 then

	If v_time > 0 then		  

	v1 = v_time 
	h = (int)(v1 / 3600)
	if len(h) = 1 then	h = "0"& h &""
	v1 = v1 mod 3600
	m = (int)(v1 / 60)

	if len(m) = 1 then	m = "0"& m &""
	s = v1 mod 60  

	if len(s) = 1 then	s = "0"& s &""

	End If

End If

If end_check > 0 Then step_check(ii+1) = 1

If precheck = 1 then%>
				<tr>
					<td><%=ii+1%>ȸ</td>

					<td class="tl"><%=dr(1)%></td>

					<td><%=dr(3)%><br /><%If end_check > 0  Then%>(�����Ϸ�)<%else%><%if v_time > 0 then response.write "("& h &":"& m &":"& s &")" else response.write"(�̼���)" end if%><%End if%></td>

<%If step_check(ii) = 1 then%>

					<td>
					<% if Len(dr(7)) = 0 and Len(dr(8)) = 0 then %>
					<% else %>
					<%If Len(player1_check) > 0 then%><a href="javascript:go2ViewerPlay(<%=strProg%>,'<%=dr(0)%>','wmv');" class="mmminii">���Ǻ���#1</a><%End if%> 
					<%If Len(player2_check) > 0 then%><a href="javascript:go2ViewerPlay_n(<%=strProg%>,'<%=dr(0)%>','wmv');" class="mmminii">���Ǻ���#2</a><%End if%>
					<%If Len(player3_check) > 0 then%><a href="javascript:go2ViewerPlay_n(<%=strProg%>,'<%=dr(0)%>','kollus');" class="mmminii">���Ǻ���#3</a><%End if%>
					<% end if %>					

					<%if (end_check > 0 or int(v_time)  >= int(check_time1)) and quiz_count > 0 then%><a href="javascript:quiz_pop(<%=quiz_count%>);" class="mmmini">���躸��</a><%end if%>
					<% if dr(10) = "" then %><% else %><a href="javascript:go2ViewerPlay(<%=strProg%>,'<%=dr(0)%>','free');" class="mmmini">�Ϲݺ���</a><% end if %>
					<% if Len(dr(4)) > 0 then %><a href="<%=dr(4)%>" target="_blank" class="mmmini">�ڷ�#1</a><% end if %>
					<% if Len(dr(5)) > 0 then %><a href="<%=dr(5)%>" target="_blank" class="mmmini">�ڷ�#2</a><% end if %></td>	

<%else%>
					<td><%=ii%>ȸ�� ���Ǹ� �����Ϸ����ּ���.</td>
<%End if%>

				</tr>	
<%else%>
				<tr>
					<td><%=ii+1%>ȸ</td>
					<td class="tl"><%=dr(1)%></td>
					<td><%If dr(6) = 1 Then%><a href="javascript:viewSample1(<%=strProg%>,'<%=idx%>','<%=dr(0)%>');" class="sbtn">������</a><%End if%></td>
					<td><%=dr(3)%></td>					
				</tr>		
<%
End if

	dr.movenext
	ii = ii + 1
	Loop
	dr.close

End if
%>
					</tbody>
				</table>

            <h3 class="stit">�����ı�</h3>
            <table class="btbl" style="width:830px">
					<colgroup>
						<col style="width:10%" />
						<col style="width:55%" />
						<col style="width:15%" />
						<col style="width:10%" />
						<col style="width:10%" />
					</colgroup>
					<thead>
						<tr>
							<th>��ȣ</th>								
							<th>�ı�</th>
							<th>����</th>
							<th>�ۼ���</th>
							<th>�����</th>		
						</tr>				
					</thead>
					<tbody>
<%
sql = "select idx,id,name,content,regdate,star from lec_reply where vidx = "& request("idx")
Set rs=db.execute(sql)

If rs.eof Or rs.bof Then
Else
i=1
Do Until rs.eof
%>
				<tr>
					<td><%=i%></td>
					<td class="tl"><%If Len(rs(3)) > 140 then%><%=cutstr(rs(3),140)%>&nbsp;&nbsp;<a href="#" onclick="layer_open('layer2',<%=rs(0)%>);return false;"><font color='#cc0000'>[������]</font></a><%else%><%=replace(rs(3),chr(13) & chr(10),"<br>")%><%End if%></td>
					<td><img src="../img/img/<%=rs(5)%>.png" ></td>
					<td><%=Left(rs(2),1)%>**</td>
					<td><%=Replace(Left(rs(4),10),"-",".")%></td>
				</tr>
<%
rs.movenext
i=i+1
Loop
rs.close
End if
%>
					</tbody>
				</table>

	<div class="rbtn"><%
sql = "select count(idx) from lec_reply where vidx = "& request("idx") &" and id = '"& str_User_ID &"'"
Set rs=db.execute(sql)

If rs(0) = 0 then

	response.write"<a href=""javascript:go2Logpg1("& strProg &",'reply_write.asp?idx="& request("idx") &"&dntGbn="& request("dntGbn") &"&repage=dan_view');"" class=""mbtn red"">�����ı��ۼ�</a>"

rs.close
End if
%></div>

        </div>
    </div>
</div>

<style>
.layer {display:none; position:fixed; _position:absolute; top:0; left:0; width:100%; height:100%; z-index:555;}
.layer .bg {position:absolute; top:0; left:0; width:100%; height:100%; background:#000; opacity:.5; filter:alpha(opacity=50);}
.layer .pop-layer {display:block;}

.pop-layer {display:none; position: absolute; top: 50%; left: 50%; width: 770px; height:auto;  background-color:#fff; z-index: 10;}	
.pop-layer .pop-container {padding: 20px 25px 40px; overflow:hidden;}
.pop-layer p.ctxt {color: #666; line-height:25px; text-align:center;}
.pop-layer p.ctxt img{max-width:139px;}
.pop-layer .login-input{background-color:#fff; border:1px solid #ddd; width:100%; padding:10px; box-sizing:border-box; margin:4px 0px}
.pop-layer .login-input[type="password"]{font-family:'dotum'}
.pop-layer .btn-r {text-align:right;}
</style>
<!-- ���̾� �˾� -->
<div class="layer">
	<div class="bg"></div>
	<div id="layer2" class="pop-layer">
		<div class="pop-container">
			<div class="pop-conts">
				<div class="btn-r">
					<a href="#" class="cbtn"><img src='/img/btn_close.png'></a>
				</div>
				<div  id="openwin_99"></div>
			</div>
		</div>
	</div>
</div>
<!-- ���̾� �˾� end -->
<script type="text/javascript">
	function layer_open(el,idx){
		var temp = $('#' + el);
		var bg = temp.prev().hasClass('bg');	//dimmed ���̾ �����ϱ� ���� boolean ����
		if(bg){
			$('.layer').fadeIn();	//'bg' Ŭ������ �����ϸ� ���̾ ��Ÿ���� ����� dimmed �ȴ�. 
		}else{
			temp.fadeIn();
		}

		// ȭ���� �߾ӿ� ���̾ ����.
		if (temp.outerHeight() < $(document).height() ) temp.css('margin-top', '-'+temp.outerHeight()/2+'px');
		else temp.css('top', '0px');
		if (temp.outerWidth() < $(document).width() ) temp.css('margin-left', '-'+temp.outerWidth()/2+'px');
		else temp.css('left', '0px');

		temp.find('a.cbtn').click(function(e){
			if(bg){
				$('.layer').fadeOut(); //'bg' Ŭ������ �����ϸ� ���̾ ������� �Ѵ�. 
			}else{
				temp.fadeOut();
			}
			e.preventDefault();
		});

		$('.layer .bg').click(function(e){	//����� Ŭ���ϸ� ���̾ ������� �ϴ� �̺�Ʈ �ڵ鷯
			$('.layer').fadeOut();
			e.preventDefault();
		});

		$.ajax({
			url: "../xml/reply_view.asp",
			type:"POST",
			data:{"idx":idx},
			dataType:"text",
			cache:false,
			processData:true,
			success:function(_data){	

				$('#openwin_99').html(_data);

			},
			error:function(xhr,textStatus){
			alert("[����]����:"+xhr.status+"                                     ");
			}	
		});		

	}			
</script>

<!-- #include file="../include/bottom.asp" -->
<script>
function quiz_pop(idx)
{ 
window.open('../quiz/quiz.asp?idx='+ idx,'quiz_window','height=100,width=100,scrollbars=yes');
} 
function viewSample(flg,intUnm){
	if(flg){
		location.href="/member/login.asp?str__Page=" + encodeURIComponent("<%=nowPage%>?idx=<%=request("idx")%>");
	}else{
		var urlnm="../viwer/smple_ready.asp?vtype=dan&plidx=" + intUnm;
		var sFeatures = "width=960,height=535,top=0,left=0,scrollbars=no,resizable=no,titlebar=no";
		var k = window.open(urlnm, "viewpg", sFeatures);
		k.focus();
	}
}
function viewSample1(flg,intUnm,sidx){
	if(flg){
		location.href="/member/login.asp?str__Page=" + encodeURIComponent("<%=nowPage%>?idx=<%=request("idx")%>");
	}else{
		var urlnm="../viwer/dan_sample.asp?vtype=dan&plidx=" + intUnm +"&sidx="+sidx;
		var sFeatures = "width=960,height=535,top=0,left=0,scrollbars=no,resizable=no,titlebar=no";
		var k = window.open(urlnm, "viewpg", sFeatures);
		k.focus();
	}
}
function AryDanBaguy(flg,n){
	if(flg){
		location.href="../member/login.asp?str__Page=" + encodeURIComponent("<%=nowPage%>?dntGbn=<%=dntGbn%>");
	}else{
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
			alert(' ��ٱ��Ͽ� ������ ��ǰ�� �������ּ���!!');
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

		var params = "key="+encodeURIComponent(strbxt)+"&key1="+encodeURIComponent(strbxt1);
		//self.location.href='danbgunyxml.asp?'+params;
		sndReq("danbgunyxml.asp",params,setBasket,"POST");

	}
}

function setBasket(){
	if(objXmlhttp.readyState == 4){
		if(objXmlhttp.status==200){
			var xmlDoc = objXmlhttp.responseXML;
			var obj = xmlDoc.getElementsByTagName("isrows");
			var flg =eval(obj[0].getAttribute("flg"));
			var chkid = obj[0].getAttribute("chkid");

			if(flg){
			 	alert("��ٱ��Ͽ� �����ϴµ� ���� �߻� : �α������� �ʾҰų�, ��Ʈ������");
			}else{
				var bool = confirm("��ٱ��Ͽ� ����Ǿ����ϴ�.\n���� Ȯ���Ͻðڽ��ϱ�?");
				if (bool){
					location.href = "/my/03_bguny.asp";
				}
				return;
			}

		}else{
			alert("��Ʈ�� ���� : �����ڿ��� �����ϼ���!");
		}
	}
}
function AryDanBuy(flg,n){
	if(flg){
		location.href="/member/login.asp?str__Page=" + encodeURIComponent("<%=nowPage%>?idx=<%=request("idx")%>");
	}else{
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

		var params = "key="+encodeURIComponent(strbxt)+"&key1="+encodeURIComponent(strbxt1);
		sndReq("danbuyxml.asp",params,setBuy,"POST");
	}
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
					alert("�����̾�  ���¸� �����ϰ� �����Ƿ� �ܰ� ���¸� �����Ͻ� �ʿ䰡 �����ϴ�!");
					return;
				}

				location.href="../elpay/pay_dan.asp";
			}

		}else{
			alert("��Ʈ�� ���� : �����ڿ��� �����ϼ���!");
		}
	}
}

</script>
<%
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