<!-- #include file="../include/set_loginfo.asp" -->
<% if  isUsr then %>
<!-- #include file = "../include/dbcon.asp" -->
<%
dim tabnm : tabnm = Request("tabnm")
dim idx,intpg
idx = request("idx")
intpg = request("intpg")

Dim bbsJemok,pgbn,ygbn,mgbn
sql = "select jemok,pgbn,ygbn,mgbn from board_mast where idx=" & tabnm
set dr = db.execute(sql)
bbsJemok = dr(0)
pgbn = dr(1)
ygbn = dr(2)
mgbn = dr(3)
dr.close

Dim title,writer,content,wrtid,image2,image1,pwd
Dim gbnS,strPart,strSearch

gbnS = request("gbnS")
strPart = request("strPart")
strSearch = request("strSerach")

sql = "select title,writer,content,wrtid,image2,snimg,pwd from board_board where idx=" & idx
set dr = db.execute(sql)
title = dr(0)
writer = dr(1)
content = dr(2)
wrtid = dr(3)
image2 = dr(4)
image1 = dr(5)
pwd = dr(6)

Dim repage : repage = "content.asp?idx=" & idx & "&tabnm=" & tabnm & "&intgp=" & intpg & "&gbnS=" & gbnS & "&strPart=" & strPart & "&strSearch=" & strSearch

if wrtid = str_User_ID then %>
<!-- #include file="../include/head1.asp" -->

<script type="text/javascript" src="/nicedit/nicEdit.js"></script>
<script type="text/javascript">
bkLib.onDomLoaded(function() {
	new nicEditor({fullPanel : true}).panelInstance('content');
});
</script>
<script language="javascript">

function go2WriteOk(theform){
	var clmn;
	clmn = theform.title;
	if(clmn.value==""){
		alert("������ �Է����ּ���!");
		clmn.focus();
		return;
	}
	if(clmn.value.replace(/ /g,"")==""){
		alert("������ �Է����ּ���!");
		clmn.select();
		return;
	}
	clmn = theform.writer;
	if(clmn.value==""){
		alert("�۾��̸� �Է����ּ���!");
		clmn.focus();
		return;
	}
	if(clmn.value.replace(/ /g,"")==""){
		alert("�۾��̸� �Է����ּ���!");
		clmn.select();
		return;
	}

	clmn = theform.content;
	clmn.value = nicEditors.findEditor('content').getContent();
	if(clmn.value==""  || clmn.value=="<br>") {
	alert("������ �Է����ּ���");
	return;
	}
	
	<% if int(ygbn) = 2 then %>

	clmn = theform.filenm1;
	if(clmn.value){
		if(!clmn.value.match(/\.(gif|jpg|png)$/i)) {
			alert("�����̹��� ������ �̹�������(*.gif,*.jpg,*.png)�� ����� �� �ֽ��ϴ�!");
			clmn.select();
			return;
		}
	}

	clmn = theform.filenm2;
	 if(clmn.value){
	 	if(!clmn.value.match(/\.(gif|jpg|png)$/i)) {
			alert("����� ������ �̹�������(*.gif,*.jpg,*.png)�� ����� �� �ֽ��ϴ�!");
			clmn.select();
			return;
		}
	 }
	<% end if %>

	theform.submit();
}
</script>

<!-- #include file="../include/top.asp" -->

<div class="smain">    
	<!-- #include file="left.asp" -->
    <div class="content">
    	<div class="cont_tit">
        	<h3><%=bbsJemok%></h3>
        </div>
        <div class="scont">
            
			<form name="fm" action="edit_ok.asp" method="post" enctype="multipart/form-data" style="display:inline;">
			<input type="hidden" name="tabnm" value="<%=tabnm%>">
			<input type="hidden" name="idx" value="<%=idx%>">
			<input type="hidden" name="intpg" value="<%=intpg%>">
			<input type="hidden" name="gbnS" value="<%=gbnS%>">
			<input type="hidden" name="strPart" value="<%=strPart%>">
			<input type="hidden" name="strSearch" value="<%=strSearch%>">
            <table class="ftbl" style="width:830px">
                <colgroup>
                <col style="width:22%" />
                <col style="width:78%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th>����</th>
                        <td><input name="title" type="text" id="title" class="inptxt1 w500" value="<%=title%>"></td>		
                    </tr>
                    <tr>
                        <th>�۾���</th>
                        <td><input name="writer" type="text" id="writer" class="inptxt1 w100" value="<%=writer%>"></td>		
                    </tr>
                    <tr>
                        <th>����</th>
                        <td><img src="/nicedit/bt1.gif" border="0" onclick="javascript:popenWindow('/nicedit/upimg.asp?box=content','390','290');" style="cursor:pointer;"><img src="/nicedit/bt2.gif" border="0" onclick="javascript:popenWindow('/nicedit/vod.asp?box=content','390','290');" style="cursor:pointer;"><img src="/nicedit/bt3.gif" border="0" onclick="javascript:popenWindow('/nicedit/files.asp?box=content','390','290');" style="cursor:pointer;"><textarea name="content" id="content" rows="2" cols="20" style="width:600px; height:200px;"><%=content%></textarea></td>		
                    </tr>	
    <% if int(ygbn) = 2 then %>	
                    <tr>
                        <th>�̹���</th>
                        <td><input name="filenm1" type="file" id="filenm1" class="inptxt1 w300"><p style="margin:5px 0" class="stip">* jpg,png,gif 5MB���ϸ� ����</p></td>		
                    </tr>	
                    <tr>
                        <th>�����</th>
                        <td><input name="filenm2" type="file" id="filenm2" class="inptxt1 w300"><p style="margin:5px 0" class="stip"><%If Len(image1)> 0 then%><input type="checkbox" name="check_del2" id="check_del2" />����&nbsp;<%End if%>* jpg,png,gif 5MB���ϸ� ����></p></td>		
                    </tr>		
    <%End if%>
                    <tr>
                        <th>��й�ȣ</th>
                        <td><input name="pwd" type="text" id="pwd" class="inptxt1 w100" value="<%=pwd%>"></td>		
                    </tr>
                </tbody>
            </table>
            </form>   
            
            <div class="cbtn"> <a href="javascript:go2WriteOk(fm);" class="mbtn grey">�ۼ��Ϸ�</a> <a href="<%=repage%>" class="mbtn">�������</a> </div>
        </div>
    </div>
</div>

<!-- #include file="../include/bottom.asp" -->
<% else %>
<!-- #include file="../include/false_pg.asp" -->
<% end if

else %>
<!-- #include file="../include/false_pg.asp" -->
<% end if %>