package com.lj.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.lj.dao.AdminDAO;
import com.lj.entity.Admin;
import com.lj.service.AdminService;
import io.goeasy.GoEasy;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class AdminServiceImpl implements AdminService {

    @Autowired
    private AdminDAO adminDAO;

    @Override
    public Integer total() {
        return adminDAO.total();
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS,readOnly = true)
    public Admin login(String username, String password) {
        return adminDAO.selectByUsernameAndPassword(username, password);
    }

    @Override
    public void register(Admin admin) {
        adminDAO.insert(admin);
        int total = adminDAO.total();
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("counts", total);
        String str = jsonObject.toString();

        GoEasy goEasy = new GoEasy( "http://rest-hangzhou.goeasy.io", "BC-39419ba4feae497a8f616b8fc931252f");
        goEasy.publish("my_channel", str);

    }

    @Override
    public void updateByPassword(Admin admin) {
        adminDAO.updateByPassword(admin);
    }
}
