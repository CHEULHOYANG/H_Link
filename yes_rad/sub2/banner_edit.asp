<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/dbcon.asp" -->
<%
Dim idx : idx = Request("idx")
Dim intpg : intpg = Request("intpg")

Dim sql,dr,banner,banner_url,bangbn,areagbn,filegbn,ordnum,target,title,bgcolor
sql = "select banner,banner_url,bangbn,areagbn,filegbn,ordnum,target,title,bgcolor from banner where idx=" & idx
set dr = db.execute(sql)
banner = dr(0)
banner_url = dr(1)
bangbn = dr(2)
areagbn = dr(3)
filegbn = dr(4)
ordnum = dr(5)
target = dr(6)
title = dr(7)
bgcolor = dr(8)
dr.close

Dim inSize,imgsize

select case areagbn
	case "010"
		inSize = "width = 1080 , height = 380"
		imgsize = "width=""1080"" * height=""380"""
	case "011"
			inSize = "width = 190 , height = 300"
		imgsize = "width=""190"" * height=""300"""
	case "012"
			inSize = "width = 190 , height = 300"
		imgsize = "width=""190"" * height=""300"""
	case "013"
			inSize = "width = 260 , height = 70"
		imgsize = "width=""260"" * height=""70"""

	case "041"
		inSize = "width < 200"
		imgsize = "width=""200"""
	case "042"
		inSize = "width < 200"
		imgsize = "width=""200"""
	case "043"
		inSize = "width < 200"
		imgsize = "width=""200"""
	case "044"
		inSize = "width < 200"
		imgsize = "width=""200"""
	case "045"
		inSize = "width < 200"
		imgsize = "width=""200"""
	case "046"
		inSize = "width < 200"
		imgsize = "width=""200"""
	case "047"
		inSize = "width < 200"
		imgsize = "width=""200"""
	case "048"
		inSize = "width < 200"
		imgsize = "width=""200"""


	case "051"
		inSize = "width = 780"
		imgsize = "width=""780"""
	case "052"
		inSize = "width = 780"
		imgsize = "width=""780"""
	case "053"
		inSize = "width = 780"
		imgsize = "width=""780"""
	case "054"
		inSize = "width = 780"
		imgsize = "width=""780"""
	case "055"
		inSize = "width = 780"
		imgsize = "width=""780"""
	case "056"
		inSize = "width = 780"
		imgsize = "width=""780"""
	case "057"
		inSize = "width = 780"
		imgsize = "width=""780"""
	case "058"
		inSize = "width = 780"
		imgsize = "width=""780"""

	case "060"
		inSize = "width = 780"
		imgsize = "width=""780"""

	case "061"
		inSize = "width < 200"
		imgsize = "width=""200"""	
		
	case else
		inSize = "width < 200"
		imgsize = "width=""185"""
end select

Function strBanGbn(gbncod)
	select case int(gbncod)
		case 1
			strBanGbn = "����"
		case 2
			strBanGbn = "����"
	end select
End Function

Function strAreaGbn(areacod)
	select case areacod
		case "010"
			strareaGbn = "�����߾�"
		case "012"
			strareaGbn = "�����̺�Ʈ���"
		case "014"
			strareaGbn = "��ܷα׿���"			
		case "041"
			strareaGbn = "���ǽǿ���"
		case "042"
			strareaGbn = "�п��Ұ�����"
		case "043"
			strareaGbn = "�ڷ�ǿ���"
		case "044"
			strareaGbn = "Ŀ�´�Ƽ����"
		case "045"
			strareaGbn = "�����Ϳ���"
		case "046"
			strareaGbn = "��������������"
		case "047"
			strareaGbn = "�׽�Ʈ����"
		case "048"
			strareaGbn = "�����Կ���"
		case "051"
			strareaGbn = "���ǽǻ��"
		case "052"
			strareaGbn = "�п��Ұ����"
		case "053"
			strareaGbn = "�ڷ�ǻ��"
		case "054"
			strareaGbn = "Ŀ�´�Ƽ���"
		case "055"
			stra6eaGbn = "�����ͻ��"
		case "056"
			strareaGbn = "�������������"
		case "057"
			strareaGbn = "���ᰭ�»��"
		case "058"
			strareaGbn = "�����Ի��"
		case "060"
			strareaGbn = "�����Ը���"
		case "061"
			strareaGbn = "����Ұ�����"
	end select
End Function %>

<!--#include file="../main/top.asp"-->

<script language="javascript">
function go2BannerReg(f){
	var clmn;
	var f = document.banner_form;
	clmn = f.fileb;
	if(clmn.value){
		 if(!clmn.value.match(/\.(gif|jpg|swf|png)$/i)){
			alert("��������� �÷���(swf),�̹���(gif,jpg,png) ���ϸ� ����Ͻ� �� �ֽ��ϴ�.");
			clmn.select();
			return;
		 }
	}
f.submit();
}

function go2DelBan(){
	var delok = confirm("������ �����Ͻðڽ��ϱ�?");
	if(delok){
		location.href="banner_del.asp?idx=<%=idx%>";
	}
}
</script>

<div class="container">
	<!--#include file="left.asp"-->
	<div class="content">
		<h2 class="cTit"><span class="bullet"></span>��ʼ���</h2>

<form name="banner_form" method="post" action="banner_edit_ok.asp" enctype="multipart/form-data">
<input type="hidden" name="idx" value="<%=idx%>">
<input type="hidden" name="intpg" value="<%=intpg%>">   		
		<table class="ftbl mb50" style="width:100%">
				<colgroup>
				<col style="width:20%" />
				<col style="width:80%" />
				</colgroup>
				<tbody>
					<tr>
						<th>�̹���</th>
						<td><img src="/ahdma/banner/<%=banner%>"></td>
					</tr>
					<tr>
						<th>�����ġ</th>
						<td><%=strBanGbn(bangbn)%> > <%=strAreaGbn(areagbn)%></td>
					</tr>
					<tr>
						<th>�������</th>
						<td><input type="file" name="fileb" size="30" class="inptxt1 w400" > <p class="stip">���������� : <%=inSize%></p></td>
					</tr>
					<tr>
						<th>�����ּ�</th>
						<td><input type="text" name="banner_url" class="inptxt1 w400" value="<%=banner_url%>"></td>
					</tr>
					<tr>
						<th>��ʼ���</th>
						<td><input type="text" name="title" class="inptxt1 w400" value="<%=title%>"></td>
					</tr>
					<tr>
						<th>��ʹ����÷�</th>
						<td><input type="text" name="bgcolor" class="inptxt1 w100" value="<%=bgcolor%>"> <span class="stip">* �����÷��� �ʿ��Ұ�� ��� �������Ʈ (https://html-color-codes.info/Korean/)</span></td>
					</tr>		
					<tr>
						<th>��ʼ���</th>
						<td><input name="ordnum" type="text" class="inptxt1 w100" id="ordnum" value="<%=ordnum%>" > <span class="stip">0�� �� ���� �����ϴ�. </td>
					</tr>	
					<tr>
						<th>���Ÿ��</th>
						<td><input name="target" type="radio" value="_self" <%if target="_self" then response.write"checked" end if%>> 
����â&nbsp;&nbsp;&nbsp;
  <input type="radio" name="target" value="_blank" <%if target="_blank" then response.write"checked" end if%>> 
��â</td>
					</tr>						
				</tbody>
			</table>
</form>


		<div class="rbtn">
			<a href="javascript:go2BannerReg(this.form);" class="btn trans">�����ϱ�</a>		
			<a href="banner_list.asp" class="btn">�������</a>
		</div>

	</div>
</div>


</body>
</html>
<!-- #include file = "../authpg_2.asp" -->