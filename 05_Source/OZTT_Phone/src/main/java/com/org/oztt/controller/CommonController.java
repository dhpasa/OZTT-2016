package com.org.oztt.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.util.CollectionUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

import com.alibaba.fastjson.JSONObject;
import com.org.oztt.base.util.DateFormatUtils;
import com.org.oztt.contants.CommonConstants;
import com.org.oztt.entity.TAddressInfo;
import com.org.oztt.entity.TCustomerLoginHis;
import com.org.oztt.entity.TCustomerLoginInfo;
import com.org.oztt.entity.TGoodsGroup;
import com.org.oztt.formDto.ContCartItemDto;
import com.org.oztt.formDto.ContCartProItemDto;
import com.org.oztt.formDto.GoodItemDto;
import com.org.oztt.service.AddressService;
import com.org.oztt.service.CommonService;
import com.org.oztt.service.CustomerService;
import com.org.oztt.service.GoodsService;

/**
 * 定义一些共同的控制器，实现共同的操作
 * 
 * @author linliuan
 */
@Controller
@RequestMapping("/COMMON")
public class CommonController extends BaseController {

    @Resource
    private GoodsService    goodsService;

    @Resource
    private CommonService   commonService;

    @Resource
    private CustomerService customerService;

    @Resource
    private AddressService  addressService;

    /**
     * 得到团购产品信息
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/getGoodsItem")
    public Map<String, Object> getCurrentItem(HttpServletRequest request, HttpSession session,
            @RequestParam String groupId) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {

            GoodItemDto goodItemDto = goodsService.getGoodAllItemDto(groupId);

            // 后台维护的时候提示让以逗号隔开
            mapReturn.put("goodItemDto", goodItemDto);
            mapReturn.put("isException", false);
            return mapReturn;
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            mapReturn.put("isException", true);
            return mapReturn;
        }
    }

    /**
     * 加入购物车
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/addConsCart")
    @ResponseBody
    public Map<String, Object> addConsCard(HttpServletRequest request, HttpServletResponse response,
            HttpSession session, @RequestBody List<Map<String, String>> list) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {
            // 判断当前产品加入购物车
            // 加入购物车操作，判断所有的属性是不是相同，相同在添加
            String customerNo = (String) session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);
            if (customerNo == null) {
                return mapReturn;
            }
            goodsService.addContCart(customerNo, list);

            String imgUrl = super.getApplicationMessage("saveImgUrl");

            // 登陆成功以后取得购物车中的数据然后更新Cookie
            List<ContCartItemDto> consCarts = goodsService.getAllContCartForCookie(customerNo);
            if (!CollectionUtils.isEmpty(consCarts)) {
                for (ContCartItemDto dto : consCarts) {
                    if (StringUtils.isEmpty(dto.getGoodsPropertiesDB())) {
                        dto.setGoodsProperties(new ArrayList<ContCartProItemDto>());
                    }
                    else {
                        dto.setGoodsProperties(JSONObject.parseArray(dto.getGoodsPropertiesDB(),
                                ContCartProItemDto.class));
                    }
                    dto.setGoodsPropertiesDB(StringUtils.EMPTY);
                    dto.setGoodsImage(imgUrl + dto.getGoodsId() + CommonConstants.PATH_SPLIT + dto.getGoodsImage());
                }
            }

            mapReturn.put("conscars", JSONObject.toJSONString(consCarts));

            // 后台维护的时候提示让以逗号隔开
            mapReturn.put("isException", false);
            return mapReturn;
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            mapReturn.put("isException", true);
            return mapReturn;
        }

    }

    /**
     * 删除购物车
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/deleteConsCart")
    @ResponseBody
    public Map<String, Object> deleteConsCard(HttpServletRequest request, HttpServletResponse response,
            HttpSession session, @RequestBody List<Map<String, String>> list) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {
            // 加入购物车操作，判断所有的属性是不是相同，相同在添加
            String customerNo = (String) session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);
            if (customerNo == null) {
                return mapReturn;
            }
            goodsService.deleteContCart(customerNo, list);

            // 后台维护的时候提示让以逗号隔开
            mapReturn.put("isException", false);
            return mapReturn;
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            mapReturn.put("isException", true);
            return mapReturn;
        }
    }

    /**
     * 清空购物车
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/emptyConsCard", method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> emptyConsCard(HttpServletRequest request, HttpServletResponse response,
            HttpSession session) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {
            // 加入购物车操作，判断所有的属性是不是相同，相同在添加
            String customerNo = (String) session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);
            if (customerNo == null) {
                return mapReturn;
            }
            goodsService.deleteAllContCart(customerNo);

            // 后台维护的时候提示让以逗号隔开
            mapReturn.put("isException", false);
            return mapReturn;
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            mapReturn.put("isException", true);
            return mapReturn;
        }
    }

    /**
     * 获取验证码
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/getVerifyCode", method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> getVerifyCode(HttpServletRequest request, HttpServletResponse response,
            HttpSession session, @RequestParam String phoneNumber) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {
            phoneNumber = java.net.URLDecoder.decode(phoneNumber, "UTF-8");
            commonService.getPhoneVerifyCode(phoneNumber);
            mapReturn.put("isException", false);
            return mapReturn;
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            mapReturn.put("isException", true);
            return mapReturn;
        }
    }

    /**
     * 检查是否已经登录
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/checkIsLogin")
    public Map<String, Object> checkIsLogin(HttpServletRequest request, HttpSession session) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {
            //获取Session中的客户号
            String customerNo = (String) session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);
            if (customerNo != null && customerNo.length() > 0) {
                mapReturn.put("isLogin", true);
            }
            else {
                mapReturn.put("isLogin", false);
            }

            mapReturn.put("isException", false);
            return mapReturn;
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            mapReturn.put("isException", true);
            return mapReturn;
        }
    }

    /**
     * ajax登录
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/ajaxLogin")
    public Map<String, Object> ajaxLogin(HttpServletRequest request, HttpSession session,
            @RequestBody Map<String, String> map) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {
            // 进入登录画面
            String username = map.get("loginname");
            String password = map.get("password");
            TCustomerLoginInfo tCustomerLoginInfo = customerService.userLogin(username, password);
            if (tCustomerLoginInfo == null) {
                // 没有取到数据
                mapReturn.put("canLogin", false);
                mapReturn.put("isException", false);
                return mapReturn;
            }
            else if (CommonConstants.CANNOT_LOGIN.equals(tCustomerLoginInfo.getCanlogin())) {
                mapReturn.put("canLogin", false);
                mapReturn.put("isException", false);
                return mapReturn;
            }

            // 登录成功插入历史记录
            if (CommonConstants.HAS_LOGINED_STATUS.equals(tCustomerLoginInfo.getLoginstatus())) {
                // 用户已经登录着，这时不需要插入历史数据也不需要更新登录表

            }
            else {
                // 插入历史登录数据并且更新登录状态
                TCustomerLoginHis tCustomerLoginHis = new TCustomerLoginHis();
                tCustomerLoginHis.setCustomerno(tCustomerLoginInfo.getCustomerno());
                customerService.insertLoginHisAndUpdateStatus(tCustomerLoginHis);
            }

            // 可以取到数据，将所用的数据放入session 中
            session.setAttribute(CommonConstants.SESSION_CUSTOMERNO, tCustomerLoginInfo.getCustomerno());
            mapReturn.put("canLogin", true);
            mapReturn.put("isException", false);
            return mapReturn;
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            mapReturn.put("isException", true);
            return mapReturn;
        }
    }

    /**
     * 加入购物车()
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/purchaseAsyncContCart", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> purchaseAsyncContCart(HttpServletRequest request, HttpServletResponse response,
            HttpSession session, @RequestBody List<Map<String, String>> list) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {
            // 加入购物车操作，判断所有的属性是不是相同，相同在添加
            String customerNo = (String) session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);
            if (customerNo == null) {
                return mapReturn;
            }
            goodsService.purchaseAsyncContCart(customerNo, list);

            String imgUrl = super.getApplicationMessage("saveImgUrl");

            // 当前用户已经登录, 直接跳转到主菜单画面。
            // 这里当用户已经登录的时候，就不需要再插入历史记录了。
            // 登陆成功以后取得购物车中的数据然后更新Cookie
            List<ContCartItemDto> consCarts = goodsService.getAllContCartForCookie(customerNo);
            if (!CollectionUtils.isEmpty(consCarts)) {
                for (ContCartItemDto dto : consCarts) {
                    if (StringUtils.isEmpty(dto.getGoodsPropertiesDB())) {
                        dto.setGoodsProperties(new ArrayList<ContCartProItemDto>());
                    }
                    else {
                        dto.setGoodsProperties(JSONObject.parseArray(dto.getGoodsPropertiesDB(),
                                ContCartProItemDto.class));
                    }
                    dto.setGoodsPropertiesDB(StringUtils.EMPTY);
                    dto.setGoodsImage(imgUrl + dto.getGoodsId() + CommonConstants.PATH_SPLIT + dto.getGoodsImage());
                }
            }

            mapReturn.put("conscars", JSONObject.toJSONString(consCarts));

            // 后台维护的时候提示让以逗号隔开
            mapReturn.put("isException", false);
            return mapReturn;
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            mapReturn.put("isException", true);
            return mapReturn;
        }

    }

    /**
     * 提交地址
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/submitAddress")
    @ResponseBody
    public Map<String, Object> submitAddress(HttpServletRequest request, HttpServletResponse response,
            HttpSession session, @RequestBody Map<String, String> reqMap) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {
            // 加入购物车操作，判断所有的属性是不是相同，相同在添加
            String customerNo = (String) session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);
            if (customerNo == null) {
                return mapReturn;
            }
            String addressId = reqMap.get("addressId");
            // 更新或者增加地址
            TAddressInfo info = new TAddressInfo();

            info.setAddressdetails(reqMap.get("details"));
            info.setContacttel(reqMap.get("contacttel"));
            info.setCountrycode(reqMap.get("country"));
            info.setCustomerno(customerNo);
            info.setDeliverymethod(reqMap.get("deliverymethod"));
            info.setPostcode(reqMap.get("post"));
            info.setReceiver(reqMap.get("reveiver"));
            info.setState(reqMap.get("state"));
            info.setSuburb(reqMap.get("suburb"));
            if (StringUtils.isEmpty(addressId)) {
                // 插入数据
                addressService.insertAddress(info);
            }
            else {
                info.setId(Long.valueOf(addressId));
                // 更新数据
                addressService.updateAddress(info);
            }
            // 取得所有的地址，返回画面更新地址信息
            // 获取所有的地址
            List<TAddressInfo> infoList = addressService.getAllAddress(customerNo, reqMap.get("deliverymethod"));
            mapReturn.put("adrList", infoList);

            // 后台维护的时候提示让以逗号隔开
            mapReturn.put("isException", false);
            return mapReturn;
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            mapReturn.put("isException", true);
            return mapReturn;
        }
    }

    /**
     * 获取单个地址
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/getAddressById")
    @ResponseBody
    public Map<String, Object> getAddressById(HttpServletRequest request, HttpServletResponse response,
            HttpSession session, @RequestParam String addressId) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {
            // 获取地址
            TAddressInfo info = addressService.getAddressById(Long.valueOf(addressId));
            mapReturn.put("item", info);
            // 后台维护的时候提示让以逗号隔开
            mapReturn.put("isException", false);
            return mapReturn;
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            mapReturn.put("isException", true);
            return mapReturn;
        }
    }

    /**
     * 获取指定客户下所有的地址
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/getAllAddress")
    @ResponseBody
    public Map<String, Object> getAllAddress(HttpServletRequest request, HttpServletResponse response,
            HttpSession session, @RequestParam String method) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {
            // 加入购物车操作，判断所有的属性是不是相同，相同在添加
            String customerNo = (String) session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);
            if (customerNo == null) {
                return mapReturn;
            }
            // 获取所有的地址
            List<TAddressInfo> infoList = addressService.getAllAddress(customerNo, method);
            if (!CollectionUtils.isEmpty(infoList)) {
                for (TAddressInfo info : infoList) {
                    info.setSuburb(addressService.getTSuburbDeliverFeeById(Long.valueOf(info.getSuburb())).getSuburb());
                }
            }
            mapReturn.put("adrList", infoList);
            // 后台维护的时候提示让以逗号隔开
            mapReturn.put("isException", false);
            return mapReturn;
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            mapReturn.put("isException", true);
            return mapReturn;
        }
    }

    /**
     * 删除地址
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/deleteAddressById")
    @ResponseBody
    public Map<String, Object> deleteAddressById(HttpServletRequest request, HttpServletResponse response,
            HttpSession session, @RequestParam String addressId) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {
            // 加入购物车操作，判断所有的属性是不是相同，相同在添加
            String customerNo = (String) session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);
            if (customerNo == null) {
                return mapReturn;
            }
            // 获取地址
            TAddressInfo info = addressService.getAddressById(Long.valueOf(addressId));

            // 获取所有的地址
            addressService.deleteAddress(Long.valueOf(addressId));

            // 获取所有的地址
            List<TAddressInfo> infoList = addressService.getAllAddress(customerNo, info.getDeliverymethod());
            mapReturn.put("adrList", infoList);
            // 后台维护的时候提示让以逗号隔开
            mapReturn.put("isException", false);
            return mapReturn;
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            mapReturn.put("isException", true);
            return mapReturn;
        }
    }

    /**
     * 获取指定客户下所有的地址
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/getFreight")
    @ResponseBody
    public Map<String, Object> getFreight(HttpServletRequest request, HttpServletResponse response,
            HttpSession session, @RequestParam String addressId) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {
            // 获取地址
            TAddressInfo info = addressService.getAddressById(Long.valueOf(addressId));
            //通过地址信息获取费用信息
            String freight = addressService.getFreightByNo(Long.valueOf(info.getSuburb()));

            mapReturn.put("freight", freight);
            // 后台维护的时候提示让以逗号隔开
            mapReturn.put("isException", false);
            return mapReturn;
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            mapReturn.put("isException", true);
            return mapReturn;
        }
    }

    /**
     * 获取指定客户下所有的地址
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/getFreightBySuburb")
    @ResponseBody
    public Map<String, Object> getFreightBySuburb(HttpServletRequest request, HttpServletResponse response,
            HttpSession session, @RequestParam String suburb) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {

            //获取费用信息
            String freight = addressService.getFreightByNo(Long.valueOf(suburb));
            mapReturn.put("freight", freight);
            // 后台维护的时候提示让以逗号隔开
            mapReturn.put("isException", false);
            return mapReturn;
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            mapReturn.put("isException", true);
            return mapReturn;
        }
    }

    /**
     * 获取指定商品指定数量是否超过团购数量
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/checkIsOverGroup")
    @ResponseBody
    public Map<String, Object> checkIsOverGroup(HttpServletRequest request, HttpServletResponse response,
            HttpSession session, @RequestBody List<Map<String, String>> list) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {
            boolean isOver = true;
            Map<String, String> mapParam = new HashMap<String, String>();
            if (list != null && list.size() > 0) {
                mapParam = list.get(0);
                TGoodsGroup tGoodsGroup = new TGoodsGroup();
                tGoodsGroup.setGroupno(mapParam.get("groupId"));
                tGoodsGroup = goodsService.getGoodPrice(tGoodsGroup);
                Long checkQuantity = Long.valueOf(mapParam.get("goodsQuantity"));
                if (checkQuantity + tGoodsGroup.getGroupcurrentquantity() <= tGoodsGroup.getGroupmaxquantity()) {
                    isOver = false;
                }
            }

            mapReturn.put("isOver", isOver);
            mapReturn.put("isException", false);
            return mapReturn;
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            mapReturn.put("isException", true);
            return mapReturn;
        }
    }

    /**
     * 判断购物车数量是否超过团购数量
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/checkCantIsOverGroup")
    @ResponseBody
    public Map<String, Object> checkCantIsOverGroup(HttpServletRequest request, HttpServletResponse response,
            HttpSession session) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {
            boolean isOver = false;
            boolean isOverTime = false;
            String customerNo = (String) session.getAttribute(CommonConstants.SESSION_CUSTOMERNO);
            if (customerNo == null) {
                return mapReturn;
            }

            List<ContCartItemDto> needBuyItems = goodsService.getAllContCartForBuy(customerNo);
            if (!CollectionUtils.isEmpty(needBuyItems)) {
                for (ContCartItemDto itemDto : needBuyItems) {
                    TGoodsGroup tGoodsGroup = new TGoodsGroup();
                    tGoodsGroup.setGoodsid(itemDto.getGoodsId());
                    tGoodsGroup = goodsService.getGoodPrice(tGoodsGroup);
                    if (Long.valueOf(itemDto.getGoodsQuantity()) + tGoodsGroup.getGroupcurrentquantity() > tGoodsGroup
                            .getGroupmaxquantity()) {
                        isOver = true;
                        mapReturn.put("isOverMsg", itemDto.getGoodsName() + super.getMessage("E0012"));
                        break;
                    }
                    if (DateFormatUtils.getCurrentDate().before(tGoodsGroup.getValidperiodstart())
                            || DateFormatUtils.getCurrentDate().after(tGoodsGroup.getValidperiodend())) {
                        // 当前时间不在团购时间范围内
                        isOverTime = true;
                        mapReturn.put(
                                "isOverTimeMsg",
                                super.getMessage("E0013").replace(CommonConstants.MESSAGE_PARAM_ONE,
                                        itemDto.getGoodsName()));
                        break;
                    }
                }
            }

            mapReturn.put("isOver", isOver);
            mapReturn.put("isOverTime", isOverTime);
            mapReturn.put("isException", false);
            return mapReturn;
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            mapReturn.put("isException", true);
            return mapReturn;
        }
    }

    /**
     * 改变当前的语言环境
     * 
     * @param request
     * @param session
     * @return
     */
    @RequestMapping(value = "/changeLocale")
    public Map<String, Object> changeLocale(HttpServletRequest request, HttpServletResponse response,
            HttpSession session, String local) {
        Map<String, Object> mapReturn = new HashMap<String, Object>();
        try {
            Locale currentLocale = null;
            if ("zh".equals(local)) {
                currentLocale = new Locale("zh", "CN");
            }
            else if ("en".equals(local)) {
                currentLocale = new Locale("en", "US");
            }
            else {
                currentLocale = new Locale("zh", "CN");
            }
            session.setAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME, currentLocale);
            mapReturn.put("isException", false);
            return mapReturn;
        }
        catch (Exception e) {
            logger.error(e.getMessage());
            mapReturn.put("isException", true);
            return mapReturn;
        }
    }

}
