<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/dbcon.asp" -->

<%
dim idx,intpg,gbnS,strPart,strSearch,gm
dim v1,h,m,s,rs

gm = Request("gm")
idx = Request("idx")
intpg = Request("intpg")
gbnS = Request("gbnS")
strPart = Request("strPart")
strSearch = Request("strSearch")

Dim varPage
varPage = "gm="& gm &"&intpg=" & intpg & "&gbnS=" & gbnS & "&strPart=" & strPart & "&strSearch=" & strSearch

dim sql,dr
dim id,pwd,name,juminno1,juminno2,tel1,tel2,email,zipcode1,zipcode2,juso1,juso2,mileage,regdate,state,login_count,b_year,b_month,b_day,b_type,sms_res,email_res,sp1,sp2,sp3,memo,ip1,ip2,ip3

If Len(request("userid")) = 0 Then
sql = "select id,pwd,name,juminno1,juminno2,tel1,tel2,email,zipcode1,zipcode2,juso1,juso2,mileage,regdate,state,login_count,b_year,b_month,b_day,b_type,sms_res,email_res,sp1,sp2,sp3,memo,ip1,ip2,ip3 from member where idx=" & idx
else
sql = "select id,pwd,name,juminno1,juminno2,tel1,tel2,email,zipcode1,zipcode2,juso1,juso2,mileage,regdate,state,login_count,b_year,b_month,b_day,b_type,sms_res,email_res,sp1,sp2,sp3,memo,ip1,ip2,ip3 from member where id= '"& request("userid") &"'"
End if
set dr = db.execute(sql)

If dr.eof Or dr.bof Then

	response.write"<script>"
	response.write"alert('�����Ϳ���!!');"
	response.write"history.back();"
	response.write"</script>"
	response.end

Else

	id = dr(0)
	pwd = dr(1)
	name = dr(2)
	juminno1 = dr(3)
	juminno2 = dr(4)
	tel1 = split(dr(5),"-")
	tel2 = split(dr(6),"-")
	email = dr(7)
	zipcode1 = dr(8)
	zipcode2 = dr(9)
	juso1 = dr(10)
	juso2 = dr(11)
	mileage = dr(12)
	regdate = dr(13)
	state = dr(14)
	login_count = dr(15)
	b_year = dr(16)
	b_month = dr(17)
	b_day = dr(18)
	b_type = dr(19)
	sms_res = dr(20)
	email_res = dr(21)
	sp1 = dr(22)
	sp2 = dr(23)
	sp3 = dr(24)
	memo = dr(25)
	ip1 = dr(26)
	ip2 = dr(27)
	ip3 = dr(28)

dr.close
End if
%>
<!--#include file="../main/top.asp"-->
<!-- #include file="../../include/daum_zip.asp" -->
<script>
function go2VewPlay(pgidx,gn,id){
	if(gn > 1){
		//location.href="view_dan_view.asp?id=<%=id%>&idx=" + pgidx;
		openWindow4('view_dan_view.asp?id=<%=id%>&idx='+pgidx+'','1030','500');
	}
	else {
		//location.href="view_class_view.asp?id=<%=id%>&idx=" + pgidx;
		openWindow4('view_class_view.asp?id=<%=id%>&idx='+pgidx+'','1030','500');
	}		
}
function openWindow4(url,width,height) {
	var widths = width;
	var heights = height;
	var top = 30; // â�� �� ��ġ ����
	var left = 30;
	var temp2 = 'toolbar=no, scrollbars=yes, width='+widths+',height='+heights+',top='+top+',left='+left;
	var temp = url;
	window.open(temp, 'view_info', temp2);
}
function or_del(oidx,idx,intpg,gbnS,strPart,strSearch){
	var bool = confirm("�����Ͻðڽ��ϱ�?");
	if (bool){
		location.href = "order_del.asp?gm=<%=gm%>&oidx="+oidx+"&idx="+idx+"&intpg="+intpg+"&gbnS="+gbnS+"&strPart="+strPart+"&strSearch="+strSearch;
	}
}
function NumKeyOnly(){
	if((event.keyCode<48)||(event.keyCode>57)) event.returnValue=false;
}

function LocalNum(strNum){
	var strlocal="02|031|032|033|041|042|043|051|052|053|054|055|061|062|063|064|070|0505";
	var numLen = strlocal.split("|");
	for(i=0;i<numLen.length;i++){
		if(numLen[i] == strNum){
			return false;
			break;
		}
	}
return true;
}

function HandNum(strNum){
	var strlocal="010|011|016|017|018|019";
	var numLen = strlocal.split("|");
	for(i=0;i<numLen.length;i++){
		if(numLen[i] == strNum){
			return false;
			break;
		}
	}
	return true;
}

function emailCheck(str) {
	if(str.match(/[\w\-\~]+\@[\w\-\~]+(\.[\w\-\~]+)+/g)!=str) return true;
}

function goReg_Member(theform){
	var clmn;

	clmn = theform.email;
	if(clmn.value == ""){
		alert("�̸����� �Է����ּ���!");
		clmn.focus();
		return;
	}

	if(emailCheck(clmn.value)){
		alert("�̸����� ��Ȯ�ϰ� �Է����ּ���!");
		clmn.select();
		return;
	}


	clmn = theform.hp1;
	if(clmn.value==""){
		alert("�޴����� ��Ȯ�ϰ� �Է��ϼ���!");
		clmn.focus();
		return;
	}
	if(HandNum(clmn.value)){
		alert("���� ���� ��ȣ�Դϴ�.");
		clmn.select();
		return;
	}

	clmn = theform.hp2;
	if(clmn.value==""){
		alert("�޴����� ��Ȯ�ϰ� �Է��ϼ���!");
		clmn.focus();
		return;
	}
	if(clmn.value.length < 3){
		alert("�޴����� ��Ȯ�ϰ� �Է��ϼ���!");
		clmn.select();
		return;
	}

	clmn = theform.hp3;
	if(clmn.value==""){
		alert("�޴����� ��Ȯ�ϰ� �Է��ϼ���!");
		clmn.focus();
		return;
	}
	if(clmn.value.length < 4){
		alert("�޴����� ��Ȯ�ϰ� �Է��ϼ���!");
		clmn.select();
		return;
	}



theform.submit();
}

function delMember(){
	delok = confirm("üũ�� ȸ���� �����մϴ�");
	if(delok){
		location.href="deletemember.asp?idx=<%=idx%>";
	}
}
function viewLecGow(danIdx){
	var sFeatures = "width=770,height=500,top=0,left=0,scrollbars=no,resizable=no,titlebar=no";
	var k = window.open("setinput.asp?idx=" + danIdx, "viewpg", sFeatures);
	k.focus();
}


function contiSu(objtd,tdidx){
	var t = (window.screen.height / 2) - (300 / 2);
	var l = (document.body.offsetWidth / 2) - (200 / 2);

	var divIDn = document.getElementById("divID");
	divIDn.style.top = t + 400;
	divIDn.style.left = l + 28;
	divIDn.style.display = "block";
	divIDn.innerHTML = inContin(tdidx);
}

function inContin(idx){
	var  inHm = "";
	inHm += "<div class='layer'><table cellpadding=\"0\" cellspacing=\"0\" width=\"320\" bgcolor='#f7f7f7'>";
	inHm += "<tr height=\"80\">";
	inHm += "<td width=\"65%\" align='center'><strong>���� �Ⱓ �߰�/�谨 <input type=\"text\" class=\"inptxt1 w30\" name=\"intgigan\" id=\"intgigan\" size=\"3\" maxlength=\"3\"> ��</strong>"
	inHm += "<input type=\"hidden\" name=\"idxnn\" value=\"" + idx + "\"></td>";
	inHm += "<td width=\"35%\"><a href=\"javascript:ContinuOk('idxnn','intgigan');\" class=\"btns\">����</a>&nbsp;<a href=\"javascript:cnlContin();\" class=\"btns trans\">���</a></td>";
	inHm += "</tr>";
	inHm += "</table></div>";
return inHm;
}

function cnlContin(){
	var t = (window.screen.height / 2) - (300 / 2);
	var l = (document.body.offsetWidth / 2) - (200 / 2);

	var divIDn = document.getElementById("divID");
	divIDn.innerHTML = "";
	divIDn.style.top = t + 400;
	divIDn.style.left = l + 28;
	divIDn.style.display = "none";
}

function ContinuOk(){
	var args = ContinuOk.arguments;
	var clmnidx = eval("document.all." + args[0] + ".value");
	var clmn = eval("document.all." + args[1]);

	if(clmn.value==""){
		alert("�����Ⱓ�� �󸶳� �����Ͻðڽ��ϱ�?");
		clmn.focus();
		return;
	}

	var delok = confirm("�����Ⱓ�� " + clmn.value + "�� �����Ͻðڽ��ϱ�?");
	if(delok){
		location.href = "order_ch.asp?oidx="+escape(clmnidx)+"&gigan="+escape(clmn.value)+"&gm=<%=request("gm")%>&idx=<%=request("idx")%>&intpg=<%=request("intpg")%>&gbnS=<%=request("gbnS")%>&strPart=<%=request("strPart")%>&strSearch=<%=request("strSearch")%>";
	}else{
		cnlContin();
	}
}

</script>

<div class="container">
	<!--#include file="left.asp"-->
	<div class="content">
		<h2 class="cTit"><span class="bullet"></span>ȸ������</h2>

<form name="regfm" action="modfy.asp" method="post" style="display:inline;">
<input type="hidden" name="idx" value="<%=idx%>">
<input type="hidden" name="intpg" value="<%=intpg%>">
<input type="hidden" name="gbnS" value="<%=gbnS%>">
<input type="hidden" name="strPart" value="<%=strPart%>">
<input type="hidden" name="strSearch" value="<%=strSearch%>">
<input type="hidden" name="gm" value="<%=gm%>">

		<table class="ftbl mb50" style="width:100%">
				<colgroup>
					<col style="width:15%" />
					<col style="width:35%" />
					<col style="width:15%" />
					<col style="width:35%" />
				</colgroup>
				<tbody>
					<tr>
						<th>���̵�</th>
						<td><%=id%></td>
						<th>�̸�</th>
						<td><input type="text"  name="name" class="inptxt1" value="<%=name%>"></td>
					</tr>
					<tr>
						<th>��й�ȣ</th>
						<td colspan="3"><input  name="pwd" type="text" class="inptxt1" id="pwd"> <span class="stip">��й�ȣ ����ÿ��� �Է��Ͻø� �˴ϴ�.</span></td>
					</tr>
					<tr>
						<th>�������</th>
						<td colspan="3"><input type="text"  name="juminno1" class="inptxt1" value="<%=juminno1%>" onKeyPress="NumKeyOnly();"></td>
					</tr>
					<tr>
						<th>�̸����ּ�</th>
						<td colspan="3"><input type="text"  name="email" class="inptxt1 w400" value="<%=email%>"></td>
					</tr>
					<tr>
						<th>����ó</th>
						<td colspan="3"><input type="text"  name="hp1" class="inptxt1 w60" size="4" maxlength="3" value="<%=tel2(0)%>" onKeyPress="NumKeyOnly();"> -
							<input type="text"  name="hp2" class="inptxt1 w60" size="5" maxlength="4" value="<%=tel2(1)%>" onKeyPress="NumKeyOnly();"> -
							<input type="text"  name="hp3" class="inptxt1 w60" size="5" maxlength="4" value="<%=tel2(2)%>" onKeyPress="NumKeyOnly();"></td>
					</tr>

					<tr>
						<th rowspan="3">�ּ�</th>
						<td colspan="3"><input name="zipcode1" type="text" class="inptxt1 w60" id="post1" value="<%=zipcode1%>" >
						<a href="javascript:openDaumPostcode();" class="fbtn">�����ȣ</a></td>
					</tr>
					<tr>
						<td colspan="4"><input name="juso1" type="text" class="inptxt1 w500" id="addr" value="<%=juso1%>" ></td>
					</tr>
					<tr>
						<td colspan="4"><input name="juso2" type="text" class="inptxt1 w500" id="addr2" value="<%=juso2%>" ></td>
					</tr>

					<tr>
						<th>�̸��ϼ���</th>
						<td><input type="radio"<% if int(email_res) = 1 Or Len(email_res) = 0 then response.write " checked" %> name="email_res" value="1"> ����
							<input type="radio"<% if int(email_res) = 0 then response.write " checked" %> name="email_res" value="0"> ��������</td>
						<th>���ڼ���</th>
						<td><input type="radio"<% if int(sms_res) = 1 then response.write " checked" %> name="sms_res" value="1"> ����
							<input type="radio"<% if int(sms_res) = 0 then response.write " checked" %> name="sms_res" value="0"> ��������</td>
					</tr>
					<tr>
						<th>������</th>
						<td><%=regdate%></td>
						<th>����Ƚ��</th>
						<td><%=formatnumber(login_count,0)%>ȸ</td>
					</tr>
					<tr>
						<th>������</th>
						<td><input type="text" class="inptxt1 w60" maxlength="10" name="mileage" value="<%=mileage%>" onKeyPress="NumKeyOnly();"> ��</td>
						<th>ȸ������</th>
						<td><select name="state" class="seltxt">
								<option<% if int(state) = 0 then response.write " selected" %> value="0">����</option>
								<option<% if int(state) = 1 then response.write " selected" %> value="1">����</option>
								<option<% if int(state) = 2 then response.write " selected" %> value="2">����</option>
								</select>	</td>
					</tr>
					<tr>
						<th>ȸ���׷�</th>
						<td><select name="sp1" id="sp1" class="seltxt">
                              <option<% if int(sp1) = 0 then response.write " selected" %> value="0">�̼���</option>
<%
sql = "select idx,title from group_mast where gu = 0 "
set rs=db.execute(sql)

if rs.eof or rs.bof then
else
do until rs.eof
%>                              
                              <option<% if int(rs(0)) = sp1 then response.write " selected" %> value="<%=rs(0)%>"><%=rs(1)%></option>
<%
rs.movenext
loop
rs.close
end if
%>
                            </select></td>
						<th>���ڱ׷�</th>
						<td><select name="sp2" id="sp2" class="seltxt">
                              <option<% if int(sp2) = 0 then response.write " selected" %> value="0">�̼���</option>
<%
sql = "select idx,title from group_mast where gu = 1 "
set rs=db.execute(sql)

if rs.eof or rs.bof then
else
do until rs.eof
%>
                              <option<% if int(rs(0)) = sp2 then response.write " selected" %> value="<%=rs(0)%>"><%=rs(1)%></option>
                              <%
rs.movenext
loop
rs.close
end if
%>
                            </select></td>
					</tr>
					<tr>
						<th>�޸�</th>
						<td colspan="3"><textarea name="memo" cols="80" class="inptxt1 w500" style="height:50px"><%=memo%></textarea></td>
					</tr>

					<tr>
						<th>��Ͼ�����#1</th>
						<td colspan="3"><input name="ip1" type="text" class="inptxt1" id="ip1" value="<%=ip1%>" > <span class="stip">������ �Ͻǰ�� �������� ���ֽø� �˴ϴ�.</span></td>
					</tr>
					<tr>
						<th>��Ͼ�����#2</th>
						<td colspan="3"><input name="ip2" type="text" class="inptxt1" id="ip2" value="<%=ip2%>" > <span class="stip">������ �Ͻǰ�� �������� ���ֽø� �˴ϴ�.</span></td>
					</tr>
					<tr>
						<th>��Ͼ�����#3</th>
						<td colspan="3"><input name="ip3" type="text" class="inptxt1" id="ip3" value="<%=ip3%>" > <span class="stip">������ �Ͻǰ�� �������� ���ֽø� �˴ϴ�.</span></td>
					</tr>

				</tbody>
			</table>
</form>

		<div class="rbtn">
			<a href="javascript:goReg_Member(regfm);" class="btn">����</a>
			<a href="javascript:delMember();" class="btn trans">����</a>
			<a href="list.asp?<%=varPage%>" class="btn trans">���</a>
		</div>

		<div class="tbl_top">
			<a href="javascript:viewLecGow('<%=idx%>');" class="fbtn1">�������</a>
			<span class="tbl_total">* ����Ŭ���� 1�� ������ 1�� , 1�� ������ -1���Է��Ͻø� �˴ϴ�.</span>
		</div>

<% sql = "select idx,sutitle=case buygbn when 0 then dbo.LectuTitle(tabidx,buygbn) else  title + dbo.LectuTitle(tabidx,buygbn) end,sday,eday,intprice,state,holdgbn,buygbn,tabidx from order_mast where id='" & id & "' and state <> 1 and bookidx = 0 order by payday desc"
				set dr = db.execute(sql)
				dim isRecod
				if Not dr.Bof or Not dr.Eof then
					isRecod = True
					Dim isRows,isCols
					isRows = split(dr.GetString(2),chr(13))
				end if
				dr.close
				set dr = nothing
				db.close
				set db = nothing

				if isRecod then %>
				<div ID="ajaxList">
					<table class="tbl" style="width:100%">
						<tr>
							<th width="40%">��������</th>
					  <th width="10%">���ǽ�����</th>
					  <th width="10%">����������</th>
					  <th width="10%">����</th>
					  <th width="10%">����</th>
					  <th width="10%">�Ⱓ����</th>
				      <th width="10%">����</th>
					  </tr><% for ii = 0 to Ubound(isRows) - 1
						isCols = split(isRows(ii),chr(9)) %>
						<tr ID="tb<%=ii%>">
							<td class="tl">&nbsp;&nbsp;<a href="javascript:go2VewPlay('<%=isCols(8)%>',<%=isCols(7)%>);"><%=isCols(1)%></a></td>
							<td><%=FormatdateTime(isCols(2),2)%></td>
						  <td><%=FormatdateTime(isCols(3),2)%></td>
						  <td><%=FormatNumber(isCols(4),0)%></td>
						  <td><% if int(isCols(5)) > 0 then
								response.write "��������"
							else
								if int(isCols(6)) > 0 then
									response.write "�ް���"
								else
									response.write "������"
								end if
							end if %>							</td>
						  <td ID="td<%=ii%>"><a href="javascript:contiSu(this,'<%=isCols(0)%>');" class="btns">�Ⱓ����</a></td>
					      <td><a href="javascript:or_del('<%=isCols(0)%>','<%=idx%>','<%=intpg%>','<%=gbnS%>','<%=strPart%>','<%=strSearch%>');" class="btns trans">����</a></td>
					  </tr><% next %>
				  </table>					</div>
				<% else %><% end if %>

				<div class="caution mt80"><p>������������ ���� ������ Ŭ���Ͻø� ȸ�� ������ Ȯ�� �����մϴ�.</p></div>
				<div class="caution"><p>�Ⱓ���� �������� Ŭ���ϼż� �����Ⱓ ������ �ϽǼ� �ֽ��ϴ�.</p></div>
				<div class="caution"><p>������ϰ����� Ŭ���Ͻø� ���Ǹ� �����ڱ������� �߰��Ҽ� �ֽ��ϴ�.</p></div>
				<div class="caution mb80"><p>ȸ���׷��� �����Ͻø� ���ǹ� ���迡 ȸ���׷캰�� ������ �����Ҽ� �ֽ��ϴ�.</p></div>

				<div ID="divID" style="top:1100px;left:30%;z-index:2;display:none;position:absolute;background-color:#DEDFDE;width:200px;"></div>

	</div>
</div>

</body>
</html>
<!-- #include file = "../authpg_2.asp" -->