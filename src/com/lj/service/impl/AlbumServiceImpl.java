package com.lj.service.impl;

import com.lj.dao.AlbumDAO;
import com.lj.entity.Album;
import com.lj.entity.Chapter;
import com.lj.service.AlbumService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class AlbumServiceImpl implements AlbumService {

    @Autowired
    private AlbumDAO albumDAO;

    @Override
    @Transactional(propagation = Propagation.SUPPORTS,readOnly = true)
    public List<Album> selectAll(Integer page, Integer rows) {
        Integer page1 = (page-1)*rows;
        return albumDAO.selectAll(page1, rows);
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS,readOnly = true)
    public Integer count() {
        return albumDAO.total();
    }

    @Override
    public void addAlbum(Album album) {
        albumDAO.addAlbum(album);
    }

    @Override
    public void addChapter(Chapter chapter) {
        albumDAO.addChapter(chapter);
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS,readOnly = true)
    public Chapter download(Integer id) {
        return albumDAO.download(id);
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS,readOnly = true)
    public Chapter onPlay(Integer id) {
        return albumDAO.onPlay(id);
    }
}
