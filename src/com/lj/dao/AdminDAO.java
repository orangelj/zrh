package com.lj.dao;

import com.lj.entity.Admin;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AdminDAO {

    //查询
    Admin selectByUsernameAndPassword(@Param("username") String username,@Param("password") String password);
    //插入
    void insert(Admin admin);
    //修改密码
    void updateByPassword(Admin admin);
    //查询所有
    Integer total();

}
