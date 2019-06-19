package com.lj.service.impl;

import com.lj.dao.UserDAO;
import com.lj.entity.User;
import com.lj.service.UserService;
import io.goeasy.GoEasy;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDAO userDAO;

    @Override
    @Transactional(propagation = Propagation.SUPPORTS,readOnly = true)
    public List<User> selectAll(Integer page, Integer rows) {
        Integer page1 = (page-1)*rows;
        return userDAO.selectAll(page1,rows);
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS,readOnly = true)
    public Integer total() {
        return userDAO.total();
    }

    @Override
    public void updateByStatus(Integer status, Integer id) {
        userDAO.updateByStatus(status, id);
    }
}
