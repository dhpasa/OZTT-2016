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
<body>

<!-- 主内容-->
<div class="main">
    <div class="pro_tl">
        <div class="jz">
            
            <a href="#"> ${goodItemDto.goods.goodsname }</a>
        </div>
    </div>
    <div class="pro_con_t">
        <div class="clearfix jz">
            <div class="left">
                <div id="preview">
                    <div class="jqzoom" id="spec-n1">
                        <img src="${goodItemDto.firstImg }" />
                    </div>
                    <div id="spec-n5" style="margin-top:10px;">
                        <div id="spec-list">
                            <ul class="list-h">
                                 <li class="lih">
                                 	<img src="${goodItemDto.firstImg }" />
                                 </li>
                            </ul>
                        </div>
                        
                    </div>
                </div>
            </div>
            <div class="right pro_con_t_rt">
                <div class="pro_con_t_rt_from clearfix">
                    <span class="left">来自：澳新</span>
                    
                </div>
                <div class="pro_con_t_rt_tl">
                    ${goodItemDto.goods.goodsname }
                </div>
                <div class="pro_con_t_rt_xinx">
                    
                </div>
                <ul class="clearfix pro_money_ul">
                    <li>价格：<span class="color_red bold">$${goodItemDto.disPrice }</span></li>
                </ul>
                <div class="clearfix pro_num">
                    <span class="left maxPurchaseNum">最大购买： ${goodItemDto.groupMax-goodItemDto.groupCurrent }</span>
                    <span class="left">数量  </span>
                    <div class="clearfix sum left">
                        <button class="min left cursor" data-id="768"></button>
                        <input class="text_box left" name="" value="1" type="text" id="item_number" data-id="768" pattern="[0-9]*" maxlength="2" size="4"/>
                        <button class="add left cursor" data-id="768"></button>
                    </div>
                    <span class="left">
                    <c:if test="${goodItemDto.stockStatus != '4'}">
                    	有货
                    </c:if>
                    <c:if test="${goodItemDto.stockStatus == '4'}">
                    	缺货
                    </c:if>
                    
                    </span>
                    
                </div>

                    <div class="pro_btn clearfix">
                        <a href="javascript:void(0);" class="left btn_yellow" id="addtocart" onclick="checktoCart('${goodItemDto.groupId}',this)">加入购物袋</a>
                    </div>

                
            </div>
        </div>
    </div>
    
    <div class="pro_con_b jz clearfix">
        <div class="left">
            
            <div class="remai">
    <div class="remai_tl">
        热卖推荐商品
    </div>
    <div class="remai_con">
        <ul>
        	<c:forEach var="hotSaleGoods" items="${ hotSaleList }">
        		<li>
                    <a href="${ctx}/item/getGoodsItem?groupId=${hotSaleGoods.groupno}" class="remai_a">
                        <img src="${hotSaleGoods.goodsthumbnail }" />
                    </a>
                    <div class="clearfix">
                        <div class="left remai_lf">
                            <p>
                                <a href="${ctx}/item/getGoodsItem?groupId=${hotSaleGoods.groupno}">${hotSaleGoods.goodsname }</a>
                            </p>
                            <p class="remai_price">$${hotSaleGoods.disprice }</p>
                        </div>
                        
                    </div>
                </li>
        	</c:forEach> 
        </ul>
    </div>
</div>





        </div>
        <div class="right pro_con_b_rt">
            <div class="pro_con_b_rt_tl clearfix">
                <a href="javascript:;" class="ahover">商品详情</a>
                
            </div>
            <div class="pro_con_b_rt_main">
                <div class="pro_con_b_rt_con active">
                    <div class="box-collateral box-additional">
						<h2>商品参数</h2>
						<p>&nbsp;</p>
						<table id="product-attribute-specs-table" class="data-table"><colgroup><col width="99"><col></colgroup>
						<tbody>
						<tr class="first odd"><th class="label">产品名</th>
						<td class="data last">${goodItemDto.goods.goodsname }</td>
						</tr>
						<c:if test='${goodItemDto.goods.goodsnameen != null && goodItemDto.goods.goodsnameen != "" }'>
						<tr class="even"><th class="label">英文名称</th>
						<td class="data last">${goodItemDto.goods.goodsnameen }</td>
						</tr>
						</c:if>
						<tr class="odd"><th class="label">品牌</th>
						<td class="data last">${goodItemDto.goods.goodsbrand }</td>
						</tr>
						<tr class="even"><th class="label">产地</th>
						<td class="data last">澳大利亚</td>
						</tr>
						</tbody>
						</table>
				</div>
				<div class="box-collateral box-description"><a name="description"></a>
				<h2>&nbsp;</h2>
				<h2>商品详情</h2>
				<p>&nbsp;</p>
				</div>
						${goodItemDto.productDesc}
				</div>
				     </div>
				        </div>
				    </div>
				</div>

</body>
<!-- END BODY -->
</html>