<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/dbcon.asp" -->
<%
Dim sql,rs,id,pwd,manage

sql = "select manage,id,pwd from admin_mast where id = '"& request("id") &"'"
Set rs=db.execute(sql)

If rs.eof Or rs.bof Then

	response.write"<script>"
	response.write"alert('�����Ϳ���!!');"
	response.write"history.back();"
	response.write"</script>"
	response.end

Else

	manage = rs(0)
	id = rs(1)
	pwd = rs(2)

rs.close
End if
%>

<!--#include file="../main/top.asp"-->

<script language="javascript">
function InputChk(){

	var clmn = form1.id;
	if(clmn.value==""){
		alert("�߰��� ������ ���̵� �Է����ּ���!");
		clmn.focus();
		return;
	}

	clmn = form1.pwd;
	if(clmn.value==""){
		alert("�н����带 �Է����ּ���!");
		clmn.focus();
		return;
	}
	
	document.form1.submit();
}

function AllCheck(thisimg,chekID){
	var srcAry = thisimg.src.split("/");
	if(srcAry[srcAry.length-1] == "noncheck.gif"){
		thisimg.src = "../rad_img/allcheck.gif";
		isChecked(true,chekID);
	}else{
		thisimg.src = "../rad_img/noncheck.gif";
		isChecked(false,chekID);
	}
}

function isChecked(cmd,chekID){
	var chekLen=chekID.length;
	if(chekLen){
		for (i=0;i<chekLen;i++){
			chekID[i].checked=cmd;
		}
	}
	else{
		chekID.checked=cmd;
	}
}
</script>

<div class="container">
	<!--#include file="left.asp"-->
	<div class="content">
		<h2 class="cTit"><span class="bullet"></span>�����ڼ���</h2>

		<form name="form1" method="post" action="admin_result.asp">
		<input type="hidden" name="id" value="<%=id%>">
		<table class="ftbl mb50" style="width:100%">
				<colgroup>
				<col style="width:20%" />
				<col style="width:80%" />
				</colgroup>
				<tbody>
					<tr>
						<th>���̵�</th>
						<td><strong><%=id%></strong></td>
					</tr>
					<tr>
						<th>��й�ȣ</th>
						<td><input type="text" id="pwd" name="pwd" class="inptxt1" value="<%=pwd%>" /></td>
					</tr>
					<tr>
						<th>���Ѽ���</th>
						<td><img src="/yes_rad/rad_img/img/noncheck.gif" align="absmiddle" style="cursor:pointer;" onClick="AllCheck(this,document.all.manage);"> <font color='#cc0000'>��ü�׸���</font><br />
						<input name="manage" type="checkbox" id="manage" value="a1" <%If InStr(manage,", a1,") Then response.write"checked" End if%> >
                        ����Ʈ��������
                        <input name="manage" type="checkbox" id="manage" value="a2" <%If InStr(manage,", a2,") Then response.write"checked" End if%>>
                        �����ڼ���
                        <input name="manage" type="checkbox" id="manage" value="a3" <%If InStr(manage,", a3,") Then response.write"checked" End if%>>
                        �������������
                        <input name="manage" type="checkbox" id="manage" value="a4" <%If InStr(manage,", a4,") Then response.write"checked" End if%>>
                        �������������
                        <input name="manage" type="checkbox" id="manage" value="a5" <%If InStr(manage,", a5,") Then response.write"checked" End if%>>
                        �Ա��������
                        <input name="manage" type="checkbox" id="manage" value="a6" <%If InStr(manage,", a6,") Then response.write"checked" End if%>>
                        �˾�â����
                        <input name="manage" type="checkbox" id="manage" value="a7" <%If InStr(manage,", a7,") Then response.write"checked" End if%>>
                        ���Ǿ����ܼ���
                        <input name="manage" type="checkbox" id="manage" value="a8" <%If InStr(manage,", a8,") Then response.write"checked" End if%>>
                        �����������<br />
						<input name="manage" type="checkbox" id="manage" value="b1" <%If InStr(manage,", b1,") Then response.write"checked" End if%>>
                        �ĺ��ܰ���
                          <input name="manage" type="checkbox" id="manage" value="b2" <%If InStr(manage,", b2,") Then response.write"checked" End if%>>
                          �ΰ����<br />
						  <input name="manage" type="checkbox" id="manage" value="c1" <%If InStr(manage,", c1,") Then response.write"checked" End if%>>
                        ȸ���׷����
                          <input name="manage" type="checkbox" id="manage" value="c2" <%If InStr(manage,", c2,") Then response.write"checked" End if%>>
                          ȸ�����
                        <input name="manage" type="checkbox" id="manage" value="c3" <%If InStr(manage,", c3,") Then response.write"checked" End if%>>
                        ȸ���뷮���
                        <input name="manage" type="checkbox" id="manage" value="c4" <%If InStr(manage,", c4,") Then response.write"checked" End if%>>
                        ���ϸ�������
                        <input name="manage" type="checkbox" id="manage" value="c5" <%If InStr(manage,", c5,") Then response.write"checked" End if%>>
                        ȸ���⼮��Ȳ
                        <input name="manage" type="checkbox" id="manage" value="c6" <%If InStr(manage,", c6,") Then response.write"checked" End if%>>
                        Ż��ȸ������
                        <input name="manage" type="checkbox" id="manage" value="c7" <%If InStr(manage,", c7,") Then response.write"checked" End if%>>
                        �������̵����
                        <input name="manage" type="checkbox" id="manage" value="c8" <%If InStr(manage,", c8,") Then response.write"checked" End if%>>
                        �̸��Ϲ߼۰���
                        <input name="manage" type="checkbox" id="manage" value="c9" <%If InStr(manage,", c9,") Then response.write"checked" End if%>>
                        ���ڹ߼۱׷����
                        <input name="manage" type="checkbox" id="manage" value="c10" <%If InStr(manage,", c10,") Then response.write"checked" End if%>>
                        ���ڹ߼۰���<br />
						<input name="manage" type="checkbox" id="manage" value="d1" <%If InStr(manage,", d1,") Then response.write"checked" End if%>>
                        �������
                        <input name="manage" type="checkbox" id="manage" value="d2" <%If InStr(manage,", d2,") Then response.write"checked" End if%>>
                        �����԰���
                        <input name="manage" type="checkbox" id="manage" value="d3" <%If InStr(manage,", d3,") Then response.write"checked" End if%>>
                        �����Ե��
                        <input name="manage" type="checkbox" id="manage" value="d4" <%If InStr(manage,", d4,") Then response.write"checked" End if%>>
                        ��������
                        <input name="manage" type="checkbox" id="manage" value="d5" <%If InStr(manage,", d5,") Then response.write"checked" End if%>>
                        �ڷ��
                        <input name="manage" type="checkbox" id="manage" value="d6" <%If InStr(manage,", d6,") Then response.write"checked" End if%>>
                        �������亯
                        <input name="manage" type="checkbox" id="manage" value="d7" <%If InStr(manage,", d7,") Then response.write"checked" End if%>>
                        �����ı�<br />
						<input name="manage" type="checkbox" id="manage" value="e1" <%If InStr(manage,", e1,") Then response.write"checked" End if%>>
                        ��ǰī�װ�
                        <input name="manage" type="checkbox" id="manage" value="e2" <%If InStr(manage,", e2,") Then response.write"checked" End if%>>
                        ��ǰ���
                        <input name="manage" type="checkbox" id="manage" value="e3" <%If InStr(manage,", e3,") Then response.write"checked" End if%>>
                        ��ǰ���
                        <input name="manage" type="checkbox" id="manage" value="e4" <%If InStr(manage,", e4,") Then response.write"checked" End if%>>
                        ��ǰ�뷮���
                        <input name="manage" type="checkbox" id="manage" value="e5" <%If InStr(manage,", e5,") Then response.write"checked" End if%>>
                        �ֹ�/��۰���<br />
						<input name="manage" type="checkbox" id="manage" value="f1" <%If InStr(manage,", f1,") Then response.write"checked" End if%>>
                        ���°���
                          <input name="manage" type="checkbox" id="manage" value="f2" <%If InStr(manage,", f2,") Then response.write"checked" End if%>>
                          ī�װ�����
                          <input name="manage" type="checkbox" id="manage" value="f3" <%If InStr(manage,", f3,") Then response.write"checked" End if%>>
                          ��������
                          <input name="manage" type="checkbox" id="manage" value="f4" <%If InStr(manage,", f4,") Then response.write"checked" End if%>>
                          ��������
                          <input name="manage" type="checkbox" id="manage" value="f5" <%If InStr(manage,", f5,") Then response.write"checked" End if%>>
                        �������<br />
						<input name="manage" type="checkbox" id="manage" value="g1" <%If InStr(manage,", g1,") Then response.write"checked" End if%>>
                        ����ī�װ�
                          <input name="manage" type="checkbox" id="manage" value="g2" <%If InStr(manage,", g2,") Then response.write"checked" End if%>>
                          ������
                        <input name="manage" type="checkbox" id="manage" value="g3" <%If InStr(manage,", g3,") Then response.write"checked" End if%>>
                        ���踸���
                        <input name="manage" type="checkbox" id="manage" value="g4" <%If InStr(manage,", g4,") Then response.write"checked" End if%>>
                        ����������<br />
						<input name="manage" type="checkbox" id="manage" value="h1" <%If InStr(manage,", h1,") Then response.write"checked" End if%>>
                        ��������
                        <input name="manage" type="checkbox" id="manage" value="h2" <%If InStr(manage,", h2,") Then response.write"checked" End if%>>
                        �������亯
                        <input name="manage" type="checkbox" id="manage" value="h3" <%If InStr(manage,", h3,") Then response.write"checked" End if%>>
                        ���ֹ�������
                        <input name="manage" type="checkbox" id="manage" value="h4" <%If InStr(manage,", h4,") Then response.write"checked" End if%>>
                        �ȳ�������
                        <input name="manage" type="checkbox" id="manage" value="h5" <%If InStr(manage,", h5,") Then response.write"checked" End if%>>
                        ��ʰ���
                        <input name="manage" type="checkbox" id="manage" value="h6" <%If InStr(manage,", h6") Then response.write"checked" End if%>>
                        ��������<br />
						<input name="manage" type="checkbox" id="manage" value="i1" <%If InStr(manage,", i1,") Then response.write"checked" End if%>>
                        �Խ��ǰ���<br />
						<input name="manage" type="checkbox" id="manage" value="j1" <%If InStr(manage,", j1,") Then response.write"checked" End if%>>
                        �����ںм�
                        <input name="manage" type="checkbox" id="manage" value="j2" <%If InStr(manage,", j2,") Then response.write"checked" End if%>>
                        �����м�
                        <input name="manage" type="checkbox" id="manage" value="j3" <%If InStr(manage,", j3,") Then response.write"checked" End if%>>
                        �Ϻ��м�
                        <input name="manage" type="checkbox" id="manage" value="j4" <%If InStr(manage,", j4,") Then response.write"checked" End if%>>
                        ���Ϻ��м�
                        <input name="manage" type="checkbox" id="manage" value="j5" <%If InStr(manage,", j5,") Then response.write"checked" End if%>>
                        �ð����м�
                        <input name="manage" type="checkbox" id="manage" value="j6" <%If InStr(manage,", j6,") Then response.write"checked" End if%>>
                        �б⺰�м�
                        <input name="manage" type="checkbox" id="manage" value="j7" <%If InStr(manage,", j7,") Then response.write"checked" End if%>>
                        ���Ӱ�κм�
                        <input name="manage" type="checkbox" id="manage" value="j8" <%If InStr(manage,", j8,") Then response.write"checked" End if%>>
                        �����ʱ�ȭ</td>
					</tr>
				</tbody>
			</table>

		<div class="rbtn">
			<a href="javascript:InputChk();" class="btn">�����ϱ�</a>		
			<a href="admin_list.asp" class="btn trans">��Ϻ���</a>
		</div>

	</div>
</div>

</body>
</html>
<!-- #include file = "../authpg_2.asp" -->