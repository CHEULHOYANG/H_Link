<!-- #include file="../include/set_loginfo.asp" -->
<% if isUsr then %>
<!-- #include file="../include/dbcon.asp" -->
<%
dim rs,order_id,regdate,total_price,tak_price,c_price

order_id=request("order_id")

sql="select top 1 regdate from order_mast where order_id='"& order_id &"' order by idx desc"
set rs=db.execute(sql)

regdate=rs(0)
rs.close


sql="select isnull(sum(intprice),0) from order_mast where bookidx=1 and order_id='"& order_id &"'"
set rs=db.execute(sql)

total_price = rs(0)
rs.close

sql="select top 1 send_price,cprice from order_mast where bookidx=1 and order_id='"& order_id &"' order by idx desc"
set rs=db.execute(sql)

If rs.eof Or rs.bof Then

	response.write"<script>"
	response.write"alert('�����Ϳ���');"
	response.write"self.close();"
	response.write"</script>"
	response.end

Else

	tak_price = rs(0)
	c_price = rs(1)

rs.close
End if
%>
<!DOCTYPE html>
<head>
<title>�������μ��ϱ�</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<STYLE>BODY {
	SCROLLBAR-FACE-COLOR: #dfdfdf; FONT-SIZE: 9pt; COLOR: #333333; SCROLLBAR-3DLIGHT-COLOR: #595959; LINE-HEIGHT: 14px; SCROLLBAR-ARROW-COLOR: #7f7f7f; FONT-FAMILY: "����", "Seoul", "arial", "Verdana", "helvetica"; SCROLLBAR-DARKSHADOW-COLOR: #ffffff
}
TABLE {
	SCROLLBAR-FACE-COLOR: #dfdfdf; FONT-SIZE: 9pt; COLOR: #333333; SCROLLBAR-3DLIGHT-COLOR: #595959; LINE-HEIGHT: 14px; SCROLLBAR-ARROW-COLOR: #7f7f7f; FONT-FAMILY: "����", "Seoul", "arial", "Verdana", "helvetica"; SCROLLBAR-DARKSHADOW-COLOR: #ffffff
}
TR {
	SCROLLBAR-FACE-COLOR: #dfdfdf; FONT-SIZE: 9pt; COLOR: #333333; SCROLLBAR-3DLIGHT-COLOR: #595959; LINE-HEIGHT: 14px; SCROLLBAR-ARROW-COLOR: #7f7f7f; FONT-FAMILY: "����", "Seoul", "arial", "Verdana", "helvetica"; SCROLLBAR-DARKSHADOW-COLOR: #ffffff
}
TD {
	SCROLLBAR-FACE-COLOR: #dfdfdf; FONT-SIZE: 9pt; COLOR: #333333; SCROLLBAR-3DLIGHT-COLOR: #595959; LINE-HEIGHT: 14px; SCROLLBAR-ARROW-COLOR: #7f7f7f; FONT-FAMILY: "����", "Seoul", "arial", "Verdana", "helvetica"; SCROLLBAR-DARKSHADOW-COLOR: #ffffff
}
.m_a {
	FONT-SIZE: 8pt; FONT-FAMILY: "����"; LETTER-SPACING: -1px
}
.01 {
	FONT-SIZE: 9pt; PADDING-TOP: 2pt
}
.02 {
	FONT-SIZE: 9pt; COLOR: #333333; PADDING-TOP: 2pt
}
.03 {
	FONT-SIZE: 9pt; COLOR: #ff4633; PADDING-TOP: 2pt
}
.xx {
	BORDER-RIGHT: #a2a2a2 1px solid; BORDER-TOP: #a2a2a2 1px solid; FONT-SIZE: 9pt; BORDER-LEFT: #a2a2a2 1px solid; BORDER-BOTTOM: #a2a2a2 1px solid; BACKGROUND-COLOR: #f0f0f0
}
.yy {
	BORDER-RIGHT: #a2a2a2 1px solid; BORDER-TOP: #a2a2a2 1px solid; FONT-SIZE: 9pt; BORDER-LEFT: #a2a2a2 1px solid; BORDER-BOTTOM: #a2a2a2 1px solid; ffffff: 
}
A:link {
	COLOR: #585858; TEXT-DECORATION: none
}
A:visited {
	COLOR: #585858; TEXT-DECORATION: none
}
A:active {
	COLOR: #585858; TEXT-DECORATION: none
}
A:hover {
	COLOR: #585858; TEXT-DECORATION: none
}
</STYLE>
<script LANGUAGE=JavaScript>
<!--
function OnPrint() {
	window.print();
	self.close();
}
//-->
</script>
</head>
<body bgcolor="#FFFFFF" text="#000000" OnLoad="OnPrint()">
<table 
style="BORDER-RIGHT: #364f9e 2px solid; BORDER-TOP: #364f9e 2px solid; BORDER-LEFT: #364f9e 2px solid; BORDER-BOTTOM: #364f9e 2px solid" 
cellspacing=0 cellpadding=0 width=400 border=0 align="center">
  <tbody> 
  <tr> 
    <td> 
      <table 
      style="BORDER-RIGHT: #364f9e 1px solid; BORDER-TOP: #364f9e 1px solid; BORDER-LEFT: #364f9e 1px solid" 
      cellspacing=0 cellpadding=0 width=400 border=0>
        <tbody> 
        <tr> 
          <td colspan="2"> 
            <table cellspacing=0 cellpadding=0 width="100%" border=0>
              <tbody> 
              <tr> 
                <td style="FONT: 18pt ����; COLOR: #364f9e" align="right" 
                width="50%" height="60"><strong>�� �� ��</strong></td>
                <td class=01 style="PADDING-LEFT: 6px" 
                width="50%" height="60">(���޹޴��ں�����)</td>
              </tr>
              </tbody> 
            </table>
          </td>
        </tr>
        <tr> 
          <td width="109" height="30" style="BORDER-RIGHT: #364f9e 1px solid;BORDER-TOP: #364f9e 1px solid">&nbsp;&nbsp;No.</td>
          <td width="291" height="30" align="right">����&nbsp;&nbsp;</td>
        </tr>
        </tbody> 
      </table>
      <table cellspacing=0 cellpadding=0 width=400 border=0>
        <tbody> 
        <tr> 
          <!-- ������ -->
          <td class=01 
          style="BORDER-TOP: #364f9e 1px solid; PADDING-LEFT: 2px; BORDER-LEFT: #364f9e 1px solid; LINE-HEIGHT: 36px" 
          align="center" width=32>��<br>
            ��<br>
            �� </td>
          <td valign=top width="368"> 
            <table 
            style="BORDER-RIGHT: #364f9e 3px solid; BORDER-TOP: #364f9e 3px solid; BORDER-LEFT: #364f9e 3px solid; BORDER-BOTTOM: #364f9e 3px solid" 
            cellspacing=0 cellpadding=0 width="368" border=0>
              <tbody> 
              <tr> 
                <td class=01 style="BORDER-RIGHT: #364f9e 1px solid" 
                align="center" width=68 height=24>��Ϲ�ȣ</td>
                <td class=02 style="PADDING-LEFT: 6px" 
                colspan=4><%=c_number%></td>
              </tr>
              <tr> 
                <td bgcolor=#364f9e colspan=5 height=1></td>
              </tr>
              <tr> 
                <td class=01 style="BORDER-RIGHT: #364f9e 1px solid" 
                align="center" height=28 width="68">��<font 
                  color=#ffffff>___</font>ȣ<br>
                  (���θ�) </td>
                <td class=02 style="PADDING-RIGHT: 6px; PADDING-LEFT: 6px" 
                width=117><%=c_name%></td>
                <td class=01 
                style="BORDER-RIGHT: #364f9e 1px solid; BORDER-LEFT: #364f9e 1px solid" 
                align="center" width=22>����</td>
                <td class=02 style="PADDING-RIGHT: 10px" align="right" width="141"><%=c_ceo%></td>
                <td width="20"><img src="../img/in.gif"></td>
              </tr>
              </tbody> 
            </table>
            <table cellspacing=0 cellpadding=0 width="368" border=0>
              <tbody> 
              <tr> 
                <td class=01 
                style="BORDER-RIGHT: #364f9e 1px solid; BORDER-LEFT: #364f9e 1px solid" 
                align="center" width=70 height=28>�� �� ��<br>
                  �� �� �� </td>
                <td class=02 
                style="BORDER-RIGHT: #364f9e 1px solid; PADDING-RIGHT: 6px; PADDING-LEFT: 6px" 
                colspan=3><%=c_juso%></td>
              </tr>
              <tr> 
                <td bgcolor=#364f9e colspan=4 height=1></td>
              </tr>
              <tr> 
                <td class=01 
                style="BORDER-RIGHT: #364f9e 1px solid; BORDER-LEFT: #364f9e 1px solid" 
                align="center" height=28 width="70">��<font color=#ffffff>___</font>��</td>
                <td class=02 style="PADDING-RIGHT: 6px; PADDING-LEFT: 6px" 
                width=117>����</td>
                <td class=01 
                style="BORDER-RIGHT: #364f9e 1px solid; PADDING-LEFT: 4px; BORDER-LEFT: #364f9e 1px solid" 
                width=19>��<br>
                  �� </td>
                <td class=02 
                style="BORDER-RIGHT: #364f9e 1px solid; PADDING-RIGHT: 6px; PADDING-LEFT: 6px" width="162">���ڻ�ŷ�</td>
              </tr>
              </tbody> 
            </table>
          </td>
          <!-- ���޹޴��� -->
        </tr>
        </tbody> 
      </table>
      <table cellspacing=1 cellpadding=0 width=400 bgcolor=#364f9e border=0>
        <tbody> 
        <tr bgcolor=#ffffff> 
          <td class=01  align="center" width="109">��&nbsp;��&nbsp;��&nbsp;��&nbsp;��</td>
          <td class=01 style="BORDER-TOP: #364f9e 2px solid;BORDER-right: #364f9e 2px solid;BORDER-left: #364f9e 2px solid" align="center" width="205">��&nbsp;��&nbsp;��&nbsp;��&nbsp;��&nbsp;��</td>
          <td class=01 align="center" width=82>��<font 
          color=#ffffff>___</font>��</td>
        </tr>
        <tr bgcolor=#ffffff> 
          <td class=01 
          height=34 align="center" width="109"><%=replace(left(now(),10),"-",".")%></td>
          <td style="BORDER-BOTTOM: #364f9e 2px solid;BORDER-right: #364f9e 2px solid;BORDER-left: #364f9e 2px solid" width="205">&nbsp;&nbsp;&nbsp;<b><%=formatcurrency(total_price,0)%></b></td>
          <td class=02 align="center" width="82"></td>
        </tr>
        </tbody> 
      </table>
      <table width="400" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td style="BORDER-BOTTOM: #364f9e 1px solid;BORDER-left: #364f9e 1px solid;BORDER-RIGHT: #364f9e 1px solid" height="30" align="center">�� 
            &nbsp;&nbsp;�ݾ��� &nbsp;&nbsp;���� &nbsp;&nbsp;���� &nbsp;&nbsp;(û��) &nbsp;&nbsp;��.</td>
        </tr>
      </table>
      <table cellspacing=0 cellpadding=0 width=400 border=0>
        <tbody> 
        <tr> 
          <td class=01 
          style="BORDER-RIGHT: #364f9e 1px solid; BORDER-LEFT: #364f9e 1px solid" 
          align="center" width="20" height=24>��</td>
          <td class=01 style="BORDER-RIGHT: #364f9e 1px solid" align="center" 
          width=19>��</td>
          <td class=01 style="BORDER-RIGHT: #364f9e 1px solid" align="center" 
          width=122>ǰ��</td>
          <td class=01 style="BORDER-RIGHT: #364f9e 1px solid" align="center" 
          width=35>����</td>
          <td class=01 style="BORDER-RIGHT: #364f9e 1px solid" align="center" 
          width=71>�ܰ�</td>
          <td class=01 style="BORDER-RIGHT: #364f9e 1px solid" align="center" 
          width=85>���ް���</td>
          <td class=01 style="BORDER-RIGHT: #364f9e 1px solid" 
            align="center" width="48">���</td>
        </tr>
        </tbody> 
      </table>
      <table cellspacing=1 cellpadding=0 width=400 bgcolor=#364f9e border=0>
<%
sql="select title,intprice from order_mast where bookidx=1 and order_id='"& order_id &"' order by idx desc"
set rs=db.execute(sql)
if rs.eof or rs.bof then
Else
do until rs.eof				
%>
        <tbody> 
        <tr bgcolor=#ffffff> 
          <td class=02 align="center" width="20" height="25"><%=left(right(FormatDateTime(regdate,2),5),2)%></td>
          <td class=02 align="center" width="20"><%=right(right(FormatDateTime(regdate,2),5),2)%></td>
          <td class=02 style="PADDING-RIGHT: 6px; PADDING-LEFT: 6px; WORD-BREAK: break-all" 
          width="116"><%=cutstr(rs(0),15)%></td>
          <td class=02 align="center" width=37>1</td>
          <td class=02 align="right"  width=66><%=formatnumber(rs(1),0)%>��</td>
          <td class=02 align="right"  width=81><%=formatnumber(rs(1),0)%>��</td>
          <td class=02 align="center" width="52"></td>
        </tr>
<%
rs.movenext
Loop
rs.close
end If

If Int(tak_price) > 0 then
%>
        <tr class=02 bgcolor=#ffffff> 
          <td class=02 align="center" height="25" width="20"><%=left(right(FormatDateTime(regdate,2),5),2)%></td>
          <td class=02 align="center" width="20"><%=right(right(FormatDateTime(regdate,2),5),2)%></td>
          <td class=02 style="PADDING-LEFT: 6px" width="116"><font color="#FF3333">��ۺ�(+)</font></td>
          <td class=02 align="center" width="37">&nbsp;</td>
          <td class=02 style="PADDING-RIGHT: 6px" align="right" width="66">&nbsp;</td>
          <td class=02 style="PADDING-RIGHT: 6px" align="right" width="81"><%=formatnumber(tak_price,0)%>��</td>
          <td class=02 align="center" width="52">&nbsp;</td>
        </tr>
<%End if%>
<%if Int(c_price) > 0 then%>
        <tr class=02 bgcolor=#ffffff> 
          <td class=02 align="center" height="25" width="20"><%=left(right(FormatDateTime(regdate,2),5),2)%></td>
          <td class=02 align="center" width="20"><%=right(right(FormatDateTime(regdate,2),5),2)%></td>
          <td class=02 style="PADDING-LEFT: 6px" width="116"><font color="#FF3333">�����������(-)</font></td>
          <td class=02 align="center" width="37">&nbsp;</td>
          <td class=02 style="PADDING-RIGHT: 6px" align="right" width="66">&nbsp;</td>
          <td class=02 style="PADDING-RIGHT: 6px" align="right" width="81"><%=formatnumber(c_price,0)%>��</td>
          <td class=02 align="center" width="52">&nbsp;</td>
        </tr>
<%end if%>      
        <tr class=02 bgcolor=#ffffff> 
          <td class=02 align="center" height="25" width="20">&nbsp;</td>
          <td class=02 align="center" width="20">&nbsp;</td>
          <td class=02 style="PADDING-LEFT: 6px" width="116">&nbsp;</td>
          <td class=02 align="center" width="37">&nbsp;</td>
          <td class=02 style="PADDING-RIGHT: 6px" align="right" width="66">&nbsp;</td>
          <td class=02 style="PADDING-RIGHT: 6px" align="right" width="81">&nbsp;</td>
          <td class=02 align="center" width="52">&nbsp;</td>
        </tr>
        </tbody> 
      </table>
      <table cellspacing=0 cellpadding=0 width=400 border=0>
        <tbody> 
        <tr> 
          <td class=01 
          style="BORDER-RIGHT: #364f9e 1px solid; BORDER-LEFT: #364f9e 1px solid" 
          align=center height="30" width=400>�ΰ���ġ���������Ģ ��25���� ������ ����(������)���� ����</td>
        </tr>
        <tr> 
          <td bgcolor=#364f9e width="400" 
  height=1></td>
        </tr>
        </tbody> 
      </table>
    </td>
  </tr>
  </tbody>
</table>
</body>
</html>
<%
Else

	response.write"<script>"
	response.write"alert('�α����� ���� �̿��� �����մϴ�.');"
	response.write"self.close();"
	response.write"</script>"
	response.end

End If

Function cutStr(str, cutLen)
	Dim strLen, strByte, strCut, strRes, char, i
	strLen = 0
	strByte = 0
	strLen = Len(str)
	for i = 1 to strLen
		char = ""
		strCut = Mid(str, i, 1)
		char = Asc(strCut)
		char = Left(char, 1)
		if char = "-" then
			strByte = strByte + 2
		else
			strByte = strByte + 1
		end if
		if cutLen < strByte then
			strRes = strRes & ".."
			exit for
		else
			strRes = strRes & strCut
		end if
	next
	cutStr = strRes
End Function
%>