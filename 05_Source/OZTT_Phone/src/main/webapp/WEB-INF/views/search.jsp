<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title><fmt:message key="SEARCH_TITLE"/></title>
  <!-- Head END -->
  <script>
	  	function beforepage(){
			var hiddencurpage = $("#hiddencurpage").val();
			var hiddentotalPage = $("#hiddentotalPage").val();
			var hiddensearchcontent = $("#hiddensearchcontent").val();
			var hiddenclassId = $("#hiddenclassId").val();
			if (hiddencurpage > 1) {
				var page = hiddencurpage -1;
				var addParam = "&topPageUp="+$("#hiddentopPageUp").val() + "&hotFlg="+$("#hiddenhotFlg").val() + "&inStockFlg="+$("#hiddeninStockFlg").val();
				location.href = "${ctx}/search/init?classId="+hiddenclassId+"&searchcontent="+hiddensearchcontent+"&page="+page+addParam;
			}
			
	  	}
		function nextpage(){
			var hiddencurpage = $("#hiddencurpage").val();
			var hiddentotalPage = $("#hiddentotalPage").val();
			var hiddensearchcontent = $("#hiddensearchcontent").val();
			var hiddenclassId = $("#hiddenclassId").val();
			if (hiddencurpage < hiddentotalPage) {
				var page = parseInt(hiddencurpage) + 1;
				var addParam = "&topPageUp="+$("#hiddentopPageUp").val() + "&hotFlg="+$("#hiddenhotFlg").val() + "&inStockFlg="+$("#hiddeninStockFlg").val();
				location.href = "${ctx}/search/init?classId="+hiddenclassId+"&searchcontent="+hiddensearchcontent+"&page="+page+addParam;
			}	
		}
		function changepage(str){
			var selectPage = $(str).val();
			var hiddencurpage = $("#hiddencurpage").val();
			var hiddentotalPage = $("#hiddentotalPage").val();
			var hiddensearchcontent = $("#hiddensearchcontent").val();
			var hiddenclassId = $("#hiddenclassId").val();
			var addParam = "&topPageUp="+$("#hiddentopPageUp").val() + "&hotFlg="+$("#hiddenhotFlg").val() + "&inStockFlg="+$("#hiddeninStockFlg").val();
			location.href = "${ctx}/search/init?classId="+hiddenclassId+"&searchcontent="+hiddensearchcontent+"&page="+selectPage+addParam;
		}
		
		function itemFlyToCart(itemNumberObj) {
  	  		// flg 为1的时候，选择的是主页形式的
  			var offset = $("#bottomCart").offset();
  			var offsetAdd = $("#bottomCart").width();
  			var img = $(itemNumberObj).parent().parent().parent().parent().find("img").attr('src');
  			
  			var imgOffset = $(itemNumberObj).parent().parent().parent().parent().find("img").offset();
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
  					//left: offset.left+offsetAdd/2+(offset.left-startLeft),
  					left: offset.left+offsetAdd/2,
  					top: offset.top+offsetAdd/2,
  					width: 0,
  					height: 0
  				},
  				onEnd: function(){
  					this.destory();
  				}
  			});
  		}
		
	  	function checktoCart(groupId, currentObj){
			if ('${currentUserId}' == '') {
				location.href = "${ctx}/login/init";
			} else {
				addToCart(groupId, $(currentObj).parent().find("input[type='text']"));
			}
		}
	  	
	  	function searchGoods(){
	  		var searchKeyWords = $("#keyword").val();
	  		location.href = "${ctx}/search/init?searchcontent="+searchKeyWords;
	  	}
		
		
  </script>
  <style type="text/css">
	

	
  </style>
</head>

<!-- Body BEGIN -->
<body>
    <!--头部开始-->
	<div class="head_fix">
	    <div class="head user_head clearfix">
	        <a href="javascript:history.back(-1)" class="head_back"></a>
	        <c:if test="${'1' == showFlg}">
	        	搜索结果
	        </c:if>
	        <c:if test="${'1' != showFlg}">
	        	${viewcontent}
	        </c:if>
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
	    <div style="margin-bottom:10px;">
	    	<c:if test="${'1' == showFlg}">
	    		<div class="search_top">
		            <div class="search_top_main clearfix">
		                <input type="text" id="keyword" class="search_top_main_lf" value="${viewcontent}" placeholder="请输入搜索的相关产品名">
		                <input type="button" onclick="searchGoods()" class="right search_top_main_btn" value="">
		            </div>
	        	</div>
	    	</c:if>
	        <!--内容开始-->
	        <c:if test="${'1' != showFlg}">
	        <div class="index_pro_tl clearfix big_fenlei_tl one_tl">
	            <span class="left">${viewcontent}</span>
	        </div>
	        </c:if>
	        <ul class="big_fenlei_ul clearfix">
	        		<c:forEach var="subClassfication" items="${ SubClassficationList }">
	                <li>
	                    <a href="${ctx}/search/init?classId=${subClassfication.classid}" title="">
	                        <img src="${imgUrl}/category/${subClassfication.classid}.png" />
	                        <p>${subClassfication.classname }</p>
	                    </a>
	                </li>
	                </c:forEach>
	        </ul>
	    </div>
	
	    <div>
	        <div class="index_pro_tl clearfix big_fenlei_tl one_tl">
	            <span class="left">商品</span>
	        </div>
	        <div>
	            <ul class="clearfix search_main_ul">
	            		<c:forEach var="goods" items="${ goodsList.resultList }">
	                    <li>
	                        <div class="clearfix search_main_ul_main">
	                            <div class="search_main_img_con">
	                                <a href="${ctx}/item/getGoodsItem?groupId=${goods.groupno}" class="search_main_img">
	                                    <img src="${goods.goodsthumbnail}" />
	                                </a>
	                            </div>
	                            <div class="search_main_text">
	                                <p class="search_main_tl">
	                                    <a href="${ctx}/item/getGoodsItem?groupId=${goods.groupno}">
	                                        ${goods.goodsname }
	                                    </a>
	                                </p>
	                                <div class="clearfix search_bt">
	                                    <span class="left search_main_price color_red">
	                                        ${goods.disprice }
	                                    </span>
	                                    <div class="clearfix sum left">
	                                        <a class="min left" data-id="${goods.groupno}"></a>
	                                        <input class="text_box left" id="number_798" data-id="${goods.groupno}" name="" type="text" value="1" pattern="[0-9]*" maxlength="2" size="4"/>
	                                        <a class="add left" data-id="${goods.groupno}"></a>
	                                    </div>
	                                        <a href="javascript:void(0);" onclick="checktoCart('${goods.groupno}',this)" class="buy_ico right gouwuico" data-id="${goods.groupno}"></a>
	                                </div>
	                            </div>
	                        </div>
	                    </li>
	                    </c:forEach>
	            </ul>
	        </div>
	        <input type="hidden" value="${searchcontent}" id="hiddensearchcontent"/>
	        <input type="hidden" value="${classId}" id="hiddenclassId"/>
	        
	        <input type="hidden" value="${topPageUp}" id="hiddentopPageUp"/>
	        <input type="hidden" value="${hotFlg}" id="hiddenhotFlg"/>
	        <input type="hidden" value="${inStockFlg}" id="hiddeninStockFlg"/>
	        
	        <c:if test="${goodsList.totalPage > 1 }">
	        <div style="" class="pagenav-wrapper" id="J_PageNavWrap">
	                <div class="pagenav-content">
	                    <div class="pagenav" id="J_PageNav">
	                        <div class="p-prev p-gray">
	                                <a href="#" onclick="beforepage()">上一页</a>
	                        </div>
	                        <div class="pagenav-cur" style="vertical-align:bottom">
	                            <div class="pagenav-text">
	                            	<span> ${goodsList.currentPage } / ${goodsList.totalPage } </span><i></i> 
	                            </div>
	                            <select class="pagenav-select" onchange="changepage(this)">
	                            	<c:forEach begin="1" end="${goodsList.totalPage }" step="1" varStatus="status">
	                            		<c:if test="${status.count == goodsList.currentPage }">
	                            			<option selected="selected" value="${status.count }">第 ${status.count } 页</option>
	                            		</c:if>
	                            		<c:if test="${status.count != goodsList.currentPage }">
	                            			<option value="${status.count }">第 ${status.count } 页</option>
	                            		</c:if>
	                            	</c:forEach>
	                            </select>
	                        </div>
	                        <div class="p-next">
	                                <a href="#" title="下一页" onclick="nextpage()">下一页</a>
	                        </div>
	                        <input type="hidden" value="${goodsList.currentPage}" id="hiddencurpage"/>
	                        <input type="hidden" value="${goodsList.totalPage}" id="hiddentotalPage"/>
	                        
	                    </div>
	                </div>
	        </div>
	        </c:if>
	    </div>
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
	<script type="text/javascript">
	    $(document).ready(function () {
	        
	        $(".add").click(function () {
	            productId = $(this).attr("data-id");
	            textInput = $("input[data-id=" + productId + "]");
	
	            quantity = isNaN(textInput.val()) ? 1 : parseInt(textInput.val());
	            textInput.val(quantity + 1);
	        })
	        $(".min").click(function () {
	            productId = $(this).attr("data-id");
	            textInput = $("input[data-id=" + productId + "]");
	
	            quantity = isNaN(textInput.val()) ? 1 : parseInt(textInput.val());
	            textInput.val(quantity - 1);
	            if (parseInt(textInput.val()) < 0) {
	                textInput.val(0);
	            }
	        })
	    })
	</script>
</body>
<!-- END BODY -->
</html>