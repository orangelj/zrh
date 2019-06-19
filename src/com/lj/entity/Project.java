package com.lj.entity;

import java.util.Date;
import java.util.List;

public class Project {
    private Integer id;
    private String name;
    private Integer status;
    private  String hot;  /*热效率*/
    private  String power; /*累计耗电量*/
    private  String water;  /*累计耗水量*/
    private String flow;  /*累计流量*/
    private Date pro_date;
    private List<Banner> childern;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getHot() {
        return hot;
    }

    public void setHot(String hot) {
        this.hot = hot;
    }

    public String getPower() {
        return power;
    }

    public void setPower(String power) {
        this.power = power;
    }

    public String getWater() {
        return water;
    }

    public void setWater(String water) {
        this.water = water;
    }

    public String getFlow() {
        return flow;
    }

    public void setFlow(String flow) {
        this.flow = flow;
    }

    public Date getPro_date() {
        return pro_date;
    }

    public void setPro_date(Date pro_date) {
        this.pro_date = pro_date;
    }

    public List<Banner> getChildern() {
        return childern;
    }

    public void setChildern(List<Banner> childern) {
        this.childern = childern;
    }

    @Override
    public String toString() {
        return "Project{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", status=" + status +
                ", hot='" + hot + '\'' +
                ", power='" + power + '\'' +
                ", water='" + water + '\'' +
                ", flow='" + flow + '\'' +
                ", pro_date=" + pro_date +
                ", childern=" + childern +
                '}';
    }

    public void setImg_path(String s) {
    }
}


