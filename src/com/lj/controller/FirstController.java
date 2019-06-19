package com.lj.controller;

import com.lj.service.FirstPageService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.Map;

@RestController
@RequestMapping("/first")
public class FirstController {

    @Resource
    private FirstPageService firstPageService;

    @RequestMapping("first")
    public Map<String,Object> selectAll(String type, String sub_type){
        return firstPageService.firstPage(type, sub_type);
    }

    @RequestMapping("two")
    public Map<String,Object> selectAll2(String id){
        return firstPageService.firstPage2(id);
    }

}
