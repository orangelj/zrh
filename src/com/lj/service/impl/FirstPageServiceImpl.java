package com.lj.service.impl;


import com.lj.dao.AlbumDAO;
import com.lj.dao.BannerDAO;
import com.lj.entity.Album;
import com.lj.entity.Banner;
import com.lj.entity.Chapter;
import com.lj.service.FirstPageService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class FirstPageServiceImpl implements FirstPageService {

    @Resource
    private AlbumDAO albumDAO;
    @Resource
    private BannerDAO bannerDAO;

    @Override
    public Map<String, Object> firstPage(String type, String sub_type) {

        Map<String,Object> map = new HashMap<>();
        List<Album> albums = albumDAO.selectAllByTime();

        List<Banner> banners = bannerDAO.selectByStatus();
        if("all".equals(type)){
            map.put("header",banners);
            map.put("body",albums);
        }
        if("si".equals(type)){
            if("ssyi".equals(sub_type)){
                map.put("body",albums);
            }
        }
        return map;
    }

    @Override
    public Map<String, Object> firstPage2(String id) {

        Map<String,Object> map = new HashMap<>();
        Album album = albumDAO.selectBySelf(id);
        List<Chapter> chapters = albumDAO.selectByChapter(id);
        map.put("list",chapters);
        map.put("introduction",album);
        return map;
    }

}
