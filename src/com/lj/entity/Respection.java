package com.lj.entity;

public class Respection {

    private Integer id;
    private Integer status;
    private Integer banner_id;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getBanner_id() {
        return banner_id;
    }

    public void setBanner_id(Integer banner_id) {
        this.banner_id = banner_id;
    }

    @Override
    public String toString() {
        return "Repair{" +
                "id=" + id +
                ", status=" + status +
                ", banner_id=" + banner_id +
                '}';
    }
}