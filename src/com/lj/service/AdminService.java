package com.lj.service;

import com.lj.entity.Admin;

public interface AdminService {

    //登录
    Admin login(String username, String password);
    //注册
    void register(Admin admin);
    //修改密码
    void updateByPassword(Admin admin);

    //查询管理员数量
    Integer total();
}
