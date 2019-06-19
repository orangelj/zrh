package com.lj.controller;

import com.lj.entity.Admin;
import com.lj.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private AdminService adminService;
    private Map<String,Object> map = new HashMap<>();

    @RequestMapping("login")
    public Map<String,Object> login(String username, String password, HttpSession session){
        try {
            Admin admin = adminService.login(username, password);

            if(admin!=null){
                session.setAttribute("username",admin.getUsername());
                session.setAttribute("admin",admin);
                session.setAttribute("ok","ok");
                map.put("message",200);
            }else {
                map.put("message",400);
            }
        }catch (Exception e){
            e.printStackTrace();
//            map.put("loginFail","登录失败");
        }
        return map;
    }

    @RequestMapping("register")
    public Map<String,Object> register(Admin admin,HttpSession session){
        try {
            adminService.register(admin);
            session.setAttribute("username",admin.getUsername());
            session.setAttribute("admin",admin);
            map.put("registerOk","注册成功");
        }catch (Exception e){
            e.printStackTrace();
            map.put("registerFail","注册失败");
        }
        return map;
    }

    @RequestMapping("updateByPassword")
    public Map<String,Object> updateByPassword(String password,HttpSession session){

        Admin admin = (Admin) session.getAttribute("admin");
        admin.setPassword(password);
        try {
            adminService.updateByPassword(admin);
            map.put("updateOk","修改成功");
        }catch (Exception e){
            e.printStackTrace();
            map.put("updateFail","修改失败");
        }
        return map;
    }

    @RequestMapping("code")
    public Map<String,Object> checkcode(HttpSession session){
        String cs = (String) session.getAttribute("validationCode");
        map.put("code",cs);
        return map;
    }

    @RequestMapping("exit")
    public  Map<String,Object> exit(HttpSession session){
        session.invalidate();
        map.put("success",200);
        return map;
    }

    @RequestMapping("password")
    public Map<String,Object> checkpassword(HttpSession session){
        Admin cs = (Admin) session.getAttribute("admin");
        map.put("admin",cs);
        return map;
    }

    @RequestMapping("/total")
    public Map<String,Object> total(){
        Map<String,Object> map = new HashMap<>();
        Integer total = adminService.total();
        map.put("success",total);
        return map;
    }
}
