package com.lj.dao;

import com.lj.entity.Banner;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface BannerDAO {

    List<Banner> selectByStatus();
    //查询所有  分页
    List<Banner> selectAll(@Param("page") Integer page, @Param("rows") Integer rows);
    //查询总条数
    Integer total();
    //修改状态
    void updateStatus(@Param("status") Integer status,@Param("id") Integer id);
    //插入
    void insert(Banner banner);
    //删除
    void delete(String id);
}
