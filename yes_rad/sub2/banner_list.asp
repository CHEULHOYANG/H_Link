<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/dbcon.asp" -->
<%
Dim sql,dr,isRecod,isRows,isCols
Dim intpg,blockPage,pagecount,recordcount,lyno
Dim tabnm : tabnm = "banner"

Dim nowPage : nowPage = Request("URL")

intpg = Request("intpg")
if intpg = "" then
	intpg = 1
else
	intpg = int(intpg)
end if

const pagesize = 10

Dim strClmn : strClmn = " idx,bangbn,areagbn,filegbn,banner_url "

sql = "select Count(idx) from " & tabnm
set dr = db.execute(sql)
recordcount = int(dr(0))
dr.close

if recordcount > 0 then
	isRecod = True
	pagecount=int((recordcount-1)/pagesize)+1
end if
%>

<!--#include file="../main/top.asp"-->

<script language="javascript">
function go2ListPage(pg){
	document.location.href="<%=nowPage%>?intpg=" + pg;
}
function go2DelBan(idx){
	var delok = confirm("������ �����Ͻðڽ��ϱ�?");
	if(delok){
		location.href="banner_del.asp?idx=" + idx;
	}
}
</script>

<div class="container">
	<!--#include file="left.asp"-->
	<div class="content">
		<h2 class="cTit"><span class="bullet"></span>��ʼ���</h2>

		<div class="tbl_top">
			<a href="banner_write.asp" class="fbtn1">��ʵ��</a>	
		</div>

<% if isRecod Then

				sql = "select  top " & pagesize & strClmn & "from " & tabnm & " where idx not in (select top " & ((intpg -1 ) * pagesize) & " idx from " & tabnm & " order by idx desc) order by idx desc"
				set dr = db.execute(sql)
				isRows = split(dr.getstring(2),chr(13)) %>
		<table class="tbl" style="width:100%">
			<colgroup>
			<col style="width:20%" />
			<col />
			<col style="width:25%" />
			<col style="width:10%" />
			</colgroup>
			<thead>
				<tr>
					<th>��ġ/����������</th>	
					<th>��ũ�ּ�</th>
					<th>�������</th>
					<th>����</th>	
				</tr>				
			</thead>
			<tbody>
<%  for ii = 0 to UBound(isRows) - 1
						isCols = split(isRows(ii),chr(9)) %>
				<tr>
					<td><%=strBanGbn(isCols(1))%> > <%=strAreaGbn(isCols(2))%></td>
					<td><% if isCols(4) = "" then %>-<% else %><a href="<%=isCols(4)%>" target="_blank"><%=isCols(4)%></a><% end if %></td>
					<td><% if isCols(3) = "swf" then %>�÷���<% else %>�̹���<% end if %>(<%=isCols(3)%>) ����</td>
					<td><a href="banner_edit.asp?idx=<%=isCols(0)%>&intpg=<%=intpg%>" class="btns">����</a> <a href="javascript:go2DelBan('<%=isCols(0)%>');" class="btns trans">����</a></td>
				</tr>
<% Next %>
			</tbody>
		</table>
<% End if%>

<% if isRecod Then%>
		<div class="cbtn">
<%
blockPage = int((intpg-1)/10) * 10 + 1
%>
			<div class="paging">
			<% if blockPage > 1 Then %>
				<a href="javascript:go2ListPage('1');"><img src="/yes_rad/rad_img/img/a_prev2.gif" alt="ó��������"></a>
				<a href="javascript:go2ListPage('<%=int(blockPage-1)%>');"><img src="/yes_rad/rad_img/img/a_prev1.gif" alt="����������" /></a>
			<%End if%>
			<% ii = 1
									Do Until ii > 10 or blockPage > pagecount
									if blockPage = int(intpg) then %>
				<strong><%=blockPage%></strong><% else %>
				<a href="javascript:go2ListPage('<%=blockPage%>');" class="num"><%=blockPage%></a>
				<% end if
									blockPage = blockPage + 1
									ii = ii + 1
									Loop %>
			<% if blockPage > pagecount then 
			else
			%>
				<a href="javascript:go2ListPage('<%=blockPage%>');"><img src="/yes_rad/rad_img/img/a_next1.gif" alt="����������"></a>
				<a href="javascript:go2ListPage('<%=pagecount%>');"><img src="/yes_rad/rad_img/img/a_next2.gif" alt="������������"></a>
			<%End if%>
			</div>
		</div>
<%End if%>

	</div>
</div>


</body>
</html><% Function strBanGbn(gbncod)
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
			strareaGbn = "����#1(������)"
		case "011"
			strareaGbn = "����#2(1��)"
		case "012"
			strareaGbn = "����#3(1��)"
		case "013"
			strareaGbn = "�ΰ������(1��)"	

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
			strareaGbn = "�����ͻ��"
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
<!-- #include file = "../authpg_2.asp" -->