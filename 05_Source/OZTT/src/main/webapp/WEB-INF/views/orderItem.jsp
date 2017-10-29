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
    width: 150px;
}

</style>
</head>
<!-- Head END -->


<!-- Body BEGIN -->
<body>

	<!-- 主内容-->
<div class="main">
    <div class="help_tl">
        <div class="jz">
            订单详情
        </div>
    </div>
    <div class="clearfix help_main jz">
        <div class="left help_lf user_center">
    <ul>
        <li>
            <a href="${ctx}/order/init" class="ahover">
                <img src="${ctx}/images/yonghuzhongxin/dingdan.png" class="img_q" />
                <img src="${ctx}/images/yonghuzhongxin/dingdanh.png" class="img_h" />
                <span class="user_center_link">我的订单</span>
            </a>
        </li>
        <li>
            <a href="${ctx}/member/init" class="">
                <img src="${ctx}/images/yonghuzhongxin/xinxi.png" class="img_q" />
                <img src="${ctx}/images/yonghuzhongxin/xinxih.png" class="img_h" />
                <span class="user_center_link">会员信息</span>
            </a>
        </li>
        <li>
            <a href="${ctx}/address/receiveList" class="">
                <img src="${ctx}/images/yonghuzhongxin/shoujianren.png" class="img_q" />
                <img src="${ctx}/images/yonghuzhongxin/shoujianrenh.png" class="img_h" />
                <span class="user_center_link">收件人管理</span>
            </a>
        </li>
        <li>
            <a href="${ctx}/address/sendList" class="">
                <img src="${ctx}/images/yonghuzhongxin/fajianren.png" class="img_q" />
                <img src="${ctx}/images/yonghuzhongxin/fajianrenh.png" class="img_h" />
                <span class="user_center_link">寄件人管理</span>
            </a>
        </li>
        <li>
            <a href="${ctx}/login/logout" id="outBtn">
                <img src="${ctx}/images/yonghuzhongxin/out.png" class="img_q" />
                <img src="${ctx}/images/yonghuzhongxin/outh.png" class="img_h" />
                <span class="user_center_link">退出</span>
            </a>
        </li>
    </ul>
</div>


<div class="alert out_alert">
    <p class="alert_tl">确认退出</p>
    <div class="alert_text">
        您确定要退出当前用户？
    </div>
    <div class="alert_btn">
        <a href="javascript:void(0);" class="quxiao" id="delCancel">取消</a>
        <a href="javascript:document.getElementById('logoutform').submit()" id="delConfirm" class="btn_red">退出</a>
    </div>
</div>

<!--弹窗开始-->
<div class="alert_bg"></div>

        <div class="right help_rt">
            <div class=" clearfix jiesuan_tl">
    <span class="left jiesuan_tl_lf">
        订单信息
    </span>
    <div class="right order_tl_a">

            <a href="javascript:void(0);" class="color_red">
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
            </a>
        
    </div>
	</div>
	<div class="clearfix jiesuan_main order_mess">
	    <p class="mt10">
	        <span class="mr50">订单号：${detailInfo.orderNo}  </span>
	        <span> 订单日期： ${detailInfo.orderDate}</span>
	    </p>
	    <p> ${detailInfo.orderDesc} </p>
	</div>

                <ul class="order_pro_ul">
                	<c:if test="${detailInfo.powderOrProductFlg == '1' }">
                		<c:forEach var="product" items="${ detailInfo.productList }" varStatus="status">
	                    <li class="clearfix">
	                        
	                        <div class="left order_pro_ul_tl">
	                              ${product.productName }
	                        </div>
	                        <div class="right order_pro_ul_price">
	                            <p class="mt10">$${product.productPrice }</p>
	                        </div>
	                    </li>
	                    </c:forEach>
                    </c:if>
                    <c:if test="${detailInfo.powderOrProductFlg == '2' }">
                		<c:forEach var="product" items="${ detailInfo.productList }" varStatus="status">
	                    <li class="clearfix">
	                        <a href="${ctx}/item/getGoodsItem?groupId=${product.productId}" class="order_pro_ul_img left">
	                            <img src="${product.productPath}" />
	                        </a>
	                        <div class="left order_pro_ul_tl">
	                            <a href="${ctx}/item/getGoodsItem?groupId=${product.productId}">
	                                ${product.productName }
	                            </a>
	                        </div>
	                        <div class="right order_pro_ul_price">
	                            <p class="mt10">$${product.productPrice }</p>
	                            <p>X ${product.productNumber }</p>
	                        </div>
	                    </li>
	                    </c:forEach>
                    </c:if>
                    
                </ul>
    <ul class="qian_shuoming">

    </ul>

<ul class="qian_shuoming">
    <li class="clearfix">
        <div class="left">
            <img src="${ctx}/images/jiesuan/zongfen.png" /> 商品总价
        </div>
        <div class="right">$${detailInfo.productAmountSum }</div>
    </li>
    <li class="clearfix">
        <div class="left">
            <img src="${ctx}/images/jiesuan/yunfei.png" /> 运费（国际快递）
        </div>
        <div class="right">
 			$${detailInfo.yunfei }      
 		</div>
    </li>
</ul>

<div class=" clearfix jiesuan_tl suan bg_white">
    <div class="right clearfix">
        <div class="left"><span class="font18"><b>实付款：</b></span>
            <span class="color_red">
                <span class="font28"><b>
                        $${detailInfo.orderAmountSum }
                </b></span>
            </span>
        </div>
            
            <c:if test="${order.status == '0' }">
            	<a class="btn_red suanbtn" href="#" onclick="toPay('${detailInfo.orderNo}','${detailInfo.paymentMethod}')">立即付款</a>
            </c:if>
    </div>
</div>


            
<div class="clearfix jiesuan_tl">
    <span class="left jiesuan_tl_lf">
        快递包裹
    </span>
</div>
<table cellpadding="0" cellspacing="0" class="baoguo_table" width="100%">
    <tr>
        <th>快递单号</th>
        <th>收件人</th>
        <th>上传身份证</th>
        <th>查看物流</th>
    </tr>
     <c:forEach var="box" items="${ detailInfo.boxList }" varStatus="status">
    <tr>
        <td>
            <div class="container">
                <a href="#my-express-img-${box.elecExpressNo}" data-toggle="modal"> ${box.elecExpressNo}</a>
            </div>
            <!--固定定位的模态框-->
            <div id="my-express-img-${box.elecExpressNo }" class="modal fade"> <!--半透明的遮罩层-->
                <div class="modal-dialog"> <!--定位和尺寸-->
                    <div class="modal-content">  <!--背景边框阴影-->
                        <div class="modal-header">
                            <span class="close" data-dismiss="modal">×</span>
                        </div>
                        <div class="modal-body">
                        	<img src="${box.expressPhotoUrl }" alt=""  height="180">
                        </div>
						<div class="modal-footer">
			               <span>提示：右击图片可以将图片保存到本地</span>
			           </div>
                    </div>
                </div>
            </div>
        </td>
        <td>
            ${box.receiveName}
        </td>
        <td>
			<div class="container">
                <a href="#my-modal-card-${box.elecExpressNo}" data-toggle="modal">身份证</a>
            </div>
            <!--固定定位的模态框-->
            <div id="my-modal-card-${box.elecExpressNo}" class="modal fade"> <!--半透明的遮罩层-->
                <div class="modal-dialog"> <!--定位和尺寸-->
                    <div class="modal-content">  <!--背景边框阴影-->
                        <div class="modal-header">
                            <span class="close" data-dismiss="modal">×</span>
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
        <td>
            <div class="container">
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
</table>
<div class="clearfix jiesuan_tl">
    <span class="left jiesuan_tl_lf">
        发货图片
    </span>
</div>
<div class="jiesuan_main clearfix fahuo">
    <ul id="parcelimages" class="clearfix">
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
                                      <img src="${photoUrl }" alt=""  height="180">
                                  </div>
                                  <div class="modal-footer">
				               <span>提示：长按图片可以将图片保存到本地</span>
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


            

        <div class="order_back">
            <a href="${ctx}/order/init">返回订单列表</a>
        </div>
        </div>
    </div>
</div>
</body>
<!-- END BODY -->
</html>