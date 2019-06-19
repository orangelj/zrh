package com.lj.service.impl;

import com.lj.dao.GuruDAO;
import com.lj.entity.Guru;
import com.lj.service.GuruService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class GuruServiceImpl implements GuruService {

    @Autowired
    private GuruDAO guruDAO;

    @Override
    @Transactional(propagation = Propagation.SUPPORTS,readOnly = true)
    public List<Guru> selectAll(Integer page, Integer rows) {
        Integer page1 = (page-1)*rows;
        return guruDAO.selectAll(page1,rows);
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS,readOnly = true)
    public Integer total() {
        return guruDAO.total();
    }

    @Override
    public void updateByStatus(Integer status, Integer id) {
        guruDAO.updateByStatus(status, id);
    }
}
