package com.org.oztt.service;

import java.util.List;

import com.org.oztt.entity.TAddressInfo;
import com.org.oztt.entity.TSuburbDeliverFee;

public interface AddressService {

    /**
     * 取得当前用户所有的地址
     * 
     * @param customerno
     * @return
     */
    public List<TAddressInfo> getAllAddress(String customerno, String deliveryMethod) throws Exception;

    /**
     * 取得当前用户所有的地址
     * 
     * @param customerno
     * @return
     */
    public List<TAddressInfo> getAllAddress(String customerno) throws Exception;

    /**
     * 获取地址
     * 
     * @param id
     * @return
     * @throws Exception
     */
    public TAddressInfo getAddressById(Long id) throws Exception;

    /**
     * 更新地址
     * 
     * @param record
     * @return
     * @throws Exception
     */
    public void updateAddress(TAddressInfo record) throws Exception;

    /**
     * 插入地址
     * 
     * @param record
     * @return
     * @throws Exception
     */
    public void insertAddress(TAddressInfo record) throws Exception;

    /**
     * 删除地址
     * 
     * @param record
     * @return
     * @throws Exception
     */
    public void deleteAddress(Long id) throws Exception;

    /**
     * 通过运费地址NO号来获取运费
     * 
     * @param no
     * @return
     * @throws Exception
     */
    public String getFreightByNo(Long no) throws Exception;

    /**
     * 通过ID来获取地址信息
     * 
     * @param no
     * @return
     * @throws Exception
     */
    public TSuburbDeliverFee getTSuburbDeliverFeeById(Long no) throws Exception;

    /**
     * 设置默认地址
     * 
     * @param customerNo
     * @param addressNo
     * @throws Exception
     */
    public void updateDefaultAddress(String customerNo, String addressNo) throws Exception;
    
    /**
     * 获取默认的地址
     * 
     * @param customerNo
     * @param addressNo
     * @throws Exception
     */
    public TAddressInfo getDefaultAddress(String customerNo) throws Exception;
}
