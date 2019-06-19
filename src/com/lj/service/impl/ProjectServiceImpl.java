package com.lj.service.impl;

import com.lj.dao.ProjectDAO;
import com.lj.entity.Project;
import com.lj.service.ProjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class ProjectServiceImpl implements ProjectService {

    @Autowired
    private ProjectDAO projectDAO;

    @Override
    @Transactional(propagation = Propagation.SUPPORTS,readOnly = true)
    public List<Project> selectAll(Integer page, Integer rows) {
        Integer page1 = (page-1)*rows;
        return projectDAO.selectAll(page1, rows);
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS,readOnly = true)
    public Integer total() {
        return projectDAO.total();
    }

    @Override
    public void updateStatus(Integer status,Integer id) {
        projectDAO.updateByStatus(status, id);
    }

    @Override
    public void insert(Project project) {
        projectDAO.insert(project);
    }

    @Override
    public void delete(String id) {
        projectDAO.delete(id);
    }
}
