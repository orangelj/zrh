package com.lj.dao;

import com.lj.entity.Project;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ProjectDAO {

    //查询所有项目
    List<Project> selectAll(@Param("page") Integer page, @Param("rows") Integer rows);
    //查询总条数
    Integer total();
    //修改状态
    void updateByStatus(@Param("status") Integer status, @Param("id") Integer id);

    //根据状态查询
    List<Project> selectByStatus();
    //添加
    void insert(Project project);
    //删除
    void delete(String id);
}
