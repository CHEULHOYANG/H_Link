<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/dbcon.asp" -->
<%
dim YY, MM, DD
dim sql ,rs, allRs, rows, rowsCount, cols, i, j
dim sumCount, maxCount, minCount
dim arrData(31,3), curSize, curPer, curMM, curCount
dim dataLength
dim addSize


call PageLoad()
call Manage()

sub PageLoad()

	YY = request ("YY")

	call CheckDate(YY,MM,DD)

end sub

sub Manage()

	dim sqlValue

	sqlValue = ""
	if YY <> "" then
		sqlValue = " where vYY = "&YY&""
	end if

	'ī���� ���� ���� ���Ѵ�
	sql = "select count(vNum) from "&theTable&sqlValue&""
	set rs = db.execute(sql)

		if rs.eof or rs.bof then
		else
			sumCount = rs(0)
		rs.close()
		end if

	'�Ϻ� ī���͸� ���Ѵ�
	sql = "select vMM,count(vNum) from "&theTable&sqlValue&" group by vYY,vMM order by vYY,vMM"
	set rs = db.execute(sql)

		if rs.eof or rs.bof then
		else
			allRs = rs.getstring(2,,chr(9)&chr(10),chr(11)&chr(12))
			rows = split(allRs,chr(11)&chr(12))
			rowsCount = ubound(rows)
			rs.close()
		end if

	'�迭 �ʱ�ȭ
	for i = 0 to ubound(arrData)
		for j = 0 to 2
			arrData(i,j) = 0
		next
	next

	'��¥�� �����͸� �迭�� ��´�
	maxCount = 0
	minCount = 100000
	for i = 0 to rowsCount - 1

		GetData(i)

		curSize		= int(((curCount/sumCount) * 560))
		curPer		= round(((curCount/sumCount) * 100),2)

		if cdbl(maxCount) < cdbl(curCount) then
			maxCount = curCount
		end if

		if cdbl(minCount) > cdbl(curCount) then
			minCount = curCount
		end if

		arrData(curMM,0) = curCount
		arrData(curMM,1) = curSize
		arrData(curMM,2) = curPer

	next

	dataLength = 12

	if minCount = 100000 then minCount = 0
	if cint(rowsCount) < cint(dataLength) then minCount = 0

	addSize = resizingGraph(maxCount,sumCount)

end sub
'---------------------------------------------------------------------------------------------------------------
function GetData(theNum)

	cols			= split(rows(theNum),chr(9)&chr(10))
	curMM		= cols(0)
	curCount	= cols(1)

end function
'---------------------------------------------------------------------------------------------------------------
function SetDetail(theNum)

	if arrData(theNum,0) = maxCount and maxCount <> 0 then
		arrData(theNum,0) = arrData(theNum,0)
	end if

end function


dim color_bar : color_bar = "#76A7FA,#CC0000,#FF6633,#76A7FA,#C5A5CF,#BC5679,#b87333,#cc9966,#009999,#cc99cc,#669933,#76A7FA,#CC0000,#FF6633,#76A7FA,#C5A5CF,#BC5679,#b87333,#cc9966,#009999,#cc99cc,#669933"
color_bar = split(color_bar,",")

%>

<!--#include file="../main/top.asp"-->

<div class="container">
	<!--#include file="left.asp"-->
	<div class="content">
		<h2 class="cTit"><span class="bullet"></span>�������</h2>

<form action="./month.asp" method="post" name="Form1">
		<div class="schWrap1">
			<h3>�˻�</h3>
			<div class="sch_area1">
						<select name="YY" onChange="document.Form1.submit();" class="seltxt w100">
                            <option value="">��ü</option>
                            <%for i = year(date)-5 to year(date) + 5%>
                            <option value="<%=i%>"><%=i%>��</option>
                            <%next%>
                          </select>
			</div>
			
		</div>
</form>		
<script language="javascript">

	form = document.Form1;
	form.YY.value = '<%=YY%>';

</script>

		<div class="tbl_top">			
			<span class="tbl_total">��ü : <%=sumCount%>&nbsp;, �ִ� : <%=maxCount%>&nbsp;, �ּ�: <%=minCount%></span>
			<%=ChangeDate("������","������","������","������","������","������")%>
		</div>

		<script type="text/javascript" src="https://www.google.com/jsapi"></script>
    <script type="text/javascript">
      google.load("visualization", "1", {packages:["corechart"]});
      google.setOnLoadCallback(drawChart);

   function drawChart() {
      var data = google.visualization.arrayToDataTable([
        ['��', '�湮��', { role: 'style' } ],
<%for i = 1 to dataLength : SetDetail(i)%>		
        ['<%=i%>�� (<%=round(arrData(i,2),1)%>%)', <%=arrData(i,0)%>, 'color: <%=color_bar(i)%>'],
<%next%>		
     
      ]);


        var options = {
          title: '����������',
          vAxis: {title: '',  titleTextStyle: {color: 'red'}}
        };


        var chart = new google.visualization.BarChart(document.getElementById('chart_div'));
        chart.draw(data, options);
      }
    </script>          
    <div id="chart_div" style="width:100%; height: 500px;"></div>

	</div>
</div>

</body>
</html>
<!-- #include file = "../authpg_2.asp" -->