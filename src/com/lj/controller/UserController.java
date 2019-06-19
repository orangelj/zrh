package com.lj.controller;

import com.lj.entity.User;
import com.lj.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;
    private Map<String,Object> map = new HashMap<>();

    @RequestMapping("selectAll")
    public Map<String,Object> selectAll(Integer page,Integer rows)throws Exception{
        List<User> users = userService.selectAll(page, rows);
        Integer total = userService.total();
        map.put("total",total);
        map.put("rows",users);
        return map;
    }

    @RequestMapping("updateByStatus")
    public Map<String,Object> updateByStatus(int status,int id){
        try {
            userService.updateByStatus(status,id);
            map.put("message","修改成功");
        }catch (Exception e){
            e.printStackTrace();
            map.put("message","修改失败");
        }
        return map;
    }

}
