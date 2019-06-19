package com.lj.controller;

import com.lj.entity.Album;
import com.lj.entity.Chapter;
import com.lj.service.AlbumService;
import it.sauronsoftware.jave.Encoder;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileInputStream;
import java.net.URLEncoder;
import java.text.DecimalFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("album")
public class AlbumController {

    @Autowired
    private AlbumService albumService;
    private Map<String,Object> map = new HashMap<>();

    @RequestMapping("selectAll")
    public Map<String,Object> selectAll(Integer page,Integer rows)throws Exception{
        List<Album> albums =  albumService.selectAll(page, rows);
        Integer total = albumService.count();
        map.put("total",total);
        map.put("rows",albums);
        return map;
    }

    @RequestMapping("/insertAlbum")
    public Map<String,Object> insertAlbum(Album album , MultipartFile upload, HttpSession session)throws Exception{
        //获取file文件夹的路径
        String path = session.getServletContext().getRealPath("/album/img");
        //创建一个新的文件 命名和原文件相同
        File file = new File(path+"/"+upload.getOriginalFilename());
        //把上传的文件内容转换到到新的文件中
        upload.transferTo(file);
        //把文件的文件名赋给user的path属性
        String fileName = upload.getOriginalFilename();
        album.setImg_path("/img/"+fileName);
        albumService.addAlbum(album);
        map.put("success",200);
        map.put("message","添加成功");
        return map;
    }
    @RequestMapping("/insertChapter")
    public Map<String,Object> insertChapter(Chapter chapter,MultipartFile upload,HttpSession session) throws  Exception{
        //获取文件名
        String fileName = upload.getOriginalFilename();
//        System.out.println("文件名:"+fileName);
        //根据相对路径获取决定路径
        String realPath = session.getServletContext().getRealPath("/album/audios");
//        System.out.println("文件夹的路径"+realPath);
        //判断文件夹是否存在
        File file = new File(realPath);
        if(!file.exists()){
            file.mkdir();
        }
        String sname = new Date().getTime()+"-"+fileName;
        //获取音频大小 字节
        long size = upload.getSize();
//        System.out.println("字节数："+size);
        DecimalFormat format = new DecimalFormat("0.00");
        String str = String.valueOf(size);
        Double dd = Double.valueOf(str)/1024/1024;
        String sizess = format.format(dd)+"MB";
//        System.out.println("文件大小:"+sizess);
//        文件上传
        upload.transferTo(new File(realPath,sname));
        //获取文件时长
        Encoder encoder= new Encoder();
        long length = encoder.getInfo(new File(realPath,sname)).getDuration();
        String duration = length/1000/60+"分"+length/1000%60+"秒";
//        System.out.println("时长："+duration);
//        给实体类chapter赋值
        chapter.setSize(sizess);
        chapter.setUrl("/audios/"+sname);
        chapter.setDuration(duration);

        albumService.addChapter(chapter);
        map.put("success",200);
        return map;
    }
    @RequestMapping("/selectByChapterByURL")
    public void selectByChapterByURL(String url,HttpSession session, HttpServletResponse response)throws Exception{
//        Chapter chapter = albumService.selectByChapterById(id);
        //获取文件名
//        String fileName = url;
        //获取文件在服务器中的路径
        String realPath = session.getServletContext().getRealPath("/album");
        //读取文件输入流
        FileInputStream fis = new FileInputStream(new File(realPath,url));
        //设置响应的方式   响应头   //attachment;以附件形式下载   inline 在线打开
        //在线播放
        response.setHeader("content-disposition","attachment;fileName=" + URLEncoder.encode(url,"UTF-8"));

        //获取响应流
        ServletOutputStream os = response.getOutputStream();
        //下载文件
        IOUtils.copy(fis,os);
        //关闭资源
        IOUtils.closeQuietly(fis);
        IOUtils.closeQuietly(os);
    }
}

