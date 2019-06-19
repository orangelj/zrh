package com.lj.service;

import com.lj.entity.Album;
import com.lj.entity.Chapter;

import java.util.List;

public interface AlbumService {

    //查询所有
    List<Album> selectAll(Integer page, Integer rows);
    //查询总条数
    Integer count();
    //添加专辑
    void addAlbum(Album album);
    //添加章节
    void addChapter(Chapter chapter);
    //下载音频
    Chapter download(Integer id);
    //在线播放
    Chapter onPlay(Integer id);
}
