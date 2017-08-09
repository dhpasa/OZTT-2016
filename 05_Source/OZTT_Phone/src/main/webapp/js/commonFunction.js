function fmoney(s, n) {  
    n = n > 0 && n <= 20 ? n : 2;
    if (s == "") {
    	return "";
    }
    if (isNaN(s)){
    	return "";
    }
    s = parseFloat((s + "").replace(/[^\d\.-]/g, "")).toFixed(n) + "";  
    var l = s.split(".")[0].split("").reverse(), r = s.split(".")[1];  
    t = "";  
    for (i = 0; i < l.length; i++) {  
        t += l[i] + ((i + 1) % 3 == 0 && (i + 1) != l.length ? "," : "");  
    }  
    return t.split("").reverse().join("") + "." + r;  
}

function isFormEdited(form) {
    for ( var j = 0; j < form.length; ++j) {
        if (isEdited(form.elements[j])) {
            return true;
        }
    }
    return false;
}

// 判断画面的值是否改变
function isEdited(item) {
    var type = item.type;
    if (!type) {
        return false;
    }
    type = type.toUpperCase();
    if (type == 'TEXT') {
        return item.defaultValue != item.value;
    }
    if (type == 'HIDDEN') {
        return item.defaultValue != item.value;
    }
    if (type == 'TEXTAREA') {
        return item.defaultValue != item.value;
    }
    if (type == 'CHECKBOX') {
        return item.defaultChecked != item.checked;
    }
    if (type ==  'RADIO') {
        return item.defaultChecked != item.checked;
    }
    if (type == 'SELECT-ONE') {
           for (var i = 0; i < item.options.length; i++ ) {
               if (item.options[i].defaultSelected != item.options[i].selected) {
                   return true;
               }
           }
    }
    return false;
}


// 下拉框没有defaultValue
function initializeSelectOne(){
    for (var i = 0; i < document.forms.length; ++i) {
       for (var j = 0; j < document.forms[i].length; ++j) {
          type = document.forms[i].elements[j].type.toUpperCase();
           if ( type == 'SELECT-ONE' ) {
               var flg = 'false';
               for (var k = 0; k < document.forms[i].elements[j].options.length; k++ ) {
                   if(document.forms[i].elements[j].options[k].defaultSelected ){
                       flg = 'true';
                   }
               }
               if(flg === 'false'){
                   document.forms[i].elements[j].options[0].defaultSelected=true;
               }
           }
       }
   }
}

// 下拉框是js改变的情况
function initializeSelectOneForJs(){
    for (var i = 0; i < document.forms.length; ++i) {
       for (var j = 0; j < document.forms[i].length; ++j) {
          type = document.forms[i].elements[j].type.toUpperCase();
           if ( type == 'SELECT-ONE' ) {
               var flg = 'false';
               for (var k = 0; k < document.forms[i].elements[j].options.length; k++ ) {
                   if(document.forms[i].elements[j].options[k].selected ){
                	   document.forms[i].elements[j].options[k].defaultSelected=true;
                   }
               }
           }
           if (type == 'TEXT') {
               document.forms[i].elements[j].defaultValue = document.forms[i].elements[j].value;
           }
       }
   }
}

// 初期化多选框的defaultValue
function initMultiselect() {
    for (var i = 0; i < document.forms.length; ++i) {
        for (var j = 0; j < document.forms[i].length; ++j) {
           type = document.forms[i].elements[j].type.toUpperCase();
            if ( type == 'CHECKBOX' ) {
                if(document.forms[i].elements[j].checked){
                	document.forms[i].elements[j].defaultChecked=true;
                }
            }
        }
    }
}

function getUuid(){
  var len=32;//32长度
  var radix=16;//16进制
  var chars='0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'.split('');var uuid=[],i;radix=radix||chars.length;if(len){for(i=0;i<len;i++)uuid[i]=chars[0|Math.random()*radix];}else{var r;uuid[8]=uuid[13]=uuid[18]=uuid[23]='-';uuid[14]='4';for(i=0;i<36;i++){if(!uuid[i]){r=0|Math.random()*16;uuid[i]=chars[(i==19)?(r&0x3)|0x8:r];}}}
  return uuid.join('');
}  

// 生成微信签名信息
function createWechatSign(parterCode, credentialCode, uuid, d){
	// valid_string=partner_code&time&nonce_str&credential_code
	var valid_string=parterCode + "&" + d + "&" + uuid + "&" + credentialCode;
	return valid_string;
}

// 获取是什么设备
function getDevice(){
	if(/android/i.test(navigator.userAgent)){
		return "android";
	} else if (/ipad|iphone|mac/i.test(navigator.userAgent)){
		return "ios";
	}
	return "pc";
	
}

// 创建等待提示
function createLoading(type) {
	
	$("#main_loading").css("display","");
//	var strHtml = '<div id="main_loading" class="main_loading">';
//	strHtml += '<img src="../images/loading.gif">';
//	strHtml += '</div>';
//
//	$('body').append(strHtml);
	if (type == '1') {
		// 并在3秒后消失
		setTimeout(function() {
			$('#main_loading').remove();
		}, 3000);
	}
}

function removeLoading(){
	$("#main_loading").css("display","none");
	//$('#main_loading').remove();
}


