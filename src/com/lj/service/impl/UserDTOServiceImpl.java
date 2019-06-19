package com.lj.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.lj.dao.UserDTODAO;
import com.lj.entity.UserDTO;
import com.lj.service.UserDTOService;
import io.goeasy.GoEasy;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

import java.util.List;

@Service
@Transactional
public class UserDTOServiceImpl implements UserDTOService {

    @Resource
    private UserDTODAO userDTODAO;

    @Override
    public List<UserDTO> selectAll() {
        List<UserDTO> list =  userDTODAO.selectAll();
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("list", list);
        String str2 = jsonObject.toString();

        GoEasy goEasy = new GoEasy( "http://rest-hangzhou.goeasy.io", "BC-39419ba4feae497a8f616b8fc931252f");
        goEasy.publish("my_channel", str2);
        return list;
    }
}


