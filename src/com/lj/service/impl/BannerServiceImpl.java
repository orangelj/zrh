package com.lj.service.impl;

import com.lj.dao.BannerDAO;
import com.lj.entity.Banner;
import com.lj.service.BannerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class BannerServiceImpl implements BannerService {

    @Autowired
    private BannerDAO bannerDAO;

    @Override
    @Transactional(propagation = Propagation.SUPPORTS,readOnly = true)
    public List<Banner> selectAll(Integer page, Integer rows) {
        Integer page1 = (page-1)*rows;
        return bannerDAO.selectAll(page1, rows);
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS,readOnly = true)
    public Integer total() {
        return bannerDAO.total();
    }

    @Override
    public void updateStatus(Integer status,Integer id) {
        bannerDAO.updateStatus(status,id);
    }

    @Override
    public void insert(Banner banner) {
        bannerDAO.insert(banner);
    }

    @Override
    public void delete(String id) {
        bannerDAO.delete(id);
    }
}
