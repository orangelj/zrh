package com.lj.service;

import com.lj.entity.Project;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ProjectService {

    //查询所有项目
    List<Project> selectAll(@Param("page") Integer page, @Param("rows") Integer rows);
    //查询总条数
    Integer total();
    //修改状态
    void updateStatus(Integer status,Integer id);
    //添加
    void insert(Project project);
    //删除
    void delete(String id);
}
