<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/dbcon.asp" -->
<%
Dim idx,intpg
Dim strPart,varPage,strSearch,gbnS
Dim sql,dr,i

idx = Request("idx")
intpg = Request("intpg")
strPart = Request("strPart")
strSearch = Request("strSearch")
gbnS = Request("gbnS")
varPage = "strPart=" & strPart & "&strSearch=" & strSearch & "&gbnS=" & gbnS

sql = "select strnm from lecturTab where idx=" & idx
set dr = db.execute(sql)
dim strnm
strnm = dr(0)
dr.close
%>
<!--#include file="../main/top.asp"-->

<script language="javascript">
function NumKeyOnly(){
	if((event.keyCode<48)||(event.keyCode>57)) event.returnValue=false;
}

function go2RegFM(theform){
	var clmn;
	clmn = theform.strnm;
	if(clmn.value==""){
		alert("���������� �Է����ּ���!");
		clmn.focus();
		return;
	}
	if(clmn.value.replace(/ /g,"")==""){
		alert("���������� �Է����ּ���!");
		clmn.select();
		return;
	}

	var dtgbn;
	clmn = theform.movlink;
	if(clmn.value){
		dtgbn = CheckDot(clmn.value);
		if(!dtgbn.match(/(wmv|asf)$/i)){
			alert("������������ Ȯ�����ּ���!!\n\n*.wmv,*.asf ���ϸ� ��ũ�� �����մϴ�.");
			clmn.select();
			return;
		}
	}
	mlink = clmn.value;

	clmn = theform.flshlink;
	if(clmn.value){
		dtgbn = CheckDot(clmn.value);
		if(dtgbn != "swf"){
			alert("�÷��������� Ȯ�����ּ���!!\n\n*.swf ���ϸ� ��ũ�� �����մϴ�.");
			clmn.select();
			return;
		}
	}
	flink = clmn.value;

	clmn = theform.movlink1;
	if(clmn.value){
		dtgbn = CheckDot(clmn.value);
		if(!dtgbn.match(/(mp4)$/i)){
			alert("������������ Ȯ�����ּ���!!\n\n*.mp4 ���ϸ� ��ũ�� �����մϴ�.");
			clmn.select();
			return;
		}
	}
	mp4link = clmn.value;

	if(mlink.replace(/ /g,"") == "" && flink.replace(/ /g,"") == "" && mp4link.replace(/ /g,"") == ""){
		alert("������ �����̳� �÷��� ���� �� �ϳ��� �ݵ�� �Է��ϼž� �մϴ�!");
		theform.movlink.focus();
		return;
	}

theform.submit();
}

function CheckDot(str){
	var tempAry = str.split(".");
	var arynum = tempAry.length - 1;

	var retrunValue = "none";

	if(arynum > 0){
		retrunValue = tempAry[arynum];
	}
return retrunValue;
}
</script>

<div class="container">
	<!--#include file="left.asp"-->
	<div class="content">
		<h2 class="cTit"><span class="bullet"></span>����Ʈ��������</h2>
	</div>
</div>


<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="35" background="../yes_rad_img/include/img/t3_bg.gif"><table width="900" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="20">&nbsp;</td>
            <td width="880"><table border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="15"><img src="../yes_rad_img/a_img/page/i_home.gif" width="11" height="10" /></td>
                <td class="grey2">HOME</td>
                <td width="15" align="center"><img src="../yes_rad_img/a_img/page/i_cate.gif" width="5" height="9" /></td>
                <td class="grey2_1">���񽺰���</td>
                <td width="15" align="center"><img src="../yes_rad_img/a_img/page/i_cate.gif" width="5" height="9" /></td>
                <td class="grey2_1"><strong>�ܰ����°���</strong></td>
                <td width="15" align="center"><img src="../yes_rad_img/a_img/page/i_cate.gif" width="5" height="9" /></td>
                <td class="grey2_1"><strong>���ǵ��</strong></td>                
              </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td height="10" align="center" valign="top"></td>
        <td height="10" align="center" valign="top"></td>
      </tr>
      <tr>
        <td width="200px" valign="top"><!--#include file="left.asp"--></td>
        <td width="88%" valign="top"><table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td><table width="780" border="0" align="center" cellpadding="0" cellspacing="0">
              <form name="regfm" action="sec_reg_ok.asp" method="post" style="display:inline;">
			  <input type="hidden" name="idx" value="<%=idx%>">
			  <input type="hidden" name="intpg" value="<%=intpg%>">
			  <input type="hidden" name="strPart" value="<%=strPart%>">
			  <input type="hidden" name="gbnS" value="<%=gbnS%>">
			  <input type="hidden" name="strSearch" value="<%=strSearch%>">
			  <tr>
				  <td width="780" align="center">
					<table width="780" border="0" cellspacing="1" cellpadding="0" bgcolor="#DEDFDE">

						<tr bgcolor="#FFFFFF" height="30">
						  <td align="center" bgcolor="eeeeee"><strong><font color="#000000">��ϱ���</font></strong></td>
						  <td colspan="3">&nbsp;
                            <input name="radio" type="radio" id="radio" onclick="self.location.href='sec_reg.asp?idx=<%=request("idx")%>&intpg=<%=request("intpg")%>&gbnS=<%=request("gbnS")%>&strPart=<%=request("strPart")%>&strSearch=<%=request("strsearch")%>';" value="radio" checked>
�������
<input name="radio" type="radio" id="radio2" value="radio" onclick="self.location.href='sec_reg_auto.asp?idx=<%=request("idx")%>&intpg=<%=request("intpg")%>&gbnS=<%=request("gbnS")%>&strPart=<%=request("strPart")%>&strSearch=<%=request("strsearch")%>';">
�뷮���</td>
						  </tr>
						<tr bgcolor="#FFFFFF" height="30">
						  <td align="center" bgcolor="eeeeee"><strong><font color="#000000">���ǹݺ���ϼ���</font></strong></td>
						  <td colspan="3">&nbsp;  
						    <select name="i" id="i" class="simpleform">
                            <%for i = 1 to 100%>
						      <option value="<%=i%>"><%=i%></option>
                             <%next%> 
						      </select></td>
						  </tr>
						<tr bgcolor="#FFFFFF" height="30">
							<td width="150" align="center" bgcolor="eeeeee"><strong><font color="#000000">��������</font></strong></td>
							<td width="237">&nbsp;  <input type="text"  name="strnm" class="simpleform" size="30" maxlength="50" value=""></td>
							<td width="150" align="center" bgcolor="eeeeee"><strong><font color="#000000">���ǽð�</font></strong></td>
							<td width="238">&nbsp; <input type="text"  name="time1" class="simpleform" size="3" maxlength="2" onKeyPress="NumKeyOnly();"> �� : <input type="text"  name="time2" class="simpleform" size="3" maxlength="2" onKeyPress="NumKeyOnly();"> ��</td>
						</tr>
						<tr bgcolor="#FFFFFF" height="30">
							<td align="center" bgcolor="eeeeee"><strong><font color="#000000">��Ʈ����ũ</font></strong></td>
							<td colspan="3">&nbsp; <input type="text"  name="movlink" class="simpleform" style="width:470px;" ></td>
						</tr>
						<tr bgcolor="#FFFFFF" height="30">
							<td align="center" bgcolor="eeeeee"><strong><font color="#000000">�÷�����ũ</font></strong></td>
							<td colspan="3">&nbsp; <input type="text"  name="flshlink" class="simpleform" style="width:470px;" ></td>
						</tr>
						<tr bgcolor="#FFFFFF" height="30">
							<td align="center" bgcolor="eeeeee"><strong><font color="#000000">MP4��ũ</font></strong></td>
							<td colspan="3">&nbsp;
							  <input type="text"  name="movlink1" class="simpleform" style="width:470px;" ></td>
						</tr>
						<tr bgcolor="#FFFFFF" height="30">
						  <td align="center" bgcolor="eeeeee"><strong><font color="#000000">�ܺθ�ũ�ҽ�</font></strong></td>
						  <td height="70" colspan="3">&nbsp;
                            <textarea name="freelink" rows="5" class="simpleform" style="width:470px;height:50px"></textarea></td>
						  </tr>
						<tr bgcolor="#FFFFFF" height="30">
						  <td align="center" bgcolor="eeeeee"><span class="style1">���ø�ũ</span></td>
						  <td colspan="3">&nbsp;
                            <input type="text"  name="movlink2" class="simpleform" style="width:470px;" ></td>
						  </tr>
						<tr bgcolor="#FFFFFF" height="30">
							<td align="center" bgcolor="eeeeee"><span class="style2">���ǿ���(�����ּ�)</span></td>
							<td colspan="3">&nbsp; <input type="text"  name="lecsum" class="simpleform" style="width:470px;"></td>
						</tr>
						<tr bgcolor="#FFFFFF" height="30">
							<td align="center" bgcolor="eeeeee"><span class="style2">���Ǽҽ�(�����ּ�)</span></td>
							<td colspan="3">&nbsp;
							  <input type="text"  name="lecsrc" class="simpleform" style="width:470px;"></td>
						</tr>
					</table>				  </td>
			  </tr>
			  <tr>
				  <td align="center">
					<table width="780" border="0" cellpadding="0" cellspacing="0">
				  <tr height="30">
							<td width="780" height="50" align="center">
							<img src="../yes_rad_img/a_img/bt/bt_01.gif" width="70" height="24" onClick="go2RegFM(regfm);" style="cursor:pointer;">&nbsp;<img src="../yes_rad_img/a_img/bt/bt_03.gif" width="70" height="24" onClick="location.href='dan_neyong.asp?idx=<%=idx%>&intpg=<%=intpg%>&<%=varPage%>';" style="cursor:pointer;"></td>
					  </tr>
					</table>			    </td>
			  </tr></form>
			</table></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table>


</body>
</html>
<!-- #include file = "../authpg_2.asp" -->