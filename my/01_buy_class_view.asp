<!-- #include file="../include/set_loginfo.asp" -->
<% if  isUsr then %>
<!-- #include file="../include/dbcon.asp" -->
<% Dim idx,intpg
idx = Request("idx")
intpg = Request("intpg")

sql = "select strnm,intprice,intgigan,strheader,sub_title from LectMast where idx=" & idx
set dr = db.execute(sql)

Dim strnm,intprice,intgigan,strheader,totalnum,sub_title
strnm = dr(0)
intprice = dr(1)
intgigan = dr(2)
strheader = dr(3)
sub_title = dr(4)
dr.close

 sql = "select count(idx) from LectAry where mastidx=" & idx
 set dr = db.execute(sql)
 totalnum = dr(0)
 dr.close

 Dim nowPage : nowPage = Request("URL")
%>
<!-- #include file="../include/head1.asp" -->

<script language="javascript">
function go2Detail(){
	var args = go2Detail.arguments;
	location.href="01_buy_class_detail.asp?order_mast_idx=<%=request("order_mast_idx")%>&idx=<%=idx%>&intpg=<%=intpg%>&lidx=" + args[0] + "&categbn=" + args[1];
}
</script>

<!-- #include file="../include/top.asp" -->

<div class="smain">    
	<!-- #include file="left.asp" -->
    <div class="content">
    	<div class="cont_tit">
        	<h3><%=strnm%></h3>
        </div>
        <div class="scont">
            <table class="ftbl" style="width:830px">
                    <colgroup>
                    <col style="width:20%" />
                    <col style="width:80%" />
                    </colgroup>
                    <thead>
                        <tr>
                            <th>��������</th>
                            <td><%=sub_title%></td>
                        </tr>
                        <tr>
                            <th>�����Ⱓ</th>
                            <td><%=intgigan%>��</td>
                        </tr>
                        <tr>
                            <th>���±���</th>
                            <td><%=totalnum%>����</td>
                        </tr>
                        <tr>
                            <th>������</th>
                            <td><strong class="fr"><%=formatnumber(intprice,0)%></strong>��</td>
                        </tr>
                    </tbody>
                </table>

			<div class="rbtn">
				<a href="01_main.asp" class="mbtn">�������</a>
			</div>

<h3 class="stit">���±���</h3>
            <table class="btbl" style="width:830px">
					<colgroup>
						<col style="width:10%" />
						<col style="width:44%" />
						<col style="width:18%" />
						<col style="width:13%" />
						<col style="width:15%" />
					</colgroup>
					<thead>
						<tr>
							<th>��ȣ</th>								
							<th>���¸�</th>
							<th>������</th>
							<th>����</th>
							<th>���ǽ�����</th>		
						</tr>				
					</thead>
					<tbody>
<%
sql = "select A.idx,A.strnm,A.strteach,A.intprice,(select count(idx) from sectionTab where l_idx=A.idx),A.intgigan,sjin=case A.sajin"
sql = sql & " when 'noimg.gif' then 'noimage.gif' else A.sajin end,datediff(day,A.regdate,getdate()) from LecturTab A join  LectAry B"
sql = sql & " on A.idx=B.lectidx where B.mastidx=" & idx & "   order by B.ordn"
set dr = db.execute(sql)

if not dr.bof or not dr.eof then
isRows = split(dr.getString(2),chr(13))

	for ii = 0 to UBound(isRows) - 1
	isCols = split(isRows(ii),chr(9))
%>
						<tr>
							<td><%=ii+1%></td>
							<td class="tl"><a href="javascript:go2Detail('<%=isCols(0)%>','');"><%=isCols(1)%></a></td>
							<td><%=isCols(2)%></td>
							<td><%=isCols(4)%>��</td>
							<td><a href="javascript:go2Detail('<%=isCols(0)%>','');" class="mmmini">���ǽ�����</a></td>
						</tr>
<%
	Next
Else
End if
%>
					</tbody>
				</table>


        </div>
    </div>
</div>

<!-- #include file="../include/bottom.asp" --><% else %>
<!-- #include file="../include/false_pg.asp" -->
<% end if %>