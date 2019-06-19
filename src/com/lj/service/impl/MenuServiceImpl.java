package com.lj.service.impl;

import com.lj.dao.MenuDAO;
import com.lj.entity.Menu;
import com.lj.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class MenuServiceImpl implements MenuService {

    @Autowired
    private MenuDAO menuDAO;

    @Override
    @Transactional(propagation = Propagation.SUPPORTS,readOnly = true)
    public List<Menu> selectAll() {
        List<Menu> menus = menuDAO.selectAll();
        return menus;
    }
}
