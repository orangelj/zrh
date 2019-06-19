package com.lj.controller;

import com.lj.entity.UserDTO;
import com.lj.service.UserDTOService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("dto")
public class UserDTOController {

    @Resource
    private UserDTOService userDTOService;

    @RequestMapping("dto")
    public Map<String,Object> selectAll(){

        Map<String,Object> map = new HashMap<>();
        List<UserDTO> userDTOS = userDTOService.selectAll();

        map.put("success",userDTOS);
        return map;
    }

}
