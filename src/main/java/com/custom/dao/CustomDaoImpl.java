package com.custom.dao;

import java.util.List;
import java.util.Map;

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
	
	public List<CustomVO> idSearch(CustomVO customVo) {
		return getSqlSession().selectList("idSearch",customVo);
	}
	
	public String passSearch(CustomVO customVo) {
		return getSqlSession().selectOne("passSearch",customVo);
	}
	
	public void loginSession(CustomVO customVo) {
		getSqlSession().update("loginSession",customVo);
	}
	
	public String sessionCheck(String cId) {
		return getSqlSession().selectOne("sessionCheck",cId);
	}
	
	public String passCheck(String cId) {
		return getSqlSession().selectOne("passCheck", cId);
	}
	
	public void customUpdate(Map custoMap) {
		getSqlSession().update("customUpdate", custoMap);
	}
	
	public void customDelete(String cId) {
		getSqlSession().delete("customDelete", cId);
	}
}
