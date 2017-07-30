package com.org.oztt.formDto;

import java.math.BigDecimal;

import com.org.oztt.entity.TProduct;
import com.org.oztt.packing.util.ProductBox;

/**
 * 分发箱子用
 * 
 * @author linliuan
 */
public class ProductOrderDetails {

    private TProduct   product;

    private ProductBox productBox;

    private Long       id;

    private String     powderId;

    private Long       quantity;

    private BigDecimal unitPrice;

    private String     powderBoxId;

    public ProductOrderDetails(TProduct product, Long quantity, BigDecimal unitPrice)
    {
        this.product = product;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
    }

    public TProduct getProduct() {
        return product;
    }

    public void setProduct(TProduct product) {
        this.product = product;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getPowderId() {
        return powderId;
    }

    public void setPowderId(String powderId) {
        this.powderId = powderId;
    }

    public Long getQuantity() {
        return quantity;
    }

    public void setQuantity(Long quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(BigDecimal unitPrice) {
        this.unitPrice = unitPrice;
    }

    public String getPowderBoxId() {
        return powderBoxId;
    }

    public void setPowderBoxId(String powderBoxId) {
        this.powderBoxId = powderBoxId;
    }

    public ProductBox getProductBox() {
        return productBox;
    }

    public void setProductBox(ProductBox productBox) {
        this.productBox = productBox;
    }

}
