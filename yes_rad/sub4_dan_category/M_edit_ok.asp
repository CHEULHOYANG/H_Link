<!-- #include file = "../authpg_1.asp" -->
<!-- #include file = "../../include/dbcon.asp" -->
<%
Dim sql,rs,name,checkdel,idx,s_idx
Dim DirectoryPath,abc

DirectoryPath = Server.MapPath("..\..\") & "\ahdma\quiz\"

Set abc = Server.CreateObject("ABCUpload4.XForm")
abc.MaxUploadSize = 1024 * 1024 * 100
abc.AbsolutePath = True

Dim filen : filen = 1024 * 1024 * 10
Dim objSajin,imgDot,perioArry,img_imsi
Dim image1

Set objSajin = abc("img")(1)
if objSajin.FileExists then
 if objSajin.Length < filen  then ''�̹��� 800KB, �ڷ� 5MB
  img_imsi = objSajin.SafeFileName
  perioArry = Split(img_imsi,".")
  imgDot = perioArry(Ubound(perioArry)) ''Ȯ��������

  if LCase(imgDot) = "gif" or LCase(imgDot) = "jpg" or LCase(imgDot) = "pdf" or LCase(imgDot) = "docx" or LCase(imgDot) = "doc" or LCase(imgDot) = "hwp" or LCase(imgDot) = "xls" or LCase(imgDot) = "txt" or LCase(imgDot) = "ppt" then ''���� ���
   image1 = "dca_" & svdatefomt & "." & imgDot
   objSajin.Save DirectoryPath & image1
  end if

 end if
end if

checkdel = abc("checkdel")(1)
idx = abc("idx")(1)
name = abc("name")(1)
s_idx = abc("s_idx")(1)

If Len(image1) > 0 Then
	sql = "update dan_category set img='"& image1 & "' where idx= '"& idx &"'"
	db.execute sql,,adexecutenorecords
End if

If Len(checkdel) > 0 Then
	sql = "update dan_category set img='' where idx= '"& idx &"'"
	db.execute sql,,adexecutenorecords
End if

sql = "update dan_category set title='"& name & "' , uidx ="& s_idx &" where idx= '"& idx &"'"
db.execute sql,,adexecutenorecords

response.write"<script language='javascript'>"
response.write"self.location.href='list.asp?show_t1="& s_idx &"';"
response.write"</script>"
response.End

Function svdatefomt()			''���ϳ��� �ߺ� �ȵǰ� ó�� �Լ�
	Dim dt1,dt2,dt3
	dt1 = FormatDateTime(now(),2)
	dt2 = FormatDateTime(now(),4)
	dt3 = second(now)
	dt1 = replace(dt1,"-","")
	dt2 = replace(dt2,":","")
	if dt3 < 10 then
		dt3 = "0" & dt3
	end if
	svdatefomt = dt1 & dt2 & dt3
End Function
%>
<!-- #include file = "../authpg_2.asp" -->