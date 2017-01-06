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
  
  	$(function(){
		$(".ico-back").click(function(){
			location.href="${ctx}/powderOrder/init?tab="+'${tab}';
		});
		
		$("#showExpress").click(function(){
			var expressElcNo = $("#hiddenElecExpressNo").val();
			var hiddenBoxId = $("#hiddenBoxId").val();
			$.ajax({
				type : "GET",
				contentType:'application/json',
				url : '${pageContext.request.contextPath}/powderOrder/getExpressInfo?expressEleNo='+expressElcNo+'&boxId='+hiddenBoxId,
				dataType : "json",
				async : false,
				data : "", 
				success : function(data) {
					var expressHtml = "";
					var expressInfo = data.expressInfo;
					for (var i = 0; i < expressInfo.length; i++) {
						expressHtml += "<li>"+expressInfo[i]+"</li>"
					}
					
					$("#expressInfoUL").html(expressHtml);
					// 弹出画面
					$("#expressinfo-pop-up").modal('show');
					
				},
				error : function(data) {
					
				}
			});
		});
		
		$("#editCard,#editCardMsg").click(function(){
			$("#cardnumberLabel").css('display','none');
			$("#editCard").css('display','none');
			$("#editCardMsg").css('display','none');
			
			$("#cardInput").css('display','');
			$("#confirmCard").css('display','');
			$("#clearCard").css('display','');
		});
		
		$("#confirmCard").click(function(){
			var updateCardNo = $("#cardInput").val();
			$("#hiddenCardNo").val(updateCardNo);
			
			var paramData = {
				cardNo : updateCardNo
			};
			// 更新身份证号码
			$.ajax({
				type : "POST",
				contentType:'application/json',
				url : '${pageContext.request.contextPath}/powderOrder/updateCard?receiveId='+$("#hiddenReceiveId").val(),
				dataType : "json",
				async : false,
				data : JSON.stringify(paramData), 
				success : function(data) {
					
				},
				error : function(data) {
					
				}
			});
			
			$("#cardInput").css('display','none');
			$("#confirmCard").css('display','none');
			$("#clearCard").css('display','none');
			
			$("#cardnumberLabel").text(updateCardNo);
			$("#cardnumberLabel").css('display','');
			$("#editCard").css('display','');
			$("#editCardMsg").css('display','');
		});
		
		$("#clearCard").click(function(){
			// 还原先前的身份信息
			var cardNo = $("#hiddenCardNo").val();
			$("#cardInput").val(cardNo);
			
			$("#cardInput").css('display','none');
			$("#confirmCard").css('display','none');
			$("#clearCard").css('display','none');
			
			$("#cardnumberLabel").text(cardNo);
			$("#cardnumberLabel").css('display','');
			$("#editCard").css('display','');
			$("#editCardMsg").css('display','');
		});
		
		document.getElementById('imgBe').addEventListener('change', function () {

	        var reader = new FileReader();

	        reader.onload = function (e) {
	            var compressImg = compress(this.result,fileSize,$("#imgInfoBe"));
	         	// 将照片传到后台
	            uploadImg(this.result,'0');
	        };

	        reader.readAsDataURL(this.files[0]);

	        var fileSize = Math.round(this.files[0].size/1024/1024) ;
	    }, false);
		
		document.getElementById('imgAf').addEventListener('change', function () {

	        var reader = new FileReader();
	        
	        reader.onload = function (e) {
	            var compressImg = compress(this.result,fileSize,$("#imgInfoAf"));
	            // 将照片传到后台
	            uploadImg(this.result,'1');
	        };

	        reader.readAsDataURL(this.files[0]);

	        var fileSize = Math.round(this.files[0].size/1024/1024) ;
	    }, false);
		
	});
  	
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

  	        ctx.clearRect(0, 0, cvs.width, cvs.height);
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
  	
  	function uploadImg(imgBase64Data, type) {

        var pos = imgBase64Data.indexOf("4") + 2;
        imgBase64Data = imgBase64Data.substring(pos, imgBase64Data.length - pos);//去掉Base64:开头的标识字符
        
        var paramData = { 'base64StrImgData': imgBase64Data};
        
        $.ajax({
			type : "POST",
			contentType:'application/json',
			url : '${pageContext.request.contextPath}/powderOrder/addImage?type='+type+"&receiveId="+$("#hiddenReceiveId").val(),
			dataType : "json",
			async : false,
			data : JSON.stringify(paramData), 
			success : function(data) {
				
			},
			error : function(data) {
				
			}
		});
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

</style>
</head>
<!-- Head END -->


<!-- Body BEGIN -->
<body>
	<div class="x-header x-header-gray border-1px-bottom">
		<div class="x-header-btn ico-back"></div>
		<div class="x-header-title">
			<span><fmt:message key="ORDERLIST_TITLE" /></span>
		</div>
		<div class="x-header-btn"></div>
	</div>
	<div class="order-item-status border-top-show">
		${ detailInfo.orderStatusView }
	</div>
	
	<div class="bottom_margin">
	<div class="powder_detail_box_info">
		<c:forEach var="powderMike" items="${ detailInfo.powderMikeList }">
		<div class="powder_detail_item clearfix">
			<span class="powderName">${powderMike.powderBrand }</span>
			<span class="powderSpec">${powderMike.powderSpec }</span>
			<span class="powderNumber">X${powderMike.number }</span>
		</div>
		</c:forEach>
		<div class="detail_count"><fmt:message key="POWDER_DETAIL_LT" />${ detailInfo.pricecount }</div>
		<div class="detail_express">
			<fmt:message key="POWDER_DETAIL_EXPRESSNAME" />${ detailInfo.expressName }&nbsp;&nbsp;
		</div>
		<div class="total_amount"><fmt:message key="POWDER_DETAIL_TOTALAMOUNT" />${ detailInfo.totalAmount }</div>
		<div class="express_show">
			<a id="showExpress"><fmt:message key="POWDER_DETAIL_EXPRESS_INFO" /></a>
		</div>
		
	</div>
	
	<div class="powder_info_item clearfix">
		<span class="item_head_inf clearfix"><fmt:message key="POWDER_DETAIL_RECEIVEINFO" /></span>
		<span class="info_name">${ detailInfo.receiveName }</span>
		<span class="info_phone">${ detailInfo.receivePhone }</span>
		<span class="info_address">${ detailInfo.receiveAddress }</span>
	</div>
	
	<div class="powder_info_item">
		<span class="item_head_inf clearfix"><fmt:message key="POWDER_ITEM_RECEIVE" /></span>
		<div class="idCardDiv clearfix">
			<span class="idCard"><fmt:message key="POWDER_ITEM_RECEIVE_CARDNO" /></span>
			<span id="cardnumberLabel" class="cardnumberLabel">${detailInfo.receiveIdCard}</span>
			<i class="glyphicon glyphicon-wrench cardEdit" id="editCard"></i>
			<span class="idCardInMsg" id="editCardMsg"><fmt:message key="POWDER_ITEM_RECEIVE_POINT_INPUT" /></span>
			
			<input placeholder="<fmt:message key="POWDER_ITEM_RECEIVE_PLACEHLODER" />" id="cardInput" style="display:none" value="${detailInfo.receiveIdCard}"/>
			<i class="glyphicon glyphicon-ok cardConfirm" id="confirmCard" style="display:none"></i>
			<i class="glyphicon glyphicon-repeat cardClear" id="clearCard" style="display:none"></i>
		</div>
		<div class="clearfix">
			<div class="wrapper">
				<input type="file" accept="image/*;" capture="camera" id= "imgBe" class="input-upload-image">
				<c:if test="${ detailInfo.receiveCardPhoneBe == ''}">
					<img class="upload-btn events-pointer-none" src="${ctx}/images/img_upload.png" id="imgInfoBe">
				</c:if>
				<c:if test="${ detailInfo.receiveCardPhoneBe != ''}">
					<img class="upload-btn events-pointer-none" src="${detailInfo.receiveCardPhoneBe }" id="imgInfoBe">
				</c:if>
			</div>
			<div class="wrapper">
				<input type="file" accept="image/*;" capture="camera" id= "imgAf" class="input-upload-image">
				<c:if test="${ detailInfo.receiveCardPhoneAf == ''}">
					<img class="upload-btn events-pointer-none" src="${ctx}/images/img_upload.png" id="imgInfoAf">
				</c:if>
				<c:if test="${ detailInfo.receiveCardPhoneAf != ''}">
					<img class="upload-btn events-pointer-none" src="${detailInfo.receiveCardPhoneAf }" id="imgInfoAf">
				</c:if>
			</div>	
		</div>
		
	</div>
	
	<div class="powder_info_item clearfix">
		<span class="item_head_inf"><fmt:message key="POWDER_DETAIL_SENDINFO" /></span>
		<span class="info_name">${ detailInfo.senderName }</span>
		<span class="info_phone">${ detailInfo.senderPhone }</span>
	</div>
	
	<c:if test="${detailInfo.ifMsg == '1' || detailInfo.ifRemarks == '1'}">
		<div class="powder_info_item clearfix">
			<span class="item_head_inf"><fmt:message key="POWDER_DETAIL_ADDINFO" /></span>
			<c:if test="${detailInfo.ifMsg == '1'}">
				<span class="info_ifMsg"><fmt:message key="POWDER_DETAIL_RE_MSG" /></span>
			</c:if>
			<c:if test="${detailInfo.ifRemarks == '1'}">
				<span class="info_ifRemarks"><fmt:message key="POWDER_DETAIL_REMARK" />${ detailInfo.remarks }</span>
			</c:if>
		</div>
	</c:if>

	<div class="powder_info_item">
		<span class="item_head_inf"><fmt:message key="POWDER_DETAIL_EXPRESS_URL" /></span>
		<c:if test="${detailInfo.expressPhotoUrlExitFlg == '1' }">
			<img alt="expressImg" src="${detailInfo.expressPhotoUrl}" class="expressImg">
		</c:if>
		<c:if test="${detailInfo.expressPhotoUrlExitFlg != '1' }">
			<span class="phone_none">暂时快递单照片</span>
		</c:if>
	</div>
	
	
	
	<div class="powder_info_item">
		<span class="item_head_inf"><fmt:message key="POWDER_DETAIL_BOX_URL" /></span>
		<c:if test="${detailInfo.boxPhotoUrlsExitFlg == '1' }">
			<img alt="expressImg" src="${detailInfo.boxPhotoUrls}" class="expressImg">
		</c:if>
		<c:if test="${detailInfo.boxPhotoUrlsExitFlg != '1' }">
			<span class="phone_none">暂时无打包照片</span>
		</c:if>
	</div>
	
	
	
	<input type="hidden" value="${detailInfo.receiveId}" id="hiddenReceiveId">
	
	<input type="hidden" value="${detailInfo.receiveIdCard}" id="hiddenCardNo">
	
	<input type="hidden" value="${detailInfo.boxId}" id="hiddenBoxId">
	
	<input type="hidden" value="${detailInfo.elecExpressNo}" id="hiddenElecExpressNo">
	
	
	<div id="expressinfo-pop-up" class="modal fade" role="dialog" aria-hidden="true" >
    	<div class="modal-dialog item-dialog">
	      <div class="modal-content">
	         
	         <div class="modal-body">
	         	<div class="powder_purchase_select express_info_div">
					<ul id="expressInfoUL">
			            
			         </ul>
	           	</div>
	         </div>
	      </div>
    	</div>
    </div>
	</div>
	 <div style="height:0rem;">
    	&nbsp;
    </div>
</body>
<!-- END BODY -->
</html>