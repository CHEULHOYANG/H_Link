<%
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

</script>

<body>
<div class="header">
    <!--  TOP �޴�  -->
    <div class="tmenu">
        <ul>
            <li class="left"><a href="javascript:bookmarksite('<%=s_name%>', '<%=shop_url%>');" class="favor">+ ���ã�� �߰�</a></li>
<% if isUsr then %>
            <li class="right"><a href="/member/logout.asp">�α׾ƿ�</a><span class="slash">|</span><a href="/my/05_myinfo.asp">��������</a><span class="slash">|</span><a href="/my/01_main.asp">���ǰ��ǽ�</a></li>
<%else%>
            <li class="right"><a href="/member/login.asp">�α���</a><span class="slash">|</span><a href="/member/agree.asp">ȸ������</a><span class="slash">|</span><a href="javascript:go2Logpg(<%=strProg%>,'/my/01_main.asp');">���ǰ��ǽ�</a></li>
<%End if%>
        </ul>
    </div>
    <div class="tWrap">
        <!--  LOGO, �˻���, �̺�Ʈ���   -->
        <div class="tban"><a href=""><img src="/img/img/tban_01.png" alt="������ �̷��׼ַ�� 1,790,000��" /></a></div>
        <h1><a href="/main/index.asp"><img src="/ahdma/logo/<%=logoimg%>" /></a></h1>

<form name="searfm" method="post" action="../search/main.asp" style="display:inline;">
		<div class="tsearch">
            <input type="text" id="searchStr" name="searchStr" placeholder="�˻�� �Է��� �ּ���!" />
            <a href="javascript:go2Search(false,searfm);" class="btn_sch mbg">�˻��ϱ�</a>
		</div>
</form>

    </div>
    <!--  �޴� �κ�   -->
    <div class="meWrap">
        <div class="menu">
            <a href="/page/page.asp" onmouseover="mopen(1);">�п��Ұ�</a> <a href="/study/class_list.asp" onmouseover="mopen(1);">������û</a><a href="/teach/teach.asp" onmouseover="mopen(1);">�����ԼҰ�</a> <a href="/book/list.asp" onmouseover="mopen(1);">����Ұ�</a><a href="/quiz/list.asp" onmouseover="mopen(1);">�׽�Ʈ</a><a href="/cumm/list.asp" onmouseover="mopen(1);">�н�Ŀ�´�Ƽ</a> <a href="/cs/nlist.asp" onmouseover="mopen(1);">������</a>
        </div>
    </div>
    <div class="tlogWrap">
<% if isUsr then 

dim lsql,lrs,my_count,qa_count

lsql = "select count(*) from order_mast where id='" & str_User_ID & "' and state=0 and holdgbn=0"
set lrs = db.execute(lsql)

my_count = lrs(0)
lrs.close

lsql = "select count(*) from oneone where quserid='" & str_User_ID & "' "
set lrs = db.execute(lsql)

qa_count = lrs(0)
lrs.close
%>
            <div class="tlog">
                <dl>
                    <dt><strong class="fb"><%=str_User_Nm%></strong>�� �ݰ����ϴ�.</dt>
                    <dd><span>���� ������Ȳ : </span><em><%=qa_count%>��</em></dd>
                    <dd><span>�������� ���� : </span><em><%=my_count%>��</em></dd>
                </dl>
                <div class="tlog_btn">
                    <a href="/my/05_myinfo.asp">��������</a><a href="/member/logout.asp">�α׾ƿ�</a>
                </div>
            </div>
<%else%>
<script language="javascript">
function strOnSubmit(isKey,theform){

	if(isKey || event) event.returnValue = false;

	clmn = theform.usrid;
	if(clmn.value.replace(/ /g,"") == ""){
		alert("���̵� �Է����ּ���!");
		clmn.focus();
		return;
	}
	clmn = theform.usrpwd;
	if(clmn.value == ""){
		alert("��й�ȣ�� �Է����ּ���!");
		return;
	}

	theform.submit();

}
</script>
            <div class="tlog">
<form name="tlogfm" action="../member/login_ok.asp" method="post" style="display:inline;">
                <fieldset>
                    <input name="usrid" type="text" class="inptxt" placeholder="���̵�" tabindex="1" onkeypress="if(event.keyCode==13) strOnSubmit(true,document.tlogfm);" />
                    <input name="usrpwd" type="password" class="inptxt" id="usrpwd" tabindex="2" placeholder="��й�ȣ" onkeypress="if(event.keyCode==13) strOnSubmit(true,document.tlogfm);"/>
                    <a href="javascript:strOnSubmit(false,document.tlogfm);" class="log_btn">LOGIN</a>
                </fieldset>
</form>
                <div class="tmem_me">
                	<a href="/member/cmsid.asp">���̵�/��й�ȣã��</a>
                </div>
            </div>
<%End if%>
        </div>

<script type="text/javascript">
var TimeOut         = 300;
var currentLayer    = null;
var currentitem     = null;

var currentLayerNum = 0;
var noClose         = 0;
var closeTimer      = null;

function mopen(n)
{
    var l  = document.getElementById("menu"+n);
    var mm = document.getElementById("mmenu"+n);
   
    if(l)
    {
        mcancelclosetime();
        l.style.visibility='visible';

        if(currentLayer && (currentLayerNum != n))
            currentLayer.style.visibility='hidden';

        currentLayer = l;
        currentitem = mm;
        currentLayerNum = n;           
    }
    else if(currentLayer)
    {
        currentLayer.style.visibility='hidden';
        currentLayerNum = 0;
        currentitem = null;
        currentLayer = null;
    }
}

function mclosetime()
{
    closeTimer = window.setTimeout(mclose, TimeOut);
}

function mcancelclosetime()
{
    if(closeTimer)
    {
        window.clearTimeout(closeTimer);
        closeTimer = null;
    }
}

function mclose()
{
    if(currentLayer && noClose!=1)
    {
        currentLayer.style.visibility='hidden';
        currentLayerNum = 0;
        currentLayer = null;
        currentitem = null;
    }
    else
    {
        noClose = 0;
    }

    currentLayer = null;
    currentitem = null;
}
document.onclick = mclose;
</script>

    <div class="smeWrap" id="menu1" onMouseOver="mcancelclosetime();" onMouseOut="mclosetime();">
    	<div class="smenu">
            <dl>
            	<dt>�п��Ұ�</dt>
                <dd><a href="">�����</a>
                	<a href="">Ư��� ���</a>
                    <a href="">��������</a>
                    <a href="">������</a>
                    <a href="">����Ư���ڽ�</a></dd>
            </dl>
            <dl>
            	<dt>������û</dt>
                <dd><a href="">����</a>
                	<a href="">����</a>
                    <a href="">����</a>
                    <a href="">��ȸ/����</a>
                    <a href="">����</a>
                    <a href="">��ü��/��Ÿ</a>
                    <a href="">Yes��</a></dd>
            </dl>
            <dl>
            	<dt>�����ԼҰ�</dt>
                <dd><a href="">�����</a>
                	<a href="">Ư��� ���</a>
                    <a href="">��������</a>
                    <a href="">������</a>
                    <a href="">����Ư���ڽ�</a></dd>
            </dl>
            <dl>
            	<dt>����Ұ�</dt>
                <dd><a href="">����</a>
                	<a href="">����</a>
                    <a href="">����</a>
                    <a href="">��ȸ/����</a>
                    <a href="">����</a>
                    <a href="">��ü��/��Ÿ</a>
                    <a href="">Yes��</a></dd>
            </dl>
            <dl>
            	<dt>�׽�Ʈ</dt>
                <dd><a href="">����</a>
                	<a href="">����</a>
                    <a href="">����</a>
                    <a href="">��ȸ/����</a>
                    <a href="">����</a>
                    <a href="">��ü��/��Ÿ</a>
                    <a href="">Yes��</a></dd>
            </dl>
            <dl>
            	<dt>Ŀ�´�Ƽ</dt>
                <dd><a href="">��������</a>
                	<a href="">�Խ�����</a>
                    <a href="">�н�����</a>
                    <a href="">����Ž��</a>
                    <a href="">��������</a>
                    <a href="">�������ڷ�</a></dd>
            	<dt>�ڷ��</dt>
                <dd><a href="">��������</a>
                	<a href="">�Խ�����</a>
                    <a href="">�н�����</a>
                    <a href="">����Ž��</a>
                    <a href="">��������</a>
                    <a href="">�������ڷ�</a></dd>
            </dl>
            <dl>
            	<dt>������</dt>
                <dd><a href="">FAQ</a>
                	<a href="">�ʺ��ڰ��̵�</a>
                    <a href="">��������</a>
                    <a href="">1:1���</a>
                    <a href="">���α׷��ٿ�</a></dd>
            	<dt>����</dt>
                <dd><a href="">FAQ</a>
                	<a href="">�ʺ��ڰ��̵�</a>
                    <a href="">��������</a>
                    <a href="">1:1���</a>
                    <a href="">���α׷��ٿ�</a></dd>
            </dl>
    	</div>
    </div>
</div>