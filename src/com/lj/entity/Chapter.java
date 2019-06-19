package com.lj.entity;

import com.alibaba.fastjson.annotation.JSONField;
import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.Date;

public class Chapter {

    private Integer id;
    private String title;
    private String size;
    private String url;
    private String duration;
    @JSONField(format = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date pub_date;
    private Integer Album_id;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getDuration() {
        return duration;
    }

    public void setDuration(String duration) {
        this.duration = duration;
    }

    public Date getPub_date() {
        return pub_date;
    }

    public void setPub_date(Date pub_date) {
        this.pub_date = pub_date;
    }

    public Integer getAlbum_id() {
        return Album_id;
    }

    public void setAlbum_id(Integer album_id) {
        Album_id = album_id;
    }

    @Override
    public String toString() {
        return "Chapter{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", size='" + size + '\'' +
                ", url='" + url + '\'' +
                ", duration='" + duration + '\'' +
                ", pub_date=" + pub_date +
                ", Album_id=" + Album_id +
                '}';
    }
}
