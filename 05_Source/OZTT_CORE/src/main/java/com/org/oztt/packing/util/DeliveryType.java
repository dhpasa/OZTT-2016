package com.org.oztt.packing.util;

public enum DeliveryType {

FOOD("小包装食品", "1", 2),
DFOOD("大包装食品","2", 5),
XIHU("洗护", "3", 3),
SHIPIN("饰品", "4", 5),
POWDER("奶粉", "5", 2),
RYP("日用品", "6", 2),
HZP("化妆品","7", 10),
CLOTH("服装","8", 10),
SHOE("鞋","9", 20),
BED("床上用品","10", 10),
WINE("酒","11", 10),
DQ("电器","12", 5),
FEE("费用","13", 0);


        private String name;
        private String id;
        private double score;
        private DeliveryType(String name, String id, double score){
                this.name=name;
                this.id=id;
                this.score=score;
        }

        public double getScore() {return this.score;}
        public void setScore(double score){this.score=score;}
        public String getName(){return this.name;}

        public String getId(){return this.id;}

        public static DeliveryType getDeliveryTypeByName(String name){
                if(name.equals("小包装食品"))
                        return FOOD;
                else if(name.equals("大包装食品"))
                        return DFOOD;
                else if(name.equals("洗护"))
                        return XIHU;
                else if(name.equals("饰品"))
                        return SHIPIN;
                else if(name.equals("奶粉"))
                        return POWDER;
                else if(name.equals("日用品"))
                        return RYP;
                else if(name.equals("化妆品"))
                        return HZP;
                else if(name.equals("服装"))
                        return CLOTH;
                else if(name.equals("鞋"))
                        return SHOE;
                else if(name.equals("床上用品"))
                        return BED;
                else if(name.equals("酒"))
                        return WINE;
                else if(name.equals("电器"))
                        return DQ;
                else
                        return FEE;

        }

        public static DeliveryType getDeliveryTypeById(String id){
                if(id.equals("1"))
                        return FOOD;
                else if(id.equals("2"))
                        return DFOOD;
                else if(id.equals("3"))
                        return XIHU;
                else if(id.equals("4"))
                        return SHIPIN;
                else if(id.equals("5"))
                        return POWDER;
                else if(id.equals("6"))
                        return RYP;
                else if(id.equals("7"))
                        return HZP;
                else if(id.equals("8"))
                        return CLOTH;
                else if(id.equals("9"))
                        return SHOE;
                else if(id.equals("10"))
                        return BED;
                else if(id.equals("11"))
                        return WINE;
                else if(id.equals("12"))
                        return DQ;
                else
                        return FEE;

        }

        @Override
        public String toString(){
                return this.name;
        }
}
