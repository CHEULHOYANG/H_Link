<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/dbcon.asp" -->
<%
Dim sql,dr,isRecod,recodnum
recodnum = 0
sql="select idx,id,pwd,regdate from admin_mast order by idx desc"
set dr = db.execute(sql)
if Not Dr.Bof or Not Dr.Eof then
	isRecod = True
	Dim isRows
	isRows = Split(Dr.GetString(2),chr(13))
	recodnum = UBound(isRows)
end if

Dr.Close
Set Dr = Nothing
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
function DeleteAdm(idxnum){
	var adLevel =<%=recodnum%>;
	if(adLevel< 2){
		alert("������ ������ �ּ� 1�� �̻� �־�� �մϴ�.\n\n������ ������ 1�� �̻� �߰��Ͻ� �Ŀ� ���� ���ּ���!");
	}
	else{
		del_ck = confirm("�ش� ������ ������ �����Ͻðڽ��ϱ�?");
		if(del_ck){
			document.location.href="admin_del.asp?idxnum=" + idxnum;
		}
	}
}

function AllCheck(thisimg,chekID){
	var srcAry = thisimg.src.split("/");
	if(srcAry[srcAry.length-1] == "noncheck.gif"){
		thisimg.src = "/yes_rad/rad_img/img/allcheck.gif";
		isChecked(true,chekID);
	}else{
		thisimg.src = "/yes_rad/rad_img/img/noncheck.gif";
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
			<table class="ftbl mb50" style="width:100%">
				<colgroup>
				<col style="width:20%" />
				<col style="width:80%" />
				</colgroup>
				<tbody>
					<tr>
						<th>���̵�</th>
						<td><input type="text" id="id" name="id" class="inptxt1" /></td>
					</tr>
					<tr>
						<th>��й�ȣ</th>
						<td><input type="text" id="pwd" name="pwd" class="inptxt1" /></td>
					</tr>
					<tr>
						<th>���Ѽ���</th>
						<td><img src="/yes_rad/rad_img/img/noncheck.gif" align="absmiddle" style="cursor:pointer;" onClick="AllCheck(this,document.all.manage);"> <font color='#cc0000'>��ü�׸���</font><br />
						<input name="manage" type="checkbox" id="manage" value="a1">
                        ����Ʈ��������
                        <input name="manage" type="checkbox" id="manage" value="a2">
                        �����ڼ���
                        <input name="manage" type="checkbox" id="manage" value="a3">
                        �������������
                        <input name="manage" type="checkbox" id="manage" value="a4">
                        �������������
                        <input name="manage" type="checkbox" id="manage" value="a5">
                        �Ա��������
                        <input name="manage" type="checkbox" id="manage" value="a6">
                        �˾�â����
                        <input name="manage" type="checkbox" id="manage" value="a7">
                        ���Ǿ����ܼ���
                        <input name="manage" type="checkbox" id="manage" value="a8">
                        �����������<br />
						<input name="manage" type="checkbox" id="manage" value="b1">
                        �ĺ��ܰ���
                          <input name="manage" type="checkbox" id="manage" value="b2">
                          �ΰ����<br />
						  <input name="manage" type="checkbox" id="manage" value="c1">
                        ȸ���׷����
                          <input name="manage" type="checkbox" id="manage" value="c2">
                          ȸ�����
                        <input name="manage" type="checkbox" id="manage" value="c3">
                        ȸ���뷮���
                        <input name="manage" type="checkbox" id="manage" value="c4">
                        ���ϸ�������
                        <input name="manage" type="checkbox" id="manage" value="c5">
                        ȸ���⼮��Ȳ
                        <input name="manage" type="checkbox" id="manage" value="c6">
                        Ż��ȸ������
                        <input name="manage" type="checkbox" id="manage" value="c7">
                        �������̵����
                        <input name="manage" type="checkbox" id="manage" value="c8">
                        �̸��Ϲ߼۰���
                        <input name="manage" type="checkbox" id="manage" value="c9">
                        ���ڹ߼۱׷����
                        <input name="manage" type="checkbox" id="manage" value="c10">
                        ���ڹ߼۰���<br />
						<input name="manage" type="checkbox" id="manage" value="d1">
                        �������
                        <input name="manage" type="checkbox" id="manage" value="d2">
                        �����԰���
                        <input name="manage" type="checkbox" id="manage" value="d3">
                        �����Ե��
                        <input name="manage" type="checkbox" id="manage" value="d4">
                        ��������
                        <input name="manage" type="checkbox" id="manage" value="d5">
                        �ڷ��
                        <input name="manage" type="checkbox" id="manage" value="d6">
                        �������亯
                        <input name="manage" type="checkbox" id="manage" value="d7">
                        �����ı�<br />
						<input name="manage" type="checkbox" id="manage" value="e1">
                        ��ǰī�װ�
                        <input name="manage" type="checkbox" id="manage" value="e2">
                        ��ǰ���
                        <input name="manage" type="checkbox" id="manage" value="e3">
                        ��ǰ���
                        <input name="manage" type="checkbox" id="manage" value="e4">
                        ��ǰ�뷮���
                        <input name="manage" type="checkbox" id="manage" value="e5">
                        �ֹ�/��۰���<br />
						<input name="manage" type="checkbox" id="manage" value="f1">
                        ���°���
                          <input name="manage" type="checkbox" id="manage" value="f2">
                          ī�װ�����
                          <input name="manage" type="checkbox" id="manage" value="f3">
                          ��������
                          <input name="manage" type="checkbox" id="manage" value="f4">
                          ��������
                          <input name="manage" type="checkbox" id="manage" value="f5">
                        �������<br />
						<input name="manage" type="checkbox" id="manage" value="g1">
                        ����ī�װ�
                          <input name="manage" type="checkbox" id="manage" value="g2">
                          ������
                        <input name="manage" type="checkbox" id="manage" value="g3">
                        ���踸���
                        <input name="manage" type="checkbox" id="manage" value="g4">
                        ����������<br />
						<input name="manage" type="checkbox" id="manage" value="h1">
                        ��������
                        <input name="manage" type="checkbox" id="manage" value="h2">
                        �������亯
                        <input name="manage" type="checkbox" id="manage" value="h3">
                        ���ֹ�������
                        <input name="manage" type="checkbox" id="manage" value="h4">
                        �ȳ�������
                        <input name="manage" type="checkbox" id="manage" value="h5">
                        ��ʰ���
                        <input name="manage" type="checkbox" id="manage" value="h6">
                        ��������<br />
						<input name="manage" type="checkbox" id="manage" value="i1">
                        �Խ��ǰ���<br />
						<input name="manage" type="checkbox" id="manage" value="j1">
                        �����ںм�
                        <input name="manage" type="checkbox" id="manage" value="j2">
                        �����м�
                        <input name="manage" type="checkbox" id="manage" value="j3">
                        �Ϻ��м�
                        <input name="manage" type="checkbox" id="manage" value="j4">
                        ���Ϻ��м�
                        <input name="manage" type="checkbox" id="manage" value="j5">
                        �ð����м�
                        <input name="manage" type="checkbox" id="manage" value="j6">
                        �б⺰�м�
                        <input name="manage" type="checkbox" id="manage" value="j7">
                        ���Ӱ�κм�
                        <input name="manage" type="checkbox" id="manage" value="j8">
                        �����ʱ�ȭ




						
						</td>
					</tr>					
				</tbody>
			</table>
		</form>

		<div class="rbtn">
			<a href="javascript:InputChk();" class="btn">�����ϱ�</a>		
			<a href="admin_list.asp" class="btn trans">��Ϻ���</a>
		</div>


	</div>
</div>


</body>
</html>
<%
db.Close
Set db = Nothing
%>
<!-- #include file = "../authpg_2.asp" -->