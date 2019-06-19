package com.lj.dao;

import com.lj.entity.Menu;
import java.util.List;
public interface MenuDAO {

    //查询所有
    List<Menu> selectAll();
}