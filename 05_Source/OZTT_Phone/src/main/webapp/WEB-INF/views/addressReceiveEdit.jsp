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
  <title><fmt:message key="ADDRESSEDIT_TITLE"/></title>
  <script type="text/javascript">
  function toAddressList(){
	  if ('${fromPurchase}' == '1') {
		  location.href = "${ctx}/purchase/init"
	  } else {
		  location.href = "${ctx}/address/receiveList"
	  }
	  
  }
		
  function addOrUpdateAddress(){
	  var addressID = $("#hiddenAddressId").val();
	  
	  var name = $("#Name").val();
	  var phoneNumber = $("#PhoneNumber").val();
	  var province = $("#Province").val();
	  var city = $("#City").val();
	  var addressLine = $("#AddressLine").val();
	  var idCard = $("#IdCard").val();
	  
	  if (name == "") {
		  $('#errormsg_content').text("请填写姓名");
		  $('#errormsg-pop-up').modal('show');
		  return;
	  }
	  
	  if (phoneNumber == "") {
		  $('#errormsg_content').text("请填写联系电话");
		  $('#errormsg-pop-up').modal('show');
		  return;
	  }
	  
	  if (province == "" || city == "") {
		  $('#errormsg_content').text("请选择省市");
		  $('#errormsg-pop-up').modal('show');
		  return;
	  }
	  
	  if (addressLine == "") {
		  $('#errormsg_content').text("请填写详细地址");
		  $('#errormsg-pop-up').modal('show');
		  return;
	  }
	  
	  /* if (idCard == "") {
		  $('#errormsg_content').text("请填写身份证号码");
		  $('#errormsg-pop-up').modal('show');
		  return;
	  } */
	  if (idCard != null && idCard != "") {
		  if (!checkIdCard(idCard)) {
			  $('#errormsg_content').text("请填写正确的身份证号码");
			  $('#errormsg-pop-up').modal('show');
			  return;
		  }
	  }
	  
	  var paramData = {
				"updateType":"1",
				"name":name,
				"phone":phoneNumber,
				"address":province+ " " + city + " " + addressLine,
				"addressId":addressID,
				"idCard":idCard
		}
		$.ajax({
			type : "POST",
			contentType:'application/json',
			url : '${ctx}/address/submitAddress',
			dataType : "json",
			async : false,
			data : JSON.stringify(paramData), 
			success : function(data) {
				
				$(".out_alert").show();
		        $(".alert_bg").show();
		        setTimeout(toAddressList(),3000);
		      
			},
			error : function(data) {
				
			}
		});
  	}
  		
  </script>
</head>
<!-- Head END -->


<!-- Body BEGIN -->
<body>
    <!--头部开始-->
	<div class="head_fix">
    	<div class="head user_head clearfix">
	        <a href="javascript:history.back(-1)" class="head_back"></a>
	        <c:if test="${receiverInfo.id == null ||  receiverInfo.id == ''}">
	        	创建新收件人地址
	        </c:if>
	        <c:if test="${receiverInfo.id != null &&  receiverInfo.id != ''}">
	        	更新收件人地址
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

        <script type="text/javascript" src="${ctx}/js/jquery.cxselect.min.js"></script>

		<!-- <div class="yucunkuan_tl">
		    
		    <input type="button" class="btn_blue cursor yckTrigger" value="一键提取">
		    <div class="quickAddress">
		        <div class="quickAddressInput"><textarea placeholder="快速录入格式(例)：
		地址，收件人，电话 (逗号作为间隔符)
		"></textarea></div>
		        <div class="quickAddressInputBtns">
		            <button class="enterAddress">一键提取</button><button class="clearAddress">清空</button><button class="closeAddress">关闭</button>
		        </div>
		    </div>
		</div> -->
		
		<!--新建收货地址开始-->
		    <div class="reg_main">
		        
		        <div class="reg_gp">
		            <input class="recipientName text-box single-line" data-val="true" data-val-required="请填写姓名" id="Name" name="Name" placeholder="收货人姓名（必填）" type="text" value="${receiverInfo.receiverName }" />
		        </div>
		        <div class="reg_gp">
		            <input class="recipientPhone text-box single-line" data-val="true" data-val-required="请填写联系电话" id="PhoneNumber" name="PhoneNumber" placeholder="电话号码（必填）" type="text" value="${receiverInfo.receiverTel }" />
		        </div>
		
		        <div class="reg_gp" id="city_china">
		            <select class="province" name="Province" id="Province"></select>
		            <select class="city" name="City" id="City"></select>
		        </div>

		        <div class="reg_gp">
		            <input class="detailAddress text-box single-line" data-val="true" data-val-required="请填写详细地址" id="AddressLine" name="AddressLine" placeholder="详细地址（必填）" type="text" value="" />
		        </div>
		       
		        <div class="reg_gp">
		            <input class="citizenIdCard text-box single-line" data-val="true" data-val-regex="身份证号格式不正确！" data-val-regex-pattern="^\d{6}(18|19|20)\d{2}(0[1-9]|1[012])(0[1-9]|[12]\d|3[01])\d{3}(\d|[xX])$" id="IdCard" name="IdCard" placeholder="身份证号码" type="text" value="${receiverInfo.receiverIdCardNo }" />
		        </div>
		        
		        <c:if test="${receiverInfo.id == null ||  receiverInfo.id == ''}">
		        	 <input type="button" class="btn btn_blue loginbtn mt10" value="确认新增收货地址" onclick="addOrUpdateAddress()"/>
		        </c:if>
		        <c:if test="${receiverInfo.id != null && receiverInfo.id != ''}">
		        	 <input type="button" class="btn btn_blue loginbtn mt10" value="确认更新收货地址" onclick="addOrUpdateAddress()"/>
		        </c:if>
		        
		        <input type="hidden" value="${receiverInfo.id}" id="hiddenAddressId"/>
		        <input type="hidden" value="${receiverInfo.receiverAddr}" id="hiddenAddressValue"/>
		    </div>
		<script type="text/javascript">
		    $.cxSelect.defaults.url = "${ctx}/js/cityData.min.json";
		
		    $('#city_china').cxSelect({
		        selects: ['province', 'city']
		    });
		
		    /* $('.yckTrigger').click(function () {
		        $('.quickAddress').toggleClass('showIt').promise().done(function () {
		            $('.quickAddressInput textarea').focus();
		        });
		    }) */
		
		    /* $('.enterAddress').click(function () {
		        var address = $('.quickAddressInput textarea').val();
		        extractAddress(address);
		    }); */
		
		    /* $('.clearAddress').click(function () {
		        $('.quickAddressInput textarea').val('');
		    }) */
		
		    /* $('.closeAddress').click(function () {
		        $('.quickAddress').toggleClass('showIt');
		    }) */
		    /* function extractAddress(dz) {
		        $.ajax({
		            url: "js/GetExtractAddress",
		            type: "POST",
		            dataType: "json",
		            data: { address: dz },
		            success: function (data) {
		                $('.recipientName').val(data.Name);
		                $('.recipientPhone').val(data.PhoneNumber);
		                $('.citizenIdCard').val(data.IdCard);
		                $('#city_china .province').val(data.Province);
		                //当json中解析出省市数据时，不在city选择中进行添加
		                $('#city_china .city').empty();
		                if (data.City.length != 0) {
		                    $('#city_china .city').removeAttr('disabled').append('<option val="' + data.City + '" selected>' + data.City + '</option>');
		                }
		                $('.detailAddress').val(data.AddressLine)
		                $('.quickAddress').toggleClass('showIt');
		            },
		            error: function (data) {
		                $('.quickAddress').toggleClass('showIt');
		            }
		        })
		    } */
  			
		    initFun();
  
  			function initFun(){
  				setTimeout(function(){
  					var addressInfo = $("#hiddenAddressValue").val();
  	  				var addArr = addressInfo.split(" ");
  	  				$("#Province").val(addArr[0]);
  	  				$("#Province").change();
  	  				$("#City").val(addArr[1]);
  	  				$("#AddressLine").val(addressInfo.replace(addArr[0],"").replace(addArr[1],"").trim())
  	  				
  				},200);
  			}
  			
		</script>

	
	<%-- <div class="x-header x-header-gray border-1px-bottom">
		<div class="x-header-btn ico-back">
		</div>
		<div class="x-header-title">
			<span><fmt:message key="ADDRESSEDIT_TITLE"/></span>
		</div>
		<div class="x-header-btn"></div>
	</div>
	
	<div class="adscontain_noborder">
        <div class="adsinputdiv">
            <input class="adsinputarea" type="text" value="${item.addressdetails }" placeholder="<fmt:message key="ADDRESSEDIT_DETAIL"/>"  autofocus="" maxlength="200" id="detail" onchange="checkShowSave()">
        </div>
        <div class="adsinputdiv">
            <input class="adsinputarea" type="text" value="${item.state }" placeholder="<fmt:message key="ADDRESSEDIT_STATE"/>"  autofocus="" maxlength="100" id="state" onchange="checkShowSave()">
        </div>
        <div class="adsinputdiv">
            <select class="adsinputarea adsSelectbg"  id="suburb" onchange="checkShowSave()">
				<option value=""><fmt:message key="ADDRESSEDIT_SUBURB"/></option>
    			<c:forEach var="seList" items="${ suburbSelect }">
    				<option value="${ seList.key }">${ seList.value }</option>
    			</c:forEach>
   			</select>
        </div>
        <div class="adsinputdiv">
            <input disabled="disabled" class="adsinputarea" type="text" value="<fmt:message key="COMMON_DEFAULTCOUNTRY" />"  autofocus="" maxlength="20" id="country" onchange="checkShowSave()">
        </div>
        <div class="adsinputdiv">
            <input class="adsinputarea" type="text" value="${item.postcode }" placeholder="<fmt:message key="ADDRESSEDIT_POSTCODE"/>"  autofocus="" maxlength="20" id="postcode" onchange="checkShowSave()">
        </div>
        <div class="adsinputdiv">
            <input class="adsinputarea" type="text" value="${item.receiver }" placeholder="<fmt:message key="ADDRESSEDIT_RECEIVER"/>"  autofocus="" maxlength="50" id="receiver" onchange="checkShowSave()">
        </div>
        <div class="adsinputdiv">
            <input class="adsinputarea" type="text" value="${item.contacttel }" placeholder="<fmt:message key="ADDRESSEDIT_PHONE"/>"  autofocus="" maxlength="20" id="phone" onchange="checkShowSave()">
        </div>
	</div>
	
	<input type="hidden" value="${item.id }" id="hiddenAddressId"/>
	<input type="hidden" value="${fromMode}" id="hiddenfromMode"/>
	
	<input type="hidden" value="${isUnify}" id="hiddenisUnify"/>
	<input type="hidden" value="${deliveryTime}" id="hiddendeliveryTime"/>
	<input type="hidden" value="${deliverySelect}" id="hiddendeliverySelect"/>
	<input type="hidden" value="${payMethod}" id="hiddenpayMethod"/>
	
	
	
	<div class="addressAdd">
		<a id="saveads" style="background-color: #B8B8B8"><i class="fa fa-save"></i>&nbsp;<fmt:message key="COMMON_SAVE"/></a>
	</div>
	
	<script type="text/javascript">
		$("#suburb").val('${item.suburb }');
	
	</script> --%>
</body>
<!-- END BODY -->
</html>