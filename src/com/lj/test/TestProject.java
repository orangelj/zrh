package com.lj.test;

import com.lj.dao.MenuDAO;
import com.lj.dao.ProjectDAO;
import com.lj.entity.Menu;
import com.lj.entity.Project;
import com.lj.service.ProjectService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class TestProject {

    @Autowired
    private ProjectDAO projectDAO;

    @Test
    public void Menu(){
        List<Project> menus = projectDAO.selectAll(1,2);
        for (Project menu : menus) {
            System.out.println(menu);
        }
    }

}
