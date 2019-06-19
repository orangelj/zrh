package com.lj.dao;

import com.lj.entity.UserDTO;

import java.util.List;


public interface UserDTODAO {

    List<UserDTO> selectAll();
}
