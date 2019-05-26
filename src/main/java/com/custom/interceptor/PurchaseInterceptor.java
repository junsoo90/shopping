package com.custom.interceptor;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.custom.dao.ProductDao;

public class PurchaseInterceptor extends HandlerInterceptorAdapter {
	
	@Autowired
	private ProductDao productDao;

	public boolean preHandle(HttpServletRequest request, 
			HttpServletResponse response) {
		
		List<Map<String,Object>> purchaseList = (List<Map<String, Object>>) request.getSession().getAttribute("purchaseList");
		
		for(int i=0; i<purchaseList.size(); i++) {
			Map<String,Object> optionMap = new HashMap<String,Object>();
			optionMap.put("pSeq", String.valueOf(purchaseList.get(i).get("pSeq")));
			optionMap.put("pOption", String.valueOf(purchaseList.get(i).get("pOption")));
			
			int purchaseStock = Integer.parseInt(String.valueOf(purchaseList.get(i).get("optionCnt")));
			
			int optionStock = productDao.checkStock(optionMap);
			System.out.println("optionStock = " + optionStock);
			System.out.println("purchaseStock = " + purchaseStock);
			
		}
		
		return true;
	}

}
