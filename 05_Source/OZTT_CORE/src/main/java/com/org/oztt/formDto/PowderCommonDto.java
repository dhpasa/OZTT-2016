package com.org.oztt.formDto;

import java.util.ArrayList;
import java.util.List;

import com.org.oztt.contants.CommonConstants;

public class PowderCommonDto {

    private String                id;

    private String                name;

    private List<PowderCommonDto> child = new ArrayList<PowderCommonDto>();
    
    private static final int[] BABY_ITEM = {1, 2, 3, 6};
    
    private static final int[] ADULT_ITEM = {1, 2, 3, 4, 5, 6, 8};

    public PowderCommonDto()
    {

    }

    /**
     * 
     * @param type 1：婴儿 2:成人
     */
    public PowderCommonDto(String type)
    {
        List<PowderCommonDto> re = new ArrayList<PowderCommonDto>();
        if (CommonConstants.POWDER_TYPE_BABY.equals(type)) {
            // 婴儿奶粉
            for (int item : BABY_ITEM) {
                PowderCommonDto d = new PowderCommonDto();
                d.setId(String.valueOf(item));
                d.setName(d.getId() + "罐");
                re.add(d);
            }
        } else {
            // 婴儿奶粉
            for (int item : ADULT_ITEM) {
                PowderCommonDto d = new PowderCommonDto();
                d.setId(String.valueOf(item));
                d.setName(d.getId() + "罐");
                re.add(d);
            }
        }
        
        
        child = re;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<PowderCommonDto> getChild() {
        return child;
    }

    public void setChild(List<PowderCommonDto> child) {
        this.child = child;
    }
}
