package com.lj.controller;


import com.lj.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import com.lj.entity.Menu;
@Controller
@RequestMapping("/menu")
public class MenuController {

    @Autowired
    private MenuService menuService;
    private Map<String,Object> map = new HashMap<>();

    @RequestMapping("/selectAll")
    @ResponseBody
    public Map<String,Object> selectAll(){
        try {
            List<Menu> menus = menuService.selectAll();
            map.put("success", menus);
            map.put("message", "查询成功");
        } catch (Exception e) {
            e.printStackTrace();
            map.put("success", 400);
            map.put("message", "查询失败");
        }

        return map;
    }
}
