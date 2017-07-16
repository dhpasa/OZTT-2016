package com.org.oztt.formDto;

import java.util.ArrayList;
import java.util.List;

import com.org.oztt.base.common.MyCategroy;

public class MainCategoryDto {

    private MyCategroy myCategroy;
    
    private List<GroupItemDto> groupItemDtoList = new ArrayList<GroupItemDto>();

    public MyCategroy getMyCategroy() {
        return myCategroy;
    }

    public void setMyCategroy(MyCategroy myCategroy) {
        this.myCategroy = myCategroy;
    }

    public List<GroupItemDto> getGroupItemDtoList() {
        return groupItemDtoList;
    }

    public void setGroupItemDtoList(List<GroupItemDto> groupItemDtoList) {
        this.groupItemDtoList = groupItemDtoList;
    }
}
