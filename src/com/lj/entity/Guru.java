package com.lj.entity;

import java.util.Date;

public class Guru {

    private Integer id;
    private String legal_name;
    private String head_img;
    private Integer status;
    private Date reg_date;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getLegal_name() {
        return legal_name;
    }

    public void setLegal_name(String legal_name) {
        this.legal_name = legal_name;
    }

    public String getHead_img() {
        return head_img;
    }

    public void setHead_img(String head_img) {
        this.head_img = head_img;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Date getReg_date() {
        return reg_date;
    }

    public void setReg_date(Date reg_date) {
        this.reg_date = reg_date;
    }

    @Override
    public String toString() {
        return "Guru{" +
                "id=" + id +
                ", legal_name='" + legal_name + '\'' +
                ", head_img='" + head_img + '\'' +
                ", status=" + status +
                ", reg_date=" + reg_date +
                '}';
    }
}
