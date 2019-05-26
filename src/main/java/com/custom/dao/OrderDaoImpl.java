package com.custom.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

import com.custom.VO.OrderVO;

@Component
public class OrderDaoImpl  extends CommonDao implements OrderDao {
	
	public List<OrderVO> orderListInfo(Map<String, Object> map) {
		return getSqlSession().selectList("orderListInfo", map);
	}
	
	public void insertOrder(Map<String,Object> orderList) {
		getSqlSession().insert("insertOrder", orderList);
	}
	
	public void insertBank(Map<String,Object> orderList) {
		getSqlSession().insert("insertBank", orderList);
	}
	
	public void insertCard(Map<String,Object> orderList) {
		getSqlSession().insert("insertCard", orderList);
	}
	
	public void updateStateCheck(int purchaseSeq) {
		getSqlSession().update("updateStateCheck", purchaseSeq);
	}
	
	public void stockDec(Map<String,Object> orderList) {
		getSqlSession().update("stockDec", orderList);
	}
	
	public int orderCount(Map<String,Object> map) {
		return getSqlSession().selectOne("orderCount", map); 
	}
	
	public void updateRefundReqeust(int purchaseSeq) {
		getSqlSession().update("updateRefundReqeust", purchaseSeq);
	}
	
	public void updateRefundCancel(int purchaseSeq) {
		getSqlSession().update("updateRefundCancel", purchaseSeq);
	}
}
