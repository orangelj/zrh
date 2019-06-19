package com.lj.test;

import com.lj.dao.MenuDAO;
import org.junit.Test;
import com.lj.entity.Menu;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class MenuTest {

    @Autowired
    private MenuDAO userDAO;

    @Test
    public void Menu(){
        List<Menu> menus = userDAO.selectAll();
        for (Menu menu : menus) {
            System.out.println(menu);
        }
    }


}
