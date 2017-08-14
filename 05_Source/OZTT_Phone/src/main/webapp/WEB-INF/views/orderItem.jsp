<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title><fmt:message key="ORDERLIST_TITLE" /></title>
<script type="text/javascript">
  	

  	
  	function showExpressInfo(elecExpressNo,boxId, powderOrProductFlg){
  		
  		var url = "";
  		if (powderOrProductFlg == '1') {
  			url = '${pageContext.request.contextPath}/powderOrder/getExpressInfo?expressEleNo='+elecExpressNo+'&boxId='+boxId;
  		} else if (powderOrProductFlg == '2') {
  			url = '${pageContext.request.contextPath}/order/getExpressInfo?expressEleNo='+elecExpressNo+'&boxId='+boxId;
  		}
		$.ajax({
			type : "GET",
			contentType:'application/json',
			url : url,
			dataType : "json",
			async : false,
			data : "", 
			success : function(data) {
				var expressHtml = "";
				var expressInfo = data.expressInfo;
				for (var i = 0; i < expressInfo.length; i++) {
					expressHtml += "<li>"+expressInfo[i]+"</li>"
				}
				
				$("#express-info-" + elecExpressNo).html(expressHtml);
				// 弹出画面
			},
			error : function(data) {
				
			}
		});
  		
  	}
  	
  	$(function(){
  		
  		$("input[date-id=imgBe]").change(function (){
  			
  			var expressNo = $(this).attr("expressNo");
  			var receiveId = $(this).attr("receiveId");
  			var reader = new FileReader();

	        reader.onload = function (e) {
	            var compressImg = compress(this.result,fileSize,$("#imgInfoBe-"+expressNo));
	         	// 将照片传到后台
	            uploadImg(this.result,'0', receiveId);
	        };

	        reader.readAsDataURL(this.files[0]);

	        var fileSize = Math.round(this.files[0].size/1024/1024) ;
  		});
  		
  		$("input[date-id=imgAf]").change(function (){
  			
  			var expressNo = $(this).attr("expressNo");
  			var receiveId = $(this).attr("receiveId");
			var reader = new FileReader();
	        
	        reader.onload = function (e) {
	            var compressImg = compress(this.result,fileSize,$("#imgInfoAf-"+expressNo));
	            // 将照片传到后台
	            uploadImg(this.result,'1', receiveId);
	        };

	        reader.readAsDataURL(this.files[0]);

	        var fileSize = Math.round(this.files[0].size/1024/1024) ;
  		});
  	})
  	
  	
  	function compress(res,fileSize, desObj) { //res代表上传的图片，fileSize大小图片的大小
  	    var img = new Image(),
  	        maxW = 640; //设置最大宽度

  	    img.onload = function () {
  	        var cvs = document.createElement( 'canvas'),
  	            ctx = cvs.getContext( '2d');

  	        if(img.width > maxW) {
  	            img.height *= maxW / img.width;
  	            img.width = maxW;
  	        }

  	        cvs.width = img.width;
  	        cvs.height = img.height;
  	      	ctx.fillStyle = "#fff";
  	        ctx.fillRect(0, 0, cvs.width, cvs.height);
  	        //ctx.clearRect(0, 0, cvs.width, cvs.height);
  	        ctx.drawImage(img, 0, 0, img.width, img.height);

  	        var compressRate = getCompressRate(1,fileSize);
  	        
  	        var dataUrl = cvs.toDataURL( 'image/jpeg', compressRate);
  	      	$(desObj).attr('src',dataUrl);
  	    }

  	    img.src = res;
  	}
  	
  	function getCompressRate(allowMaxSize,fileSize){ //计算压缩比率，size单位为MB
	      var compressRate = 1;

	      if(fileSize/allowMaxSize > 4){
	           compressRate = 0.5;
	      } else if(fileSize/allowMaxSize >3){
	           compressRate = 0.6;
	      } else if(fileSize/allowMaxSize >2){
	           compressRate = 0.7;
	      } else if(fileSize > allowMaxSize){
	           compressRate = 0.8;
	      } else{
	           compressRate = 0.9;
	      }

	      return compressRate;
	}
  	
  	
  	function uploadImg(imgBase64Data, type, receiveId) {

        var pos = imgBase64Data.indexOf("4") + 2;
        imgBase64Data = imgBase64Data.substring(pos, imgBase64Data.length);//去掉Base64:开头的标识字符   
        var paramData = { 'base64StrImgData': imgBase64Data};
        $.ajax({
			type : "POST",
			contentType:'application/json',
			url : '${pageContext.request.contextPath}/powderOrder/addImage?type='+type+"&receiveId="+receiveId,
			dataType : "json",
			async : false,
			data : JSON.stringify(paramData), 
			success : function(data) {
				
			},
			error : function(data) {
				
			}
		});
  	}
  	
  	function submitIdCard(receiveId, str, elecExpressNo){
  		
  		var updateCardNo = $(str).parent().parent().find(".cardInput").val();
		var paramData = {
			cardNo : updateCardNo
		};
		// 更新身份证号码
		$.ajax({
			type : "POST",
			contentType:'application/json',
			url : '${pageContext.request.contextPath}/powderOrder/updateCard?receiveId='+receiveId,
			dataType : "json",
			async : false,
			data : JSON.stringify(paramData), 
			success : function(data) {
				
			},
			error : function(data) {
				
			}
		});
		// 模态框关闭
		$('#my-modal-card-'+elecExpressNo).modal('hide');
  	}
  	
  	
  	function toPay(orderId, paymentMethod) {
		if (paymentMethod == "1") {
			location.href = "${ctx}/Pay/init?orderNo="+orderId+"&paymentMethod="+paymentMethod;
		} else if (paymentMethod == "4") {
			// 新增的微信支付
			if (!isWeiXin()){
				// 不是微信，则跳出提示
				createInfoDialog('<fmt:message key="I0009" />', '3');
				return;
			}
			$.ajax({
				type : "GET",
				timeout : 60000, //超时时间设置，单位毫秒
				contentType:'application/json',
				url : '${ctx}/purchase/getWeChatPayUrlHasCreate?orderId='+orderId,
				dataType : "json",
				async : false,
				data : "", 
				success : function(data) {
					if (data.payUrl != null && data.payUrl != "") {
						// 重新加载画面
						location.href = data.payUrl;
					} else {
						removeLoading();
						createErrorInfoDialog('<fmt:message key="E0023" />');
					}					
				},
				error : function(data) {
					removeLoading();
					createErrorInfoDialog('<fmt:message key="E0023" />');
				}
			});
		}
		
	}
  	

  </script>
  <style type="text/css">
.wrapper
{
    position: relative;
    height: 200px;
    overflow: hidden;
    width: 50%;
    float: left;
}
.input-upload-image {
    z-index: 1;
    border: none;
    -webkit-opacity: 0;
    opacity: 0;
}
.input-upload-image, .upload-btn {
    width: 100px;
    height: 100px;
    display: block;
    position: absolute;
    top: 20px;
    left: 25%;
}

.cardInput{
	border-color: #878787;
    border-style: solid;
    border-top-width: 0px;
    border-right-width: 0px;
    border-bottom-width: 1px;
    border-left-width: 0px;
    border-radius: 0px;
    padding-left:8px;
    width: 150px;
}

</style>
</head>
<!-- Head END -->


<!-- Body BEGIN -->
<body>

<!--头部开始-->
<div class="head_fix">
    <div class="head user_head clearfix">
        <a href="javascript:history.back(-1)" class="head_back"></a>
        订单详情
        <div class="daohang">
	    <em></em>
	    <ul class="daohang_yin">
	        <span class="sj"></span>
	        <li>
	            <a href="${ctx}/main/init" class="clearfix">
	                <img src="${ctx}/images/head_menu_shouye.png" /> 首页
	            </a>
	        </li>
	        <li>
	            <a href="${ctx}/category/init" class="clearfix">
	                <img src="${ctx}/images/head_menu_fenlei.png" /> 分类
	            </a>
	        </li>
	        <li>
	            <a href="${ctx}/user/init" class="clearfix">
	                <img src="${ctx}/images/head_menu_zhanghu.png" /> 我的账户
	            </a>
	        </li>
	        <li>
	            <a href="${ctx}/order/init" class="clearfix">
	                <img src="${ctx}/images/head_menu_dingdan.png" /> 我的订单
	            </a>
	        </li>
	    </ul>
	</div>
    </div>
</div>

<div class="main">
    <!--内容开始-->
    <div class="dingdancon_main">
    <div class="xiangqing_main">
        <div class="xiangqing_main_ico">
            <img src="${ctx}/images/dingdancon/dingdan.png" />
        </div>
        <div class="xiangqing_text">
            <div class="xiangqing_text_main clearfix">
                <div class=" clearfix">
                    <div class="left xiangqing_text_main_lf">
                        订单号：${detailInfo.orderNo}
                    </div>
                    <div class="right xiangqing_text_main_rt">
                        <%-- <span class="color_blue">
                        	<c:if test="${order.status == '1' || order.status == '2' }">
                            	等待处理
                            </c:if>
                        </span> --%>
                        <span class="color_red">
                        	<c:if test="${order.status == '0' }">
                            	未付款
                            </c:if>
                            <c:if test="${order.status == '1' }">
                           		下单成功
                           	</c:if>
                           	<c:if test="${order.status == '2' }">
                           		商品派送中
                           	</c:if>
                           	<c:if test="${order.status == '3' }">
                           		订单已完成
                           	</c:if>
                        </span>
                    </div>
                </div>
                订单日期： ${detailInfo.orderDate}<br />
                备注： ${detailInfo.orderDesc}

            </div>
        </div>
    </div>
</div>

<div class="dingdancon_main pro_list border-top mt5">
            	<ul>
            		<c:if test="${detailInfo.powderOrProductFlg == '1' }">
            			<c:forEach var="product" items="${ detailInfo.productList }" varStatus="status">
	                    <li class="clearfix">
	                        
	                        <div class="right pro_list_rt clearfix">
	                            <div class="left pro_list_rt_tl">
	                                    ${product.productName }
	                            </div>
	                            <div class="right pro_list_rt_price">
	                                <p>$${product.productPrice }</p>
	                            </div>
	                        </div>
	                    </li>
	                    </c:forEach>
            		</c:if>
            		<c:if test="${detailInfo.powderOrProductFlg == '2' }">
            		<c:forEach var="product" items="${ detailInfo.productList }" varStatus="status">
	                    <li class="clearfix">
	                        <a href="${ctx}/item/getGoodsItem?groupId=${product.productId}" class="pro_list_lf left">
	                            <img src="${product.productPath}" />
	                        </a>
	                        <div class="right pro_list_rt clearfix">
	                            <div class="left pro_list_rt_tl">
	                                <a href="${ctx}/item/getGoodsItem?groupId=${product.productId}">
	                                    ${product.productName }
	                                </a>
	                            </div>
	                            <div class="right pro_list_rt_price">
	                                <p>$${product.productPrice }</p>
	                                <p>X ${product.productNumber }</p>
	                            </div>
	                        </div>
	                    </li>
                    </c:forEach>
                    </c:if>
            </ul>
        </div>
    <%-- <div class="dingdancon_main zhangdan border-top">
        <ul>
            <li class="clearfix">
                <div class="left zhangdan_li">
                    <img src="images/dingdancon/jifen.png" />
                    本单积分
                </div>
                <div class="right zhangdan_price">61分</div>
            </li>
            <li class="clearfix">
                <div class="left zhangdan_li">
                    <img src="${ctx}/images/dingdancon/yunfeibucha.png" />
                    运费补差
                </div>
                <div class="right zhangdan_price">$${detailInfo.yunfeicha }</div>
            </li>
        </ul>
    </div> --%>

<div class="dingdancon_main zhangdan border-top">
    <ul>
        <li class="clearfix">
            <div class="left zhangdan_li">
                <img src="${ctx}/images/dingdancon/zongjia.png" />
                商品总价
            </div>
            <div class="right zhangdan_price">$${detailInfo.productAmountSum }</div>
        </li>
        <li class="clearfix">
            <div class="left zhangdan_li">
                <img src="${ctx}/images/dingdancon/yunfei.png" />
                运费（国际快递）
            </div>
            <div class="right zhangdan_price">
 				$${detailInfo.yunfei }        
 			</div>
        </li>
        <li class="clearfix">
            <div class="left zhangdan_li">
                <img src="${ctx}/images/dingdancon/dingdanzongjia.png" />
                订单总价
            </div>
            <div class="right zhangdan_price">
 				$${detailInfo.orderAmountSum }              
 			</div>
        </li>
    </ul>
    
        <div class="shifu">
        		<c:if test="${order.status == '0' }">
                <a href="#" onclick="toPay('${detailInfo.orderNo}','${detailInfo.paymentMethod}')" style="color:#fa4e83">立即付款</a>
                </c:if>
            	实付款<span class="color_red">$${detailInfo.orderAmountSum }     </span>
        </div>
	</div>    

    <div class="dingdancon_main border-top baoguo">
    <div class="user_order_tl clearfix">
        <span class="left">快递包裹</span>
    </div>
    <div class="baoguo_main">
            <div class="clearfix">
                <table width="100%">
                    <tbody>
                        <tr>
                            <th style="text-align: center">快递单号</th>
                            <th style="text-align: center">收件人</th>
                            <th style="text-align: center">上传身份证</th>
                            <th style="text-align: center">查看物流</th>
                        </tr>
                        <c:forEach var="box" items="${ detailInfo.boxList }" varStatus="status">
						<tr>
							<td style="text-align: center">
								<div class="container <c:if test="${box.elecExpressNo != null && box.elecExpressNo != ''}">add-border</c:if>">
								
									<a href="#my-express-img-${box.elecExpressNo}" data-toggle="modal"> ${box.elecExpressNo}</a>
								</div>
								
								
								<div id="my-express-img-${box.elecExpressNo }" class="modal fade"> <!--半透明的遮罩层-->
	                            <div class="modal-dialog"> <!--定位和尺寸-->
	                                <div class="modal-content">  <!--背景边框阴影-->
	                                    <div class="modal-body">
	                                        <img src="${box.expressPhotoUrl }" alt=""  height="180">
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
							</td>
							<td style="text-align: center">
									${box.receiveName}
							</td>
							<td style="text-align: center">
								<div class="container add-border">
										<a href="#my-modal-card-${box.elecExpressNo}" data-toggle="modal">身份证</a>
								</div>
								<!--固定定位的模态框-->
								<div id="my-modal-card-${box.elecExpressNo}" class="modal fade"> <!--半透明的遮罩层-->
										<div class="modal-dialog"> <!--定位和尺寸-->
												<div class="modal-content">  
														<!--背景边框阴影-->
														<div class="modal-header">
															<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
															<h4 class="modal-title" id="myModalLabel">身份证信息</h4>
														</div>
														<div class="modal-body">
															<div class="idCardDiv clearfix">
																<span class="idCard"><fmt:message key="POWDER_ITEM_RECEIVE_CARDNO" /></span>
																<input placeholder="" class="cardInput" value="${box.receivecardId}"/>
															</div>
															<div class="clearfix">
																<div class="wrapper">
																	<input type="file" accept="image/*;" date-id="imgBe" class="input-upload-image" expressNo="${box.elecExpressNo}" receiveId="${box.receiveId}">
																	<c:if test="${ box.receiveCardPhoneBe == ''}">
																		<img class="upload-btn events-pointer-none" src="${ctx}/images/img_upload.png" id="imgInfoBe-${box.elecExpressNo}">
																	</c:if>
																	<c:if test="${ box.receiveCardPhoneBe != ''}">
																		<img class="upload-btn events-pointer-none" src="${box.receiveCardPhoneBe }" id="imgInfoBe-${box.elecExpressNo}">
																	</c:if>
																</div>
																<div class="wrapper">
																	<input type="file" accept="image/*;" date-id="imgAf" class="input-upload-image" expressNo="${box.elecExpressNo}" receiveId="${box.receiveId}">
																	<c:if test="${ box.receiveCardPhoneAf == ''}">
																		<img class="upload-btn events-pointer-none" src="${ctx}/images/img_upload.png" id="imgInfoAf-${box.elecExpressNo}">
																	</c:if>
																	<c:if test="${ box.receiveCardPhoneAf != ''}">
																		<img class="upload-btn events-pointer-none" src="${box.receiveCardPhoneAf }" id="imgInfoAf-${box.elecExpressNo}">
																	</c:if>
																</div>	
															</div>
														</div>
														<div class="modal-footer">
											               <button type="button" class="btn btn-primary right" onclick="submitIdCard('${box.receiveId}',this,'${box.elecExpressNo}')">提交身份证号码</button>
											           </div>
												</div>
										</div>
								</div>
							</td>	
							<td style="text-align: center">
								<div class="container add-border">
										<a href="#my-modal-express-${box.elecExpressNo}" data-toggle="modal" onclick="showExpressInfo('${box.elecExpressNo}','${box.boxId}', '${detailInfo.powderOrProductFlg }')">物流消息</a>
								</div>
								<!--固定定位的模态框-->
								<div id="my-modal-express-${box.elecExpressNo}" class="modal fade"> <!--半透明的遮罩层-->
										<div class="modal-dialog"> <!--定位和尺寸-->
												<div class="modal-content">  
														<!--背景边框阴影-->
														<div class="modal-header">
															<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
															<h4 class="modal-title" id="myModalLabel">物流信息</h4>
														</div>
														<div class="modal-body" id="express-info-${box.elecExpressNo}">
														</div>
												</div>
										</div>
								</div>
							</td>
					</tr>
					</c:forEach>
                    </tbody>
                </table>
            </div>
            </div>
	</div>

    <div class="dingdancon_main border-top baoguo">
        <div class="user_order_tl clearfix">
            <span class="left">发货图片</span>
        </div>
        <ul id="parcelimages" class="fahuo clearfix  photoswipe-gallery">
        		<c:forEach var="box" items="${ detailInfo.boxList }" varStatus="status1">
        		<c:if test="${box.status == '1' || box.status == '2'}">
        			<c:forEach var="photoUrl" items="${ box.boxPhotoUrl }" varStatus="status2">
	                <li>
	                    <div class="baoguo_main">
	                        <div class="container">
	                            <a href="#my-modal-photo-${status1.count }-${status2.count }" data-toggle="modal">
	                                <img src="${photoUrl}" alt="" width="100" height="100">
	                            </a>
	                        </div>
	                        <!--固定定位的模态框-->
	                        <div id="my-modal-photo-${status1.count }-${status2.count }" class="modal fade"> <!--半透明的遮罩层-->
	                            <div class="modal-dialog"> <!--定位和尺寸-->
	                                <div class="modal-content">  <!--背景边框阴影-->
	                                    <div class="modal-body">
	                                        <img src="${photoUrl }" alt="" width="400" height="400">
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	                </li>
	                </c:forEach>
	            </c:if>
	            <c:if test="${box.status == '0' }">
	            	<li>
	                    <div class="baoguo_main">
	            			${box.orderStatusView}
	            		</div>
	            	</li>
	            </c:if>
                </c:forEach>
            </ul>
    </div>

    <div class="fanhui">
        <a href="${ctx}/order/init">返回订单列表</a>
    </div>

</div>




	<%-- <div class="x-header x-header-gray border-1px-bottom">
		<div class="x-header-btn ico-back"></div>
		<div class="x-header-title">
			<span><fmt:message key="ORDERLIST_TITLE" /></span>
		</div>
		<div class="x-header-btn"></div>
	</div>
	<div class="order-item-status border-top-show">
		${detailInfo.orderStatusView}!
	</div>
	
	<div class="order-item-head">
		<div class="order-item-time"><fmt:message key="ORDER_ITEM_ORDERNO" />${detailInfo.orderNo}</div>
		<div class="order-item-headStatus">${detailInfo.orderStatusView}</div>
		<div class="order-select-address border-top-show">
			<c:if test="${detailInfo.addressId != '0' }">
				<div class="nameandphone">
					<div class="name">${detailInfo.receiver }&nbsp;&nbsp;&nbsp;${detailInfo.receiverPhone }</div>
					<div class="phone"></div>
				</div>
				<div class="detailaddress">
					<i class="position"></i>
					<div>
						${detailInfo.receiverAddress}
					</div>
				</div>
			</c:if>
			<c:if test="${detailInfo.addressId == '0' }">
				<div class="detailaddress_store">
					<i class="position"></i>
					<div>
						${detailInfo.receiverAddress}
					</div>
				</div>
			</c:if>
			
		</div>
	</div>
	<div class="order-goods-div margin-1rem-top">
		<c:forEach var="goodslist" items="${ detailInfo.goodList }">
		<div class="order-checkBlockBody">
			<div class="order-groupinfo">
				<div class="order-group-img">
					<img src="${goodslist.goodsImage }" class="img-responsive">
				</div>
				<div class="order-group-pro">
					<span class="order-goodname">${goodslist.goodsName }</span>
					
					<div class="order-good－picktime" style="display: none">
						<fmt:message key="ORDER_ITEM_DELIVERYTIME" /> ${goodslist.canbuyDay }
					</div>
				</div>
				<div class="order-group-price">
					<span>$${goodslist.goodsPrice }</span>	
					<div class="order-item-group">X${goodslist.goodsQuantity }</div>		
				</div>
				<c:if test="${goodslist.detailStatus == '0' }">
					<div class="order-groupinfo-status"><a><fmt:message key="COMMON_ORDER_DETAIL_HANDLE_0" /></a></div>
				</c:if>
				<c:if test="${goodslist.detailStatus == '1' }">
					<div class="order-groupinfo-status"><a><fmt:message key="COMMON_ORDER_DETAIL_HANDLE_1" /></a></div>
				</c:if>
				<c:if test="${goodslist.detailStatus == '2' }">
					<div class="order-groupinfo-status"><a><fmt:message key="COMMON_ORDER_DETAIL_HANDLE_2" /></a></div>
				</c:if>
				<c:if test="${goodslist.detailStatus == '3' }">
					<div class="order-groupinfo-status"><a><fmt:message key="COMMON_ORDER_DETAIL_HANDLE_3" /></a></div>
				</c:if>
				
			</div>
		</div>
		</c:forEach>
	</div>
			

	<div class="order-item-allinfo margin-1rem-top">
		<div class="order-item-payinfo top-padding">
			<div class="paytitle"><fmt:message key="ORDER_ITEM_PAYMETHOD" /></div>
			<div class="paycontent">${ detailInfo.paymethod}</div>
		</div>
		<div class="order-item-payinfo top-padding">
			<div class="paytitle"><fmt:message key="ORDER_ITEM_DELIVERYMETHOD" /></div>
			<div class="paycontent">${ detailInfo.deliveryMethodView}</div>
		</div>
<!-- 		<div class="order-item-payinfo top-padding"> -->
			<div class="paytitle"><fmt:message key="ORDER_ITEM_UNIFY" /></div>
			<div class="paycontent">${ detailInfo.deliveryDate} ${ detailInfo.deleveryTime}</div>
<!-- 		</div> -->
		<div class="order-item-payinfo top-padding">
			<div class="paytitle"><fmt:message key="ORDER_ITEM_FEIGHT" /></div>
			<div class="paycontent">${ detailInfo.yunfei}</div>
		</div>
		<div class="order-item-payinfo bottom-padding">
			<div class="paytitle"><fmt:message key="ORDER_ITEM_COMMENT" /></div>
			<div class="paycontent">${ detailInfo.customerComment}</div>
		</div>
		
	</div>
	<div class="order-item-money margin-1rem-top">
		<div><fmt:message key="ORDRE_ITEM_COUNT" />${ detailInfo.heji}</div>
		<p><fmt:message key="ORDRE_ITEM_ALL" />${ detailInfo.goodList.size()}<fmt:message key="ORDRE_ITEM_COUNT_GOODS" /></p>
	</div> --%>
</body>
<!-- END BODY -->
</html>