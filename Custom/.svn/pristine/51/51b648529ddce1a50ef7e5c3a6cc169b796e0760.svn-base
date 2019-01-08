package com.custom.dao;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CommonDao extends SqlSessionDaoSupport {

	@Autowired(required = false)
	@Override
	public void setSqlSessionFactory(SqlSessionFactory sqlSessionFactory) {

		super.setSqlSessionFactory(sqlSessionFactory);

	}

	@Autowired(required = false)
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {

		super.setSqlSessionTemplate(sqlSessionTemplate);

	}

}
