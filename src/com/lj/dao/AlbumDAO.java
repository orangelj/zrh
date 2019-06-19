package com.lj.dao;

import com.lj.entity.Album;
import com.lj.entity.Chapter;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AlbumDAO {

    //查询所有
    List<Album> selectAll(@Param("page") Integer page, @Param("rows") Integer rows);
    //查询总条数
    Integer total();
    //添加专辑
    void addAlbum(Album album);
    //添加章节
    void addChapter(Chapter chapter);
    //下载音频
    Chapter download(Integer id);
    //在线播放
    Chapter onPlay(Integer id);

    //App页面
    List<Album> selectAllByTime();
    //根据id查本身
    Album selectBySelf(String id);
    //根据父id查集合
    List<Chapter> selectByChapter(String Fid);
}
