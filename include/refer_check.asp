<%
''����üũ -- ����â�� ���� URL ġ�� ������ ��� ó��
Dim vReferer,vPage
vReferer = request.ServerVariables("HTTP_REFERER")
vPage = "http://" & request.ServerVariables("HTTP_HOST") & ""
'vPage = "http://" & request.ServerVariables("HTTP_HOST") & "/pstudy"
%>