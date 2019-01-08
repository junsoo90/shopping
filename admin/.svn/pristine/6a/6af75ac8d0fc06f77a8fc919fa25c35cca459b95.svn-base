package com.admin.dao;

import java.util.List;

import org.springframework.stereotype.Component;

import com.admin.VO.CustomVO;

@Component
public class CustomDaoImpl extends CommonDao implements CustomDao {
	
	public List<CustomVO> list(){
		return getSqlSession().selectList("customList");
	}
}
