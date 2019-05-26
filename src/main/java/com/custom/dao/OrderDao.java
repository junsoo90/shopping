package com.custom.dao;

import java.util.List;
import java.util.Map;

import com.custom.VO.OrderVO;

public interface OrderDao {

	public List<OrderVO> orderListInfo(Map<String, Object> map);
	
	public void insertOrder(Map<String,Object> orderList);
	
	public void insertBank(Map<String,Object> orderList);
	
	public void insertCard(Map<String,Object> orderList);
	
	public void updateStateCheck(int purchaseSeq);
	
	public void stockDec(Map<String,Object> orderList);
	
	public int orderCount(Map<String,Object> map);
	
	public void updateRefundReqeust(int purchaseSeq);
	
	public void updateRefundCancel(int purchaseSeq);
	
}
