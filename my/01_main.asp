<!-- #include file="../include/set_loginfo.asp" -->
<% if isUsr then %>
<!-- #include file="../include/dbcon.asp" -->
<!-- #include file="../include/head1.asp" -->
<%
Dim huday

sql = "select huday from site_info"
set dr = db.execute(sql)

If dr.eof Or dr.bof Then
	huday = 0
Else
	huday = dr(0)
dr.close
End if
%>
<script language="javascript">
function go2HoldOn(hldidx,hil,whnhuil){

		if(parseInt(whnhuil) < 1){
			alert("������ ������û��, �Ǵ� ������ ���Ϸ簡 ������  ��û�Ͻ� �� �ֽ��ϴ�!");
			return;
		}

		var bool = confirm("������ �Ͻðڽ��ϱ�?");
		if (bool){

			if(parseInt(hil) < 1){
				alert("������ �������� ����Ǿ ���̻� �����Ͻ� �� �����ϴ�!");
				return;
			}
			location.href="holdon.asp?idx=" + hldidx;

		}

}
function go2HoldOff(hldidx,whnhold){

		if(parseInt(whnhold) < 1){
			alert("������ �����ϰ� �Ϸ簡 ���� �Ŀ� ��û�Ͻ� �� �ֽ��ϴ�!");
			return;
		}

		var bool = confirm("������ �Ͻðڽ��ϱ�?");
		if (bool){

			location.href="holdoff.asp?idx=" + hldidx;

		}
}
function go2VewPlay(pgidx,gn,order_mast_idx){
	if(gn > 1){
		location.href="01_buy_dan_view.asp?idx="+pgidx+"&order_mast_idx="+order_mast_idx+"";
	}
	else {
		location.href="01_buy_class_view.asp?idx="+pgidx+"&order_mast_idx="+order_mast_idx+"";
	}		
}
</script>

<!-- #include file="../include/top.asp" -->

<div class="smain">    
	<!--#include file="left.asp" -->
    <div class="content">
    	<div class="cont_tit">
        	<h3>���Ű��Ǹ��</h3>
        </div>
        <div class="scont">
        	<%If huday > 0 then%><h3 class="stit">�������� ���Ǹ��</h3><%End if%>
			<table class="btbl mb80" style="width:830px">
					<colgroup>
						<col style="width:8%" />
						<col />
						<col style="width:14%" />
						<col style="width:14%" />
						<col style="width:12%" />
						<%If huday > 0 then%><col style="width:14%" /><%End if%>
						<col style="width:10%" />
					</colgroup>
					<thead>
						<tr>
							<th>��ȣ</th>								
							<th>���¸�</th>
							<th>������</th>
							<th>������</th>
							<th>�����Ⱓ</th>		
							<%If huday > 0 then%><th>���н�û</th><%End if%>
							<th>ȯ��</th>	
						</tr>				
					</thead>
					<tbody>
<% 
sql = "select titlenm = title + dbo.LectuTitle(tabidx,buygbn),buygbn,tabidx,sday,eday,DateDiff(day,GetDate(),eday),idx,holdil,isNull(DateDiff(day,holdsday,GetDate()),1),return_state from order_mast"
sql = sql & " where id='" & str_User_ID & "' and state=0 and holdgbn=0 and bookidx=0 and DateDiff(day,GetDate(),sday) <=0 and DateDiff(day,GetDate(),eday) >= 0 order by buygbn"

set dr = db.execute(sql)
if Not dr.Bof or Not dr.Eof then
isRecod = True
isRows = split(dr.Getstring(2),chr(13))
end if
dr.Close 			  
			  
if isRecod then 
			   
	for ii = 0 to UBound(isRows) - 1
	isCols = split(isRows(ii),chr(9))		
	
		If Len(isCols(0)) > 0 then
			   %>
				<tr>
					<td><%=ii+1%></td>
					<td class="tl"><% if int(isCols(1)) > 0 then %><a href="javascript:go2VewPlay('<%=isCols(2)%>',<%=isCols(1)%>,<%=isCols(6)%>);"><%=isCols(0)%></a><%else%><%=isCols(0)%><%end if%></td>
					<td><%=replace(formatdatetime(isCols(3),2),"-",".")%></td>
					<td><%=replace(formatdatetime(isCols(4),2),"-",".")%></td>
					<td><%=isCols(5)%></td>
					<%If huday > 0 then%><td><a href="javascript:go2HoldOn('<%=isCols(6)%>','<%=isCols(7)%>','<%=isCols(8)%>');" class="sbtn">��û�ϱ�</a></td><%End if%>

					<%If isCols(9) = 0 then%>
					<td><a href="01_return.asp?idx=<%=isCols(6)%>" style="display:block;height:28px;line-height:28px;margin:3px auto;width:50px;vertical-align:middle;border:1px solid #cc0000;color:#cc0000!important;font-size:12px;letter-spacing:-1px">ȯ�ҽ�û</a></td>
					<%End if%>
					<%If isCols(9) = 1 then%>
					<td><p style="display:block;height:28px;line-height:28px;margin:3px auto;width:50px;vertical-align:middle;border:1px solid #ff6633;color:#ff6633!important;font-size:12px;letter-spacing:-1px">ȯ������</p></td>
					<%End if%>
					<%If isCols(9) = 2 then%>
					<td><p style="display:block;height:28px;line-height:28px;margin:3px auto;width:50px;vertical-align:middle;border:1px solid #336699;color:#336699!important;font-size:12px;letter-spacing:-1px">ȯ�ҿϷ�</p></td>
					<%End if%>

				</tr>
<%
		End if
	Next
End If
%>
					</tbody>
				</table>
<%If huday > 0 then%>
			<h3 class="stit">�ް����� ���Ǹ��</h3>
			<table class="btbl" style="width:830px">
					<colgroup>
						<col style="width:8%" />
						<col />
						<col style="width:14%" />
						<col style="width:14%" />
						<col style="width:12%" />
						<col style="width:14%" />
					</colgroup>
					<thead>
						<tr>
							<th>��ȣ</th>								
							<th>���¸�</th>
							<th>������</th>
							<th>������</th>
							<th>�����Ⱓ</th>		
							<th>���н�û</th>
						</tr>				
					</thead>
					<tbody>
<% Dim isHold

sql = "select titlenm = title + dbo.LectuTitle(tabidx,buygbn),buygbn,tabidx,holdsday,holdeday,DateDiff(day,GetDate(),holdeday),idx,DateDiff(day,holdsday,GetDate()) from order_mast"
sql = sql & " where id='" & str_User_ID & "' and state=0 and holdgbn > 0 and bookidx=0 and eday > convert(smalldatetime,getdate()) order by buygbn"

set dr = db.execute(sql)

if Not dr.Bof or Not dr.Eof then
	isHold = True
	isRows = split(dr.Getstring(2),chr(13))
end if
dr.Close 
if isHold then 

	for ii = 0 to UBound(isRows) - 1
	isCols = split(isRows(ii),chr(9))
%>
				<tr>
					<td><%=ii+1%></td>
					<td class="tl"><%=isCols(0)%></td>
					<td><%=replace(formatdatetime(isCols(3),2),"-",".")%></td>
					<td><%=replace(formatdatetime(isCols(4),2),"-",".")%></td>
					<td><%=isCols(5)%></td>
					<td><a href="javascript:go2HoldOff('<%=isCols(6)%>','<%=isCols(7)%>');" class="sbtn">��û�ϱ�</a></td>
				</tr>
<%
	Next
End If
%>
					</tbody>
				</table>
			<ul class="free">
				<li class="cont"><span>������ ���Ϻ����� �Ұ����ϸ� �Ϸ簡 �����Ŀ� ������ �����մϴ�.</span></li>
			</ul>
<%End if%>
        </div>
    </div>
</div>

<!-- #include file="../include/bottom.asp" -->
<% else %><!-- #include file = "../include/false_pg.asp" -->
<% end if %>