<!-- #include file="../include/set_loginfo.asp" -->
<% if  isUsr then %>
<!-- #include file = "../include/dbcon.asp" -->
<%
Dim abc
Set abc = Server.CreateObject("ABCUpload4.XForm")
abc.AbsolutePath = True
Dim perioArry,imgDot,DirectoryPath
DirectoryPath = Server.MapPath("..\") & "\ahdma\pds\"

dim tabnm : tabnm = abc.item("tabnm")

''board_board info
Dim ygbn
sql = "select ygbn from board_mast where idx=" & tabnm
set dr = db.execute(sql)
ygbn = dr(0)
dr.close

''�Ѿ�� ��
Dim title,writer,content,idx,check_del1,check_del2,pwd

pwd = abc.item("pwd")
idx = abc.item("idx")
title = abc.item("title")
writer = abc.item("writer")
content = abc("content")(1)

check_del1 = abc("check_del1")
check_del2 = abc("check_del2")

idx = Tag2Txt(idx)
title = Tag2Txt(title)
writer = Tag2Txt(writer )
content = replace(content,"'","''")

dim wrtid
sql = "select wrtid from board_board where idx=" & idx
set dr = db.execute(sql)
wrtid = dr(0)

	if str_User_ID = wrtid then

		''����������
		Dim gbnS,strPart,strSearch,intpg
		gbnS = abc.item("gbnS")
		strPart = abc.item("strPart")
		strSearch = abc.item("strSerach")
		intpg = abc.item("intpg")

		gbnS = Tag2Txt(gbnS)
		strPart = Tag2Txt(strPart)
		strSearch = Tag2Txt(strSearch)
		intpg = Tag2Txt(intpg)
		dim varPage : varPage = "tabnm=" & tabnm & "&gbnS=" & gbnS & "&strPart=" & strPart & "&strSearch=" & strSearch & "&intpg=" & intpg & "&idx=" & idx

		''���ε����� ó��*********************************************
		set objFso = server.CreateObject("scripting.filesystemobject")

		dim filen : filen = 1024 * 1024 * 5
		Dim objSajin

		Set objSajin = abc("filenm1")(1)
		if objSajin.FileExists then

			if objSajin.Length < filen  then	''�̹��� 800KB, �ڷ� 5MB
				Dim image1,image2
				image2 = objSajin.SafeFileName
				perioArry = Split(image2,".")
				imgDot = perioArry(Ubound(perioArry))	''Ȯ��������

				if LCase(imgDot) = "gif" or LCase(imgDot) = "jpg" or LCase(imgDot) = "png" then	''���� ���

					sql = "select image1 from board_board where idx=" & idx
					set dr = db.execute(sql)
					image1 = dr(0)
					dr.close

					''���� ���� ����
					strFile = DirectoryPath & image1
					if objFso.FileExists(strFile) then
						objFso.DeleteFile(strFile)
					end if
					image1 = "f_" & svdatefomt & "." & imgDot
					objSajin.Save DirectoryPath & image1	''���Ͼ��ε�
					db.execute("update board_board set image1='" & image1 & "',image2='" & image2 & "' where idx=" & idx)	''���ϸ� ����

				end if

			end if
		end if

		if int(ygbn) = 2 then		''������ �Խ����� ��� ������̹���

			Set objSajin = abc("filenm2")(1)
			if objSajin.FileExists then
				if objSajin.Length < 1024 * 1024 * 5  then	''�̹��� 100KB
					perioArry = Split(objSajin.SafeFileName,".")
					imgDot = perioArry(Ubound(perioArry))	''Ȯ��������

					if LCase(imgDot) = "gif" or LCase(imgDot) = "jpg" or LCase(imgDot) = "png" then	''���� ���
						dim snimg
						sql = "select snimg from board_board where idx=" & idx
						set dr = db.execute(sql)
						snimg = dr(0)
						dr.close

						''���� ���� ����
						strFile = DirectoryPath & snimg
						if objFso.FileExists(strFile) then
							objFso.DeleteFile(strFile)
						end if

						snimg = "s_" & svdatefomt & "." & imgDot
						objSajin.Save DirectoryPath & snimg
						db.execute("update board_board set snimg='" & snimg & "' where idx=" & idx)	''���ϸ� ����
					end if

				end if
			end if
		end if

		Set objSajin = Nothing
		set objFso = Nothing
		''***********************************************************

If Len(check_del1) > 0 Then
	db.execute("update board_board set image1='',image2='' where idx=" & idx)	''���ϸ� ����
End If

If Len(check_del2) > 0 Then
	db.execute("update board_board set snimg='' where idx=" & idx)	''���ϸ� ����
End if

		sql = "update board_board set "
		sql = sql & "title='" & title & "',"
		sql = sql & "pwd='" & pwd & "',"
		sql = sql & "content='" & content & "',"
		sql = sql & "writer='" & writer & "'"
		sql = sql & " where idx=" & idx

		db.execute(sql)
		db.close
		set db = nothing

		response.redirect "content.asp?" & varPage

		Function Tag2Txt(s)
			s = Replace(s,"'","''")
			s = Replace(s,"<","&lt;")
			s = Replace(s,">","&gt;")
			s = Replace(s,"&","&amp;")
			Tag2Txt = s
		End Function

		Function svdatefomt()
			Dim dt1,dt2,dt3
			dt1 = replace(Date,"-","")
			dt2 = FormatDateTime(now(),4)
			dt3 = second(now)
			dt1 = Right(dt1,8)
			dt2 = replace(dt2,":","")

			if dt3 < 10 then
				dt3 = "0" & dt3
			end if
		svdatefomt = dt1 & dt2 & dt3
		End Function

	else %>
<!-- #include file="../include/false_pg.asp" -->
<% end if
else %>
<!-- #include file="../include/false_pg.asp" -->
<% end if %>