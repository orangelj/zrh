package com.lj.service;

import com.lj.entity.Banner;
import com.lj.entity.Project;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface BannerService {

    //查询所有  分页
    List<Banner> selectAll(@Param("page") Integer page, @Param("rows") Integer rows);
    //查询总条数
    Integer total();
    //修改状态
    void updateStatus(Integer status,Integer id);
    //插入
    void insert(Banner banner);
    //删除
    void delete(String id);
}
