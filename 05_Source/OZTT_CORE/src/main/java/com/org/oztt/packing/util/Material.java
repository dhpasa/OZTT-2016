package com.org.oztt.packing.util;

public enum Material {
PAPER("纸", "1", 0),
PLASTIC("塑料", "2", 0),
GLASS("玻璃", "3", 0.01),
METAL("金属", "4",0.02),
NA("无", "5",0);

        private double weight;
        private String name;
        private String id;
        private Material(String name, String id, double weight){
                this.name=name;
                this.id=id;
                this.weight=weight;
        }

        public String getName(){return this.name;}

        public String getId(){return this.id;}
        public double getWeight(){return this.weight;}

        public static Material getMaterialByName(String name){
                if(name.equals("纸"))
                        return PAPER;
                else if(name.equals("塑料"))
                        return PLASTIC;
                else if(name.equals("玻璃"))
                        return GLASS;
                else if(name.equals("金属"))
                        return METAL;
                else
                        return NA;
        }

        public static Material getMaterialById(String id){
                if(id.equals("1"))
                        return PAPER;
                else if(id.equals("2"))
                        return PLASTIC;
                else if(id.equals("3"))
                        return GLASS;
                else if(id.equals("4"))
                        return METAL;
                else
                        return NA;
        }

        @Override
        public String toString(){
                return this.name;
        }
}
