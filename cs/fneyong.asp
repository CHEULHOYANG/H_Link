<!-- #include file="../include/set_loginfo.asp" -->
<!-- #include file="../include/dbcon.asp" -->
<%
Dim idx,intpg
Dim wday,readnum
dim jemok,neyong

idx = Request("idx")
intpg = Request("intpg")

sql = "select jemok,neyong,wday from faqTab where idx=" & idx
set dr = db.execute(sql)

jemok = dr(0)
neyong = dr(1)
wday = dr(2)
dr.close 
%>
<!-- #include file="../include/head1.asp" -->
<!-- #include file="../include/top.asp" -->

<div class="smain">
	<!-- #include file="left.asp" -->
    <div class="content">
    	<div class="cont_tit">
        	<h3>���ֹ�������</h3>
        </div>
        <div class="scont">

            <table class="ftbl" style="width:830px">
                    <colgroup>
                    <col style="width:20%" />
                    <col style="width:30%" />
                    <col style="width:20%" />
					<col style="width:30%" />
                    </colgroup>
                    <thead>
                        <tr>
                            <th>����</th>
                            <td colspan="3"><%=jemok%></td>
                        </tr>
                        <tr>
                            <th>�ۼ���</th>
                            <td><%=wday%></td>
							<th>��ȸ��</th>
                            <td><%=readnum%></td>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="cmt" colspan="4"><%=neyong%></td>
                        </tr>
                    </tbody>
                </table>
            <div class="cbtn"> <a href="flist.asp?intpg=<%=intpg%>&searchpart=<%=request("searchpart")%>&searchstr=<%=request("searchstr")%>" class="mbtn">�������</a> </div>

        </div>
    </div>
</div>

<!-- #include file="../include/bottom.asp" -->