package com.org.oztt.formDto;

import java.util.ArrayList;
import java.util.List;

public class PowderCommonDto {

    private String                id;

    private String                name;

    private List<PowderCommonDto> child = new ArrayList<PowderCommonDto>();

    public PowderCommonDto()
    {

    }

    public PowderCommonDto(int number)
    {
        List<PowderCommonDto> re = new ArrayList<PowderCommonDto>();
        int i = 0;
        while (number > 0) {
            number--;
            PowderCommonDto d = new PowderCommonDto();
            d.setId(String.valueOf(++i));
            d.setName(d.getId());
            re.add(d);
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
