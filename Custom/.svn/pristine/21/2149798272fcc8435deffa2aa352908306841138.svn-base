package com.custom.dao;

import org.springframework.stereotype.Component;

import com.custom.VO.CustomVO;

@Component
public class CustomDaoImpl extends CommonDao implements CustomDao {
	public int idCheck(String cId) {
		return getSqlSession().selectOne("idCheck", cId);
	}
	
	public void customInsert(CustomVO vo) {
		getSqlSession().insert("customInsert",vo);
	}
	
	public CustomVO customLogin(String cId) {
		return getSqlSession().selectOne("login",cId);
	}
	
	
}
