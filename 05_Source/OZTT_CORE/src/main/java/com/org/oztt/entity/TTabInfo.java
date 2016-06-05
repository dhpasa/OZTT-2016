package com.org.oztt.entity;

import java.io.Serializable;

public class TTabInfo implements Serializable{
    /**
     * 
     */
    private static final long serialVersionUID = -7244916995190851647L;

    private Long id;

    private String tabname;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTabname() {
        return tabname;
    }

    public void setTabname(String tabname) {
        this.tabname = tabname;
    }
}