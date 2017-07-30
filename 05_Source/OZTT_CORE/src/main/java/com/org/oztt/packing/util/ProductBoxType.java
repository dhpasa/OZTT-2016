package com.org.oztt.packing.util;

public enum ProductBoxType {
        B1("一罐箱", "13.3*14*17.3", 0.1033),
        B2("两罐箱", "26.6*18.7*14.4", 0.2034),
        B3("三罐箱", "39.5*13.4*18.5", 0.2564),
        B4("四罐箱", "27*19*26.5", 0.3736),
        B6("六罐箱", "28*42*17.5", 0.4544);
        private String name;
        private String size;
        private double weight;
        private ProductBoxType(String name, String size, double weight){
                this.name=name;
                this.size=size;
                this.weight=weight;
        }

        public String getName(){return this.name;}

        public String getSize(){return this.size;}

        public double getWeight(){return this.weight;}

        public static ProductBoxType getProductBoxTypeByName(String name){
                if(name.equals("一罐箱"))
                        return B1;
                if(name.equals("两罐箱"))
                        return B2;
                if(name.equals("三罐箱"))
                        return B3;
                if(name.equals("四罐箱"))
                        return B4;
                else if(name.equals("六罐箱"))
                        return B6;
                else
                        return null;
        }


        @Override
        public String toString(){
                return this.name;
        }
}
