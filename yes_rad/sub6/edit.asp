<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/dbcon.asp" -->
<%
dim tabnm : tabnm = Request("tabnm")
dim sql,dr
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

Dim title,writer,content
Dim gbnS,strPart,strSearch,regdate,readnum,notice,pwd,image1,snimg

gbnS = request("gbnS")
strPart = request("strPart")
strSearch = request("strSerach")

sql = "select title,writer,content,regdate,readnum,notice,pwd,image1,snimg from board_board where idx=" & idx
set dr = db.execute(sql)

title = dr(0)
writer = dr(1)
content = dr(2)
regdate = dr(3)
readnum = dr(4)
notice = dr(5)
pwd = dr(6)
image1 = dr(7)
snimg = dr(8)

Dim repage : repage = "content.asp?idx=" & idx & "&tabnm=" & tabnm & "&intgp=" & intpg & "&gbnS=" & gbnS & "&strPart=" & strPart & "&strSearch=" & strSearch
%>
<!--#include file="../main/top.asp"-->

<script type="text/javascript" src="/nicedit/nicEdit.js"></script>
<script type="text/javascript">
bkLib.onDomLoaded(function() {
	new nicEditor({fullPanel : true,maxHeight : 320}).panelInstance('content');
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
	
	<% if int(ygbn) < 3 then %>
	clmn = theform.filenm;<% select case int(ygbn)
	case 1 %>
	if(clmn.value){
		if(!clmn.value.match(/\.(doc|hwp|zip|ppt|txt|xls|pdf|docx|pptx|xlsx)$/i)) {
			alert("������ �ʴ� ���� �Դϴ�! \n\n����Ȯ���ڸ� Ȯ���ϼ���\n\n���� ���� : doc,hwp,zip,ppt,txt,xls,pdf,docx,pptx,xlsx          ");
			clmn.select();
			return;
		}
	}
	<% case 2 %>
	 if(clmn.value){
		if(!clmn.value.match(/\.(gif|jpg|png)$/i)) {
			alert("�����̹��� ������ �̹�������(*.gif,*.jpg)�� ����� �� �ֽ��ϴ�!");
			clmn.select();
			return;
		}
	}

	clmn = theform.snfile;
	 if(clmn.value){
	 	if(!clmn.value.match(/\.(gif|jpg|png)$/i)) {
			alert("����� ������ �̹�������(*.gif,*.jpg)�� ����� �� �ֽ��ϴ�!");
			clmn.select();
			return;
		}
	 }
	<% end select
	end if %>

	theform.submit();
}

function bbsDel(bbcn){
	if(bbcn < 2){
		alert("�Խ����� �ּ� 1�� �̻��� �־�� �մϴ�!");
		return;
	}

	var delok = confirm("�� <%=bbsJemok%> �Խ����� ������ �����Ͻðڽ��ϱ�?");
	if(delok){
		location.href="deleteb.asp?tabnm=<%=tabnm%>";
	}
}
</script>

<div class="container">
	<!--#include file="left.asp"-->
	<div class="content">
		<h2 class="cTit"><span class="bullet"></span><%=bbsJemok%></h2>

<form name="fm" action="edit_ok.asp" method="post" enctype="multipart/form-data" style="display:inline;">
					<input type="hidden" name="tabnm" value="<%=tabnm%>">
					<input type="hidden" name="idx" value="<%=idx%>">
					<input type="hidden" name="intpg" value="<%=intpg%>">
					<input type="hidden" name="gbnS" value="<%=gbnS%>">
					<input type="hidden" name="strPart" value="<%=strPart%>">
					<input type="hidden" name="strSearch" value="<%=strSearch%>">       
		<table class="ftbl mb50" style="width:100%">
				<colgroup>
				<col style="width:20%" />
				<col style="width:80%" />
				</colgroup>
				<tbody>
						<tr>
								    <th><span class="style5">�����</span></th>
								    <td><input name="edate" type="text" class="inptxt1 w100" id="edate" value="<%=left(regdate,10)%>" onClick="calendar(event);" readonly></td>
								    </tr>
								  <tr>
								    <th><span class="style5">��ȸ��</span></th>
								    <td><input name="readnum" type="text" class="inptxt1 w60" id="readnum" value="<%=readnum%>"></td>
								    </tr>
					<tr>
						<th>����</th>
						<td><input type="text" name="title" class="inptxt1 w400" value="<%=title%>" ><%If ygbn <> 2 then%>&nbsp;<input type="checkbox" name="notice" id="checkbox" value="1" <%If notice = 1 Then Response.write"checked" End if%> /> ����<%End if%></td>
					</tr>
					<tr>
						<th>�ۼ���</th>
						<td><input type="text" name="writer" class="inptxt1 w200" value="<%=writer%>"></td>
					</tr>
					<tr>
						<th>��й�ȣ</th>
						<td><input type="text" name="pwd" class="inptxt1 w100" value="<%=pwd%>" > <span class="stip">* �Է½� ��й�ȣ�� �Է��ؾ� �ش� ���� ���� �ֽ��ϴ�.</span></td>
					</tr>
					<tr>
						<th>����</th>
						<td><a href="javascript:popenWindow('/nicedit/upimg.asp?box=content','390','290');"><img src="/nicedit/bt1.gif" border="0"></a><a href="javascript:popenWindow('/nicedit/vod.asp?box=content','390','290');"><img src="/nicedit/bt2.gif" border="0"></a><a href="javascript:popenWindow('/nicedit/files.asp?box=content','390','290');"><img src="/nicedit/bt3.gif" border="0"></a><textarea name="content" id="content" rows="2" cols="20" style="width:600px; height:300px;"><%=content%></textarea></td>
					</tr>
					<% select case int(ygbn)
										case 1 %>
										<tr>
											<th><span class="style5">�ڷ�����</span></th>
											<td><input type="file" name="filenm" class="inptxt1" style="width:470px;" > <%if len(image1) > 0 then%>&nbsp;<input name="check_del1" type="checkbox" id="check_del1" value="1"> ����(<%=image1%>)<%end if%></td>
										</tr><% case 2 %>
										<tr>
											<th><span class="style5">�����̹���</span></th>
											<td><input type="file" name="filenm" class="inptxt1" style="width:470px;" > <%if len(image1) > 0 then%>&nbsp;<input name="check_del1" type="checkbox" id="check_del1" value="1"> ����(<%=image1%>)<%end if%></td>
										</tr>
										<tr>
											<th><span class="style5">�����</span></th>
											<td><input type="file" name="snfile" class="inptxt1" style="width:470px;" > <%if len(snimg) > 0 then%>&nbsp;<input name="check_del2" type="checkbox" id="check_del2" value="1"> ����(<%=snimg%>)<%end if%></td>
										</tr><% end select %>
				</tbody>
			</table>
</form>

		<div class="rbtn">
			<a href="javascript:go2WriteOk(fm);" class="btn">�����ϱ�</a>
			<a href="javascript:history.back();" class="btn trans">��Ϻ���</a>		
		</div>

	</div>
</div>

	</div>
</div>

</body>
</html>
<!-- #include file = "../authpg_2.asp" -->