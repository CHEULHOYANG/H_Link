<!-- #include file="../include/set_loginfo.asp" -->
<!-- #include file="../include/dbcon.asp" -->
<% 
Dim idx,intpg
Dim icon,icon_count,jj
Dim strnm,intprice,intgigan,strheader,totalnum,mem_group,sub_title,mst_view_chk,pass_view_chk,book_idx

idx = Request("idx")
intpg = Request("intpg")

db.execute("update LectMast set readnum=readnum+1 where idx=" & idx)

sql = "select strnm,intprice,intgigan,strheader,icon,mem_group,sub_title,dbo.order_mast_count_mst(idx,'"& str_User_ID &"'),dbo.order_mast_count_pass(idx,'"& str_User_ID &"'),book_idx from LectMast where idx=" & idx
set dr = db.execute(sql)

If dr.eof Or dr.bof Then

	Response.write"<script>"
	Response.write"alert('DB����');"
	Response.write"history.back();"
	Response.write"</script>"
	Response.End
	
Else

	strnm = dr(0)
	intprice = dr(1)
	intgigan = dr(2)
	strheader = dr(3)
	icon = dr(4)
	mem_group = dr(5)
	sub_title = dr(6)
	mst_view_chk = dr(7)
	pass_view_chk = dr(8)
	book_idx = dr(9)

dr.close
End If

Dim varPage : varPage = "idx=" & Request("idx") & "&intpg=" & Request("intpg") & "&categbn=" & request("categbn")

If Len(mem_group) > 3 Then

	sql = "select sp1 from member where id = '"& str_User_ID &"'"
	Set dr = db.execute(sql)

	If dr.eof Or dr.bof Then

			response.redirect "../member/login.asp?str__Page="& server.urlencode(nowPage) &"?"& server.urlencode(varPage) &""
			response.End

	Else

		if instr(mem_group,", "& dr(0) &",") Then
		else

			response.write"<script>"
			response.write"alert('�ش� ���´� ���������� ���� ȸ���� ������ �����մϴ�.');"
			response.write"history.back();"
			response.write"</script>"
			response.End
			
		End If
		
	dr.close
	End if

End if

 sql = "select count(idx) from LectAry where mastidx=" & idx
 set dr = db.execute(sql)
 totalnum = dr(0)
 dr.close

 Dim nowPage : nowPage = Request("URL")
%>
<!-- #include file="../include/head1.asp" -->

<script language="javascript">
function imgBrdStyle(flg,imobj){
	if(flg){
		imobj.style.border="solid 2px #FF6600";
	}
	else{
		imobj.style.border="none";
	}
}
function go2Detail(lidx,categbn){
	var args = go2Detail.arguments;
	location.href="class_detail.asp?idx=<%=idx%>&intpg=<%=intpg%>&lidx=" + lidx + "&categbn=" + categbn;
}

function go2Mst(flg,ctgbn){
	if(flg){
		location.href="../member/login.asp?str__Page=" + encodeURIComponent("<%=nowPage%>?idx=<%=idx%>&intpg=<%=intpg%>&categbn=" + ctgbn);
	}else{
		var params = "key=" + encodeURIComponent("<%=idx%>");
		sndReq("packagebuyxml.asp",params,setMstBuy,"POST");
	}
}

function setMstBuy(){
	if(objXmlhttp.readyState == 4){
		if(objXmlhttp.status==200){
			var xmlDoc = objXmlhttp.responseXML;
			var obj = xmlDoc.getElementsByTagName("isrows");
			var flg =eval(obj[0].getAttribute("flg"));
			var bygbn = obj[0].getAttribute("errgbn");
			bygbn = parseInt(bygbn,10);

			if(flg && bygbn == 3 ){
				location.href="../elpay/pay_mst.asp";
			}else{
				var strMsg = "";
				switch(bygbn){
					case 0:
						strMsg = "Error : �α��� ���� �ʾҰų�, ��Ʈ������";
						break;
					case 1:
						strMsg = "�����̾��� �����ϰ� �����Ƿ� �������¸� �����Ͻ� �ʿ�����ϴ�!";
						break;
					case 2:
						strMsg = "���� ���� ���� �����̰ų� �Աݴ������ �����Դϴ�!";
						break;
				}
				alert(strMsg);
			}
		}else{
			alert("��Ʈ�� ���� : �����ڿ��� �����ϼ���!");
		}
	}
}

function go2Basket(flg,ctgbn){
	if(flg){
		location.href="../member/login.asp?str__Page=" + encodeURIComponent("<%=nowPage%>?idx=<%=idx%>&intpg=<%=intpg%>&categbn=" + ctgbn);
	}else{
		var params = "key=" + encodeURIComponent("<%=idx%>");
		sndReq("packagexml.asp",params,pkgBaguny,"POST");
	}
}

function pkgBaguny(){
	if(objXmlhttp.readyState == 4){
		if(objXmlhttp.status==200){
			var xmlDoc = objXmlhttp.responseXML;
			var obj = xmlDoc.getElementsByTagName("isrows");
			var flg =eval(obj[0].getAttribute("flg"));

			if(flg){
				 alert("�̹� ��ٱ��Ͽ� ����� �����Դϴ�.");
			}else{
				var bool = confirm("��ٱ��Ͽ� ����Ǿ����ϴ�.\n���� Ȯ���Ͻðڽ��ϱ�?");
				if (bool){
					location.href = "/my/03_bguny.asp";
				}
			}

		}else{
			alert("��Ʈ�� ���� : �����ڿ��� �����ϼ���!");
		}
	}
}

function AryDanBuy(flg,ctgbn,n){
	if(flg){
		location.href="../member/login.asp?str__Page=" + encodeURIComponent("<%=nowPage%>?idx=<%=idx%>&intpg=<%=intpg%>&categbn=" + ctgbn);
	}else{
		var params = "key=" + encodeURIComponent(n);
		sndReq("danbuyxml.asp",params,setBuy,"POST");
	}
}

function setBuy(){
	if(objXmlhttp.readyState == 4){
		if(objXmlhttp.status==200){
			var xmlDoc = objXmlhttp.responseXML;
			var obj = xmlDoc.getElementsByTagName("isrows");
			var flg =eval(obj[0].getAttribute("flg"));
			var bygbn = obj[0].getAttribute("errgbn");

			if(flg){
				alert("���� �߻� : �α������� �ʾҰų�, ��Ʈ������");
			}else{

				if(parseInt(bygbn,10) > 0){
					alert("�����̾�  ���¸� �����ϰ� �����Ƿ� �ܰ� ���¸� �����Ͻ� �ʿ䰡 �����ϴ�!");
					return;
				}

				location.href="../elpay/pay_dan.asp";
			}

		}else{
			alert("��Ʈ�� ���� : �����ڿ��� �����ϼ���!");
		}
	}
}

function viewSample(flg,intUnm){
	if(flg){
		alert("�α��� �Ͻ� �� �̿��ϼ���!");
	}else{
		var urlnm="../viwer/smple_ready1.asp?plidx=" + intUnm;
		var sFeatures = "width=980,height=560,top=0,left=0,scrollbars=no,resizable=no,titlebar=no";
		var k = window.open(urlnm, "viewpg", sFeatures);
		k.focus();
	}
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
<%If Len(sub_title) > 0 then%>
                        <tr>
                            <th>��������</th>
                            <td><%=sub_title%></td>
                        </tr>
<%End if%>
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

<%
Dim bcount,book_pop,i,rs
				
				book_pop = book_idx
				book_idx = split(book_idx,",")
				bcount = ubound(book_idx)

	If bcount > 0 then
%>
                        <tr>
                            <th>���ñ���</th>
                            <td colspan="3"><%

		For i = 1 To bcount

				sql = "select price1,title,idx from book_mast where state = 0 and idx = "& book_idx(i)
				Set rs=db.execute(sql)

				If rs.eof Or rs.bof Then
				bcount = bcount - 1
				else
%><strong><a href="/book/content.asp?idx=<%=rs(2)%>" target="_blank"><%=rs(1)%></a></strong><br /><%
				rs.close
				End if
		Next

response.write"* �ش� ��Ű���� ���õ� �������Դϴ�. �����ؼ� �����Ͻø� �����ϴ�."
%></td>
                        </tr>
<%
	End if
%>

<%If Len(strheader) > 4 then%>
                        <tr>
                            <td colspan="2"><%=strheader%></td>
                        </tr>
<%End if%>
                    </tbody>
                </table>

			<div class="rbtn">				
				<a href="class_list.asp?categbn=<%=categbn%>&intpg=<%=intpg%>" class="mbtn">�������</a>
				<%If mst_view_chk = 0 And pass_view_chk = 0 then%>
				<a href="javascript:go2Mst(<%=strProg%>,'<%=categbn%>');" class="mbtn red">������û</a>
				<a href="javascript:go2Basket(<%=strProg%>,'<%=categbn%>');" class="mbtn grey">��ٱ���</a>
				<%End if%>
			</div>

            <h3 class="stit">���±���</h3>
            <table class="btbl" style="width:830px">
					<colgroup>
						<col style="width:10%" />
						<col style="width:42%" />
						<col style="width:18%" />
						<col style="width:10%" />
						<col style="width:20%" />
					</colgroup>
					<thead>
						<tr>
							<th>��ȣ</th>								
							<th>���¸�</th>
							<th>������</th>
							<th>����</th>
							<th></th>		
						</tr>				
					</thead>
					<tbody>
<%
sql = "select A.idx,A.strnm,A.strteach,A.intprice,(select count(idx) from sectionTab where l_idx=A.idx),A.intgigan,sjin=case A.sajin"
sql = sql & " when 'noimg.gif' then 'noimage.gif' else A.sajin end,datediff(day,A.regdate,getdate()),icon from LecturTab A join  LectAry B"
sql = sql & " on A.idx=B.lectidx where B.mastidx=" & idx & "   order by B.ordn"
set dr = db.execute(sql)

if not dr.bof or not dr.eof then
isRows = split(dr.getString(2),chr(13))

for ii = 0 to UBound(isRows) - 1
isCols = split(isRows(ii),chr(9))
%>
						<tr>
							<td><%=ii+1%></td>
							<td class="tl"><a href="javascript:go2Detail('<%=isCols(0)%>','<%=categbn%>');"><%=isCols(1)%></a></td>
							<td><%=isCols(2)%></td>
							<td><%=isCols(4)%>��</td>
<%If mst_view_chk = 0 And pass_view_chk = 0 then%>
							<td><a href="javascript:viewSample(<%=strProg%>,'<%=isCols(0)%>');" class="mmini_sbtn" style="width:60px">���ú���</a>&nbsp;<a href="dan_view.asp?idx=<%=isCols(0)%>" class="mmini_sbtn" style="width:60px">������û</a></td>
<%else%>
							<td><a href="javascript:go2Detail('<%=isCols(0)%>','<%=categbn%>');" class="mmini_sbtn" style="width:60px">���Ǻ���</a></td>
<%End if%>
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

<!-- #include file="../include/bottom.asp" -->