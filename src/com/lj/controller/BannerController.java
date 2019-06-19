package com.lj.controller;

import com.lj.entity.Banner;
import com.lj.service.BannerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import java.io.File;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/banner")
public class BannerController {

    @Autowired
    private BannerService bannerService;
    private Map<String,Object> map = new HashMap<>();
    @RequestMapping("selectAll")
    public Map<String,Object> selectAll(Integer page,Integer rows){
        try {
            List<Banner> banners = bannerService.selectAll(page, rows);
            Integer total1 = bannerService.total();

            map.put("total",total1);
            map.put("rows",banners);
        }catch (Exception e){
            e.printStackTrace();
        }
        return map;
    }

    @RequestMapping("updateBanner")
    public Map<String,Object>  updateStatus(int status,int id){
        try {
            bannerService.updateStatus(status,id);
            map.put("message","修改成功");
        }catch (Exception e){
            e.printStackTrace();
            map.put("message","修改失败");
        }
       return map;
    }

    @RequestMapping("insert")
    public Map<String,Object> insert(Banner banner, MultipartFile upload, HttpSession session){

        try {
            //获取文件的路径
            String path = session.getServletContext().getRealPath("/banner");
            //创建一个新文件 命名和原文件相同
            File file = new File(path+"/"+upload.getOriginalFilename());
            if(!file.exists()){
                file.mkdir();
            }
            //把上传的文件内容转换到新的文件中
            upload.transferTo(file);
            //把文件的文件名赋给admin 的path属性
            String fileName = upload.getOriginalFilename();
            banner.setImg_path("banner/"+fileName);

            bannerService.insert(banner);
            map.put("message","添加成功");
        }catch (Exception e){
            e.printStackTrace();
            map.put("message","添加失败");
        }
        return map;
    }

    @RequestMapping("delete")
    public Map<String,Object> delete(String id)throws Exception{
        bannerService.delete(id);

        map.put("message","删除成功");
        return map;
    }
}
