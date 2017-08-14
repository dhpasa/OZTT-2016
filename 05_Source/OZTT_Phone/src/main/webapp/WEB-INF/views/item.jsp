<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title><fmt:message key="ITEM_TITLE"/></title>
  
  <!-- Head END -->
  <script>	

		  function itemFlyToCart(itemNumberObj) {
	  			var offset = $(".pro_footer_car").offset();
	  			var offsetAdd = $(".pro_footer_car").width();
	  			var img = $(".shangpin_img").find("img").attr('src');
	  			
	  			var imgOffset = $(".shangpin_img").find("img").offset();
	  			var startLeft = imgOffset.left;
	  			var locationTop = imgOffset.top;
	  			var bodyScrollTop = $("body").scrollTop();
	  			var flyer = $('<img class="u-flyer" src="'+img+'">');
	  			flyer.fly({
	  				start: {
	  					left: startLeft,
	  					top: (locationTop-bodyScrollTop)
	  				},
	  				end: {
	  					left: offset.left+offsetAdd/2+(offset.left-startLeft),
	  					//left: offset.left+offsetAdd/2,
	  					top: offset.top+offsetAdd/2,
	  					width: 0,
	  					height: 0
	  				},
	  				onEnd: function(){
	  					this.destory();
	  				}
	  			});
	  		}
		
		
		function checkGoodsNum(str) {
			if ($(str).val().trim() == "" || isNaN($(str).val())) {
				$(str).val("1");
			}
		}
		
		function checktoCart(groupId, currentObj){
			if ('${currentUserId}' == '') {
				location.href = "${ctx}/login/init";
			} else {
				addToCart(groupId, $("#item_number"));
			}
		}
		
		
		
  </script>
  <style type="text/css">
  	
	
	
  </style>
</head>


<!-- Body BEGIN -->
<body data-pinterest-extension-installed="ff1.37.9">

	<div class="head_fix">
	    <!--头部开始-->
	    <div class="head user_head clearfix">
	        <a href="javascript:history.back(-1)" class="head_back"></a>
	        <div class="pro_menu">
	            <div class="pro_menu_main" style="margin-left:0px; margin-right: 0px;">
	                <a href="javascript:;" class="ahover">商品</a>
	                <a href="javascript:;">详情</a>
	            </div>
	        </div>
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
		<form action="${ctx}/search/init" method="post">        
			<div class="search_top">
		            <div class="search_top_main clearfix">
		                <input type="text" id="keyword" name="searchcontent" class="search_top_main_lf" placeholder="请输入搜索的相关产品名" />
		                <input type="submit" class="right search_top_main_btn" value="" />
		            </div>
		        </div>
		</form>
		</div>
		
		<div class="main" style="padding-top: 80px;padding-bottom:0px;">
    <!--内容开始-->
    <div class="pro_main">
        <div class="pro_qiehuan active">
            <div class="shangpin_img">
                <img src="${goodItemDto.firstImg }" />
            </div>
            <div class="caixian"></div>
            <div class="shangpin_tl">
                <div class="shangpin_tl_main">
                    <div class="shangpin_tl_con">
                        ${goodItemDto.goods.goodsname }
                        <input type="hidden" id="productId" value="1510" />
                    </div>
                </div>
                
            </div>
            <div class="shangpin_mess">
                <div class="shangpin_mess_text">
                    ${goodItemDto.goods.goodsname }
                </div>
                <div class="shangpin_mess_price">
                        <p>
                            <span class="shangpin_mess_price_name">售价：</span>
                            <span class="color_red price">$ ${goodItemDto.nowPrice }</span>
                        </p>
                </div>
            </div>
            <div class="shangpin_buy">
                <div class="shangpin_zhongliang">
                    <!-- <span>重量：1.7370 克</span> -->
                    <c:if test="${goodItemDto.stockStatus != '4'}">
                    	<span>可售库存：有货</span>
                    </c:if>
                    <c:if test="${goodItemDto.stockStatus == '4'}">
                    	<span>可售库存：缺货</span>
                    </c:if>
                    <!-- <span>可获积分：20</span> -->
                </div>
                <div class="shangpin_do clearfix">
                    <div class="right clearfix">
                        <span class="left">最大购买：${goodItemDto.groupMax-goodItemDto.groupCurrent }</span>
                        <div class="left clearfix shangpin_jiajian">
                            <span class="left">数量</span>
                            <div class="clearfix sum left">
                                <button class="min left" data-id="1510"></button>
                                <input class="text_box left" id="item_number" data-id="1510" name="" type="text" value="1" pattern="[0-9]*" maxlength="2" size="4">
                                <button class="add left" data-id="1510"></button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div id="pro_desc" class="pro_qiehuan">
            <div class="pro_tl clearfix">
                <span class="left">商品信息</span>
                
            </div>
            <div class="pro_con">
                <table id="product-attribute-specs-table" class="table">
				<tbody>
				<tr class="additional-tr">
				<th class="data product-table-column" style="width: 81px;">品牌国</th>
				<td class="data product-table-value">澳大利亚</td>
				<tr class="additional-tr">
				<th class="data product-table-column" style="width: 81px;">产品英文名</th>
				<td class="data product-table-value">${goodItemDto.goods.goodsname }</td>
				</tr>
				<c:if test='${goodItemDto.goods.goodsnameen != null && goodItemDto.goods.goodsnameen != "" }'>
					<tr class="additional-tr">
					<th class="data product-table-column" style="width: 81px;">品牌英文名</th>
					<td class="data product-table-value">${goodItemDto.goods.goodsnameen }</td>
					</tr>
				</c:if>
				
				</tbody>
				</table>

				${goodItemDto.productDesc}
            </div>
        </div>
        <div class="pro_qiehuan">

            <div class="pengyouquan">
                
            </div>

        </div>
    </div>
</div>

<!--产品详情底部-->
<div class="pro_footer clearfix">
    <div class="left pro_footer_lf">
       	<span class="pro_footer_lf_main clearfix">
            <a href="#chatQRcode" data-toggle="modal" class="pro_kefu left"></a>
            <span class="pro_footer_line left"></span>
            <a href="javascript:void(0);" class="pro_weibu left"></a>
            <div id="chatQRcode" class="modal fade"> <!--半透明的遮罩层-->
                  <div class="modal-dialog"> <!--定位和尺寸-->
                      <div class="modal-content">  <!--背景边框阴影-->
                          <div class="modal-body">
                              <img src="${ctx}/images/oztt_qrcode.png" alt="" height="250">
                          </div>
                      </div>
                  </div>
              </div>
        </span>
        <a href="${ctx}/shopcart/init" class="pro_footer_car">
            <div class="pro_footer_car_main">
                <img src="${ctx}/picture/gouwudai.png" />
                <span class="num" id="ecsCartInfo"></span>
            </div>
        </a>
    </div>
    <a href="javascript:void(0);" style="width:50%;" class="left btn_red pro_footer_a" id="addtocart" onclick="checktoCart('${goodItemDto.groupId}',this)" >加入购物袋</a>
    
</div>
    <!--弹窗开始-->
<div class="clearfix" style="margin-bottom: 100px;" id="outsideAlertView">
    <div class="verify out_alert alert">
        <div class="alert_btn">
            <b><a href="javascript:void(0)" id="alertConfirm" class="verify_btn color_red"></a></b>
        </div>
    </div>
    <!--加载中-->
    <div class="alert_bg"></div>
    <div class="loading">
        <div class="loading_con">
            <img src="${ctx}/picture/loading.png" />
            <p>
                玩命加载中……
            </p>
        </div>
    </div>
</div>


<script>
    //lazy load description images
    $(function () {
        $(".pro_con").css("min-height", function () {
            return $(window).height() + 1;
        });
        $(".img-product-desc").unveil();
        var observer = new MutationObserver(function (mutations) {
            $('html, body').animate({ scrollTop: 1 }, "fast");
            $('html, body').animate({ scrollTop: 0 }, "fast");
        });
        var target = document.querySelector('#pro_desc');
        observer.observe(target, {
            attributes: true
        });
    });
</script>

    <script type="text/javascript">
        
    </script>
	
    <%-- <div class="x-header x-header-gray border-1px-bottom x-fixed">
		<div class="x-header-btn"></div>
		<div class="x-header-btn"></div>
		<div class="x-header-title">
			<span><fmt:message key="ITEM_TITLE" /></span>
		</div>
		<div class="x-header-btn icon-shopcart" id="navCartIcon" onclick="toShopCart()">
			<span id="itemShopCart" style="display:none"></span>
		</div>
		<div class="x-header-btn icon-search"></div>
	</div>
	
	<div class="flexslider border-top-show item_flexslider">
  		<ul class="slides">
  			<c:forEach var="imgList" items="${ goodItemDto.imgList }" varStatus="status">
    			<li><img src="${imgList}" class="padding-2rem"/></li>
    		</c:forEach>
  		</ul>
   </div>
   
   <div class="iteminfo">
   		<div>
   			<span class="item-goodsname" id="item-goodsname-id">${ goodItemDto.goods.goodsname}</span>
   		</div>
   		<div>
   			<span class="item-disprice" id="item-disprice-id">
   				<span><fmt:message key="COMMON_DOLLAR" /></span>${goodItemDto.disPrice}
   			</span>
   			<span class="item-nowprice"><fmt:message key="COMMON_DOLLAR" />${ goodItemDto.nowPrice}</span>
   		</div>
   		
   		<c:if test="${not empty goodItemDto.goodsTabs}">
   			<div class="border-top-show tabarea tabInfo">
	   		<c:forEach var="tabList" items="${ goodItemDto.goodsTabs }">
	   			<span class="item-label" onclick="toShowTabGoods('${tabList.id}')">${tabList.tabname}</span>
	   		</c:forEach>
	   		</div>
   		</c:if>
   		
   		<c:if test="${goodItemDto.isStock == '1' || goodItemDto.diamondShowFlg == '1'}">
   		<div class="border-top-show height3">
   			<c:if test="${goodItemDto.stockStatus == '1' }">
				<span class="stock_1"><fmt:message key="COMMON_STOCK_1" /></span>
			</c:if>
			<c:if test="${goodItemDto.stockStatus == '2' }">
				<span class="stock_2"><fmt:message key="COMMON_STOCK_2" /></span>
			</c:if>
			<c:if test="${goodItemDto.stockStatus == '3' }">
				<span class="stock_3"><fmt:message key="COMMON_STOCK_3" /></span>
			</c:if>
			<c:if test="${goodItemDto.stockStatus == '4' }">
				<span class="stock_4"><fmt:message key="COMMON_STOCK_4" /></span>
			</c:if>
   		</div>
   		</c:if>
   		<c:if test="${goodItemDto.isStock != '1' && goodItemDto.diamondShowFlg != '1'}">
   			<div class="border-top-show height3">
	   			<span class="item-timeword forceFloatLeft"><fmt:message key="ITEM_TIME" /></span>
	   			<c:if test="${goodItemDto.isTopPage == '1'}">
	   				<div class="cuntdown item-countdown" data-seconds-left="${goodItemDto.countdownTime}" data-isrush="1"></div>
	   			</c:if>
	   			<c:if test="${goodItemDto.isTopPage != '1'}">
	   				<div class="cuntdown item-countdown" data-seconds-left="${goodItemDto.countdownTime}"></div>
	   			</c:if>
	   			
	   		</div>
	   		
	   		<div class="border-top-show" style="padding:0.5rem 0">
	   			<i class="main-hasBuy" style="float: left"></i>
	   			<c:if test="${goodItemDto.isTopPage == '1'}">
	   				<span class="item-timeword"><fmt:message key="ITEM_HASRUSHBUY" /></span>&nbsp;
	   			</c:if>
	   			<c:if test="${goodItemDto.isTopPage != '1'}">
	   				<span class="item-timeword"><fmt:message key="ITEM_HASBUY" /></span>&nbsp;
	   			</c:if>
	   			<span class="">${goodItemDto.groupCurrent}&nbsp;/&nbsp;${goodItemDto.groupMax}</span>
	   		</div>
   		</c:if>
   </div>
   
   <div class="product-page-content">
      <ul id="myTab" class="nav nav-tabs">
        <li class="active"><a href="#Description" data-toggle="tab"><fmt:message key="ITEM_DESC"/></a></li>
        <li><a href="#Information" data-toggle="tab"><fmt:message key="ITEM_INFO"/></a></li>
        <li><a href="#Reviews" data-toggle="tab"><fmt:message key="ITEM_RULE"/></a></li>
      </ul>
      <div id="myTabContent" class="tab-content">
      	<div class="tab-pane fade in active" id="Description">
          	${goodItemDto.productDesc}
        </div>
        <div class="tab-pane fade" id="Information">
          	${goodItemDto.productInfo}
        </div>
        <div class="tab-pane fade" id="Reviews">
          	${goodItemDto.sellerRule}
        </div>
      </div>
    </div>
    
    <div class="item-btn">
    	<div class="item-btn-nav">
    		<a href="${ctx}/main/init" class="main-nav-item main-nav-home main-nav-active">
				<img alt="home" src="${ctx}/images/main.png">
				<span><fmt:message key="DECORATOR_MAIN"/></span>
			</a>
    		<a href="${ctx}/user/init" class="main-nav-item main-nav-profile " style="position: relative;">
				<img alt="me" src="${ctx}/images/me.png">
				<span><fmt:message key="DECORATOR_ME"/></span>
				<span class="notSuccessedOrder" id="notSuccessedOrder"></span>
			</a>
    	</div>
    	
    	<div class="item-btn-btn">
    		<c:if test="${goodItemDto.diamondShowFlg != '1'}">
    			<c:if test="${goodItemDto.isStock != '1'}">
    				<c:if test="${IS_END == '1' }">
    					<c:if test="${goodItemDto.isTopPage == '1'}">					
    						<a class="canNotBuy"><fmt:message key="ITEM_RUSHOVER"/></a>
    					</c:if>
    					<c:if test="${goodItemDto.isTopPage != '1'}">
    						<a class="canNotBuy"><fmt:message key="ITEM_ISEND"/></a>
    					</c:if>
			    	</c:if>
			    	<c:if test="${IS_END != '1' }">
			    		<c:if test="${IS_OVER != '1' }">
			    			<a onclick="checktoItem('${goodItemDto.groupId}')" class="canBuy"><fmt:message key="ITEM_ADDTOCART"/></a>
				    	</c:if>
				    	<c:if test="${IS_OVER == '1' }">
				    		<c:if test="${goodItemDto.isTopPage == '1'}">					
	    						<a class="canNotBuy"><fmt:message key="ITEM_RUSHOVER"/></a>
	    					</c:if>
	    					<c:if test="${goodItemDto.isTopPage != '1'}">
	    						<a class="canNotBuy"><fmt:message key="ITEM_ISEND"/></a>
	    					</c:if>
				    	</c:if>
			    	</c:if>
    			</c:if>
    			<c:if test="${goodItemDto.isStock == '1'}">
    					<c:if test="${IS_OVER != '1' }">
			    			<a onclick="checktoItem('${goodItemDto.groupId}')" class="canBuy"><fmt:message key="ITEM_ADDTOCART"/></a>
				    	</c:if>
				    	<c:if test="${IS_OVER == '1' }">
				    		<a class="canNotBuy"><fmt:message key="COMMON_STOCK_4"/></a>
				    	</c:if>
    			</c:if>
    		</c:if>
    		<c:if test="${goodItemDto.diamondShowFlg == '1'}">
    			<a class="canNotBuyDiamond"><fmt:message key="DIAMOND_CAN_NOT_BUY"/></a> 		
    		</c:if>
    	</div>
    </div>
    
    <div id="purchase-credit-pop-up" class="modal fade" role="dialog" aria-hidden="true" >
    	<div class="modal-dialog item-dialog">
	      <div class="modal-content">
	         
	         <div class="item-modal-body">
	         	<div class="item-modal-img">
	         		<img src="${goodItemDto.firstImg}" class="item-dialog-img" id="itemFlyImg"/>
	         	</div>
	         	<div class="item-modal-value">
	           		<div class="item-goods-quantity">
						<span class="minus"><i class="fa fa-minus valuemius"></i></span>	
						<span class="txt" id="goodsnum">
							<input type="text" value="1" maxlength="4" pattern="[0-9]*" class="item-num-input" id="itemNumber" onblur="checkGoodsNum(this)"/>
						</span>
						<span class="add"><i class="fa fa-plus valueplus"></i></span>
					</div>
	           	</div>
	           	<div class="item-modal-confirm">
		            <a onclick="addToCart('${goodItemDto.groupId}')" id="addcartBtn"><fmt:message key="COMMON_CONFIRM"/></a>
	           	</div>
	           	
	         </div>
	      </div>
    	</div>
    </div>

    <script type="text/javascript">
		$(function() {
		    $(".flexslider").flexslider({
				slideshowSpeed: 4000, //展示时间间隔ms
				animationSpeed: 400, //滚动时间ms
				directionNav:false,
				touch: true //是否支持触屏滑动
			});
		});	
		
		$('.cuntdown').startTimer({
    		
    	});
		
		var sessionUserId = '${currentUserId}';
		if (sessionUserId != null && sessionUserId.length > 0) {
			updateItemShopCart();
			$("#itemShopCart").css("display","");
		} 

	</script> --%>
</body>
<!-- END BODY -->
</html>