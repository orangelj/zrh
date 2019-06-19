package com.lj.controller;

import com.lj.entity.Guru;
import com.lj.service.GuruService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/guru")
public class GuruController {

    @Autowired
    private GuruService guruService;
    private Map<String,Object> map = new HashMap<>();

    @RequestMapping("selectAll")
    public Map<String,Object> selectAll(Integer page,Integer rows,Integer total)throws Exception{
        List<Guru> gurus = guruService.selectAll(page, rows);
        guruService.total();
        map.put("total",total);
        map.put("rows",gurus);
        return map;
    }

    @RequestMapping("updateByStatus")
    public Map<String,Object> updateByStatus(int status,int id){
        try {
            guruService.updateByStatus(status,id);
            map.put("message","修改成功");
        }catch (Exception e){
            e.printStackTrace();
            map.put("message","修改失败");
        }
        return map;
    }
}
