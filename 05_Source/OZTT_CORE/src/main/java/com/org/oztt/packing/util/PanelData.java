package com.org.oztt.packing.util;

import java.awt.Panel;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public abstract class PanelData {

    protected Panel  panel;

    protected String id;

    protected String addTimestamp;

    protected String addUserKey;

    protected String updTimestamp;

    protected String updUserKey;

    protected String updPgmId;

    public PanelData()
    {
        this.panel = new Panel();
        id = "-1";
        this.addTimestamp = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(new Date());
        this.updTimestamp = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(new Date());
        this.updPgmId = "desktop";
        //this.addUserKey=SystemUser.CURRENT_USER.getName());
        //this.updUserKey=SystemUser.CURRENT_USER.getName());
    }

    public PanelData(long id, Date addTimestamp, String addUserKey, Date updTimestamp, String updUserKey,
            String updPgmId)
    {
        this.id = id + "";

        if (updTimestamp == null)
            this.updTimestamp = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(new Date());
        else
            this.updTimestamp = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(updTimestamp);
        if (addTimestamp == null)
            this.addTimestamp = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(updTimestamp);
        else
            this.addTimestamp = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(addTimestamp);

        this.addUserKey = addUserKey == null ? "" : addUserKey;
        this.updUserKey = updUserKey == null ? "" : updUserKey;
        this.updPgmId = updPgmId == null ? "" : updPgmId;
        this.panel = new Panel();
    }

    public String idProperty() {
        return id;
    }

    public String addUserKeyProperty() {
        return addUserKey;
    }

    public String addTimestampProperty() {
        return addTimestamp;
    }

    public String updTimestampProperty() {
        return updTimestamp;
    }

    public String updUserKeyProperty() {
        return updUserKey;
    }

    public String updPgmIdProperty() {
        return updPgmId;
    }

    public long getId() {
        return Long.parseLong(id);
    }

    public Date getAddTimestamp() {
        Date date = null;
        try {
            date = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").parse(this.addTimestamp);
        }
        catch (ParseException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return date;
    }

    public void setAddTimestamp(Date addTimestamp) {
        this.addTimestamp = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(addTimestamp);
    }

    public Date getUpdTimestamp() {
        Date updTimestamp = null;
        try {
            updTimestamp = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").parse(this.updTimestamp);
        }
        catch (ParseException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return updTimestamp;
    }

    public void setUpdTimestamp(Date updTimestamp) {
        this.updTimestamp = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(updTimestamp);
    }

    public void setPanel(Panel panel) {
        this.panel = panel;
    }

    public Panel getPanel() {
        return this.panel;
    }

    //public abstract List<String> getObservableData();

    //public abstract boolean insertToDB();

    //public abstract boolean updateInDB();

    //public abstract boolean deleteFromDB();

    //public abstract long getNewId();

}
