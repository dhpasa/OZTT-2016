package com.org.oztt.packing.util;

import java.io.FileInputStream;
import java.io.InputStream;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import com.org.oztt.entity.TProduct;
import com.org.oztt.formDto.ProductOrderDetails;

public class PackingUtil {

    private List<ProductBoxType> boxTypes       = new ArrayList<ProductBoxType>();

    List<Item>                   itemsPlaced;

    List<ProductOrderDetails>    odList;

    List<ProductBox>             productBoxes;

    private long                           totalScore     = 0;

    private long                           totalWeight    = 0;

    private long                           itemCount      = 0;

    private long                           totalItemCount = 0;

    public PackingUtil(String expressName, List<ProductOrderDetails> odList,
            List<ProductBox> productBoxes) throws Exception
    {
        boxTypes.add(ProductBoxType.B1);
        boxTypes.add(ProductBoxType.B2);
        boxTypes.add(ProductBoxType.B3);
        boxTypes.add(ProductBoxType.B4);
        boxTypes.add(ProductBoxType.B6);
        this.odList = odList;
        this.productBoxes = productBoxes;

        this.itemsPlaced = new ArrayList<Item>(); 
        //ExpressUtil.initilizeExpressConfig(expressName);
        initilizeExpressConfig(expressName);
        this.itemCount = Conf.ITEM_COUNT.getLongValue();
        this.totalItemCount = Conf.TOTAL_ITEM_COUNT.getLongValue();
        assign();

    }
    
    private void initilizeExpressConfig(String expressName) throws Exception{
        String s = PackingUtil.class.getResource("/").getPath().toString();
        s = java.net.URLDecoder.decode(s, "UTF-8");

        if(expressName.equals("蓝天")) {
            
            String configurationPath = s + "/bluesky.properties";
            Properties prop = new Properties();
            InputStream inputStream = new FileInputStream(configurationPath);
            prop.load(inputStream);
            this.totalScore = Long.valueOf(prop.getProperty("totalWeight", "30"));
            this.totalWeight = Long.valueOf(prop.getProperty("totalScore", "5500"));
        }
          
        else if(expressName.equals("狂派")) {
            String configurationPath = s + "/freakyquick.properties";
            Properties prop = new Properties();
            InputStream inputStream = new FileInputStream(configurationPath);
            prop.load(inputStream);
            this.totalScore = Long.valueOf(prop.getProperty("totalWeight", "30"));
            this.totalWeight = Long.valueOf(prop.getProperty("totalScore", "5500"));
        }
          
        else if(expressName.equals("龙门")) {
            String configurationPath = s + "/longmen.properties";
            Properties prop = new Properties();
            InputStream inputStream = new FileInputStream(configurationPath);
            prop.load(inputStream);
            this.totalScore = Long.valueOf(prop.getProperty("totalWeight", "30"));
            this.totalWeight = Long.valueOf(prop.getProperty("totalScore", "5500"));
      
        }
          
        else if(expressName.equals("速品")) {
            String configurationPath = s + "/supin.properties";
            Properties prop = new Properties();
            InputStream inputStream = new FileInputStream(configurationPath);
            prop.load(inputStream);
            this.totalScore = Long.valueOf(prop.getProperty("totalWeight", "30"));
            this.totalWeight = Long.valueOf(prop.getProperty("totalScore", "5500"));
        }
          
        else if(expressName.equals("星速递")){
            String configurationPath = s + "/xingsudi.properties";
            Properties prop = new Properties();
            InputStream inputStream = new FileInputStream(configurationPath);
            prop.load(inputStream);
            this.totalScore = Long.valueOf(prop.getProperty("totalWeight", "30"));
            this.totalWeight = Long.valueOf(prop.getProperty("totalScore", "5500"));
        }
        
        else if(expressName.equals("天越")){
            String configurationPath = s + "/tianyue.properties";
            Properties prop = new Properties();
            InputStream inputStream = new FileInputStream(configurationPath);
            prop.load(inputStream);
            this.totalScore = Long.valueOf(prop.getProperty("totalWeight", "30"));
            this.totalWeight = Long.valueOf(prop.getProperty("totalScore", "5500"));
        }
          
        else {
      
        }
    }

    public List<ProductBox> getAssignedProductBoxes() {
        return productBoxes;
    }

    public List<ProductOrderDetails> getAssignedODList() {
        return odList;
    }

    private String[] getLowerBound(List<Item> items) {
        String[] results = { "1", "score" };
        double weight = 0;
        for (Item item : items) {
            weight += item.getWeight();
        }
        double score = 0;
        for (Item item : items) {
            score += item.getScore();
        }
        int num1 = (int) Math.ceil(score / totalScore);
        int num2 = (int) Math.ceil(weight / totalWeight);
        if (num1 > num2) {
            results[0] = num1 + "";
            results[1] = "score";
        }
        else {
            results[0] = num2 + "";
            results[1] = "weight";
        }

        return results;
    }

    private void assign() {
        List<Item> items = transferFromOD(odList);
        List<Box> boxes = transferFromProductBoxes(productBoxes);

        // decide the minimum box number&bound type
        String[] result = getLowerBound(items);
        int minBoxNum = Integer.parseInt(result[0]);
        //	String boundType=result[1];
        // create the minimum number of boxes
        int startBoxId = 0;
        if (boxes.size() > minBoxNum) {
            for (int i = boxes.size() - 1; i >= minBoxNum; i--) {
                Box box = boxes.get(i);
                boxes.remove(box);
            }
        }
        else if (boxes.size() < minBoxNum) {
            for (int i = 0; i < boxes.size(); i++) {
                if (boxes.get(i).getId().indexOf("号箱") >= 0) {
                    int id = Integer.parseInt(boxes.get(i).getId().replace("号箱", ""));
                    if (id > startBoxId)
                        startBoxId = id;
                }
            }
            for (int j = boxes.size(); j < minBoxNum; j++) {
                startBoxId++;
                boxes.add(new Box(startBoxId + "号箱", ProductBoxType.B1));
            }

        }
        startBoxId++;
        // while(items to be placed are not empty)
        //sort boxes asc in weight
        //sort items desc in weight
        //place the item with the heaviest weight into the lightest box while the score constraint is not violated
        assign(items, boxes, startBoxId);
        this.productBoxes = transferToProductBoxes(boxes);
        odList.clear();
        for (ProductBox box : this.productBoxes) {
            odList.addAll(box.getProductOrderDetailsList());
        }

    }

    private void assign(List<Item> items, List<Box> boxes, int startBoxId) {
        List<Item> placedItems = new ArrayList<Item>(); 
        while (items.size() > 0) {
            sortItemsByWeightDesc(items);
            Item heaviestItem = items.get(0);
            Box lightestBox = getLightestBox(heaviestItem, boxes);
            if (lightestBox == null) {
                for (Item item : placedItems)
                    item.removeFromBox();
                items.addAll(placedItems);
                boxes.add(new Box(startBoxId + "号箱", ProductBoxType.B1));
                startBoxId++;
                assign(items, boxes, startBoxId);
            }
            else {
                heaviestItem.placeOnBox(lightestBox);
                items.remove(heaviestItem);
                placedItems.add(heaviestItem);

            }
        }
        for (int i = 0; i < boxes.size(); i++) {
            Box box = boxes.get(i);
            setBestBoxType(box);
        }
    }

    private Box getLightestBox(Item item, List<Box> boxes) {
        Box lightestBox = null;
        double weight = Double.MAX_VALUE;
        for (int i = 0; i < boxes.size(); i++) {
            Box box = boxes.get(i);
            item.placeOnBox(box);
            setBestBoxType(box);
            if (box.getTotalScore() <= totalScore && box.getWeight() <= totalWeight
                    && box.getItemCount(item) <= itemCount && box.getTotalItemCount() <= totalItemCount) {
                double boxWeight = box.getWeight();
                if (boxWeight < weight) {
                    lightestBox = box;
                    weight = boxWeight;
                }
            }
            item.removeFromBox();
        }
        return lightestBox;

    }

    private List<ProductBox> transferToProductBoxes(List<Box> boxes) {
        List<ProductBox> productBoxes = new ArrayList<ProductBox>(); 
        for (Box box : boxes) {
            if (box.getProductBox() != null) {
                transferToOD(box.getItems(), box.getProductBox());
                box.getProductBox().setTagProperty(box.getProductBoxType().getName());
                
                productBoxes.add(box.getProductBox());
            }
            else {
                ProductBox productBox = new ProductBox();
                productBox.setTagProperty(box.getProductBoxType().getName());
                transferToOD(box.getItems(), productBox);
                productBoxes.add(productBox);
                productBox.id = box.getId();
                productBox.setExpressDateProperty(new SimpleDateFormat("yyyyMMdd").format(new Date()));
            }
        }
        return productBoxes;
    }

    private List<Box> transferFromProductBoxes(List<ProductBox> productBoxes) {
        List<Box> boxes = new ArrayList<Box>();
        for (ProductBox b : productBoxes) {
            if (!b.tagProperty().equals(""))
                boxes.add(new Box(b.idProperty(), ProductBoxType.B1, b));
        }
        return boxes;
    }

    private void setBestBoxType(Box box) {
        for (int i = 0; i < boxTypes.size(); i++) {
            //ProductBoxType type=boxTypes.get(i);
            box.setBoxType(boxTypes.get(i));
            if (box.getRestVolume() >= 0 && box.isPackingable())
                break;
        }

    }

    private long caculateScore(List<Item> items) {
        long score = 0;
        for (Item item : items)
            score += item.getScore();
        return score;
    }

    private List<Item> transferFromOD(List<ProductOrderDetails> list) {
        List<Item> items = new ArrayList<Item>();
        int index = 0;
        for (ProductOrderDetails od : list) {
            String name = od.getProduct().getName();
            String sizesStr = od.getProduct().getSize();
            double[] sizes = new double[3];
            sizes[0] = Double.parseDouble(sizesStr.split("\\*")[0]);
            sizes[1] = Double.parseDouble(sizesStr.split("\\*")[1]);
            sizes[2] = Double.parseDouble(sizesStr.split("\\*")[2]);
            double weight = od.getProduct().getWeight();
            double score = DeliveryType.getDeliveryTypeByName(od.getProduct().getDeliveryType()).getScore();
            for (int i = 0; i < od.getQuantity(); i++) {
                items.add(new Item(index, name, sizes, weight, od.getUnitPrice().doubleValue(), score, od.getProduct()));
                index++;
            }

        }

        return items;
    }

    private List<ProductOrderDetails> transferToOD(List<Item> items, ProductBox box) {
        List<ProductOrderDetails> list = new ArrayList<ProductOrderDetails>();
        Map<String, ProductOrderDetails> maps = new HashMap<String, ProductOrderDetails>();

        for (Item item : items) {
            if (maps.containsKey(item.getName())) {
                ProductOrderDetails od = maps.get(item.getName());
                long quantity = od.getQuantity();
                quantity += 1;
                od.setQuantity(quantity);

            }
            else {
                ProductOrderDetails od = new ProductOrderDetails(item.getProduct(), 1L, new BigDecimal(item.getPrice()));
                od.setProductBox(box);
                list.add(od);
                maps.put(item.getName(), od);

            }

        }
        box.setProductOrderDetailsList(list);
        return list;
    }

    private void sortItemsByWeightDesc(List<Item> items) {
        if (items.size() <= 1)
            return;
        Collections.sort(items, new Comparator<Item>() {
            public int compare(Item arg0, Item arg1) {
                if (arg0.getWeight() > arg1.getWeight())
                    return -1;
                else if (arg0.getWeight() == arg1.getWeight())
                    return 0;
                else
                    return 1;
            }
        });
    }

    class Item {
        private int      id;

        private String   name;

        private double[] sizes;

        private double   weight;

        private double   price;

        private TProduct  product;

        private double   score;

        private Box      box;

        private Item(int id, String name, double[] sizes, double weight, double price, double score, TProduct product)
        {
            this.id = id;
            this.name = name;
            this.sizes = sizes;
            this.weight = weight;
            this.score = score;
            this.box = null;
            this.price = price;
            this.product = product;

        }

        private String getName() {
            return this.name;
        }

        private void placeOnBox(Box box) {
            this.box = box;
            box.getItems().add(this);
        }

        private void removeFromBox() {
            if (this.box != null) {
                box.getItems().remove(this);
                box = null;
            }
        }

        private TProduct getProduct() {
            return this.product;
        }

        private double getPrice() {
            return this.price;
        }

        private double getScore() {
            return this.score;
        }

        private double getVolume() {
            return sizes[0] * sizes[1] * sizes[2];
        }

        private String getSize() {
            return sizes[0] + "*" + sizes[1] + "*" + sizes[2];
        }

        private double getWeight() {
            return weight;
        }

    }

    class Box {
        private String               id;

        private ProductBoxType       boxType;

        private List<Item> items = new ArrayList<Item>();

        private ProductBox           productBox;

        private Box(String id, ProductBoxType boxType, ProductBox productBox)
        {
            this.id = id;
            this.boxType = boxType;
            this.productBox = productBox;
        }

        public Box(String id, ProductBoxType boxType)
        {
            this.id = id;
            this.boxType = boxType;
            this.productBox = null;
            // TODO Auto-generated constructor stub
        }

        private ProductBox getProductBox() {
            return this.productBox;
        }

        private void setBoxType(ProductBoxType boxType) {
            this.boxType = boxType;
        }

        private ProductBoxType getProductBoxType() {
            return this.boxType;
        }

        private List<Item> getItems() {
            return this.items;
        }

        private String getId() {
            return id;
        }

        private double getTotalScore() {
            return caculateScore(items);
        }

        private double getTotalVolume() {
            String sizesStr = boxType.getSize();
            double[] sizes = new double[3];
            sizes[0] = Double.parseDouble(sizesStr.split("\\*")[0]);
            sizes[1] = Double.parseDouble(sizesStr.split("\\*")[1]);
            sizes[2] = Double.parseDouble(sizesStr.split("\\*")[2]);
            return sizes[0] * sizes[1] * sizes[2] * (1 + (double) Conf.BOX_MARGIN.getLongValue() / 100.0);
        }

        private boolean isPackingable() {
//            double[] sizes = ExpressUtil.getSortedSizes(boxType.getSize());
//            for (Item item : items) {
//                double[] psizes = ExpressUtil.getSortedSizes(item.getSize());
//                if (psizes[0] > sizes[0] || psizes[1] > sizes[1] || psizes[2] > sizes[2])
//                    return false;
//            }
            return true;

        }

        private double getRestVolume() {
            double totalVolume = getTotalVolume();
            double volume = 0;
            for (Item item : items) {
                volume += item.getVolume();
            }
            double restVolume = totalVolume - volume;
            return restVolume;

        }

        private double getWeight() {
            double weight = 0;
            for (Item item : items) {
                weight += item.getWeight();
            }
            weight += boxType.getWeight();
            return weight;

        }

        private long getItemCount(Item item) {
            long count = 0;
            for (Item it : items) {
                if (it.getName().equals(item))
                    count++;
            }
            return count;
        }

        private long getTotalItemCount() {

            return items.size();
        }

    }

}
