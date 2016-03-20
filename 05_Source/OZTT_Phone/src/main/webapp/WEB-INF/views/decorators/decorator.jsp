<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title><sitemesh:write property='title' /></title>
  <sitemesh:write property='head' />
</head>
<!-- Head END -->
<script>

	var errorHtml = "<span id=\"spanError\" class=\"error\" onmouseover=\"makeMesDiv(this)\" onmouseout=\"removeMesDiv()\"><img src=\"${ctx}/images/error.png\"/></span>";
	
	function cleanFormError(){
		$("#spanError").remove();
	}
	
	function showErrorSpan(obj, msg){
		$(obj).after(errorHtml);
		$(obj).next().append(msg);
	}
	
	function tologin(){
		location.href = "${pageContext.request.contextPath}/OZ_TT_TP_LG/init";
	}
	
	function tologinOut(){
		delCookie("contcart");
		location.href = "${pageContext.request.contextPath}/OZ_TT_TP_LG/logout";
	}
	
	var E0002 = "<fmt:message key='E0002' />";
	var E0007 = "<fmt:message key='E0007' />";
	var E0008 = "<fmt:message key='E0008' />";
	var E0001 = "<fmt:message key='E0001' />";
	var E0009 = "<fmt:message key='E0009' />";
	var E0010 = "<fmt:message key='E0010' />";
	var E0011 = "<fmt:message key='E0011' />";
	
	function validateCheckLogin(){
		cleanFormError();
		var username = $("#username").val();
		var password = $("#password").val();
		if (username == "") {
			var message = E0002.replace("{0}", '<fmt:message key="OZ_TT_TP_LG_email" />')
			showErrorSpan($("#username"), message);
			return false;
		}
		if (password == "") {
			var message = E0002.replace("{0}", '<fmt:message key="OZ_TT_TP_LG_password" />')
			showErrorSpan($("#password"), message);
			return false;
		}
		return true;
	}
	
	// 确认画面登录
	function checkLogin(){
		if (!validateCheckLogin()) return;
		var username = $("#username").val();
		var password = $("#password").val();
		var dataJSON = {
				"loginname":username,
				"password":password
		}
		$.ajax({
			type : "POST",
			contentType:'application/json',
			url : '${pageContext.request.contextPath}/COMMON/ajaxLogin',
			dataType : "json",
			data : JSON.stringify(dataJSON), 
			success : function(data) {
				if(!data.isException){

					if (!data.canLogin) {
						// 登录错误
						showErrorSpan($("#username"), E0001);
					} else {
						// 登录成功
						// 同步购物车的内容
						var needSyncData = getCookie("contcart");
						var contCartFromDB;
						if (getJsonSize(needSyncData) > 0) {
							$.ajax({
								type : "POST",
								contentType:'application/json',
								url : '${pageContext.request.contextPath}/COMMON/purchaseAsyncContCart',
								dataType : "json",
								async:false,
								data : needSyncData, 
								success : function(data) {
									if(!data.isException){
										// 同步购物车成功
										contCartFromDB = data.conscars;
									} else {
										// 同步购物车失败
									}
								},
								error : function(data) {
									
								}
							});
						}
						
						// 用户登录同步购物车里面的内容
						if (getJsonSize(contCartFromDB) > 0) {
							var contcartJSONFromDB = JSON.parse(contCartFromDB);
							var contcartArrayFromDB = eval(contCartFromDB);

							// 如果Cookie购物车里面没有数据，更新购物车
							var tempCookie = [];
							for(var i=0; i<contcartArrayFromDB.length; i++){
								var properties = {
										"groupId":contcartArrayFromDB[i].groupId,
										"goodsName":contcartArrayFromDB[i].goodsName,
										"goodsImage":contcartArrayFromDB[i].goodsImage,
										"goodsQuantity":contcartArrayFromDB[i].goodsQuantity,
										"goodsPrice":contcartArrayFromDB[i].goodsPrice,
										"goodsProperties":JSON.stringify(contcartArrayFromDB[i].goodsProperties)

								}
								tempCookie.push(properties);
							}
							delCookie("contcart");
							addCookie("contcart",JSON.stringify(tempCookie))
						}
						
						location.href = "${pageContext.request.contextPath}/OZ_TT_GB_SH/init";
					}
					
				} else {
					// 系统异常
				}
			},
			error : function(data) {
				
			}
		});
	}
	
	function viewProductPopUp(groupId){
		jQuery.ajax({
			type : 'GET',
			contentType : 'application/json',
			url : '${pageContext.request.contextPath}/COMMON/getGoodsItem?groupId='+groupId,
			cache : false,
			async : false,
			dataType : 'json',
			success : function(data) {
				if(!data.isException){
					var goodItemDto = data.goodItemDto;
					$("#activeImage").attr("src", goodItemDto.firstImg);
					$("#activeImage").attr("alt", goodItemDto.goods.goodsname);
					$("#hiddenImage").val(goodItemDto.goods.goodsthumbnail);
					$("#productImage").empty();
					
					var imghtml = "";
					var imgList = goodItemDto.imgList;
					for(var j = 0; j < imgList.length; j++) {
						var imageUrl = imgList[j];
						if (j == 0) {
							imghtml +=  '<a onclick="showImgMain(this,\''+imageUrl+'\',\''+goodItemDto.goods.goodsname+'\')" class="active"><img alt="'+goodItemDto.goods.goodsname+'" src="'+imageUrl+'"></a>';
						} else {
							imghtml +=  '<a onclick="showImgMain(this,\''+imageUrl+'\',\''+goodItemDto.goods.goodsname+'\')"><img alt="'+goodItemDto.goods.goodsname+'" src="'+imageUrl+'"></a>';
						}
					}
					$("#productImage").append(imghtml);
					
					
					$("#goodsNameh1").html(goodItemDto.goods.goodsname)
					$("#disPrice").html(goodItemDto.disPrice + '<fmt:message key="common_yuan"/>');
					$("#nowPrice").html(goodItemDto.nowPrice + '<fmt:message key="common_yuan"/>');
					
					$("#prodectTime").html(goodItemDto.validPeriodStart + "~" +goodItemDto.validPeriodEnd)
					var isOver = goodItemDto.isOver;
					var isOverTime = goodItemDto.isOverTime;
					if (isOver == "1" || isOverTime == "1") {
						$("#groupPercent").html('<fmt:message key="common_tuangouover"/>');
						$("#addCart").css("display","none");
						$("#productQuantityDiv").css("display","none");
					} else {
						$("#groupPercent").html('<fmt:message key="common_hasTuanQan"/>' + goodItemDto.groupCurrent + "/" + goodItemDto.groupMax);
						$("#addCart").css("display","");
						$("#productQuantityDiv").css("display","");
					}
					
					$("#prodectDesc").html(goodItemDto.goods.goodsdesc)
					$("#productOptions").empty();

					$("#detail").attr("onclick", "toItem('"+goodItemDto.groupId+"')");
					$("#addCart").attr("onclick", "addToCart('"+goodItemDto.groupId+"')");
					
					var properties = JSON.parse(goodItemDto.properties);
					
			    	var properJson = eval(properties);
			    	var temp1 = '<div class="pull-left" style="padding-top:5px">';
			    	var temp2 = '<label class="control-label" id={1}>{0}</label>';
			    	var temp3 = '<select class="form-control input-sm" id="{0}">';
			   		var temp4 = '<option value="{0}">{1}</option>';
					var temp5 = '</select>';
					var temp6 = '</div>';
			    	for(var i=0; i<properJson.length; i++){
			    		if (properJson[i].goodsPropertiesType == "3") {
			    			var inHtml = temp1;
			    			inHtml += temp2.replace("{0}",properJson[i].goodsPropertiesName).replace("{1}",properJson[i].goodsPropertiesType);
			    			inHtml += temp3.replace("{0}",properJson[i].goodsPropertiesId);
			    			var classValue = properJson[i].goodsPropertiesJson.split(",");
			    			for (var j = 0; j < classValue.length; j++) {
			    				inHtml += temp4.replace("{0}",classValue[j]).replace("{1}", classValue[j]);
			    			}
			    			inHtml += temp5;
			    			inHtml += temp6;
			    			$("#productOptions").append(inHtml);
			    		}
			    	}
				}
			},
			error : function(data) {
				
			}
		});	
	}
	
	function toItem(groupId) {
		location.href = "${pageContext.request.contextPath}/OZ_TT_TP_PD/init?groupId="+groupId;
	}
	
	function toMainIndex(){
		location.href = "${pageContext.request.contextPath}/main/init";
	}
	
	
	function showImgMain(str, image, goodsName) {
		$(str).parent().find("a").removeClass("active");
		$(str).addClass("active");
		
		$("#activeImage").attr("src", image);
		$("#activeImage").attr("alt", goodsName);
		$("#activeImage").attr("data-BigImgSrc", image);
		
		App.initImageZoom();
	}
	
	function addToCart(groupId) {
		// 取得商品的属性
		var allDiv = $("#productOptions").find("div");
		var goodsName = $("#goodsNameh1").html();
		var goodsImage = $("#hiddenImage").val();
		var goodsQuantity = $("#product-quantity").val();
		var goodsPrice = parseFloat($("#disPrice").html().replace('<fmt:message key="common_yuan"/>', ''))*parseFloat(goodsQuantity);
		var oneGoodPropertiesList = [];
		for(var i = 0; i < allDiv.length; i++) {
			var teLabel = $(allDiv[i]).find("label")[0];
			if($(teLabel).attr("id") == '3') {
				// 下拉框
				var teSelect = $(allDiv[i]).find("select")[0];
				var properId = $(teSelect).attr("id");
				var properName = $(teLabel).html();
				var properValue = $(teSelect).val();
				var propertyOne = {
						"properId":properId,
						"properName":properName,
						"properValue":properValue
				};
				oneGoodPropertiesList.push(propertyOne);
			}
		}
		var properties = {
				"groupId":groupId,
				"goodsName":goodsName,
				"goodsImage":goodsImage,
				"goodsQuantity":goodsQuantity,
				"goodsPrice":goodsPrice,
				"goodsProperties":JSON.stringify(oneGoodPropertiesList)

		}
		
		var checkGroup = [];
		checkGroup.push(properties);
		var checkOver = true;
		$.ajax({
			type : "POST",
			contentType:'application/json',
			url : '${pageContext.request.contextPath}/COMMON/checkIsOverGroup',
			dataType : "json",
			async : false,
			data : JSON.stringify(checkGroup), 
			success : function(data) {
				if(!data.isException){
					// 同步购物车成功
					if (data.isOver) {
						alert(E0011);
						checkOver = true;
						return;
					} else {
						checkOver = false;
					}
				} else {
					// 同步购物车失败
					return;
				}
			},
			error : function(data) {
				
			}
		});
		
		if (checkOver) return;
		
		// 首先得到购物车里面的所有的东西
		var contcart = getCookie("contcart");
		if(contcart != null && contcart.length > 0) {
			var contcartJSON = JSON.parse(contcart);
			var contcartArray = eval(contcartJSON);
			var hasGoods = false;
			for(var i=0; i<contcartArray.length; i++){
				if (contcartArray[i].groupId == properties.groupId && JSON.stringify(contcartArray[i].goodsProperties) == properties.goodsProperties ) {
					contcartArray[i].goodsQuantity = parseFloat(contcartArray[i].goodsQuantity) + parseFloat(properties.goodsQuantity);
					contcartArray[i].goodsPrice = parseFloat(contcartArray[i].goodsPrice) + parseFloat(properties.goodsPrice);
					hasGoods = true;
					break;
				}
			}
			
			if (!hasGoods) {
				// 如果购物车中没有数据的画面，则加入Cookie中
				contcartJSON.push(properties);
				delCookie("contcart");
				addCookie("contcart",JSON.stringify(contcartJSON))
			} else {
				delCookie("contcart");
				addCookie("contcart",JSON.stringify(contcartJSON))
			}
		} else {
			var contcartJSON = [];
			contcartJSON.push(properties);
			addCookie("contcart",JSON.stringify(contcartJSON))
		}
		
		// 刷新页面的购物列表
		reflashCart();
		
		// 需要公用设成List
		var sessionUserId = '${sessionUserId}';
		
		if (sessionUserId != null && sessionUserId != "") {
			var inputList = [];
			inputList.push(properties);
			$.ajax({
				type : "POST",
				contentType:'application/json',
				url : '${pageContext.request.contextPath}/COMMON/addConsCart',
				dataType : "json",
				async : false,
				data : JSON.stringify(inputList), 
				success : function(data) {
					if(!data.isException){
						// 同步购物车成功
						
					} else {
						// 同步购物车失败
					}
				},
				error : function(data) {
					
				}
			});
		}
		
		// 关闭弹出框
		$(".fancybox-close").click();
		// 回到页面最上
		$("#topcontrol").click();
	}
	
	function reflashCart(){
		$("#contcartScroller").empty();
		
		$("#sumCount").html();
		$("#sumMoney").html();
		var contcart = getCookie("contcart");
		if (contcart != null && contcart.length > 0) {
			var contcartJSON = JSON.parse(contcart);
			var contcartArray = eval(contcartJSON);
			var temp1 = '<li>';
			var temp2 = '<a onclick="toItem(\'{0}\')"><img src="{1}" alt="{2}" width="37" height="34"></a>';
			var temp3 = '<span class="cart-content-count" id="spancount">x {0}</span>';
			var temp4 = '<strong><a onclick="toItem(\'{0}\')">{1}</a></br>{2}</strong>';
			var temp5 = '<em>{0}<fmt:message key="common_yuan"/></em>';
			var temp6 = '<a onclick="deleteContCart(this,\'{0}\',\'{1}\')" class="del-goods"><i class="fa fa-times"></i></a>';
			var temp7 = '</li>';
			var inHtml = "";
			var money = 0;
			if (contcartArray != null && contcartArray.length > 0) {
				for(var i=0; i<contcartArray.length; i++){
					var groupId = contcartArray[i].groupId;
					var goodsName = contcartArray[i].goodsName;
					var goodsImage = contcartArray[i].goodsImage;
					var goodsQuantity = contcartArray[i].goodsQuantity;
					var goodsPrice = contcartArray[i].goodsPrice;
					var goodsProperties = contcartArray[i].goodsProperties;
					var goodsPropertiesEval = eval(goodsProperties);
					var goodsPropertiesStr = "";
					for(var j=0; j<goodsPropertiesEval.length; j++){
						goodsPropertiesStr += goodsPropertiesEval[j].properName + ":" + goodsPropertiesEval[j].properValue + " ";
					}
					inHtml += temp1;
					inHtml += temp2.replace("{0}",groupId).replace("{1}", goodsImage).replace("{2}", goodsName);
					inHtml += temp3.replace("{0}",goodsQuantity);
					inHtml += temp4.replace("{0}",groupId).replace("{1}", goodsName).replace("{2}",goodsPropertiesStr);
					inHtml += temp5.replace("{0}",goodsPrice);
					inHtml += temp6.replace("{0}",groupId).replace("{1}","ITEM" + i);
					inHtml += temp7;
					
					money = money + parseFloat(goodsPrice);
				}
				$("#contcartScroller").append(inHtml);
				$("#sumCount").html(contcartArray.length + '<fmt:message key="common_item"/>');
				$("#sumMoney").html(money + '<fmt:message key="common_yuan"/>');
			} else {
				$("#contcartScroller").append("");
				$("#sumCount").html("");
				$("#sumMoney").html("");
			}
		}
	}
	
	// 添加COOKIE
	function addCookie(objName,objValue){
	    var infostr = objName + '=' + escape(objValue);
	    var date = new Date();
	    date.setTime(date.getTime()+8*3600*1000);
	    infostr += ';expires =' + date.toGMTString() + ";path=/";
	    document.cookie = infostr; //添加
	}

	// 删除COOKIE
	function delCookie(objName){
		var newContCart = [];
		addCookie(objName,JSON.stringify(newContCart));
	}

	function getCookie(name){ 
		var strCookie=document.cookie;
		var arrCookie=strCookie.split(";"); 
		for(var i=0;i<arrCookie.length;i++){ 
			var arr=arrCookie[i].split("="); 
			if(arr[0]==name){
				return unescape(arr[1]); 
			}
		} 
		return ""; 
	} 
	
	// 删除购物车
	function deleteContCart(str, goodsId, itemIndex) {
		
		$(str).parent().remove();
		// 这里删除Cookie里面的值
		var contcart = getCookie("contcart");
		if (contcart != null && contcart.length > 0) {
			var contcartJSON = JSON.parse(contcart);
			var contcartArray = eval(contcartJSON);
			var cookieIndex = parseFloat(itemIndex.replace("ITEM",""));
			var newContCart = [];
			var deleteItem;
			for(var i=0; i<contcartArray.length; i++){
				if (i != cookieIndex) {
					newContCart.push(contcartArray[i]);
				} else {
					deleteItem = contcartArray[i];
				}
			}
			delCookie("contcart");
			addCookie("contcart",JSON.stringify(newContCart));
			//刷新购物车
			reflashCart();
			//同步后台购物车的表
			// 需要公用设成List
			var sessionUserId = '${sessionUserId}';
			if (sessionUserId != null && sessionUserId != "") {
				var deleteData = {
						"groupId":deleteItem.groupId,
						"goodsName":deleteItem.goodsName,
						"goodsImage":deleteItem.goodsImage,
						"goodsQuantity":deleteItem.goodsQuantity,
						"goodsPrice":deleteItem.goodsPrice,
						"goodsProperties":deleteItem.goodsProperties

				}
				var inputList = [];
				inputList.push(deleteData);
				$.ajax({
					type : 'POST',
					contentType : 'application/json',
					url : '${pageContext.request.contextPath}/COMMON/deleteConsCart',
					dataType : 'json',
					data : JSON.stringify(inputList),
					success : function(data) {
						if(!data.isException){
							// 同步购物车成功
							
						} else {
							// 同步购物车失败
						}
					},
					error : function(data) {
						
					}
				});
			}
		}
	}
	
	function emptyContCart(){
		$("#contcartScroller").empty();
		// 删除Cookie里面的购物车
		delCookie("contcart");
		// 删除后台数据库中购物车
		var sessionUserId = '${sessionUserId}';
		if (sessionUserId != null && sessionUserId != "") {
			jQuery.ajax({
				type : 'GET',
				contentType : 'application/json',
				url : '${pageContext.request.contextPath}/COMMON/emptyConsCard',
				cache : false,
				async : false,
				dataType : 'json',
				success : function(data) {
					if(!data.isException){
						// 同步购物车成功
						
					} else {
						// 同步购物车失败
					}
				},
				error : function(data) {
					
				}
			});
		}
	}
	
	// 购物车一览
	function viewcart(){
		var licount = $("#contcartScroller").find("li")
		if (licount == null || licount.length == 0) return;
		location.href = "${pageContext.request.contextPath}/OZ_TT_GB_CA/init";
	}
	
	// 结算画面
	function toCheckout(){
		var licount = $("#contcartScroller").find("li");
		if (licount == null || licount.length == 0) return;
		var sessionUserId = '${sessionUserId}';
		if (sessionUserId != null && sessionUserId != "") {

			// 同步购物车的内容
			var needSyncData = getCookie("contcart");
			var contCartFromDB;
			if (getJsonSize(needSyncData) > 0) {
				$.ajax({
					type : "POST",
					contentType:'application/json',
					url : '${pageContext.request.contextPath}/COMMON/purchaseAsyncContCart',
					dataType : "json",
					async:false,
					data : needSyncData, 
					success : function(data) {
						if(!data.isException){
							// 同步购物车成功
							contCartFromDB = data.conscars;
							// 用户登录同步购物车里面的内容
							if (getJsonSize(contCartFromDB) > 0) {
								var contcartJSONFromDB = JSON.parse(contCartFromDB);
								var contcartArrayFromDB = eval(contCartFromDB);

								// 如果Cookie购物车里面没有数据，更新购物车
								var tempCookie = [];
								for(var i=0; i<contcartArrayFromDB.length; i++){
									var properties = {
											"groupId":contcartArrayFromDB[i].groupId,
											"goodsName":contcartArrayFromDB[i].goodsName,
											"goodsImage":contcartArrayFromDB[i].goodsImage,
											"goodsQuantity":contcartArrayFromDB[i].goodsQuantity,
											"goodsPrice":contcartArrayFromDB[i].goodsPrice,
											"goodsProperties":JSON.stringify(contcartArrayFromDB[i].goodsProperties)

									}
									tempCookie.push(properties);
								}
								delCookie("contcart");
								addCookie("contcart",JSON.stringify(tempCookie))
							}
							
							location.href = "${pageContext.request.contextPath}/OZ_TT_GB_SH/init";
						} else {
							// 同步购物车失败
						}
					},
					error : function(data) {
						
					}
				});
			}
			
			
		} else {
			location.href = "${pageContext.request.contextPath}/OZ_TT_TP_LG/init";
		}
	}
	
	// 画面初期化时加载
	function initLoad(){
		if ('${needSync}' == '1') {
			var sessionUserId = '${sessionUserId}';
			if (sessionUserId != null && sessionUserId != "") {
				var needSyncData = getCookie("contcart");
				var contCartFromDB;
				$.ajax({
					type : "POST",
					contentType:'application/json',
					url : '${pageContext.request.contextPath}/COMMON/addConsCart',
					dataType : "json",
					async: false,
					data : needSyncData, 
					success : function(data) {
						if(!data.isException){
							// 同步购物车成功
							contCartFromDB = data.conscars;
						} else {
							// 同步购物车失败
						}
					},
					error : function(data) {
						
					}
				});

				// 用户登录同步购物车里面的内容
				if (getJsonSize(contCartFromDB) > 0) {
					var contcartJSONFromDB = JSON.parse(contCartFromDB);
					var contcartArrayFromDB = eval(contCartFromDB);

					// 如果Cookie购物车里面没有数据，更新购物车
					var tempCookie = [];
					for(var i=0; i<contcartArrayFromDB.length; i++){
						var properties = {
								"groupId":contcartArrayFromDB[i].groupId,
								"goodsName":contcartArrayFromDB[i].goodsName,
								"goodsImage":contcartArrayFromDB[i].goodsImage,
								"goodsQuantity":contcartArrayFromDB[i].goodsQuantity,
								"goodsPrice":contcartArrayFromDB[i].goodsPrice,
								"goodsProperties":JSON.stringify(contcartArrayFromDB[i].goodsProperties)

						}
						tempCookie.push(properties);
					}
					delCookie("contcart");
					addCookie("contcart",JSON.stringify(tempCookie))
				}
			}
		}
		
		reflashCart();
	}
	
	function searchGoods(){
		var goodsText = $("#goodsText").val();
		location.href = "${pageContext.request.contextPath}/main/searchGoods?goodsNameParam="+encodeURI(encodeURI(goodsText));
	}
	
	// 进入我的信息画面
	function toMyTuantuan(){
		location.href = "${pageContext.request.contextPath}/OZ_TT_CS_PE/init";
	}
	
	// 进入我的订单画面
	function toMyOrder(){
		location.href = "${pageContext.request.contextPath}/OZ_TT_GB_OL/itemList";
	}
	
	// 注册画面
	function toRegister(){
		location.href = "${pageContext.request.contextPath}/OZ_TT_TP_RE/init";
	}
	
	// 获取JSONlist的数量
	function getJsonSize(str) {
		if (str == null || str.length == 0){
			return 0;
		} else {
			var strJSON = JSON.parse(str);
			var strArray = eval(strJSON);
			return strArray.length;
		}
	}
	
	// 将DB购物车的值放入到Cookie中
	
	
	function changeLocale(local) {
		$.ajax({
			type : "GET",
			contentType:'application/json',
			url : '${pageContext.request.contextPath}/COMMON/changeLocale?local='+local,
			dataType : "json",
			async:false,
			data : '', 
			success : function(data) {
			},
			error : function(data) {
				
			}
		});
		window.location.reload();
	}
	
</script>

<!-- Body BEGIN -->
<body onload="initLoad()">
    <!-- BEGIN TOP BAR -->
    <div class="pre-header">
        <div class="container">
            <div class="row">
                <!-- BEGIN TOP BAR LEFT PART -->
                <div class="col-md-6 col-sm-6 additional-shop-info">
                    <ul class="list-unstyled list-inline">
                        <li><i class="fa fa-phone"></i><span>+1 456 6717</span></li>
                        <li class="langs-block">
                        	<c:if test="${languageSelf == 'zh_CN' }">
                        		<a href="javascript:void(0);" class="current">中文 <i class="fa fa-angle-down"></i></a>
	                            <div class="langs-block-others-wrapper">
		                            <div class="langs-block-others">
		                              <a href="" onclick="changeLocale('en')">English</a>
		                            </div>
	                            </div>
                        	</c:if>
                        	<c:if test="${languageSelf == 'en_US' }">
                        		<a href="javascript:void(0);" class="current">English <i class="fa fa-angle-down"></i></a>
	                            <div class="langs-block-others-wrapper">
		                            <div class="langs-block-others">
		                              <a href="" onclick="changeLocale('zh')">中文</a>
		                            </div>
	                            </div>
                        	</c:if>
                            
                        </li>
                    </ul>
                </div>
                <!-- END TOP BAR LEFT PART -->
                <!-- BEGIN TOP BAR MENU -->
                <div class="col-md-6 col-sm-6 additional-nav">
                    <ul class="list-unstyled list-inline pull-right">
                    	<c:if test="${ sessionUserId != null && sessionUserId != ''}">
                    		<li><fmt:message key="header_welcome"/>${sessionUserName}</li>
                    		<li><a onclick="toMyOrder()"><fmt:message key="header_myOrder"/></a></li>
                    		<li class="mytuantuan-block">
	                    		<a href="javascript:void(0);"><fmt:message key="header_myOztuantuan"/><i class="fa fa-angle-down"></i></a>
	                    		<div class="mytuantuan-block-others-wrapper">
		                            <div class="mytuantuan-block-others">
		                            	<div>
		                            		<a onclick="toMyTuantuan()">我的个人信息</a>
		                            	</div>
		                            	
		                            </div>
	                            </div>
                    		</li>
                    		
                    	</c:if>
                        <li><a onclick="toCheckout()"><fmt:message key="header_checkout"/></a></li>
                        <c:if test="${ sessionUserId == null || sessionUserId == '' }">
                        	<li><a onclick="tologin();return false;"><fmt:message key="header_welcomeLogin"/></a></li>
                        </c:if>
                        <c:if test="${ sessionUserId != null && sessionUserId != '' }">
                        	<li><a onclick="tologinOut();return false;"><fmt:message key="header_logout"/></a></li>
                        </c:if>
                        <li><a onclick="toRegister()"><fmt:message key="header_register"/></a></li>
                    </ul>
                </div>
                <!-- END TOP BAR MENU -->
            </div>
        </div>        
    </div>
    <!-- END TOP BAR -->

    <!-- BEGIN HEADER -->
    <div role="navigation" class="navbar header no-margin">
        <div class="container">
            <div class="navbar-header">
                <!-- BEGIN RESPONSIVE MENU TOGGLER -->
                <button data-target=".navbar-collapse" data-toggle="collapse" class="navbar-toggle" type="button">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <!-- END RESPONSIVE MENU TOGGLER -->
                <a href="${ctx}/main/init" class="navbar-brand"><img src="${ctx}/images/logo.png" width="129px" height="32px" alt="OZTUANTUAN.COM.AU"></a><!-- LOGO -->
            </div>
            <!-- BEGIN CART -->
             <div class="cart-block">
                <div class="cart-info">
                    <a href="javascript:void(0);" class="cart-info-count" id="sumCount"></a>
                    <a href="javascript:void(0);" class="cart-info-value" id="sumMoney"></a>
                </div>
                <i class="fa fa-shopping-cart"></i>
                <!-- BEGIN CART CONTENT -->
                <div class="cart-content-wrapper">
                  <div class="cart-content">
                    <ul class="scroller" style="height: 250px;" id="contcartScroller">
                      <li>
                        
                      </li>
                    </ul>
                    <div class="text-right">
                      <a onclick="viewcart()" class="btn btn-primary"><fmt:message key="common_viewcart"/></a>
                      <a onclick="toCheckout()" class="btn btn-primary"><fmt:message key="common_checkout"/></a>
                    </div>
                  </div>
                </div>
                <!-- END CART CONTENT -->
            </div>
            <!-- END CART -->
            <!-- BEGIN NAVIGATION -->
            <div class="collapse navbar-collapse mega-menu">
                <ul class="nav navbar-nav">
                    <li class="dropdown" onclick="toMainIndex()">
                      <a class="dropdown-toggle" data-toggle="dropdown" data-delay="0" data-close-others="false" data-target="" href="#">
                         <fmt:message key="common_group"/>
                        <i class="fa fa-angle-down"></i>
                      </a>
                    </li>
                    <li class="dropdown">
                      <a class="dropdown-toggle" data-toggle="dropdown" data-delay="0" data-close-others="false" data-target="" href="#">
                         <fmt:message key="common_pleshop"/>
                        <i class="fa fa-angle-down"></i>
                      </a>
                    </li>
                    <li class="dropdown">
                      <a class="dropdown-toggle" data-toggle="dropdown" data-delay="0" data-close-others="false" data-target="" href="#">
                         <fmt:message key="common_hotsell"/>
                        <i class="fa fa-angle-down"></i>
                      </a>
                    </li>
                    <li class="dropdown">
                      <a class="dropdown-toggle" data-toggle="dropdown" data-delay="0" data-close-others="false" data-target="" href="#">
                         <fmt:message key="common_retail"/>
                        <i class="fa fa-angle-down"></i>
                      </a>
                    </li>
                    
                    <!-- BEGIN TOP SEARCH -->
                    <li class="menu-search">
                        <span class="sep"></span>
                        <i class="fa fa-search search-btn"></i>
                        <div class="search-box">
                               <div class="input-group">
                                   <input type="text" placeholder="Search" class="form-control" id="goodsText" 
                                   	onkeydown="javascript:if(event.keyCode==13) searchGoods();">
                                   <span class="input-group-btn">
                                       <button class="btn btn-primary" type="submit" onclick="searchGoods()">
                                       	<fmt:message key="indexSearch"/>
                                       </button>
                                   </span>
                               </div>
                        </div> 
                    </li>
                    <!-- END TOP SEARCH -->
                </ul>
            </div>
            <!-- END NAVIGATION -->
        </div>
    </div>
    <!-- END HEADER -->

    
	<sitemesh:write property='body' />
    

        

    <!-- BEGIN FOOTER -->
    <footer>
    <div class="footer padding-top-15">
      <div class="container">
        <div class="row">
          <!-- BEGIN COPYRIGHT -->
          <div class="col-md-9 col-sm-9 padding-top-10">
            <fmt:message key="mainFooter"/>
            <ul class="list-unstyled list-inline pull-right">
               	<li>
               		<a href="${ctx}/main/init"><fmt:message key="FOOTER_Home"/></a>
               	</li>
               	<li>
               		<a href="${ctx}/AboutUs/AU"><fmt:message key="FOOTER_aboutUs"/></a>
               	</li>
               	<li>
               		<a href="${ctx}/AboutUs/AU"><fmt:message key="FOOTER_contactUs"/></a>
               	</li>
               	<li>
               		<a href="${ctx}/AboutUs/RS#1f"><fmt:message key="FOOTER_termsCondtions"/></a>
               	</li>
               	<li>
               		<a href="${ctx}/AboutUs/RS#2f"><fmt:message key="FOOTER_refundPolicy"/></a>
               	</li>
               	<li>
               		<a href="${ctx}/AboutUs/RS#3f"><fmt:message key="FOOTER_deliveryDetails"/></a>
               	</li>
               	<li>
               		<a href="${ctx}/AboutUs/RS#4f"><fmt:message key="FOOTER_privacypolicy"/></a>
               	</li>
            </ul>
          </div>
          <!-- END COPYRIGHT -->
          <!-- BEGIN PAYMENTS -->
          <div class="col-md-3 col-sm-3">
            <ul class="list-unstyled list-inline pull-right margin-bottom-15">
              <li><img src="<c:url value='/assets/img/payments/PayPal.jpg' />" alt="We accept PayPal" title="We accept PayPal"></li>
            </ul>
          </div>
          <!-- END PAYMENTS -->
        </div>
      </div>
    </div>
    </footer>
    <!-- END FOOTER -->
    
</body>
<!-- END BODY -->
</html>