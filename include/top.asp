<%
dim lsql,lrs,my_count,qa_count,top_banner

top_banner = 0

db.execute("sp_HoldOff '" & date & "'")

Dim user_IP1
user_IP1 = Request.Servervariables("REMOTE_ADDR")

Dim Dr1,CountIN1
Set Dr1 = db.execute("select Count(user_IP) from Chk_IP where user_IP='" & user_IP1 & "' and regdate='"& date() &"'")
CountIN1 = Dr1(0)

Dr1.Close

if CountIN1 < 1 then

Dim temp1

temp1 = split(request.ServerVariables("HTTP_USER_AGENT"),";")

dim vBrowser1, vOS1

if ubound(temp1) > 1 then
	vBrowser1 = temp1(1)
	vOS1 = temp1(2)
	vOS1 = replace(vOS1,")","")

	vBrowser1 = trim(vBrowser1)
	vOS1 = trim(vOS1)
	vBrowser1 = replace(vBrowser1,"'","''")
	vOS1 = replace(vOS1,"'","''")
end if

dim vReferer1,vDW1,vTarget1

vReferer1 = request.ServerVariables("HTTP_REFERER")
vTarget1 = request.ServerVariables("SCRIPT_NAME") & "?" & request.ServerVariables("QUERY_STRING")
vDW1 = weekday(date)

dim vSeason1
select case month(date)
	case 1,2,3
		vSeason1 = 1
	case 4,5,6
		vSeason1 = 2
	case 7,8,9
		vSeason1 = 3
	case 10,11,12
		vSeason1 = 4
end select

db.execute("insert into Chk_IP (user_IP,regdate) values ('" & user_IP1 & "','"& date &"')")

sql = "delete from Chk_IP where regdate <> '"& date() &"'"
db.execute sql,,adexecutenorecords

sql = "insert into Visit_Counter (vIP,vYY,vMM,vDD,vHH,vMT,vSeason,vDW,vBrowser,vOS,VReferer,vTarget) values ('"
sql = sql & user_IP1 & "'," & year(date) & "," & month(date) & "," & day (date) & "," & hour(now) & "," & minute(now) & ","
sql = sql & vSeason1 & "," & vDW1 & ",'" & vBrowser1 &"','" & vOS1 & "','" & vReferer1 &"','"& vTarget1 &"')"
db.execute(sql)

end if

Dim sns_kakao,sns_naver1,sns_naver2,t_menu1,t_menu2,t_menu3,t_menu4,t_menu5,t_menu6,t_menu7,t_menu8,t_menu9,t_menu10
Dim t_menu_sub1,t_menu_sub2,t_menu_sub3,t_menu_sub4,t_menu_sub5,t_menu_sub6,t_menu_sub7,t_menu_sub8,t_menu_sub9,t_menu_sub10

lsql = "select kakao,naver1,naver2,t_menu1,t_menu2,t_menu3,t_menu4,t_menu5,t_menu6,t_menu7,t_menu8,t_menu9,t_menu10,t_menu_sub1,t_menu_sub2,t_menu_sub3,t_menu_sub4,t_menu_sub5,t_menu_sub6,t_menu_sub7,t_menu_sub8,t_menu_sub9,t_menu_sub10 from site_info"
Set lrs=db.execute(lsql)

If lrs.eof Or lrs.bof Then

	t_menu1 = "�п��Ұ�"
	t_menu2 = "������û"
	t_menu3 = "�����ԼҰ�"
	t_menu4 = "����Ұ�"
	t_menu5 = "�׽�Ʈ"
	t_menu6 = "�н�Ŀ�´�Ƽ"
	t_menu7 = "������"
	t_menu8 = "���ǰ��ǽ�"
	t_menu9 = ""
	t_menu10 = ""
	t_menu_sub1 = "Company"
	t_menu_sub2 = "Class"
	t_menu_sub3 = "Teach"
	t_menu_sub4 = "Book"
	t_menu_sub5 = "Test"
	t_menu_sub6 = "BBS"
	t_menu_sub7 = "Cs"
	t_menu_sub8 = "Myroom"
	t_menu_sub9 = ""
	t_menu_sub10 = ""

Else
	
	sns_kakao = lrs(0)
	sns_naver1 = lrs(1)
	sns_naver2 = lrs(2)
	t_menu1 = lrs(3)
	t_menu2 = lrs(4)
	t_menu3 = lrs(5)
	t_menu4 = lrs(6)
	t_menu5 = lrs(7)
	t_menu6 = lrs(8)
	t_menu7 = lrs(9)
	t_menu8 = lrs(10)
	t_menu9 = lrs(11)
	t_menu10 = lrs(12)
	t_menu_sub1 = lrs(13)
	t_menu_sub2 = lrs(14)
	t_menu_sub3 = lrs(15)
	t_menu_sub4 = lrs(16)
	t_menu_sub5 = lrs(17)
	t_menu_sub6 = lrs(18)
	t_menu_sub7 = lrs(19)
	t_menu_sub8 = lrs(20)
	t_menu_sub9 = lrs(21)
	t_menu_sub10 = lrs(22)

lrs.close
End if

str__Page = Request("str__Page")

if str__Page = "" then
	str__Page = Request.ServerVariables("PATH_INFO") & str__Var
end if

'if inStr(str__Page,"/pstudy") = 1 then
'	str__Page = Replace(str__Page,"/pstudy","")
'end if

if InStr(str__Page,"/member/") > 0 then
	str__Page = "/main/index.asp"
end if

dim logoimg : logoimg = "logo.gif"
sql = "select imgsrc from logoTab where gbn=1"
set dr = db.execute(sql)
if not dr.bof or not dr.eof then
	logoimg = dr(0)
end if
dr.close

dim logoimg1 : logoimg1 = "logo.gif"
sql = "select imgsrc from logoTab where gbn=2"
set dr = db.execute(sql)
if not dr.bof or not dr.eof then
	logoimg1 = dr(0)
end if
dr.close

if len(str_User_ID) > 0 then

	dim new_ip,m_ip,dr99,sql99,check_login_code
		
	new_ip = Request.ServerVariables("HTTP_X_FORWARDED_FOR")'Ŭ���̾�Ʈ�� ����IP����
	
	If new_ip = "" Then '����Ip�ƴҶ� ����IP����(Ŭ���̾�Ʈ)
	   new_ip = Request.ServerVariables("REMOTE_ADDR")
	end If
	
	if new_ip="" or len(new_ip)=0 then
	   response.write "<script language=javascript>alert('�ҹ����� �����Դϴ�.1');location.href='../member/logout.asp';</script>"
	   response.end
	end if

	sql99 = "select ins_my from member where id = '"& str_User_ID &"'"
	set dr99 = db.execute(sql99)

	if not dr99.bof or not dr99.eof then
		m_ip = dr99(0)
	dr99.close
	end if		

	if Trim(m_ip) <> Trim(new_ip) then
	   response.write "<script language=javascript>alert('�ҹ����� �����Դϴ�.');location.href='../member/logout.asp';</script>"
	   response.end
	end if	

end if

Function cutStrEv(strev, cutLenev)
	Dim strLenev, strByteev, strCutev, strResev, charev, iev
	strLenev = 0
	strByteev = 0
	strLenev = Len(strev)
	for iev = 1 to strLenev
		charev = ""
		strCutev = Mid(strev, iev, 1)
		charev = Asc(strCutev)
		charev = Left(charev, 1)
		if charev = "-" then
			strByteev = strByteev + 2
		else
			strByteev = strByteev + 1
		end if
		if cutLenev < strByteev then
			strResev = strResev & ".."
			exit for
		else
			strResev = strResev & strCutev
		end if
	next
	cutStrEv = strResev
End Function %>
<script language="javascript">
function go2Logpg(flg,ul){
	if(flg){
		alert("�α����� ���� �̿��� �����մϴ�!");
		location.href="../member/login.asp?str__Page=" + encodeURIComponent(ul);
	}else{
		location.href=".." + ul;
	}
}
function go2Logpg1(flg,ul){
	if(flg){
		alert("�α����� ���� �̿��� �����մϴ�!");
		location.href="/member/login.asp?str__Page=" + encodeURIComponent(ul);
	}else{
		location.href="" + ul;
	}
}

function go2Search(sKey,sfm){
	if(sKey || event) event.returnValue = false;
	clmn = sfm.searchStr;
	if(clmn.value==""){
		alert("�˻�� �Է����ּ���!");
		clmn.focus();
		return;
	}
	if(clmn.value.replace(/ /g,"") == ""){
		alert("�˻�� �Է����ּ���!");
		clmn.select();
		return;
	}
	if(clmn.value.length < 2){
		alert("�˻���� 2�� �̻� �Է��ϼž� �մϴ�!");
		clmn.select();
		return;
	}
sfm.submit();
}

function bookmarksite() { 
     bookmark_url  = "<%=shop_url%>"; 
     bookmark_name = "<%=s_name%>"; 
     
     try {
      window.external.AddFavorite(bookmark_url,bookmark_name);
     } catch(e) {
      alert('�� �������� ���ã�� �߰� ����� �������� �ʽ��ϴ�.');
      return false;
     }
 }
function tmenu_check(){

	if (tdivList1.style.display == "")
	{
		tdivList1.style.display = "none";
	}
	else
	{
		tdivList1.style.display = "";
	}
} 
$(document).ready(function(){
        $(document).bind('keydown',function(e){
            if ( e.keyCode == 123 /* F12 */) {
                e.preventDefault();
                e.returnValue = false;
            }
        });
});
    
// ���� Ŭ�� ����
document.onmousedown=disableclick;
status="Right click is not available.";
    
function disableclick(event){
        if (event.button==2) {
            alert(status);
            return false;
    }
}
</script>

<link rel="canonical" href="http://<%=request.ServerVariables("HTTP_HOST")%>">
<meta property="og:title" ConTENT="<%=shop_title%>"/>
<meta property="og:site_name" ConTENT="<%=shop_title%>"/>
<meta property="og:type" ConTENT="website"/>
<meta property="og:url" ConTENT="http://<%=request.ServerVariables("HTTP_HOST")%>"/>
<meta property="og:description" ConTENT="<%=shop_keyword%>"/>
<meta property="og:image" ConTENT="http://<%=request.ServerVariables("HTTP_HOST")%>/ahdma/logo/<%=logoimg%>"/>

<body>
<div class="header">
    <!--  TOP �޴�  -->
    <div class="tmenu">
        <ul>
            <li class="left"><a href="" class="favor">+ ���ã�� �߰�</a></li>
            <% if isUsr then %>
			<li class="right"><a href="/member/logout.asp">�α׾ƿ�</a><span class="slash">|</span><a href="/my/05_myinfo.asp">��������</a><span class="slash">|</span><a href="javascript:go2Logpg(<%=strProg%>,'/my/01_main.asp');"><strong><%=t_menu8%></strong></a></li>
			<%else%>
			<li class="right"><a href="/member/login.asp">�α���</a><span class="slash">|</span><a href="/member/agree.asp">ȸ������</a><span class="slash">|</span><a href="javascript:go2Logpg(<%=strProg%>,'/my/01_main.asp');"><strong><%=t_menu8%></strong></a></li>
			<%End if%>
        </ul>
    </div>
    <div class="tWrap">
        <h1><a href="/main/index.asp"><img src="/ahdma/logo/<%=logoimg%>" /></a></h1>
<form name="searfm" method="post" action="../search/main.asp">        
		<div class="tsearch">
            <input type="text" id="searchStr" name="searchStr" placeholder="�˻�� �Է��� �ּ���!" />
            <a href="javascript:go2Search(false,searfm);" class="btn_sch mbg">�˻��ϱ�</a> 
		</div>
</form>
        <div class="tban"><%
sql99 = "select top 1 banner,banner_url,filegbn,target from banner where areagbn='013' order by idx desc"
	set dr99 = db.execute(sql99)
	if not dr99.bof or not dr99.eof then
	do until dr99.eof 
	response.write BannerOutput1(dr99(0),dr99(1),dr99(2),258,dr99(3))
	dr99.movenext
	Loop
	end if
	dr99.close%></div>
    </div>
    <!--  �޴� �κ�   -->
    <div class="meWrap">
        <ul class="menu">
            <li class="all_cate"><a href="javascript:tmenu_check();" class="mbg">��ü����</a></li>
            <li class="melist">
			<%If Len(t_menu1) > 0 then%><a href="/page/page.asp" ><%=t_menu1%></a><%End if%>
			<%If Len(t_menu2) > 0 then%><a href="/study/class_list.asp" ><%=t_menu2%></a><%End if%>
			<%If Len(t_menu3) > 0 then%><a href="/teach/teach.asp" ><%=t_menu3%></a><%End if%>
			<%If Len(t_menu4) > 0 then%><a href="/book/list.asp" ><%=t_menu4%></a><%End if%>
			<%If Len(t_menu5) > 0 then%><a href="/quiz/list.asp" ><%=t_menu5%></a><%End if%>
			<%If Len(t_menu6) > 0 then%><a href="/cumm/list.asp" ><%=t_menu6%></a><%End if%>
			<%If Len(t_menu7) > 0 then%><a href="/cs/nlist.asp" ><%=t_menu7%></a><%End if%></li>
        </ul>
    </div>
    <div class="smeWrap" style="display:none" id="tdivList1">
        <div class="smenu">
			<%If Len(t_menu1) > 0 then%>
            <dl>
                <dt><%=t_menu1%></dt>
                <dd><% 
sql99 = "select idx,jemok from guideTab where gbn = 2 order by ordnum asc,idx desc"
set dr99 = db.execute(sql99)
if not dr99.bof or not dr99.eof then
do until dr99.eof 
%><a href="/page/page.asp?idx=<%=dr99(0)%>"><%=dr99(1)%></a><%
dr99.movenext
Loop
else 
dr99.close	
end if	  
%></dd>
            </dl>
<%End if%>
<%If Len(t_menu2) > 0 then%>
            <dl>
                <dt><%=t_menu2%></dt>
                <dd><%If ksnetid = "1" then%><a href="/study/premium.asp">�����н� ��û</a><%End if%>
<% 
sql99 = "select idx,bname from mscate where state = 0 order by ordnum"
set dr99 = db.execute(sql99)
if not dr99.bof or not dr99.eof then
do until dr99.eof 
%><a href="/study/class_list.asp?categbn=<%=dr99(0)%>"><%=dr99(1)%></a><%
dr99.movenext
Loop
else 
dr99.close	
end if	  

sql99 = "select idx,title,(select count(idx) from dan_category where deep=1 and uidx=A.idx) from dan_category A where state = 0 and deep=0 order by ordnum asc,idx desc"
set dr99 = db.execute(sql99)
if not dr99.bof or not dr99.eof then
do until dr99.eof 
%><a href="/study/dan_list.asp?ca1=<%=dr99(0)%>"><%=dr99(1)%></a><%
dr99.movenext
Loop
else 
dr99.close	
end if	  
%></dd>
            </dl>
<%End if%>
<%If Len(t_menu3) > 0 then%>
            <dl>
                <dt><%=t_menu3%></dt>
                <dd><% 
sql99 = "select idx,name,(select count(idx) from teach_mast where guk = A.name) from teach_category A where deep=0 order by order_num asc,idx desc"
set dr99 = db.execute(sql99)
if not dr99.bof or not dr99.eof then
do until dr99.eof 
%><a href="/teach/teach.asp?ca=<%=dr99(0)%>"><%=dr99(1)%></a><%
dr99.movenext
Loop
else 
dr99.close	
end if	  
%></dd>
            </dl>
<%End if%>
<%If Len(t_menu4) > 0 then%>
            <dl>
                <dt><%=t_menu4%></dt>
                <dd><% 
sql99 = "select idx,title,(select count(idx) from shop_category where deep=1 and uidx = A.idx) from shop_category A where deep=0 order by ordnum asc,idx desc"
set dr99 = db.execute(sql99)
if not dr99.bof or not dr99.eof then
do until dr99.eof 
%><a href="/book/list.asp?ca1=<%=dr99(0)%>"><%=dr99(1)%></a><%
dr99.movenext
Loop
else 
dr99.close	
end if	  
%></dd>
            </dl>
<%End if%>
<%If Len(t_menu5) > 0 then%>
            <dl>
                <dt><%=t_menu5%></dt>
                <dd><% 
sql99 = "select idx,title,(select count(idx) from quiz_category where deep=1 and uidx = A.idx) from quiz_category A where deep=0 order by ordnum asc,idx desc"
set dr99 = db.execute(sql99)
if not dr99.bof or not dr99.eof then
do until dr99.eof 
%><a href="/quiz/list.asp?tca1=<%=dr99(0)%>"><%=dr99(1)%></a><%
dr99.movenext
Loop
else 
dr99.close	
end if	  
%></dd>
            </dl>
<%End if%>
<%If Len(t_menu6) > 0 then%>
            <dl>
                <dt><%=t_menu6%></dt>
                <dd><% 
sql99 = "select idx,jemok from board_mast where ygbn > 1 order by ordnum asc,idx desc"
set dr99 = db.execute(sql99)
if not dr99.bof or not dr99.eof then
do until dr99.eof 
%><a href="/cumm/list.asp?tabnm=<%=dr99(0)%>"><%=dr99(1)%></a><%
dr99.movenext
Loop
else 
dr99.close	
end if	  

sql99 = "select idx,jemok from board_mast where ygbn = 1 order by ordnum asc,idx desc"
set dr99 = db.execute(sql99)
if not dr99.bof or not dr99.eof then
do until dr99.eof 
%><a href="/jalyo/list.asp?tabnm=<%=dr99(0)%>"><%=dr99(1)%></a><%
dr99.movenext
Loop
else 
dr99.close	
end if	  
%></dd>
            </dl>
<%End if%>
<%If Len(t_menu7) > 0 then%>
            <dl>
                <dt><%=t_menu7%></dt>
                <dd><a href="/cs/nlist.asp">��������</a><a href="/cs/flist.asp">���ֹ����������亯</a><a href="/cs/qlist.asp">���ǰԽ���</a><% 
sql99 = "select idx,jemok from guideTab where gbn = 1 order by ordnum asc,idx desc"
set dr99 = db.execute(sql99)
if not dr99.bof or not dr99.eof then
do until dr99.eof 
%><a href="/cs/page.asp?idx=<%=dr99(0)%>"><%=dr99(1)%></a><%
dr99.movenext
Loop
else 
dr99.close	
end if	  

sql99 = "select idx,title from cal_mast order by idx desc"
set dr99 = db.execute(sql99)
if not dr99.bof or not dr99.eof then
do until dr99.eof 
%><a href="/cs/cal.asp?cal_idx=<%=dr99(0)%>"><%=dr99(1)%></a><%
dr99.movenext
Loop
else 
dr99.close	
end if	  
%><a href="/question/ing.asp">�������μ���</a><a href="/question/end.asp">����ȼ���</a></dd>
            </dl>
<%End if%>
        </div>
    </div>
</div>