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
            <a href="/Order?orderStatus=0" class="ahover">
                <img src="images/yonghuzhongxin/dingdan.png" class="img_q" />
                <img src="images/yonghuzhongxin/dingdanh.png" class="img_h" />
                <span class="user_center_link">我的订单</span>
            </a>
        </li>
        <li>
            <a href="/User/RewardPoints" class="">
                <img src="images/yonghuzhongxin/jifen.png" class="img_q" />
                <img src="images/yonghuzhongxin/jifenh.png" class="img_h" />
                <span class="user_center_link">积分记录</span>
                <span class="jifenshu" id="points"></span>
            </a>
        </li>
        
        <li>
            <a href="/User/UserProfile?orderStatus=1" class="">
                <img src="images/yonghuzhongxin/xinxi.png" class="img_q" />
                <img src="images/yonghuzhongxin/xinxih.png" class="img_h" />
                <span class="user_center_link">会员信息</span>
            </a>
        </li>
        <li>
            <a href="/User/ConsigneeList" class="">
                <img src="images/yonghuzhongxin/shoujianren.png" class="img_q" />
                <img src="images/yonghuzhongxin/shoujianrenh.png" class="img_h" />
                <span class="user_center_link">收件人管理</span>
            </a>
        </li>
        <li>
            <a href="/User/SenderList" class="">
                <img src="images/yonghuzhongxin/fajianren.png" class="img_q" />
                <img src="images/yonghuzhongxin/fajianrenh.png" class="img_h" />
                <span class="user_center_link">寄件人管理</span>
            </a>
        </li>
        <!--<li>
            <a href="/User/AccountDetail" class="">
                <img src="images/yonghuzhongxin/yue.png" class="img_q" />
                <img src="images/yonghuzhongxin/yueh.png" class="img_h" />
                <span class="user_center_link">账户余额</span>
                <span class="jifenshu" id="balance"></span>
            </a>
        </li>-->
        <li>
            <a href="javascript:void(0)" id="outBtn">
                <img src="images/yonghuzhongxin/out.png" class="img_q" />
                <img src="images/yonghuzhongxin/outh.png" class="img_h" />
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

<form action="/Login/LogOut" id="logoutform" method="post"><input name="__RequestVerificationToken" type="hidden" value="-K5Ywq1RmJ-PjArnSz13gV0kJYznzjavW1gCxiyMVYoGuw73Aj0BMJtTgZPd3Xu_A3Lh6wEIh-LE0-rngMCoWvu-swZONYKlT9N3tTAKWlml-dBaAjjdTHL0zoZBRsCzPpwl25yLS1COoKKRPNNveA2" /></form>

<script>
    $(document).ready(function () {
        $.ajax({
            url: "/User/GetBalanceInfoJson",
            type: "POST",
            dataType: "JSON",
            success: function (result) {
                $("#points").text(result.RewardsPoints + "积分");
                $("#balance").text("$" + Number(result.AccountBalance.toFixed(2)));
            }
        });
    });
</script>

<script type="text/javascript" src="/Js/otherfuncs.js"></script>

        <div class="right help_rt">
            <div class=" clearfix jiesuan_tl">
    <span class="left jiesuan_tl_lf">
        订单信息
    </span>
    <div class="right order_tl_a">
        <a href="javascript:void(0);" class="color_blue">
            等待处理
        </a>
            <a href="javascript:void(0);" class="color_red">未付款</a>
        
    </div>
</div>
<div class="clearfix jiesuan_main order_mess">
    <p class="mt10">
        <span class="mr50">订单号：101291  </span><span> 订单日期： 12/06/2017 13:54</span>
    </p>
    <p> 备注： EWE - Web订单
</p>
</div>


                <!--<div class=" clearfix jiesuan_tl">
                    <span class="left jiesuan_tl_lf">
                        收件人信息
                    </span>
                </div>
                <div class="clearfix jiesuan_main">
                    <div class="jiesuan_main_permess">
                        

                            <div class="clearfix mb20">
                                <div class="left dingdan_text_gp_main mr50">
                                    <img src="images/yonghuzhongxin/fajianren.png">
                                    <span>寄件人：陆城城 15295105536</span>
                                </div>
                            </div>
                            <div class="clearfix mb20">
                                <div class="left dingdan_text_gp_main mr50">
                                    <img src="images/yonghuzhongxin/xingming.png">
                                    <span>收件人：<b>测试</b></span>
                                </div>
                                <div class="left dingdan_text_gp_main">
                                    <img src="images/yonghuzhongxin/shouji.png" />
                                    <span>手机：15295105536 </span>
                                </div>
                            </div>
                            <div class="clearfix mb20">
                                <div class="left dingdan_text_gp_main mr50">
                                    <img src="images/yonghuzhongxin/dizhi.png">
                                    <span> 地址：江苏省 泰州市 泰兴人才科技广场 </span>
                                </div>
                            </div>
                    </div>
                </div>-->
                <ul class="order_pro_ul">
                    <li class="clearfix">
                        <a href="/Product/caprilac-goat-milk-powder-1kg" class="order_pro_ul_img left">
                            <img src="picture/0000307_blackmores-evening-primerose-oil-190.jpeg" />
                        </a>
                        <div class="left order_pro_ul_tl">
                            <a href="/Product/caprilac-goat-milk-powder-1kg">
                                Caprilac  成人羊奶粉 1kg
                            </a>
                        </div>
                        <div class="right order_pro_ul_price">
                            <p class="mt10">$26.95</p>
                            <p>X 1</p>
                        </div>
                    </li>
                    <li class="clearfix">
                        <a href="/Product/a2-step-1-900g" class="order_pro_ul_img left">
                            <img src="picture/0000307_blackmores-evening-primerose-oil-190.jpeg" />
                        </a>
                        <div class="left order_pro_ul_tl">
                            <a href="/Product/a2-step-1-900g">
                                A2 Platinum 白金婴幼儿奶粉 1段 900g
                            </a>
                        </div>
                        <div class="right order_pro_ul_price">
                            <p class="mt10">$34.50</p>
                            <p>X 1</p>
                        </div>
                    </li>
                </ul>
    <ul class="qian_shuoming">
        <li class="clearfix">
            <div class="left">
                <img src="images/order_con/bendanjifen.png" /> 本单积分
            </div>
            <div class="right">61分</div>
        </li>
        <!--<li class="clearfix">
            <div class="left">
                <img src="images/order_con/yunfeibucha.png" /> 运费补差
            </div>
            <div class="right">0分</div>
        </li>-->
    </ul>

<ul class="qian_shuoming">
    <li class="clearfix">
        <div class="left">
            <img src="images/jiesuan/zongfen.png" /> 商品总价
        </div>
        <div class="right">$61.45</div>
    </li>
    <li class="clearfix">
        <div class="left">
            <img src="images/jiesuan/yunfei.png" /> 运费（国际快递）
        </div>
        <div class="right">
 $11.24         </div>
    </li>


    
    
</ul>

<div class=" clearfix jiesuan_tl suan bg_white">
    <div class="right clearfix">
        <div class="left"><span class="font18"><b>实付款：</b></span>
            <span class="color_red">
                <span class="font28"><b>
                        $72.69
                </b></span>
            </span>
        </div>
            <a class="btn_red suanbtn" href="/Purchase/OrderPayment?orderId=101291">立即付款</a>
            
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
        <th>打包照片</th>
        <th>查看物流</th>
    </tr>
    <tr>
        <td>
            <div class="container">
                <a href="#my-modal" data-toggle="modal">1233221</a>
            </div>
            <!--固定定位的模态框-->
            <div id="my-modal" class="modal fade"> <!--半透明的遮罩层-->
                <div class="modal-dialog"> <!--定位和尺寸-->
                    <div class="modal-content">  <!--背景边框阴影-->
                        <div class="modal-header">
                            <span class="close" data-dismiss="modal">×</span>
                        </div>
                        <div class="modal-body">12332215646515645123</div>

                    </div>
                </div>
            </div>
        </td>
        <td>
            赵忠
        </td>
        <td>
						<div class="container">
                <a href="#my-modal2" data-toggle="modal">这是身份证</a>
            </div>
            <!--固定定位的模态框-->
            <div id="my-modal2" class="modal fade"> <!--半透明的遮罩层-->
                <div class="modal-dialog"> <!--定位和尺寸-->
                    <div class="modal-content">  <!--背景边框阴影-->
                        <div class="modal-header">
                            <span class="close" data-dismiss="modal">×</span>
                        </div>
                        <div class="modal-body">这是一份身份证</div>

                    </div>
                </div>
            </div>
				</td>
        <td>
            <div class="container">
                <a href="#my-modal3" data-toggle="modal">打包图片</a>
            </div>
            <!--固定定位的模态框-->
            <div id="my-modal3" class="modal fade"> <!--半透明的遮罩层-->
                <div class="modal-dialog"> <!--定位和尺寸-->
                    <div class="modal-content">  <!--背景边框阴影-->
                        <div class="modal-header">
                            <span class="close" data-dismiss="modal">×</span>
                        </div>
                        <div class="modal-body">图片</div>

                    </div>
                </div>
            </div>
        </td>
        <td>
            <div class="container">
                <a href="#my-modal1" data-toggle="modal">物流消息</a>
            </div>
            <!--固定定位的模态框-->
            <div id="my-modal1" class="modal fade"> <!--半透明的遮罩层-->
                <div class="modal-dialog"> <!--定位和尺寸-->
                    <div class="modal-content">  <!--背景边框阴影-->
                        <div class="modal-header">
                            <span class="close" data-dismiss="modal">×</span>
                        </div>
                        <div class="modal-body">您的快件,还没发货,稍等片刻</div>

                    </div>
                </div>
            </div>
        </td>
    </tr>
</table>
<!--<div class="clearfix jiesuan_tl">
    <span class="left jiesuan_tl_lf">
        发货图片
    </span>
</div>-->
<div class="jiesuan_main clearfix fahuo">
    <ul id="parcelimages" class="clearfix">
    </ul>
</div>

<script src="/bundles/fancybox?v=HaeDS5phKmcs-r0xcWE3wk_4tpeQiNX5S2OCqQWwOek1"></script>

<script>
    jQuery(document).ready(function ($) {
        //var viewer = new Viewer(document.getElementById('parcelimages'),
        //    {
        //        rotatable: false,
        //        scalable: false,
        //        url: 'data-original'
        //    });

        $(".fancybox").fancybox({
            margin: [50, 100, 50, 50],
            openEffect: "none",
            closeEffect: "none",
            nextEffect: "none",
            prevEffect: "none"
        });

    });

		</script>
            <script>
                $('#test5').on('click', function(){
                    layer.tips('Hello tips!', '#test5');
                });
            </script>

            <div class="order_back">
                <a href="/Order">返回订单列表</a>
            </div>
        </div>
    </div>
</div>
</body>
<!-- END BODY -->
</html>