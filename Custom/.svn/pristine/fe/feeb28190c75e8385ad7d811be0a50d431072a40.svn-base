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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.custom.VO.CustomVO;
import com.custom.dao.CustomDao;

import net.sf.json.JSONArray;

@Controller
public class LoginController {

	@Autowired
	private CustomDao customDao;

	
	@RequestMapping(value = "/idcheck.do", method = RequestMethod.POST)
	@ResponseBody
	public String idcheck(@RequestBody String cId) {

		int count = 0;
		Boolean bol = false;
		Map<Object, Object> map = new HashMap<Object, Object>();

		count = customDao.idCheck(cId);
		System.out.println("count = " + count);
		map.put("cnt", count);

		if (count > 0)
			bol = true;
		return String.valueOf(bol);
	}

	@RequestMapping(value = "/login.do", method = RequestMethod.GET)
	public ModelAndView loginGet(ModelAndView mav) {
		mav.setViewName("login");
		return mav;
	}

	@RequestMapping(value = "/login.do", method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView loginPOST(HttpServletRequest request, HttpServletResponse response,
			@RequestParam("userId") String userId, @RequestParam("userPass") String userPass) throws UnsupportedEncodingException {
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		
		ModelAndView mav = new ModelAndView();
		System.out.println("inputid = " + userId);
		System.out.println("inputpass = " + userPass);
		
		CustomVO loginVo = customDao.customLogin(userId);
		Boolean loginBol = false;

		if (loginVo != null)
			loginBol = userPass.equals(loginVo.getcPass());
		System.out.println("loginVo = " + loginVo);
		HttpSession session = request.getSession();
		
		if (loginVo != null && loginBol) {
			mav.addObject("msg", true);
			session.setAttribute("custom", loginVo);
			session.setAttribute("userId", loginVo.getcId());
			session.setAttribute("userName", loginVo.getcName());
			
			System.out.println("sesseion = " + session.getAttribute("custom"));
			System.out.println("sesseion cartInCheck = " + session.getAttribute("cartInCheck"));
			System.out.println("sesseion purchaseCheck= " + session.getAttribute("purchaseCheck"));
			
			// purchaseList session 유무 
			// 구매하기
			if(session.getAttribute("purchaseList") != null &&
				session.getAttribute("purchaseCheck") == "purchaseCheck") { 
				mav.addObject("url", "purchase.do");
				System.out.println("구매");
			}
			
			// 장바구니
			else if(session.getAttribute("cartList") != null &&
					session.getAttribute("cartInCheck") == "cartInCheck") {
				mav.addObject("url", "cartIn.do");
				System.out.println("카트");
			}
			else
				mav.addObject("url", "productList.do");
		} 
		else {
			session.setAttribute("custom", null);
			
			mav.addObject("msg", false);
			System.out.println("sesseion = " + session.getAttribute("custom"));
			if (loginVo == null) {
				mav.addObject("result", "아이디가 없습니다");
				System.out.println("아이디 x");
			} else if (!loginBol) {
				mav.addObject("result", "비밀번호가 일치하지 않습니다");
				System.out.println("비밀번호 x");
			}
			
		}
		
		mav.setViewName("jsonView");
		return mav;
	}
	@RequestMapping(value = "/logout.do")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:login.do";
	}
	
	
	
}
