package com.custom.Controller;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import com.custom.VO.CustomVO;
import com.custom.dao.ProductDao;
import com.custom.dao.PurchaseDao;

import net.sf.json.JSONArray;

@Controller
public class CartController {

	@Autowired
	private PurchaseDao purchaseDao;
	
	@Autowired
	private ProductDao productDao;

	
	// cartIn 카트에 추가
	@RequestMapping(value = "/cartIn.do")
	public ModelAndView cartIn(ModelAndView mav, HttpServletRequest request, HttpSession session) {
		
		List<Map<String,Object>> list = (List<Map<String, Object>>) session.getAttribute("cartList");
		
		CustomVO customVo = (CustomVO)session.getAttribute("custom");
		try {
			String userId = customVo.getcId();
			
			int cartCnt = purchaseDao.getMaxCnt(userId);
			// 장바구니 담기
			session.removeAttribute("purchaseList");
			//int cartCount = 0;
			int totalPrice = 0;
			
			for (Map<String, Object> map : list) {
				
				int pSeq = Integer.parseInt((String) map.get("pSeq"));
				String pName = (String) map.get("pName");
				String savefilename = (String) map.get("savefilename");
				String pOption = (String) map.get("pOption");
				int optionPrice = Integer.parseInt((String) map.get("optionPrice"));
				int optionCnt = (Integer) map.get("optionCnt");
				int optionStock = Integer.parseInt((String) map.get("optionStock"));
				int deliveryCharge = Integer.parseInt((String) map.get("deliveryCharge"));
				
				System.out.println(pName);
				System.out.println(userId);
				System.out.println(savefilename);
				System.out.println(pOption);
				System.out.println(optionPrice);
				System.out.println(optionCnt);
				
			
				CartVO cartvo = new CartVO(++cartCnt, userId, pSeq, pName, savefilename,
						pOption, optionPrice, optionCnt, optionStock);
				cartvo.setDeliveryCharge(deliveryCharge);
				
				purchaseDao.cartIn(cartvo);
				totalPrice += optionPrice * optionCnt;
		    }
			System.out.println("totalPrice = " + totalPrice);
			mav.addObject("cartTotalPrice",totalPrice);
			mav.addObject("aaa","aaa");
			
			List<CartVO> cartList = purchaseDao.getCart(userId);
			
			mav.addObject("cartList",cartList);
			
			session.removeAttribute("cartList");
			mav.setViewName("cart");
		}
		catch(Exception e) {
			e.printStackTrace();
			mav.setViewName("login");
		}
		return mav;
	}
	
	
	// cart.do 카트 list
	@RequestMapping(value = "/cart.do")
	public ModelAndView cartDo(ModelAndView mav, HttpServletRequest request, HttpSession session) {
		
		CustomVO customVo = (CustomVO)session.getAttribute("custom");
		if(customVo == null) {
			mav.setViewName("login");
			return mav;
		}
		try {
			String userId = customVo.getcId();
			System.out.println("userId = " + userId);
			
			session.removeAttribute("purchaseList");
			List<CartVO> cartList = purchaseDao.getCart(userId);
			// session.setAttribute("cartList", cartList);
			//System.out.println("CartList[0].savefilename = " + cartList.get(0).getsavefilename());
			System.out.println("Cart size = " + cartList.size());
			
			int totalPrice = 0;
			
			for(int i=0; i<cartList.size(); i++) {
				
				totalPrice += totalPriceResult(cartList.get(i).getCartCnt(), cartList.get(i).getOptionPrice());
				System.out.println("optionStock = " + cartList.get(i).getOptionStock());
				cartList.get(i).setOptionStock(productDao.getOptionStock(cartList.get(i)));
			}
			
			System.out.println("totalPrice = " + totalPrice);
			
			mav.addObject("count", cartList.size());
			mav.addObject("cartList", cartList);
			mav.addObject("cartTotalPrice", totalPrice);
		
			mav.setViewName("cart");
		}catch(Exception e) {
			e.printStackTrace();
			mav.setViewName("productList");
		}
		return mav;
	}
	
	
	//purchaseClick
	@RequestMapping(value = "/purchaseClick.do")
	@ResponseBody
	public ModelAndView purchaseClick(@RequestBody String purchaseInfo,
			HttpServletRequest request, HttpSession session, HttpServletResponse response) throws UnsupportedEncodingException {
		
		ModelAndView mav = new ModelAndView();
		try {
			request.setCharacterEncoding("UTF-8");
			response.setContentType("text/html;charset=UTF-8");
	
			System.out.println("========== purchase click ==========");
			
			List<Map<String,Object>> purchaseList;
			int totalPrice = 0;
			
			// cart purchase
			if(session.getAttribute("purchaseList") == null) {
				System.out.println("cart에서 누른거야");
				purchaseList = new ArrayList<Map<String,Object>>();
				purchaseList = JSONArray.fromObject(purchaseInfo);
				
				
				System.out.println(purchaseList.get(0).get("savefilename"));
				mav.addObject("cartPurchaseList", purchaseList);
				session.setAttribute("cartPurchaseList", purchaseList);
				session.setAttribute("purchaseList", purchaseList);
				mav.addObject("url","purchase");
	
				mav.setViewName("jsonView");
			}
			// detail purchase
			else {
				System.out.println("Detail에서 누른거야");
				purchaseList = (List<Map<String, Object>>) session.getAttribute("purchaseList");
				
				System.out.println("purchaseList.size() = " + purchaseList.size());
				System.out.println("savefilename = " + purchaseList.get(0).get("savefilename"));
				mav.setViewName("purchase");
			}
			
			// totalPrice
			
			for (Map<String, Object> map : purchaseList) {
				System.out.println(map.get("pName") + " , " + map.get("pOption"));
				int cnt = Integer.parseInt(String.valueOf(map.get("optionCnt")));
				int optionPrice = Integer.parseInt(String.valueOf(map.get("optionPrice")));
				
				totalPrice += totalPriceResult(cnt, optionPrice);			
			}
			
			for(int i=0; i<purchaseList.size(); i++) {
				Map<String,Object> optionMap = new HashMap<String,Object>();
				optionMap.put("pSeq", String.valueOf(purchaseList.get(i).get("pSeq")));
				optionMap.put("pOption", String.valueOf(purchaseList.get(i).get("pOption")));
				
				int purchaseStock = Integer.parseInt(String.valueOf(purchaseList.get(i).get("optionCnt")));
				
				int optionStock = productDao.checkStock(optionMap);
				System.out.println("optionStock = " + optionStock);
				System.out.println("purchaseStock = " + purchaseStock);
				System.out.println("deliveryCharge = " + purchaseList.get(i).get("deliveryCharge"));
				
			}
			
			// userInfo
			CustomVO customVo = (CustomVO) session.getAttribute("custom");
			System.out.println(customVo.getcName());
			System.out.println(customVo.getcId());
			System.out.println(customVo.getcAdd());
			System.out.println(customVo.getcAddCode());
			System.out.println(customVo.getcAddDetail());
			int deliveryCharge = 0;
			int orderPrice = 0;
			orderPrice = totalPrice;
			System.out.println("totalPrice = " + totalPrice);
			
			System.out.println("deliveryCharge = " + purchaseList.get(0).get("deliveryCharge") );
			
			if(totalPrice < 50000) {
				deliveryCharge = Integer.parseInt(String.valueOf(purchaseList.get(0).get("deliveryCharge")));				
				totalPrice += deliveryCharge;
			}
			session.setAttribute("orderPrice", orderPrice);
			session.setAttribute("deliveryCharge", deliveryCharge);
			session.setAttribute("purchaseListSize", purchaseList.size());
			session.setAttribute("totalPrice", totalPrice);
			//mav.addObject("delRequest", delRequest());
		}catch(Exception e) {
			e.printStackTrace();
			mav.setViewName("login");
		}
		return mav;
	}
	
	
	// cartInCheck
	@RequestMapping(value = "/cartInCheck.do")
	@ResponseBody
	public String cartInCheck(@RequestBody String str,
			HttpServletRequest request, HttpSession session) {

		if(session.getAttribute("custom") == null) {
			System.out.println("세션없당");
			session.setAttribute("cartInCheck", "cartInCheck");
			return "false";
		}
		System.out.println("세션있당");
		
		List<Map<String,Object>> cartList = new ArrayList<Map<String,Object>>();
		
		cartList = JSONArray.fromObject(str);
		
		
		CustomVO customVo = (CustomVO) session.getAttribute("custom");
		
		List<CartVO> getCartList = purchaseDao.getCart(customVo.getcId());
	
		for(int i=0; i<getCartList.size(); i++) {
			for(int j=0; j<cartList.size(); j++) {
				System.out.println("장바구니에 있는거 = " + getCartList.get(i).getpOption());
				System.out.println("이제 넣을꺼 = " + cartList.get(j).get("pOption"));
				if( getCartList.get(i).getpName().equals(cartList.get(j).get("pName"))
						&& getCartList.get(i).getpOption().equals(cartList.get(j).get("pOption"))){	
					return "exist";
				}
			}
		}
		
		session.setAttribute("cartList", cartList);
		return "true";
		
	}
	
	
	// purchaseCheck
	@RequestMapping(value = "/purchaseCheck.do" , method = RequestMethod.POST)
	@ResponseBody
	public String purchaseCheck(@RequestBody  String str,
			ModelAndView mav, HttpServletRequest request, HttpSession session) throws ServletRequestBindingException {
		
		if(session.getAttribute("custom") == null) {
			session.setAttribute("purchaseCheck", "purchaseCheck");
			System.out.println("세션없당");
			
			return "false";
		}
		
		List<Map<String,Object>> purchaseList = new ArrayList<Map<String,Object>>();
		purchaseList = JSONArray.fromObject(str);
		
		session.setAttribute("purchaseList", purchaseList);
		
	    return "true";
	}

	
	//purchase get
	@RequestMapping(value = "/purchase.do" , method = RequestMethod.GET)
	public ModelAndView purchaseGet(@RequestBody String purchase,
			ModelAndView mav, HttpServletRequest request, HttpSession session) {
		if(session.getAttribute("loginSession") == null)
			mav.setViewName("login");
		else
			mav.setViewName("purchase");
		return mav;
	}
	
	//purchase post
	@RequestMapping(value = "/purchase.do" , method = RequestMethod.POST)
	public ModelAndView purchasePost(@RequestBody String purchase,
			ModelAndView mav, HttpServletRequest request, HttpSession session) {
		
		//session.getAttribute("purchaseList");
		
		List<Map<String,Object>> purchaseList =  (List<Map<String, Object>>) session.getAttribute("purchaseList");
		mav.addObject("purchaseList");
		return mav;
	}
	
	
	// cartDelete
	@RequestMapping(value = "/cartDelete.do")
	@ResponseBody
	public String cartDelete(@RequestBody String cartDelete,
			HttpServletRequest request, HttpSession session, HttpServletResponse response) throws UnsupportedEncodingException {
		
		List<Map<String,Object>> cartDeleteList = new ArrayList<Map<String,Object>>();
		cartDeleteList = JSONArray.fromObject(cartDelete);
		
		CustomVO customVo = (CustomVO)session.getAttribute("custom");
		String userId = customVo.getcId();
		
		for(Map deleteMap : cartDeleteList) {
			deleteMap.put("userId", userId);
			System.out.println(deleteMap.get("optionStock"));
			int cartCnt = Integer.parseInt(String.valueOf(deleteMap.get("cartCnt")));
			System.out.println("carCnt = " + cartCnt);
			purchaseDao.cartDelete(deleteMap);	
		}
		
		return "true";
	}	
	
	
	public int totalPriceResult(int cnt, int price) {
		return cnt * price;
	}
	
	
	@RequestMapping(value = "/stockCheck.do" , method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView stockCheck(@RequestBody String stockCheck,
			HttpServletRequest request, 
			HttpSession session, HttpServletResponse response,
			ModelAndView mav) {
		
		
		Boolean bol = true;
		try {
			request.setCharacterEncoding("UTF-8");
			response.setContentType("text/html;charset=UTF-8");
	
			System.out.println("========== stock Check ==========");
			
			List<Map<String,Object>> purchaseList;
			int totalPrice = 0;
			
			// cart purchase
			if(session.getAttribute("purchaseList") == null) {
				purchaseList = new ArrayList<Map<String,Object>>();
				purchaseList = JSONArray.fromObject(stockCheck);
				
			}
			// detail purchase
			else {
				purchaseList = (List<Map<String, Object>>) session.getAttribute("purchaseList");
				
			}
			
			for(int i=0; i<purchaseList.size(); i++) {
				Map<String,Object> optionMap = new HashMap<String,Object>();
				optionMap.put("pSeq", String.valueOf(purchaseList.get(i).get("pSeq")));
				optionMap.put("pOption", String.valueOf(purchaseList.get(i).get("pOption")));
				
				int purchaseStock = Integer.parseInt(String.valueOf(purchaseList.get(i).get("optionCnt")));
				
				int optionStock = productDao.checkStock(optionMap);
				System.out.println("optionStock = " + optionStock);
				System.out.println("purchaseStock = " + purchaseStock);
				if(purchaseStock > optionStock) {
					System.out.println("재고가 부족합니다");
					mav.addObject("msg","선택한 품목의 재고가 부족합니다. 재고를 다시 확인해 주세요");
					mav.addObject("result",false);
					mav.setViewName("jsonView");
					
					bol = false;
					return mav;
				}
			}
			
			System.out.println("result = " + bol);
			mav.addObject("result",true);
			mav.setViewName("jsonView");
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return mav;
		
	}
}
