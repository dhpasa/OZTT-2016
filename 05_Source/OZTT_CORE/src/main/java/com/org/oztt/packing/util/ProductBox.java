package com.org.oztt.packing.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.util.StringUtils;

import com.org.oztt.contants.CommonConstants;
import com.org.oztt.contants.CommonEnum;
import com.org.oztt.entity.TExpressInfo;
import com.org.oztt.entity.TProduct;
import com.org.oztt.entity.TProductOrder;
import com.org.oztt.entity.TReceiverInfo;
import com.org.oztt.entity.TSenderInfo;
import com.org.oztt.formDto.ProductOrderDetails;

public class ProductBox extends PanelData implements Cloneable{
        private String elecExpressNo;
        private String expressDate;
        private String expressId;
        private String senderId;
        private String receiverId;
        private String expressName;
        private String senderName;
        private String receiverName;
        private String ifRemarks;
        private String remarks;
        private String ifMsg;
        private String additionalCost;
        private String sumAmount;
        private String expressPhotoUrl;
        private String boxPhotoUrls;
        private String orderId;
        private String handleStatus;
        private String operatorName;
        private String productContent;
        private String weight;
        private String tag;


        private TExpressInfo expressInfo=null;
        private TProductOrder productOrder=null;
        private TSenderInfo senderInfo=null;
        private TReceiverInfo receiverInfo=null;
//      private List<ProductInfo> productInfos=FXCollections.observableArrayList();
        private List<ProductOrderDetails> orderDetailsList=new ArrayList<ProductOrderDetails>();
        private List<ProductOrderDetails> orderDetailsListCopy=null;
        //private TProductBoxDao productBoxDao;


        public ProductBox(){
                id="";
                this.elecExpressNo="";
                this.expressDate="";
                this.expressId="";
                this.senderId="";
                this.receiverId="";
                this.expressName="";
                this.senderName="";
                this.receiverName="";
                this.ifRemarks="";
                this.remarks="";
                this.ifMsg="";
                //this.orderDetailsList=orderDetailsList;
                this.additionalCost="0";
                this.productContent=getProductContent(orderDetailsList);
                this.expressPhotoUrl="";
                this.boxPhotoUrls="";
                this.orderId="";
                this.handleStatus=CommonEnum.HandleFlag.COMPLATE.getLabel();
                this.operatorName="";
                this.expressInfo=null;
                this.senderInfo=null;
                this.receiverInfo=null;
                this.weight="";
                this.sumAmount="";
                this.tag="";
        }





        public ProductBox(String elecExpressNo, TExpressInfo expressInfo
                        , TSenderInfo senderInfo, TReceiverInfo receiverInfo, String ifRemarks, String remarks
                        , String ifMsg, String expressPhotoUrl, String tag, String orderId
                        , List<ProductOrderDetails> orderDetailsList){// insert into database
                //String elecExpressNo=getElecExpressNo();
                id="";
                this.elecExpressNo=elecExpressNo;
                this.expressDate=new SimpleDateFormat ("yyyyMMdd").format(new Date());
                this.expressId=expressInfo.getId().toString();
                this.senderId=senderInfo.getId().toString();
                this.receiverId=receiverInfo.getId().toString();
                this.expressName=expressInfo.getExpressName();
                this.senderName=senderInfo.getSenderName();
                this.receiverName=receiverInfo.getReceiverName();
                this.ifRemarks=ifRemarks;
                this.remarks=remarks;
                this.ifMsg=ifMsg;
                this.orderDetailsList=orderDetailsList;
                for(ProductOrderDetails pod:this.orderDetailsList)
                        pod.setProductBox(this);

                this.additionalCost=getAdditionalCost(ifRemarks, ifMsg)+"";
                this.productContent=getProductContent(orderDetailsList);
                this.expressPhotoUrl=expressPhotoUrl;
                this.boxPhotoUrls="";
                this.orderId=orderId;
                this.handleStatus=CommonEnum.HandleFlag.COMPLATE.getLabel();
                this.operatorName="";
                this.expressInfo=expressInfo;
                this.senderInfo=senderInfo;
                this.receiverInfo=receiverInfo;
                this.tag=tag;
                this.weight=getWeight()+"";
                this.sumAmount=getPrice()+"";


        }
        public ProductBox(long id, String elecExpressNo, Date expressDate, TExpressInfo expressInfo
                        , TSenderInfo senderInfo, TReceiverInfo receiverInfo, String ifRemarks, String remarks
                        , String ifMsg,  double additionalCost, double sumAmount
                        , String boxPhotoUrls, String expressPhotoUrl, String orderId
                        , String handleStatus, String operatorName, String tag, List<ProductOrderDetails> orderDetailsList
                        , Date addTimestamp, String addUserKey, Date updTimestamp
                        , String updUserKey, String updPgmId){ //read from database
                super(id, addTimestamp, addUserKey, updTimestamp, updUserKey, updPgmId);
                this.elecExpressNo=elecExpressNo;
                if(expressDate!=null)
                   this.expressDate=new SimpleDateFormat ("yyyyMMdd").format(expressDate);
                else
                   this.expressDate="";

                if(expressInfo!=null){
                    this.expressId=expressInfo.getId().toString();
                        this.expressName=expressInfo.getExpressName();
                }
                else{
                    this.expressId="";
                        this.expressName="";
                }

                if(senderInfo!=null){
                    this.senderId=senderInfo.getId().toString();
                        this.senderName=senderInfo.getSenderName();

                }
                else{
                        this.senderId="";
                        this.senderName="";

                }
                if(receiverInfo!=null){
                        this.receiverId=receiverInfo.getId().toString();
                        this.receiverName=receiverInfo.getReceiverName();
                }
                else{
                        this.receiverId="";
                        this.receiverName="";
                }
                this.ifRemarks=ifRemarks;
                this.remarks=remarks;
                this.ifMsg=ifMsg;
                this.additionalCost=additionalCost+"";
                this.sumAmount=sumAmount+"";
                this.expressPhotoUrl=expressPhotoUrl;
                this.boxPhotoUrls=boxPhotoUrls;
                this.orderId=orderId;
                this.handleStatus=handleStatus;
                this.operatorName=operatorName;
                this.productContent=getProductContent(orderDetailsList);
                this.expressInfo=expressInfo;
                this.senderInfo=senderInfo;
                this.receiverInfo=receiverInfo;
                this.orderDetailsList=orderDetailsList;
                for(ProductOrderDetails pod: this.orderDetailsList)
                        pod.setProductBox(this);
                this.tag=tag;
                this.weight=getWeight()+"";


        }


        public String elecExpressNoProperty()  { return elecExpressNo; }
        public String expressDateProperty()  { return expressDate; }
        public void setExpressDateProperty(String expressDate)  { this.expressDate = expressDate; }
        public String expressIdProperty()  { return expressId; }
        public String senderIdProperty()  { return senderId; }
        public String receiverIdProperty()  { return receiverId; }
        public String expressNameProperty()  { return expressName; }
        public String senderNameProperty()  { return senderName; }
        public String receiverNameProperty()  { return receiverName; }
        public String ifRemarksProperty()  { return ifRemarks; }
        public String tagProperty()  { return tag; }
        public void setTagProperty(String tag)  { this.tag = tag; }

        public String remarksProperty()  { return remarks; }
        public String ifMsgProperty()  { return ifMsg; }
        public String additionalCostProperty()  { return additionalCost; }
        public String sumAmountProperty()  { return sumAmount; }
        public String expressPhotoUrlProperty()  { return expressPhotoUrl; }
        public String boxPhotoUrlsProperty()  { return boxPhotoUrls; }
        public String orderIdProperty()  { return orderId; }
        public String handleStatusProperty()  { return handleStatus; }
        public String operatorNameProperty()  { return operatorName; }
        public String productContentProperty()  { return productContent; }
        public String weightProperty()  {
                double weightDouble=getWeight();
                weight=weightDouble<=0?"": weightDouble+"";
                return weight; }

        public double getAdditionalCost(){return Double.parseDouble(additionalCost);}
        public double getSumAmount(){return Double.parseDouble(sumAmount);}
        public TExpressInfo getExpressInfo (){return this.expressInfo;}
        public void setExpressInfo(TExpressInfo expressInfo){
                this.expressInfo=expressInfo;
                if(expressInfo!=null){
                    this.expressId=expressInfo.getId().toString();
                        this.expressName=expressInfo.getExpressName();
                }
                else{
                    this.expressId="";
                        this.expressName="";
                }
        }
        public void setProductOrder(TProductOrder productOrder) {
                this.productOrder=productOrder;
                this.orderId=productOrder.getId().toString();
                }
        public TProductOrder getProductOrder() {return this.productOrder;}
        public TSenderInfo getSenderInfo(){return this.senderInfo;}
        public void setSenderInfo(TSenderInfo senderInfo){
                this.senderInfo=senderInfo;
                if(senderInfo!=null){
                    this.senderId=senderInfo.getId().toString();
                        this.senderName=senderInfo.getSenderName();

                }
                else{
                        this.senderId="";
                        this.senderName="";

                }
        }
        public TReceiverInfo getReceiverInfo(){return this.receiverInfo;}
        public void setReceiverInfo(TReceiverInfo receiverInfo){
                this.receiverInfo=receiverInfo;
                if(receiverInfo!=null){
                        this.receiverId=receiverInfo.getId().toString();
                        this.receiverName=receiverInfo.getReceiverName();
                }
                else{
                        this.receiverId="";
                        this.receiverName="";
                }
        }

        public Date getExpressDate(){
                Date date=null;
                if(StringUtils.isEmpty(this.expressDate)) return null;
                try {
                        date=new SimpleDateFormat ("yyyyMMdd").parse(this.expressDate);
                } catch (ParseException e) {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                }
                return date;
        }

        /*public void setProductInfos(List<ProductInfo> productInfos){
                this.productInfos=productInfos;
        }

        public List<ProductInfo> getProductInfos(){
                return this.productInfos;
        }*/

        private void updateOrderDetailList(List<ProductOrderDetails> orderDetailsList){
                for(int i=0;i<orderDetailsList.size();i++){
                        orderDetailsList.get(i).setId(Long.valueOf(id));
                }
        }
        private String getProductContent(List<ProductOrderDetails> orderDetailsList){
                String content="";
                for(int i=0;i<orderDetailsList.size();i++){
                        content+=orderDetailsList.get(i).getProduct().getName()+"*"
                                        + orderDetailsList.get(i).getQuantity();
                        if(i<orderDetailsList.size()-1)
                                content+=",";
                }
                return content;
        }

        private Double getSumAmount(List<ProductOrderDetails> orderDetailsList){
                double amount=0;
                for(int i=0;i<orderDetailsList.size();i++){
                        amount+=orderDetailsList.get(i).getUnitPrice().doubleValue()*orderDetailsList.get(i).getQuantity();
                }
                return amount;
        }

        public void setAdditionalCost(String ifRemarks, String ifMsg){
                this.additionalCost=getAdditionalCost(ifRemarks, ifMsg)+"";
        }
        private double getAdditionalCost(String ifRemarks, String ifMsg){
                double remarkCost=0;
                double msgCost=0;
                remarkCost=ifRemarks.equals("Yes")?CommonConstants.IFMARK_FEE:0;
                msgCost=ifMsg.equals("Yes")?CommonConstants.MESSAGE_FEE:0;
                return remarkCost+msgCost;
        }

//        private String getExpressPhotoUrl(String expressNo){
//                return FilePath.EXPRESS_PIC.getPath()+expressNo+".jpg";
//        }

        public void setProductOrderDetailsList(List<ProductOrderDetails> orderDetailsList){
                this.orderDetailsList=orderDetailsList;
                for(ProductOrderDetails pod:this.orderDetailsList)
                        pod.setProductBox(this);
                this.productContent=getProductContent(orderDetailsList);
        }

        public List<ProductOrderDetails> getProductOrderDetailsList(){
                return this.orderDetailsList;
        }


        public void setProductOrderDetailsListCopy(List<ProductOrderDetails> orderDetailsList){
                this.orderDetailsListCopy=orderDetailsList;
                for(ProductOrderDetails pod:this.orderDetailsListCopy)
                        pod.setProductBox(this);
                //this.productContent=getProductContent(orderDetailsList));
        }

        public List<ProductOrderDetails> getProductOrderDetailsListCopy(){
                return this.orderDetailsListCopy;
        }


//        @Override
//        public List<String> getObservableData() {
//                // TODO Auto-generated method stub
//                List<String> observableData=FXCollections.observableArrayList();
//                //observableData.add(super.id);
//                //System.out.println(super.id.get());
//                //observableData.add(productNo);
//                observableData.add(elecExpressNo);
//                observableData.add(expressDate);
//                observableData.add(expressName);
//                observableData.add(tag);
//                observableData.add(senderName);
//                observableData.add(receiverName);
//                observableData.add(productContent);
//                observableData.add(ifRemarks);
//                observableData.add(remarks);
//                observableData.add(ifMsg);
//                observableData.add(weight);
//                observableData.add(sumAmount);
//                observableData.add(additionalCost);
//                observableData.add(handleStatus);
//                observableData.add(operatorName);
//
//                return observableData;
//        }
//        @Override
//        public boolean insertToDB() {
//                // TODO Auto-generated method stub
//                productBoxDao=new ProductBoxDao();
//                boolean flg=productBoxDao.add(this);
//                productBoxDao.close();
//                return flg;
//        }
//        @Override
//        public boolean updateInDB() {
//                // TODO Auto-generated method stub
//                productBoxDao=new ProductBoxDao();
//                boolean flg=productBoxDao.update(this);
//                productBoxDao.close();
//                return flg;
//        }
//        @Override
//        public boolean deleteFromDB() {
//                // TODO Auto-generated method stub
//                productBoxDao=new ProductBoxDao();
//                boolean flg=productBoxDao.delete(this);
//                productBoxDao.close();
//                return flg;
//        }
//        @Override
//        public long getNewId() {
//                // TODO Auto-generated method stub
//
//                productBoxDao=new ProductBoxDao();
//                long id=productBoxDao.getNewId();
//                productBoxDao.close();
//                return id;
//
//        }


        public double getPrice(){
                double price=0;
                double weight=0;
                if(orderDetailsList.size()==0) return price=0;
                ProductBoxType boxType=ProductBoxType.getProductBoxTypeByName(tag);
                for(ProductOrderDetails orderDetails:orderDetailsList){
                        price+=orderDetails.getUnitPrice().doubleValue()*orderDetails.getQuantity();
                        if(boxType!=null){
                                double materialWeight=Material.getMaterialByName(orderDetails
                                                .getProduct().getMaterial()).getWeight();
                                weight+=orderDetails.getProduct().getWeight()
                                                *orderDetails.getQuantity()+materialWeight;
                        }

                }
                if(boxType!=null){
                        weight+=boxType.getWeight();
                        weight=(double)Math.ceil(weight*10)/10.0;
                        if(weight<1) weight=1;
                        price+=weight*expressInfo.getInstantKiloCost().doubleValue();
                        price+=this.getAdditionalCost();
                }

        //      price+=discount*isDiscount;
                price=(double)Math.round(price*100)/100.00;
                return price;
        }

        public double getWeight(){
                double weight=0;
        //      List<ProductOrderDetails> productOrderDetailsList=this.getProductOrderDetailsList();
                if(orderDetailsList.size()==0) return weight;

        //      double isDiscount=isDeliveryDiscount(productOrderDetailsList);
                for(ProductOrderDetails orderDetails:orderDetailsList){
                        double materialWeight=Material.getMaterialByName(orderDetails
                                        .getProduct().getMaterial()).getWeight();
                        weight+=(orderDetails.getProduct().getWeight()+materialWeight)
                                        *orderDetails.getQuantity();
                }

                ProductBoxType boxType=ProductBoxType.getProductBoxTypeByName(tag);
                if(boxType!=null)
                    weight+=boxType.getWeight();

                //BigDecimal bd=new BigDecimal(weight).setScale(1, RoundingMode.HALF_UP);
                weight=(double)Math.ceil(weight*10)/10.0;
                if(weight<1)
                        weight=1;
                return weight;

        }

        /*

        private double isDeliveryDiscount(List<ProductOrderDetails> productOrderDetailsList){
                // return 0: not discount
                double isDiscount=0;
                if(productOrderDetailsList.size()>0){
                        String productType=productOrderDetailsList.get(0).getProductInfo().productTypeProperty().get();
                        String productNo=productOrderDetailsList.get(0).productNoProperty().get();
                        int number=0;
                        for(ProductOrderDetails orderDetails:productOrderDetailsList){
                                if(!orderDetails.productNoProperty().get().equals(productNo))
                                        return isDiscount;
                                else
                                        number+=orderDetails.getQuantity();
                        }
                        int maxNum=ProductType.getProductTypeByName(productType).getMaxNum();
                        if(number!=maxNum)
                                return isDiscount;
                        else
                                isDiscount=1;
                }
                return isDiscount;
        }*/

//        public void saveExpressPic(){
//                if(expressName.get().equals("")||elecExpressNo.get().equals("")) return;
//                DeliveryPicOperation dpOperation=null;
//                String expressPhotoUrl= EncodingUtil.getHashCode(this.elecExpressNo.get())+".jpg";
//                this.expressPhotoUrl=expressPhotoUrl);
//                if(this.expressName.get().equals("蓝天"))
//                        dpOperation=new DeliveryPicOperation(FilePath.BLUESKY_TEMPLATE.getPath());
//                else if(this.expressName.get().equals("狂派"))
//                        dpOperation=new DeliveryPicOperation(FilePath.FQ_TEMPLATE.getPath());
//                else if(this.expressName.get().equals("龙门"))
//                        dpOperation=new DeliveryPicOperation(FilePath.LM_TEMPLATE.getPath());
//                else if(this.expressName.get().equals("速品"))
//                        dpOperation=new DeliveryPicOperation(FilePath.SP_TEMPLATE.getPath());
//                else if(this.expressName.get().equals("星速递"))
//                        dpOperation=new DeliveryPicOperation(FilePath.SSD_TEMPLATE.getPath());
//                else
//                        return;
//
//
//                String outputPath=FilePath.EXPRESS_PIC.getPath()+"source/"+this.expressPhotoUrl.get();
//                File file= new File(outputPath);
//                if(file.exists())
//                   file.delete();
//            HashMap<String, Integer> products=new HashMap<String, Integer>();
//            for(ProductOrderDetails details:this.getProductOrderDetailsList()){
//                products.put(details.productNameProperty().get(), (int)details.getQuantity());
//            }
//
//            // need to upload to OZTT_Pic/EXPRESS/xxx
//
//            dpOperation.createDeliveryPic(outputPath
//                        ,this.elecExpressNo.get(),this.senderInfo.senderNameProperty().get()
//                        , this.senderInfo.senderTelProperty().get(),""
//                        , this.receiverInfo.receiverNameProperty().get()
//                        , this.receiverInfo.receiverTelProperty().get()
//                                , this.receiverInfo.receiverAddrProperty().get()
//                                , products, getWeight()+"", this.getExpressDate());
//
//
//        }


//        public String isPackingable(String expressName){
//                String msg="";
//                List<ProductOrderDetails> orderDetailsList=FXCollections.observableArrayList();
//                orderDetailsList.addAll(this.orderDetailsList);
//                if(ExpressUtil.initilizeExpressConfig(expressName)){
//                        ProductBoxType type=ProductBoxType.getProductBoxTypeByName(this.tag.get());
//                        double[] sizes=ExpressUtil.getSortedSizes(type.getSize());
//
//                        double bvolume=sizes[0]*sizes[1]*sizes[2];
//                        if(getVolume(orderDetailsList)>bvolume*(1+(double)Conf.BOX_MARGIN.getLongValue()/100.0))
//                                return "超过箱子体积";
//                        if(getScore(orderDetailsList)>(double)Conf.TOTAL_SCORE.getLongValue())
//                                return "超过规定价值";
//                        if(getWeight(orderDetailsList, tag.get())>(double)Conf.TOTAL_WEIGHT.getLongValue()/1000.0)
//                                return "超过最大重量";
//                        for(ProductOrderDetails pod: orderDetailsList){
//                                Product product=pod.getProduct();
//                                double[] psizes=ExpressUtil.getSortedSizes(product.sizeProperty().get());
//                                if(psizes[0]>sizes[0]||psizes[1]>sizes[1]||psizes[2]>sizes[2])
//                                        return "货物尺寸超过箱子";
//                        }
//
//                }
//                return msg;
//        }
//
//        public String isPackingable(ProductOrderDetails newOd, String expressName, String boxType){
//                String msg="";
//                List<ProductOrderDetails> orderDetailsList=FXCollections.observableArrayList();
//                orderDetailsList.addAll(this.orderDetailsList);
//                orderDetailsList.add(newOd);
//                if(ExpressUtil.initilizeExpressConfig(expressName)){
//                        ProductBoxType type=ProductBoxType.getProductBoxTypeByName(boxType);
//                        double[] sizes=ExpressUtil.getSortedSizes(type.getSize());
//                        double bvolume=sizes[0]*sizes[1]*sizes[2];
//                        if(getVolume(orderDetailsList)>bvolume*(1+(double)Conf.BOX_MARGIN.getLongValue()/100.0))
//                                return "超过箱子体积";
//                        if(getScore(orderDetailsList)>(double)Conf.TOTAL_SCORE.getLongValue())
//                                return "超过规定价值";
//                        if(getWeight(orderDetailsList, boxType)>(double)Conf.TOTAL_WEIGHT.getLongValue()/1000.0)
//                                return "超过最大重量";
//                        for(ProductOrderDetails pod: orderDetailsList){
//                                Product product=pod.getProduct();
//                                double[] psizes=ExpressUtil.getSortedSizes(product.sizeProperty().get());
//                                if(psizes[0]>sizes[0]||psizes[1]>sizes[1]||psizes[2]>sizes[2])
//                                        return "货物尺寸超过箱子";
//                        }
//
//                }
//                return msg;
//        }


//        public void copyStringProperty(String sp){
//                String newStr=new String(sp.get());
//                sp=new SimpleStringProperty(newStr);
//        }

//        public ProductOrderDetails getProductOrderDetails(String productName){
//                for(ProductOrderDetails pod: orderDetailsList){
//                        if(pod.productNameProperty().get().equals(productName))
//                                return pod;
//                }
//                return null;
//        }
//
//
//        public ProductBox getFullCopy(){
//
//                List<ProductOrderDetails> orderDetailsList=FXCollections.observableArrayList();
//                for(ProductOrderDetails orderDetails: this.orderDetailsList)
//                        orderDetailsList.add(orderDetails.getFullCopy());
//
//                ProductBox productBox=new ProductBox(this.getId(), this.elecExpressNo.get(), this.getExpressDate()
//                                , this.expressInfo,  this.senderInfo, this.receiverInfo, this.ifRemarks.get(), this.remarks.get()
//                                , this.ifMsg.get(),  getAdditionalCost(this.ifRemarks.get(), this.ifMsg.get())
//                                , getPrice(), this.boxPhotoUrls.get(), this.expressPhotoUrl.get()
//                                , this.orderId.get(), this.handleStatus.get(), this.operatorName.get()
//                                , this.tag.get(), orderDetailsList, this.getAddTimestamp()
//                                , this.addUserKey.get(), this.getUpdTimestamp(), this.updUserKey.get(), this.updPgmId.get());
//                        productBox.setProductOrder(getProductOrder());
//                return productBox;
//                //getProductOrder().getProductBoxes().add(productBox);
//                //getProductOrder().sumAmountProperty()=getProductOrder().getTotalPrice()+"");
//        }


//
//        
//        @Override
//        public Object clone() throws CloneNotSupportedException {
//                ProductBox newBox=(ProductBox)super.clone();
//        //      String expressNo=new String(newBox.elecExpressNoProperty().get());
//                newBox.copyStringProperty(elecExpressNoProperty());
//        return newBox;
//   }

        public double getVolume(List<ProductOrderDetails> orderDetailsList){
                double volumn=0;
                if(orderDetailsList.size()==0) return volumn=0;

                //      double isDiscount=isDeliveryDiscount(productOrderDetailsList);
                for(ProductOrderDetails orderDetails:orderDetailsList){
                        TProduct product=orderDetails.getProduct();
                        String[] sizes=product.getSize().split("\\*");
                        double vol=Double.parseDouble(sizes[0])*Double.parseDouble(sizes[1])
                                        *Double.parseDouble(sizes[2]);
                        volumn+=vol*orderDetails.getQuantity();
                }
                return volumn;


        }

        public double getScore(List<ProductOrderDetails> orderDetailsList){
                double totalScore=0;
                if(orderDetailsList.size()==0) return totalScore=0;

                //      double isDiscount=isDeliveryDiscount(productOrderDetailsList);
                for(ProductOrderDetails orderDetails:orderDetailsList){
                        TProduct product=orderDetails.getProduct();
                        double score=DeliveryType.getDeliveryTypeByName(product.getDeliveryType()).getScore();
                        totalScore+=score*orderDetails.getQuantity();
                }
                return totalScore;


        }

        public double getWeight(List<ProductOrderDetails> orderDetailsList
                        , String type){
                double weight=0;
        //      List<ProductOrderDetails> productOrderDetailsList=this.getProductOrderDetailsList();
                if(orderDetailsList.size()==0) return weight;

        //      double isDiscount=isDeliveryDiscount(productOrderDetailsList);
                for(ProductOrderDetails orderDetails:orderDetailsList){
                        double materialWeight=Material.getMaterialByName(orderDetails
                                        .getProduct().getMaterial()).getWeight();
                        weight+=(orderDetails.getProduct().getWeight()+materialWeight)
                                        *orderDetails.getQuantity();
                }

                ProductBoxType boxType=ProductBoxType.getProductBoxTypeByName(type);
                if(boxType!=null)
                    weight+=boxType.getWeight();

                //BigDecimal bd=new BigDecimal(weight).setScale(1, RoundingMode.HALF_UP);
                weight=(double)Math.floor(weight*10)/10.0;
                if(weight<1)
                        weight=1;
                return weight;

        }



        public double getInstantWeight(){ return 0;}
        public double getCommWeight(){ return 0;}
        public double getOtherWeight(){ return 0;}


}
