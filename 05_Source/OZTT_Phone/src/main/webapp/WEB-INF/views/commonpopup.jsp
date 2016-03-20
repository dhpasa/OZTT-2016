    <!-- BEGIN fast view of a product -->
    <div id="product-pop-up" style="display: none; width: 700px;">
            <div class="product-page product-pop-up">
              <div class="row">
                <div class="col-md-6 col-sm-6 col-xs-3">
                  <div class="product-main-image">
                    <img src="" alt="" class="img-responsive" id="activeImage">
                    <input type="hidden" value="" id="hiddenImage" />
                  </div>
                  <div class="product-other-images" id="productImage">
                    
                  </div>
                </div>
                <div class="col-md-6 col-sm-6 col-xs-9">
                  <h1 id="goodsNameh1"></h1>
                  <div class="price-availability-block clearfix">
                    <div class="price">
                      <strong id="disPrice"></strong>
                      <em><span id="nowPrice"></span></em>
                    </div>
                    <div class="availability">
<!--                       <fmt:message key="OZ_TT_TP_PD_youhuo"/> -->
						<span id="groupPercent"></span>
                    </div>
                  </div>
                  <div class="description">
                    <p id="prodectTime"></p>
                  </div>
                  <div class="description">
                    <p id="prodectDesc"></p>
                  </div>
                  <div class="product-page-options" id="productOptions">
                    
                  </div>
                  <div class="product-page-cart">
                    <div class="product-quantity" id="productQuantityDiv">
                        <input id="product-quantity" type="text" value="1" readonly name="product-quantity" class="form-control input-sm">
                    </div>
                    <button class="btn btn-primary" type="button" id="addCart" onclick=""><fmt:message key="common_addtocart"/></button>
                    <button class="btn btn-default" type="button" id="detail" onclick=""><fmt:message key="common_detail"/></button>
                  </div>
                </div>

                <div class="sticker sticker-sale"></div>
              </div>
            </div>
    </div>