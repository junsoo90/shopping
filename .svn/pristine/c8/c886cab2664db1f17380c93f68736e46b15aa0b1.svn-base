package com.custom.interceptor;

import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.custom.Map.LoginCheckMap;
import com.custom.VO.CustomVO;
import com.custom.dao.CustomDao;

public class LoginInterceptor extends HandlerInterceptorAdapter {
	
	@Autowired
	private CustomDao customDao;

	Map map = new HashMap();
	
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws IOException {
		System.out.println("=============== login interceptor ===================");
		System.out.println("pageNum = " + request.getParameter("pageNum"));
		int pageNum;
		int pSeq;
		
//		try {
//			if(request.getParameter("pageNum") != null) {
//				pageNum = Integer.parseInt(request.getParameter("pageNum"));
//			}
//			if(request.getParameter("pSeq") != null) {
//				pSeq = Integer.parseInt(request.getParameter("pSeq"));
//			}
//		}catch(Exception e) {
//			//e.printStackTrace();
//		
//			response.sendRedirect("productEmpty.do");
//			return false;
//		}
		
		Enumeration<String> paramNames = request.getParameterNames();
		while (paramNames.hasMoreElements()) {
			String key = (String) paramNames.nextElement();
			String value = request.getParameter(key);
			System.out.println("key = " + key);
		}
		
		//String cId = request.getParameter("userId");
		CustomVO customVo = (CustomVO)request.getSession().getAttribute("custom");
		
		if(request.getSession().getAttribute("url") == null 
				|| request.getSession().getAttribute("url") == "undefined"
				) {
			request.getSession().setAttribute("url", "productList.do");
		}
		
		String cId = null;
		if(customVo != null)			
			cId = customVo.getcId();
		
		Object preSession = LoginCheckMap.logincheckMap.get(cId);
		Object currentSession = request.getSession().getId();
		Object loginSession = request.getSession().getAttribute("loginSession");
		
		if(loginSession == null) {
			System.out.println("loginSession == null ");
		}
		System.out.println("cId = " + cId);
		System.out.println("current session = " + currentSession);
		System.out.println("preSession session = " + preSession);
		System.out.println("request URI = " + request.getRequestURI());
		
		System.out.println("session url = "  + request.getSession().getAttribute("url"));
		System.out.println("cartInCheck = " + request.getSession().getAttribute("cartInCheck"));
		System.out.println("purchaseCheck = " + request.getSession().getAttribute("purchaseCheck"));
		System.out.println("loginSession = " + request.getSession().getAttribute("loginSession"));
		
		
		
		if(customVo != null) {
			int count = customDao.idCheck(cId);
			System.out.println("count = " + count);
			
			if(preSession != currentSession || count <= 0) {
				System.out.println("remove cId");
				request.getSession().removeAttribute(cId);
				request.getSession().removeAttribute("loginSession");
				request.getSession().removeAttribute("custom");
				request.getSession().invalidate();
				//response.sendRedirect("login.do");
				//return false;
			}
		}
		
	
		return true;
	}
}
