package com.custom.Controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestBindingException;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.custom.VO.CartVO;
import com.custom.VO.OptionVO;
import com.custom.dao.PurchaseDao;

import net.sf.json.JSONArray;

@Controller
public class CartController {

	@Autowired
	private PurchaseDao purchaseDao;

	@RequestMapping(value = "/cartIn.do")
	public ModelAndView cartIn(ModelAndView mav, HttpServletRequest request, HttpSession session) {
		
		List<Map<String,Object>> list = (List<Map<String, Object>>) session.getAttribute("cartList");
		String userId = String.valueOf(session.getAttribute("userId"));
		
		//int cartCnt = purchaseDao.getMaxCnt();
		// 장바구니 담기
		
		int cartCount = 0;
		
		for (Map<String, Object> map : list) {
			
			int pSeq = Integer.parseInt((String) map.get("pSeq"));
			String pName = (String) map.get("pName");
			String filelocation = (String) map.get("filelocation");
			String pOption = (String) map.get("pOption");
			int optionPrice = Integer.parseInt((String) map.get("optionPrice"));
			int cnt = (Integer) map.get("cnt");
			String cartState = "state";
			
			System.out.println(pName);
			System.out.println(userId);
			System.out.println(filelocation);
			System.out.println(pOption);
			System.out.println(optionPrice);
			System.out.println(cnt);
			System.out.println(cartState);
			
		
			CartVO cartvo = new CartVO(cartCount++, userId, pSeq, pName, filelocation,
					pOption, optionPrice, cnt, cartState);
				        
			purchaseDao.cartIn(cartvo);
	    }
		
		List<CartVO> cartList = purchaseDao.getCart(userId);
		mav.addObject("cartList",cartList);
	
		mav.setViewName("cart");
		return mav;
	}
	
	@RequestMapping(value = "/cart.do")
	public ModelAndView cart(ModelAndView mav, HttpServletRequest request, HttpSession session) {
		String userId = String.valueOf(session.getAttribute("userId"));
		
		List<CartVO> cartList = purchaseDao.getCart(userId);
		mav.addObject("cartList",cartList);
	
		mav.setViewName("cart");
		return mav;
	}
	
	@RequestMapping(value = "/purchaseClick.do")
	@ResponseBody
	public ModelAndView purchaseClick(@RequestBody String str,
			ModelAndView mav, HttpServletRequest request, HttpSession session) {
		
		
		List<Map<String,Object>> list = (List<Map<String, Object>>) session.getAttribute("purchaseList");
	
		for (Map<String, Object> map : list) {
	        System.out.println(map.get("option") + " : " + map.get("cnt"));
	    }
		mav.setViewName("purchase");
		return mav;
	}
	
	@RequestMapping(value = "/cartInCheck.do")
	@ResponseBody
	public String cartInCheck(@RequestBody String str,
			HttpServletRequest request, HttpSession session) {

		List<Map<String,Object>> cartList = new ArrayList<Map<String,Object>>();
		cartList = JSONArray.fromObject(str);
		
		session.setAttribute("cartList", cartList);
		
		if(session.getAttribute("custom") == null) {
			System.out.println("세션없당");
			session.setAttribute("cartInCheck", "cartInCheck");
			return "false";
		}
			
		System.out.println("세션있당");
		for (Map<String, Object> map : cartList) {
	        System.out.println(map.get("option") + " : " + map.get("cnt"));
	    }
		return "true";
		
	}
	
	@RequestMapping(value = "/purchaseCheck.do" , method = RequestMethod.POST)
	@ResponseBody
	public String purchaseCheck(@RequestBody  String str,
			ModelAndView mav, HttpServletRequest request, HttpSession session) throws ServletRequestBindingException {
		
		System.out.println("================purchase================");
	
		List<Map<String,Object>> purchaseList = new ArrayList<Map<String,Object>>();
		purchaseList = JSONArray.fromObject(str);
		
		session.setAttribute("purchaseList", purchaseList);
		
		if(session.getAttribute("custom") == null) {
			session.setAttribute("purchaseCheck", "purchaseCheck");

			System.out.println("세션없당");
			
			return "false";
		}
		
	    for (Map<String, Object> map : purchaseList) {
	        System.out.println(map.get("option") + " : " + map.get("cnt"));
	    }
	    
	    return "true";
	}

	
}
