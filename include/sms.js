function direct_send(){
	var f = window.document.emoticon_form;
	if (f.message.value == ""  )	{
	alert("�޽��� ������ �Է����ּ���!!");
	f.message.focus();
	return;
	}
	f.submit();
}
function CheckLen1() {

	document.sms_config.content_length1.value = document.sms_config.msg1.value.length ;	
}
<!--
var R_DAY_MSG				= "�����Ͻ� �� ���� ��¥�Դϴ�.";
var R_DAY_NULL_MSG			= "���� ��¥�� �Է����� �ʾҽ��ϴ�.";
var R_DAY_TYPE_MSG			= "��¥ ������ ���� �ʽ��ϴ�.";
var R_TIME_NULL_MSG			= "���� �ð��� �Է����� �ʾҽ��ϴ�.";
var R_TIME_TYPE_MSG			= "�ð� ������ ���� �ʽ��ϴ�.";
var R_TIME_MSG				= "�����Ͻ� �� ���� �ð��Դϴ�.";
var CONTENT_MSG				= "�޽��� ������ �����ϴ�.";
var SVC_NUM_MSG				= "���� ��ȭ��ȣ�� �����ϴ�. �Է��� �ּ���.";
var PHON_NUM_MSG			= "�߽� ��ȭ��ȣ�� �����ϴ�. �Է��� �ּ���.";
var PHON_CD_MSG				= "�߽� ������ �����ϴ�.";
var REGIST_80_BYTE			= "80����Ʈ������ ����� �����մϴ�.";
var CONTNET_80_BYTE_MSG		= "�޽��� �Է��� 80����Ʈ������ �����մϴ�.";
var CONT_SVC_NUM_MSG		= "��ȭ ��ȣ�� �����ϴ�.";
var LENGTH_MSG				= "��ȭ��ȣ�� �߸��Ǿ����ϴ�. �ٽ� �Է��� �ּ���.";
var REMOVE_MSG				= "�޽����� �����Ͻðڽ��ϱ�?";
var Msg_Null				= "�޽��� ������ �����ϴ�.";
var NO_SELECT_BEFORE_DAY	= "�������ڷδ� �����Ͻ� �� �����ϴ�.";
var NO_DAY					= "���� ��¥ �Դϴ�.";
var BYTE_30					= "30����Ʈ ���� �Է��� �����մϴ�";
var NO_NUMBER_RE_INPUT		= "���� ��ȣ�Դϴ�. �ٽ� �Է��� �ּ���";
var NULL_MSG				= "";
var TOG_WORD				= '%0D';
var MSG_LEN_80				= 80;										//�޽��� ����
var MSG_LEN_2000			= 2000;										//�幮���� �޽��� ����
var m_iFlag					= 1;
var c_iFlag					= 1;

//ó�� â�� Ŭ���ҽ� â�� �����.
function clearContent() {
	if (m_iFlag == 1) {
		document.telephone_frm.CONTENT.value="";
//		checkShrtMsgLen(document.frmsms.CONTENT,"SHORT");
		m_iFlag=0;
	}
}
//ó�� â�� Ŭ���ҽ� â�� �����.(�����̰��ʿ��ؼ�)
function clearContent1() {
	if (c_iFlag == 1) {
		document.telephone_frm.CONTENT1.value="";
//		checkShrtMsgLen(document.frmsms.CONTENT,"SHORT");
		c_iFlag=0;
	}
}
//��Ʈ������ �޾Ƽ� ����Ʈ ���� üũ�Ѵ�.
function getLeng(sMessage) {
	var iCount = 0 ;													//�޽����� ����Ʈ�� �����ϴ� ����
	for (var i = 0; i < sMessage.length; i++) {							// 0-127 1byte, 128~ 2byte
		if ( sMessage.charCodeAt(i) > 127) {
			iCount += 2;
		}
		else {
			iCount++;
		}
	}
	return iCount;
}
//�޽���â�� �޽����� �־� �ִ� �Լ�
function setMsgToContent(obj) {

	var sMsg = obj.value;
	clearContent();
	document.telephone_frm.CONTENT.value = sMsg;
//	checkShrtMsgLen(document.telephone_frm.CONTENT,"SHORT");
//	document.telephone_frm.CONTENT.focus();
	self.scroll(0,0);
	checkShrtMsgLen(obj,'SHORT');
}
//�޽���â�� �޽����� �־� �ִ� �Լ�2
function setMsgToContent(obj,Sms_id) {

	var sMsg = obj.value;
	clearContent();
	document.telephone_frm.CONTENT.value = sMsg;
//	checkShrtMsgLen(document.telephone_frm.CONTENT,"SHORT");
//	document.telephone_frm.CONTENT.focus();
	setCookie('SMS_VALUE', Sms_id, 5);
	self.scroll(0,0);
	checkShrtMsgLen(obj,'SHORT');
}

// cookie ���� �Լ�
function setCookie(name, value, minutes) {
   var expire = new Date();
   expire.setTime(expire.getTime() + (60*minutes*1000));
   document.cookie = name + "=" + escape(value)
   + ((expire == null) ? "" : ("; expires=" + expire.toGMTString()))
}

function getCookie(Name) {
   var search = Name + "="
   if (document.cookie.length > 0) { 
      offset = document.cookie.indexOf(search) 
      if (offset != -1) { 
         offset += search.length 
         end = document.cookie.indexOf(";", offset) 
         if (end == -1) 
            end = document.cookie.length
         return unescape(document.cookie.substring(offset, end))
      } 
   }
}

//������ ���̸� üũ�Ͽ� 80byte�� ������ ���̸� �߶��ش�.
function checkMsgLen(obj,sByteLen) {
	var iCounts = new Array();
	iCounts = getByteLen(obj);											//������ ���̸� ���ϴ� �Լ�
	if (iCounts[0] > sByteLen)
		return false;
	else
		return true;
}

//�ܹ��޽������� �޽����� ���̸� üũ�ϰ� ¥���� �Լ�
function checkShrtMsgLen(obj,sAlertType) {
	var bResult		= checkMsgLen(obj,MSG_LEN_80);
	var iCountByte	= 0;
	var sContentMsg	= '';

	if (!bResult){
		if (sAlertType == 'SHORT') {
			alert(CONTNET_80_BYTE_MSG);
			sContentMsg = cutText(obj,MSG_LEN_80);
			obj.value = sContentMsg;
		}
		else if (sAlertType == 'SCH') {
			alert(CONTNET_80_BYTE_MSG);
			sContentMsg = cutText(obj,MSG_LEN_80);
			obj.value = sContentMsg;
		}
		else {
			alert(REGIST_80_BYTE);
			sContentMsg = cutText(obj,MSG_LEN_80);
			document.frmsms.CONTENT.value = sContentMsg;
		}
	}
	iCountByte = getByteLen(obj);
	if (sAlertType == 'SCH') {
		document.frmsms.COUNTBYTE1.value = iCountByte[0];
		document.frmsms.COUNTBYTE2.value = iCountByte[0];
	}
	else
		document.telephone_frm.COUNTBYTE.value = iCountByte[0];
}

//�ܹ��޽������� �޽����� ���̸� üũ�ϰ� ¥���� �Լ�(�����̰��ʿ��ؼ�)
function checkShrtMsgLen1(obj,sAlertType) {
	var bResult		= checkMsgLen(obj,MSG_LEN_80);
	var iCountByte	= 0;
	var sContentMsg	= '';

	if (!bResult){
		if (sAlertType == 'SHORT') {
			alert(CONTNET_80_BYTE_MSG);
			sContentMsg = cutText(obj,MSG_LEN_80);
			obj.value = sContentMsg;
		}
		else if (sAlertType == 'SCH') {
			alert(CONTNET_80_BYTE_MSG);
			sContentMsg = cutText(obj,MSG_LEN_80);
			obj.value = sContentMsg;
		}
		else {
			alert(REGIST_80_BYTE);
			sContentMsg = cutText(obj,MSG_LEN_80);
			document.frmsms1.CONTENT.value = sContentMsg;
		}
	}
	iCountByte = getByteLen(obj);
	if (sAlertType == 'SCH') {
		document.frmsms1.COUNTBYTE1.value = iCountByte[0];
		document.frmsms1.COUNTBYTE2.value = iCountByte[0];
	}
	else
		document.telephone_frm.COUNTBYTE1.value = iCountByte[0];
}


function checkShrtMsgLen2(obj,sAlertType) {
	var bResult		= checkMsgLen(obj,MSG_LEN_80);
	var iCountByte	= 0;
	var sContentMsg	= '';

	if (!bResult){
		if (sAlertType == 'SHORT') {
			alert(CONTNET_80_BYTE_MSG);
			sContentMsg = cutText(obj,MSG_LEN_80);
			obj.value = sContentMsg;
		}
		else if (sAlertType == 'SCH') {
			alert(CONTNET_80_BYTE_MSG);
			sContentMsg = cutText(obj,MSG_LEN_80);
			obj.value = sContentMsg;
		}
		else {
			alert(REGIST_80_BYTE);
			sContentMsg = cutText(obj,MSG_LEN_80);
			document.frmsms2.CONTENT.value = sContentMsg;
		}
	}
	iCountByte = getByteLen(obj);
	if (sAlertType == 'SCH') {
		document.frmsms2.COUNTBYTE1.value = iCountByte[0];
		document.frmsms2.COUNTBYTE2.value = iCountByte[0];
	}
	else
		document.telephone_frm.COUNTBYTE2.value = iCountByte[0];
}

function checkShrtMsgLen3(obj,sAlertType) {
	var bResult		= checkMsgLen(obj,MSG_LEN_80);
	var iCountByte	= 0;
	var sContentMsg	= '';

	if (!bResult){
		if (sAlertType == 'SHORT') {
			alert(CONTNET_80_BYTE_MSG);
			sContentMsg = cutText(obj,MSG_LEN_80);
			obj.value = sContentMsg;
		}
		else if (sAlertType == 'SCH') {
			alert(CONTNET_80_BYTE_MSG);
			sContentMsg = cutText(obj,MSG_LEN_80);
			obj.value = sContentMsg;
		}
		else {
			alert(REGIST_80_BYTE);
			sContentMsg = cutText(obj,MSG_LEN_80);
			document.frmsms3.CONTENT.value = sContentMsg;
		}
	}
	iCountByte = getByteLen(obj);
	if (sAlertType == 'SCH') {
		document.frmsms3.COUNTBYTE1.value = iCountByte[0];
		document.frmsms3.COUNTBYTE2.value = iCountByte[0];
	}
	else
		document.telephone_frm.COUNTBYTE3.value = iCountByte[0];
}

function checkShrtMsgLen4(obj,sAlertType) {
	var bResult		= checkMsgLen(obj,MSG_LEN_80);
	var iCountByte	= 0;
	var sContentMsg	= '';

	if (!bResult){
		if (sAlertType == 'SHORT') {
			alert(CONTNET_80_BYTE_MSG);
			sContentMsg = cutText(obj,MSG_LEN_80);
			obj.value = sContentMsg;
		}
		else if (sAlertType == 'SCH') {
			alert(CONTNET_80_BYTE_MSG);
			sContentMsg = cutText(obj,MSG_LEN_80);
			obj.value = sContentMsg;
		}
		else {
			alert(REGIST_80_BYTE);
			sContentMsg = cutText(obj,MSG_LEN_80);
			document.frmsms4.CONTENT.value = sContentMsg;
		}
	}
	iCountByte = getByteLen(obj);
	if (sAlertType == 'SCH') {
		document.frmsms4.COUNTBYTE1.value = iCountByte[0];
		document.frmsms4.COUNTBYTE2.value = iCountByte[0];
	}
	else
		document.telephone_frm.COUNTBYTE4.value = iCountByte[0];
}

function checkShrtMsgLen5(obj,sAlertType) {
	var bResult		= checkMsgLen(obj,MSG_LEN_80);
	var iCountByte	= 0;
	var sContentMsg	= '';

	if (!bResult){
		if (sAlertType == 'SHORT') {
			alert(CONTNET_80_BYTE_MSG);
			sContentMsg = cutText(obj,MSG_LEN_80);
			obj.value = sContentMsg;
		}
		else if (sAlertType == 'SCH') {
			alert(CONTNET_80_BYTE_MSG);
			sContentMsg = cutText(obj,MSG_LEN_80);
			obj.value = sContentMsg;
		}
		else {
			alert(REGIST_80_BYTE);
			sContentMsg = cutText(obj,MSG_LEN_80);
			document.frmsms5.CONTENT.value = sContentMsg;
		}
	}
	iCountByte = getByteLen(obj);
	if (sAlertType == 'SCH') {
		document.frmsms5.COUNTBYTE1.value = iCountByte[0];
		document.frmsms5.COUNTBYTE2.value = iCountByte[0];
	}
	else
		document.telephone_frm.COUNTBYTE5.value = iCountByte[0];
}

//�ѱ��� ��쿡�� 2byte�� �׿��� ���ڴ� 1byte�� ����Ͽ�  iCounts�� �����Ͽ� return ���ش�.
/*
// ���� ���ڿ� ���� ���ϱ�

function getByteLen(obj,sMsgLng) {

	var sMsg       = obj.value;
	var sTmpMsg    = '';												//�޽����� �ӽ÷� �����ϴ� ����
	var sTmpMsgLen = 0;													//�ӽ÷� ����� �޽����� ���̸� �����ϴ� ����
	var sOneChar   = '';												//�ѹ��ڸ� �����ϴ� ����
	var iCounts    = new Array();										//�� ����Ʈ�� �������� ����Ʈ ���� �����ϴ� �迭

	iCounts[0]=0;														//�� ����Ʈ�� ���� �ϴ� ����

	if (sMsgLng != null) {
		sTmpMsg	= new String(sMsgLng);
	}
	else
		sTmpMsg	= new String(sMsg);
	sTmpMsgLen	= sTmpMsg.length;

	for (k = 0 ;k < sTmpMsgLen ;k++) {
		sOneChar = sTmpMsg.charAt(k);
		if (escape(sOneChar) == TOG_WORD) {
			iCounts[0]++;
		}
		else if (escape(sOneChar).length > 4) {
			iCounts[0] += 2;
		}
		else if (sOneChar!='\r'){
			iCounts[0]++;
		}
		else  {
			iCounts[0]++;
		}
	}

	return iCounts;
}
*/

//�ѱ��� ��쿡�� 2byte�� �׿��� ���ڴ� 1byte�� ����Ͽ�  iCounts�� �����Ͽ� return ���ش�.
// ���ο� ���ڿ� ���� ���ϱ�
function getByteLen(obj,sMsgLng) {

	var sMsg       = obj.value;
	var sTmpMsg    = '';												//�޽����� �ӽ÷� �����ϴ� ����
	var sTmpMsgLen = 0;													//�ӽ÷� ����� �޽����� ���̸� �����ϴ� ����
	var sOneChar   = '';												//�ѹ��ڸ� �����ϴ� ����
	var iCounts    = new Array();										//�� ����Ʈ�� �������� ����Ʈ ���� �����ϴ� �迭
	var i=0,l=0;
	var temp,lastl;

	iCounts[0]=0;														//�� ����Ʈ�� ���� �ϴ� ����

	if (sMsgLng != null) {
		sTmpMsg	= new String(sMsgLng);
	}
	else
		sTmpMsg	= new String(sMsg);
	sTmpMsgLen	= sTmpMsg.length;

	while(i < sTmpMsgLen)
	{
		temp = sTmpMsg.charAt(i);
		
		if (escape(temp).length > 4)
			iCounts[0]+=2;
		else if (temp!='\r')
			iCounts[0]++;
		// OverFlow

		lastl = l;
		i++;
	}

	return iCounts;
}




//80����Ʈ �̻� �Ǹ� ������ ���̸� �ڸ��� �Լ�
function cutText(obj,sByteLen) {

	var sTmpMsg			= '';
	var iTmpMsgLen		= 0;
	var sOneChar		= '';
	var iCount			= 0;
	var sOneCharNext	= '';

	sTmpMsg = new String(obj.value);
	iTmpMsgLen = sTmpMsg.length;

	for (var k = 0 ;k < iTmpMsgLen ; k++) {
		sOneChar = sTmpMsg.charAt(k);
		sOneCharNext = sTmpMsg.charAt(k+1);


		if (escape(sOneChar).length > 4){
			iCount+=2;

		}
		else if (sOneChar!='\r'){
			iCount++;
		}

/*
		if (escape(sOneChar) == TOG_WORD) {
			iCount++;
			if (iCount > sByteLen-1) {
				sTmpMsg = sTmpMsg.substring(0,k);
				break;
			}
		}
		else if (escape(sOneChar).length > 4) {
			iCount += 2;
		}
		else {
			iCount++;
		}

*/
		if (iCount > sByteLen) {
			sTmpMsg = sTmpMsg.substring(0,k);
			break;
		}
	}
	return sTmpMsg;
}

//�ڵ� '-'����
function addDash(obj) {
	var sNoDashNumber = "" ;											//'-'�� ������ ��ȣ�� �����ϴ� ����
	sNoDashNumber	= removeDash(obj);
	var iLen		= getLeng(sNoDashNumber);

	if (event.keyCode != 8) {
		switch (iLen) {
			case 0:
			case 1:
			case 2:
				break;
			case 3:
			case 4:
			case 5:
			case 6:
			case 7:
				obj.value  = sNoDashNumber.substring(0,3) + "-" + sNoDashNumber.substr(3,4) ;
				break;
			case 8:
				obj.value  = sNoDashNumber.substring(0,4) + "-" + sNoDashNumber.substr(4,4) ;
				break;
			default :
				alert(NO_NUMBER_RE_INPUT);								//"���� ��ȣ�Դϴ�. �ٽ� �Է��� �ּ���"
				obj.value  = sNoDashNumber.substring(0,4) + "-" + sNoDashNumber.substr(4,4) ;
		}
	}
}


//dash�� �����Ѵ�.
function removeDash(obj) {

	var sNoDashNumber = "";												// '-'�� ������ ��ȣ�� ������ ����
	var i = 0;															
	
	for (i = 0; i < obj.value.length; i++) {
		if ((obj.value).charAt(i) != "-") {
			sNoDashNumber += (obj.value).charAt(i);
		}
	}

	return sNoDashNumber;
}

// Ű�� �Է°��� ���ڰ��� ��츸 �Է� �� �� �ְ����ش�.
function checkOnlyNumber() {

	if ( event.keyCode == 37 || event.keyCode == 39 || event.keyCode == 46) {
		event.returnValue = true;
	}
	else {
		if (!event.shiftKey) {
			if (event.keyCode > 47) {
				if ( event.keyCode < 58){
					event.returnValue = true;
				}
				else if (event.keyCode > 95 ){
					if (event.keyCode < 106) {
						event.returnValue = true;
					}
					else
						event.returnValue = false;
				}
				else
					event.returnValue = false;
			}
			else if ( event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 32) {
				event.returnValue = true;
			}
			else
				event.returnValue = false;
		}else
			event.returnValue = false;
	}
}

// �������۽� select box�� ������ ��ȭ��ȣ �ֱ�
function AddCheck() {
	if(document.telephone_frm.phone_num.value.length==0) {
		alert("�߰��� ����ȣ�� �Է��ϼ���.");
		document.telephone_frm.phone_num.focus();
		return;
	}
	if (!checkNumber(del_hipen(document.telephone_frm.phone_num.value))) {
		alert("���ڷ� �Է��Ͽ� �ֽʽÿ�.");
		document.telephone_frm.phone_num.focus();
		return;
	}
	if (document.telephone_frm.phone_num.value.length<8) {
		alert("���Ź�ȣ������ �߸��Ǿ����ϴ�.");
		document.telephone_frm.phone_num.focus();
		return;
	}
// tophone.sel_receive_num -> telephone_frm.phone_num
// tophone.vc_receive_code -> telephone_frm.phone_type
	var selobj = document.telephone_frm.sel_receive_num;
	var cnt = selobj.options.length;
/*
	if( cnt >= 10 ) {
		alert("���������� 10����� �Դϴ�.");
		return;
	} else {
*/
		selobj1	= document.telephone_frm.phone_type;
		selobj1_value = selobj1.options[selobj1.selectedIndex].text;
		selobj2 = document.telephone_frm.phone_num;
		selvalue = selobj1_value + '-' + selobj2.value;
		myselobj = document.telephone_frm.sel_receive_num;

		myselobj.options[myselobj.options.length] = new Option(selvalue,selvalue);	
		cnt_v = cnt + 1;
		document.telephone_frm.phone_count.value = cnt_v +" ��";
		document.telephone_frm.phone_num.focus();
		//myselobj.options[myselobj.options.length].value = selobj;	
	
		selobj2.value = '';
//	}
//	alert("24��, 25���� ���۷� ���ַ� ����\n���������� �����մϴ�."); 
//	return;
}

// ���������ϱ� ���� select box�� ���� ��ȭ��ȣ �����
function DelCheck()	{
	if(document.telephone_frm.sel_receive_num.options.length==0) {
		alert("���̻� ������ ��ȣ�� �����ϴ�.");
		return;
	}
	if(document.telephone_frm.sel_receive_num.selectedIndex==-1) {
		//alert( "������ ��ȣ�� �����ϼ���" );  		
		//ù��°���� �����Ѵ�.
		document.telephone_frm.sel_receive_num.options[0] = null;
	} else {
		Selindex= document.telephone_frm.sel_receive_num.selectedIndex;
		//���ù�ȣ�� ����Ʈ���� �����Ѵ�.
		document.telephone_frm.sel_receive_num.options[Selindex] = null;
	}
	document.telephone_frm.phone_count.value = document.telephone_frm.sel_receive_num.options.length+" ��";
}

// ���� check 
function checkNumber( str)
{
    for( var i=0; i < str.length; i++) {
        var ch = str.substring( i, i+1 );
        if( (ch < "0" || ch > "9") && ch != "." ) 
            return false;              
    }    
    return true;
}
function del_hipen(str) {
//	alert("��ȯ�� = " + str)
	var len = str.length;
	var val;
	val = str.replace("-", "");
	for(var i=0 ; i < len ; i++) {
		val = val.replace("-", "");
	}
//	alert("��ȯ�� = " + val);
	return val;
}

// ���� ���� ���� �Է��ϱ�
function Set_preengage_time(){
	f = document.telephone_frm;
	if(f.preengage.checked == true){
	today = new Date()
	f.preengage_year.value=today.getYear();
	f.preengage_month.value=today.getMonth()+1;
	f.preengage_day.value=today.getDate();
	f.preengage_hour.value=today.getHours();
	f.preengage_min.value=today.getMinutes();
	}else{
	f.preengage_year.value="";
	f.preengage_month.value="";
	f.preengage_day.value="";
	f.preengage_hour.value="";
	f.preengage_min.value="";
	}
}

// ����ð��� ���÷��� �Ѵ�.
function showtime(){
    var now = new Date()
	var year = now.getYear();
	var month = now.getMonth()+1;
	var day = now.getDate();
    var hours = now.getHours()
    var minutes = now.getMinutes()
    var seconds = now.getSeconds()
//    var timeValue = "" + ((hours > 12) ? hours - 12 : hours)
	var timeValue = ""+year+"-"+month+"-"+day+" "+hours;
    timeValue  += ((minutes < 10) ? ":0" : ":") + minutes
    timeValue  += ((seconds < 10) ? ":0" : ":") + seconds
//    timeValue  += (hours >= 12) ? " PM" : " AM"
    document.telephone_click.time.value = timeValue
//    if(timeValue == set) {alert(message);}
    timerID = setTimeout("showtime()",1000)
//    timerRunning = true
}

// �ڵ��� ���� ��ư�� ��������....

function telephone_submit(){
  if(login_c() == true) {
	var this_frm = document.telephone_frm;

	var selobj = this_frm.sel_receive_num;
	var cnt = selobj.options.length;

	var total_num = "";
	if(this_frm.CONTENT.value==""||this_frm.CONTENT.value=="������ �޽����� �Է����ּ���."){
		alert("������ ���ڸ� �־��ּ���");
		this_frm.CONTENT.focus();
		return;
	}
	if(this_frm.phone_num.value=="" && cnt==0){
		alert("������ ��ȣ�� �־��ּ���");
		this_frm.phone_num.focus();
		return;
	}
	if(this_frm.return_phone.value==""){
		alert("���Ź�ȣ�� �־��ּ���");
		this_frm.return_phone.focus();
		return;
	}
	for(i=0; i<cnt;i++){
			total_num=total_num+selobj.options[i].text+"|";
	}
	this_frm.num_list.value=total_num;
	this_frm.SMS_VALUE.value=getCookie('SMS_VALUE');
	this_frm.mode.value="submit";
	this_frm.submit();
  }
}

// �̸�Ƽ�� �߰�
function addChar(aspchar) 
{
	opener.document.telephone_frm.CONTENT.value +=  aspchar;
//	opener.document.forms[0].vc_message.focus();
	cal_byte2(opener.telephone_frm.CONTENT.value);
}

function cal_byte2(aquery) 
{

	var tmpStr;
	var temp=0;
	var onechar;
	var tcount;
	tcount = 0;

	tmpStr = new String(aquery);
	temp = tmpStr.length;

	for (k=0;k<temp;k++)
	{
		onechar = tmpStr.charAt(k);
		if (escape(onechar) =='%0D') { } else if (escape(onechar).length > 4) { tcount += 2; } else { tcount++; }
	}

	opener.document.telephone_frm.COUNTBYTE.value = tcount;

}
//-->