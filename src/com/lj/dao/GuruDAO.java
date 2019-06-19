package com.lj.dao;

import com.lj.entity.Guru;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface GuruDAO {

    //查询所有用户
    List<Guru> selectAll(@Param("page") Integer page, @Param("rows") Integer rows);
    //查询总条数
    Integer total();
    //修改用户状态
    void updateByStatus(@Param("status") Integer status, @Param("id") Integer id);

}
