<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/dbcon.asp" -->
<!-- #include file="../main/top.asp"-->

<script language="javascript">
function visit_del(idx){
		var bool = confirm("������ �������ʱ�ȭ�� �Ͻðڽ��ϱ�?");
		if (bool){
			var params = "key=" +  escape(idx);
			sndReq("resetxml.asp",params,toDwnGo,"POST");
			//location.href="resetxml.asp?" + params;
		}
}

function toDwnGo(){
	if(objXmlhttp.readyState == 4){
		if(objXmlhttp.status==200){
			var xmlDoc = objXmlhttp.responseXML;
			var rowtag = xmlDoc.getElementsByTagName("isrows").item(0);
			var strRetun = rowtag.firstChild.nodeValue;

			if(parseInt(strRetun,10) > 0) {
				alert("�ʱ�ȭ �Ǿ����ϴ�.\n\n���� ���ڷ� ���Ӻм���  ���۵˴ϴ�.");
				self.location.href="list.asp";
			}

		}
		else{
			alert("�ý��ۿ���!");
		}
	}

}
</script>

<div class="container">
	<!--#include file="left.asp"-->
	<div class="content">
		<h2 class="cTit"><span class="bullet"></span>�����ʱ�ȭ</h2>

		<div class="caution"><p>��� ���������� �ʱ�ȭ�մϴ�.</p></div>
		<div class="caution"><p>������ ������ ������ �����ʽ��ϴ�.</p></div>

		<div class="rbtn">
			<a href="javascript:visit_del('visit');" class="btn">�ʱ�ȭ�ϱ�</a>
		</div>

	</div>
</div>

</body>
</html>
<!-- #include file = "../authpg_2.asp" -->