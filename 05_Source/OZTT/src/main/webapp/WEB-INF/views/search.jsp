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
			if (parseInt(hiddencurpage) > 1) {
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
			if (parseInt(hiddencurpage) < parseInt(hiddentotalPage)) {
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
    <!-- 主内容-->
<div class="muying_fenlei">
    <div class="muying_fenlei_main clearfix">
    	<c:if test="${'1' != showFlg}">
        <span class="left muying_fenlei_name">
            ${viewcontent}
        </span>
        </c:if>
        <div class="right">
        		<c:forEach var="subClassfication" items="${ SubClassficationList }">
                <a href="${ctx}/search/init?classId=${subClassfication.classid}">${subClassfication.classname } </a>
                &nbsp;| &nbsp;
                </c:forEach>
        </div>
    </div>
</div>




<!--搜索条件-->

<!-- 精选-->
<div class="jingxua">
    <div class="index_con_same">
        <ul class="jingxuan_ul clearfix jz">
        		<c:forEach var="goods" items="${ goodsList.resultList }">
                <li>
                    <div class="jingxuan_main">
                        <a href="${ctx}/item/getGoodsItem?groupId=${goods.groupno}" class="jingxuan_img">
                            <img src="${goods.goodsthumbnail}" />
                        </a>
                        <p class="jingxuan_tl">
                            <a href="${ctx}/item/getGoodsItem?groupId=${goods.groupno}">${goods.goodsname }</a>
                        </p>
                        
                        <div class="clearfix jingxuan_b">
                            <div class="left jingxuan_lf">
                                <p class="jingxuan_money">
                                    $${goods.disprice }
                                </p>
                                
                                <div class="clearfix sum">
                                    <button class="min left" data-id="${goods.groupno}"></button>
                                    <input class="text_box left" id="number_798" data-id="${goods.groupno}" value="1" type="text" pattern="[0-9]*" maxlength="2" size="4">
                                    <button class="add left" data-id="${goods.groupno}"></button>
                                </div>

                            </div>
                            <a href="javascript:void(0);" onclick="checktoCart('${goods.groupno}',this)" class="jingxuan_buy" data-id="${goods.groupno}"></a>
                        </div>
                    </div>
                </li>
                </c:forEach>
        </ul>
        	<input type="hidden" value="${searchcontent}" id="hiddensearchcontent"/>
	        <input type="hidden" value="${classId}" id="hiddenclassId"/>
	        
	        <input type="hidden" value="${topPageUp}" id="hiddentopPageUp"/>
	        <input type="hidden" value="${hotFlg}" id="hiddenhotFlg"/>
	        <input type="hidden" value="${inStockFlg}" id="hiddeninStockFlg"/>
	        <c:if test="${goodsList.totalPage > 1 }">
	        <div class="page">
                    <a href="#" onclick="beforepage()">上一页</a>
             		<span> ${goodsList.currentPage } / ${goodsList.totalPage } </span>
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
                     <a href="#" title="下一页" onclick="nextpage()">下一页</a>
                     <input type="hidden" value="${goodsList.currentPage}" id="hiddencurpage"/>
	                 <input type="hidden" value="${goodsList.totalPage}" id="hiddentotalPage"/>
        	</div>
        	</c:if>
    </div>
</div>



<script type="text/javascript">
   
</script>
	
</body>
<!-- END BODY -->
</html>