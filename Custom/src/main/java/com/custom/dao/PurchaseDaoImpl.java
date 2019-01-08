package com.custom.dao;

import java.util.List;

import org.springframework.stereotype.Component;

import com.custom.VO.CartVO;

@Component
public class PurchaseDaoImpl extends CommonDao implements PurchaseDao {

	
	@Override
	public void cartIn(CartVO cartvo) {
		 getSqlSession().insert("cartIn", cartvo);
	}
	
	public List<CartVO> getCart(String userId){
		return getSqlSession().selectList("getCart", userId);
	}
	
	public int getMaxCnt() {
		return getSqlSession().selectOne("getMaxCnt");
	}

}
