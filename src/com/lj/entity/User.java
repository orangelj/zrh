package com.lj.entity;

import java.util.Date;

public class User {

    private Integer id;
    private String phone;
    private String password;
    private String salt;
    private String head_img;
    private String name;
    private String legal_name;
    private String sex;
    private String city;
    private String sign;
    private Integer status;
    private Date reg_data;
    private Guru guru;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getSalt() {
        return salt;
    }

    public void setSalt(String salt) {
        this.salt = salt;
    }

    public String getHead_img() {
        return head_img;
    }

    public void setHead_img(String head_img) {
        this.head_img = head_img;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLegal_name() {
        return legal_name;
    }

    public void setLegal_name(String legal_name) {
        this.legal_name = legal_name;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getSign() {
        return sign;
    }

    public void setSign(String sign) {
        this.sign = sign;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Date getReg_data() {
        return reg_data;
    }

    public void setReg_data(Date reg_data) {
        this.reg_data = reg_data;
    }

    public Guru getGuru() {
        return guru;
    }

    public void setGuru(Guru guru) {
        this.guru = guru;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", phone='" + phone + '\'' +
                ", password='" + password + '\'' +
                ", salt='" + salt + '\'' +
                ", head_img='" + head_img + '\'' +
                ", name='" + name + '\'' +
                ", legal_name='" + legal_name + '\'' +
                ", sex='" + sex + '\'' +
                ", city='" + city + '\'' +
                ", sign='" + sign + '\'' +
                ", status=" + status +
                ", reg_data=" + reg_data +
                ", guru=" + guru +
                '}';
    }
}
