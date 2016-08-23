package com.org.oztt.entity;

import java.io.Serializable;
import java.util.Date;

public class TCustomerBasicInfo implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long no;

    private String customerno;

    private String cnsurname;

    private String cngivenname;

    private String enfirstname;

    private String enmiddlename;

    private String enlastname;

    private String idcardno;

    private String passportno;

    private String sex;

    private String nickname;

    private String birthday;

    private String headpic;

    private String marriage;

    private String education;

    private String occupation;
    
    private String comments;

    private String deleteflg;

    private Date addtimestamp;

    private String adduserkey;

    private Date updtimestamp;

    private String upduserkey;

    private String updpgmid;

    public Long getNo() {
        return no;
    }

    public void setNo(Long no) {
        this.no = no;
    }

    public String getCustomerno() {
        return customerno;
    }

    public void setCustomerno(String customerno) {
        this.customerno = customerno;
    }

    public String getCnsurname() {
        return cnsurname;
    }

    public void setCnsurname(String cnsurname) {
        this.cnsurname = cnsurname;
    }

    public String getCngivenname() {
        return cngivenname;
    }

    public void setCngivenname(String cngivenname) {
        this.cngivenname = cngivenname;
    }

    public String getEnfirstname() {
        return enfirstname;
    }

    public void setEnfirstname(String enfirstname) {
        this.enfirstname = enfirstname;
    }

    public String getEnmiddlename() {
        return enmiddlename;
    }

    public void setEnmiddlename(String enmiddlename) {
        this.enmiddlename = enmiddlename;
    }

    public String getEnlastname() {
        return enlastname;
    }

    public void setEnlastname(String enlastname) {
        this.enlastname = enlastname;
    }

    public String getIdcardno() {
        return idcardno;
    }

    public void setIdcardno(String idcardno) {
        this.idcardno = idcardno;
    }

    public String getPassportno() {
        return passportno;
    }

    public void setPassportno(String passportno) {
        this.passportno = passportno;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public String getHeadpic() {
        return headpic;
    }

    public void setHeadpic(String headpic) {
        this.headpic = headpic;
    }

    public String getMarriage() {
        return marriage;
    }

    public void setMarriage(String marriage) {
        this.marriage = marriage;
    }

    public String getEducation() {
        return education;
    }

    public void setEducation(String education) {
        this.education = education;
    }

    public String getOccupation() {
        return occupation;
    }

    public void setOccupation(String occupation) {
        this.occupation = occupation;
    }

    public String getDeleteflg() {
        return deleteflg;
    }

    public void setDeleteflg(String deleteflg) {
        this.deleteflg = deleteflg;
    }

    public Date getAddtimestamp() {
        return addtimestamp;
    }

    public void setAddtimestamp(Date addtimestamp) {
        this.addtimestamp = addtimestamp;
    }

    public String getAdduserkey() {
        return adduserkey;
    }

    public void setAdduserkey(String adduserkey) {
        this.adduserkey = adduserkey;
    }

    public Date getUpdtimestamp() {
        return updtimestamp;
    }

    public void setUpdtimestamp(Date updtimestamp) {
        this.updtimestamp = updtimestamp;
    }

    public String getUpduserkey() {
        return upduserkey;
    }

    public void setUpduserkey(String upduserkey) {
        this.upduserkey = upduserkey;
    }

    public String getUpdpgmid() {
        return updpgmid;
    }

    public void setUpdpgmid(String updpgmid) {
        this.updpgmid = updpgmid;
    }

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}
}