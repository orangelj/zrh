package com.lj.controller;


import com.lj.entity.Project;
import com.lj.service.ProjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("project")
public class ProjectController {

    @Autowired
    private ProjectService projectService;
    private Map<String,Object> map = new HashMap<>();

    @RequestMapping("selectAll")
    public Map<String,Object> selectAll(Integer page,Integer rows)throws Exception{
        List<Project> projects =  projectService.selectAll(page, rows);
        Integer total = projectService.total();
        map.put("total",total);
        map.put("rows",projects);
        return map;
    }

    @RequestMapping("/insert")
    public Map<String,Object> insertAlbum(Project project , MultipartFile upload, HttpSession session){

    try{
        //获取file文件夹的路径
        String path = session.getServletContext().getRealPath("/project");
        //创建一个新的文件 命名和原文件相同
        File file = new File(path+"/"+upload.getOriginalFilename());
        if(!file.exists()){
            file.mkdir();
        }
        //把上传的文件内容转换到到新的文件中
        upload.transferTo(file);
        //把文件的文件名赋给user的path属性
        String fileName = upload.getOriginalFilename();
        project.setImg_path("project/"+fileName);
        projectService.insert(project);
        map.put("success",200);
        map.put("message","添加成功");
    }catch (Exception e){
        e.printStackTrace();
        map.put("message","添加失败");
    }
        return map;
}

}

