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
    <div class="main">
    <div class="help_tl">
        <div class="jz clearfix">
            <span class="left">用户中心</span>
        </div>
    </div>
    <div class="clearfix help_main jz">
        <div class="left help_lf user_center">
    <ul>
        <li>
            <a href="/Order?orderStatus=0" class="ahover">
                <img src="${ctx}/images/yonghuzhongxin/dingdan.png" class="img_q" />
                <img src="${ctx}/images/yonghuzhongxin/dingdanh.png" class="img_h" />
                <span class="user_center_link">我的订单</span>
            </a>
        </li>
        
        <li>
            <a href="/User/UserProfile?orderStatus=1" class="">
                <img src="${ctx}/images/yonghuzhongxin/xinxi.png" class="img_q" />
                <img src="${ctx}/images/yonghuzhongxin/xinxih.png" class="img_h" />
                <span class="user_center_link">会员信息</span>
            </a>
        </li>
        <li>
            <a href="/User/ConsigneeList" class="">
                <img src="${ctx}/images/yonghuzhongxin/shoujianren.png" class="img_q" />
                <img src="${ctx}/images/yonghuzhongxin/shoujianrenh.png" class="img_h" />
                <span class="user_center_link">收件人管理</span>
            </a>
        </li>
        <li>
            <a href="/User/SenderList" class="">
                <img src="${ctx}/images/yonghuzhongxin/fajianren.png" class="img_q" />
                <img src="${ctx}/images/yonghuzhongxin/fajianrenh.png" class="img_h" />
                <span class="user_center_link">寄件人管理</span>
            </a>
        </li>
        <li>
            <a href="javascript:void(0)" id="outBtn">
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

<form action="/Login/LogOut" id="logoutform" method="post"><input name="__RequestVerificationToken" type="hidden" value="-3wIMSDkDtAjLzm589nvTqZMOiGEIk6ijKNyTsXghbB-HfsIYExc6IORT_yXaw78UxcTl0dtxsIfzm6aQH3D5WHwSenU4pmkNwAN-AW1IBq5kKgxO8Y6HU2wT_KsrO2282P-qwn2F47zXXZulnep9A2" /></form>

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
            <div class="yucunkuan_tl">
                新建收货地址
                <input type="button" class="btn_blue cursor yckTrigger" value="一键提取">
                <div class="quickAddress">
                    <div class="quickAddressInput"><textarea placeholder="快速录入格式(例)：
地址，收件人，电话 (逗号或者回车作为间隔符)"></textarea></div>
                    <div class="quickAddressInputBtns">
                        <button class="enterAddress">一键提取</button><button class="clearAddress">清空</button><button class="closeAddress">关闭</button>
                    </div>
                </div>
            </div>

<form action="/User/ConsigneeCreate" method="post"><input name="__RequestVerificationToken" type="hidden" value="JOQ0u271_A1OxNnKVUJIhc4TS-4FOcUPIZVvg9cGPYC8S86WAK6r5DrewA1URR-gW5HsxCHvpKsjL6Qiqzddmu0D4AmmMe0kA4ib5j7POZdVZV-k0Dnyf0GBpXhQsRSeIrNF4CVNlIUhaYkJi9nXyA2" />                <input type="hidden" name="returnUrl" value="" />
                <div class="clearfix renguanli_gp ren_form">
                    <span class="left renguanli_gp_name">名字</span>
                    <input class="left recipientName text-box single-line" data-val="true" data-val-required="请填写姓名" id="Name" name="Name" placeholder="收货人姓名（必填）" type="text" value="" />
                    <div class="ren_form_erro"><span class="field-validation-valid has-error" data-valmsg-for="Name" data-valmsg-replace="true"></span></div>
                </div>
                <div class="clearfix renguanli_gp">
                    <span class="left renguanli_gp_name">电话</span>
                    <input class="left recipientPhone text-box single-line" data-val="true" data-val-required="请填写联系电话" id="PhoneNumber" name="PhoneNumber" placeholder="电话号码（必填）" type="text" value="" />
                    <div class="ren_form_erro"><span class="field-validation-valid has-error" data-valmsg-for="PhoneNumber" data-valmsg-replace="true"></span></div>
                </div>
                <div class="clearfix renguanli_gp" id="city_china">
                    <span class="left renguanli_gp_name">
                        省/市
                    </span>
                    <select class="province" name="Province"></select>
                    <select class="city" name="City"></select>
                    <div class="ren_form_erro"><span class="field-validation-valid has-error" data-valmsg-for="Province" data-valmsg-replace="true"></span></div>
                    <div class="ren_form_erro"><span class="field-validation-valid has-error" data-valmsg-for="City" data-valmsg-replace="true"></span></div>
                </div>
                <div class="clearfix renguanli_gp">
                    <span class="left renguanli_gp_name">
                        详细地址
                    </span>
                    <input class="left detailAddress text-box single-line" data-val="true" data-val-required="请填写详细地址" id="AddressLine" name="AddressLine" placeholder="详细地址（必填）" type="text" value="" />
                    <div class="ren_form_erro"><span class="field-validation-valid has-error" data-valmsg-for="AddressLine" data-valmsg-replace="true"></span></div>
                </div>
                <div class="clearfix renguanli_gp">
                    <span class="left renguanli_gp_name">
                        身份证号码
                    </span>
                    <input class="left citizenIdCard text-box single-line" data-val="true" data-val-regex="身份证号格式不正确！" data-val-regex-pattern="^\d{6}(18|19|20)\d{2}(0[1-9]|1[012])(0[1-9]|[12]\d|3[01])\d{3}(\d|[xX])$" id="IdCard" name="IdCard" placeholder="身份证号码" type="text" value="" />
                    <div class="ren_form_erro"><span class="field-validation-valid has-error" data-valmsg-for="IdCard" data-valmsg-replace="true"></span></div>
                </div>
                <input type="submit" class="btn_blue fangshibtn cursor" value="确认新增收货地址" />
</form>        </div>
    </div>
</div>
    



<script type="text/javascript">

    $.cxSelect.defaults.url = "js/cityData.min.json";

    $('#city_china').cxSelect({
        selects: ['province', 'city']
    });

    $('.yckTrigger').click(function () {
        $('.quickAddress').toggleClass('show').promise().done(function () {
            $('.quickAddressInput textarea').focus();
        });
    })

    $('.enterAddress').click(function () {
        var address = $('.quickAddressInput textarea').val();
        extractAddress(address);
    });

    $('.clearAddress').click(function () {
        $('.quickAddressInput textarea').val('');
    })

    $('.closeAddress').click(function () {
        $('.quickAddress').toggleClass('show');
    })
    function extractAddress(dz) {
        $.ajax({
            url: "js/GetExtractAddress",
            type: "POST",
            dataType:"json",
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
                $('.quickAddress').toggleClass('show');
            },
            error: function (data) {
                $('.quickAddress').toggleClass('show');
            }
        })
    }
</script>
</body>
<!-- END BODY -->
</html>