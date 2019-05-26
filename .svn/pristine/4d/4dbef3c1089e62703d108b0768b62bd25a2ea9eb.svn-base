package com.custom.Controller;

import java.io.UnsupportedEncodingException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.custom.Map.LoginCheckMap;
import com.custom.VO.CustomVO;
import com.custom.dao.CustomDao;


@Controller
public class LoginController {

	@Autowired
	private CustomDao customDao;
	String preLoginSessionId = null;
	String currentLoginSessionId = null;
	
	
	// insert
	@RequestMapping(value = "/customInsert.do", method = RequestMethod.POST)
	public String insertPost(ModelAndView mav, HttpServletRequest request) throws Exception {
		
		String cId = request.getParameter("cId");
		String cName = request.getParameter("cName");
		String cPass = request.getParameter("cPass");
		String cAdd = request.getParameter("cAdd");
		String cAddCode = request.getParameter("cAddCode");
		String cAddDetail = request.getParameter("cAddDetail");
		String cPhone1 = request.getParameter("phone1");
		String cPhone2 = request.getParameter("phone2");
		String cPhone3 = request.getParameter("phone3");

		CustomVO vo = new CustomVO(cId, cPass, cName, cAdd, cAddCode, cAddDetail, cPhone1, cPhone2, cPhone3);
		customDao.customInsert(vo);
		mav.setViewName("productList");
		String url = String.valueOf(request.getSession().getAttribute("url"));
		mav.addObject("url", url);
		return "redirect:"+url;
	}
	
	
	// id check
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
	
	
	
	// login.do Get
	@RequestMapping(value = "/login.do", method = RequestMethod.GET)
	public ModelAndView loginGet(ModelAndView mav) {
		System.out.println("----------- login.do get -----------");
		mav.setViewName("login");
		return mav;
	}

	// login.do post
	@RequestMapping(value = "/login.do", method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView loginPOST(HttpServletRequest request, HttpServletResponse response,
			HttpSession session,
			@RequestParam("userId") String cId, 
			@RequestParam("userPass") String cPass) throws UnsupportedEncodingException {
		
	
		System.out.println("============== login post =============");
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		
		ModelAndView mav = new ModelAndView();
		System.out.println("inputid = " + cId);
		System.out.println("inputpass = " + cPass);
		
		CustomVO loginVo = customDao.customLogin(cId);
		Boolean loginBol = false;
		
		String param ="?keyWord=" + String.valueOf(session.getAttribute("keyWord")) 
				+ "&pageNum=" + String.valueOf(session.getAttribute("pageNum"));
		
		if (loginVo != null)
			loginBol = cPass.equals(loginVo.getcPass());
		
		if (loginVo != null && loginBol) {
			mav.addObject("msg", true);
			
			LoginCheckMap.logincheckMap.put(cId, session.getId());
			session.setAttribute("loginSession", LoginCheckMap.logincheckMap.get(cId));
			session.setAttribute("custom", loginVo);
			session.setAttribute(cId, session.getId());
			
			String loginSession = String.valueOf( (session.getAttribute(cId)) );
			
			loginVo.setLoginSession(loginSession);
		
			// purchaseList session 유무 
			// 구매하기
			if(session.getAttribute("purchaseList") != null &&
				session.getAttribute("purchaseCheck") == "purchaseCheck") { 
				
				mav.addObject("url", "custom/purchaseClick.do"+param);
				System.out.println("구매");
			}
			
			// 장바구니
			else if(session.getAttribute("cartList") != null &&
					session.getAttribute("cartInCheck") == "cartInCheck") {
				mav.addObject("url", "cartIn.do");
				System.out.println("카트");
			}
			else {
				String url = String.valueOf(session.getAttribute("url"));
				System.out.println("url = " + session.getAttribute("url"));
				mav.addObject("url", url);
			}
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
	
	// logout
	@RequestMapping(value = "/logout.do")
	public String logout(HttpServletRequest request, HttpSession session) {
		System.out.println("cSeq = " + request.getParameter("cSeq"));
		
		Enumeration e = session.getAttributeNames();

		while (e.hasMoreElements()) {

			String attributeName = (String) e.nextElement();
			System.out.println(attributeName);
			//String attributeValue = (String) session.getAttribute(attributeName);
		}
		
		String cId = String.valueOf(session.getAttribute("cId"));
		
		CustomVO customVo = new CustomVO(cId, "");
		//customDao.loginSession(customVo);
		LoginCheckMap.logincheckMap.remove(cId);
		session.removeAttribute(cId);
		session.removeAttribute("loginSession");
		
		//session.invalidate();
		//return "redirect:productList.do";
		return "redirect:" + session.getAttribute("url");
	}
	
	// idSearch Get
	@RequestMapping(value = "/idSearch.do", method = RequestMethod.GET)
	public ModelAndView idSearchGet(ModelAndView mav) {
		mav.setViewName("Search/idSearch");
		return mav;
	}
	
	// passSearch Get
	@RequestMapping(value = "/passSearch.do", method = RequestMethod.GET)
	public ModelAndView passSearchGet(ModelAndView mav) {
		mav.setViewName("Search/passSearch");
		return mav;
	}
	
	
	// idSearch POST
	@RequestMapping(value = "/idSearch.do", method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView idSearch(
			@RequestParam("cName") String cName,
			@RequestParam("cPhone1") String Phone1,
			@RequestParam("cPhone2") String Phone2,
			@RequestParam("cPhone3") String Phone3,
			ModelAndView mav,
			HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		System.out.println(cName);
		
		CustomVO customVo = new CustomVO(cName, Phone1,Phone2,Phone3);
		
		List<CustomVO> resultVoList = customDao.idSearch(customVo);
		
		
		String msg = "";
		Boolean bol = false;
		
		if(resultVoList == null || resultVoList.size() == 0) {
			msg = "아이디를 찾을 수 없습니다";
			mav.addObject("url","custom/idSearch.do");
			bol = false;
		}
		else {
			bol = true;
			msg += "찾으시는 아이디는 : ";
			for(int i=0; i<resultVoList.size();i++) {
				msg += resultVoList.get(i).getcId();
				if(resultVoList.size()-1 != i)
					msg += " , " ;
			}
			msg += " 입니다 ";
			
		}
		
		mav.addObject("msg",msg);
		mav.addObject("result",bol);
		
		
		mav.setViewName("jsonView");
		return mav;
	}
	
	
	// passSearch POST
	@RequestMapping(value = "/passSearch.do", method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView passSearchPost(
			@RequestParam("cId") String cId,
			@RequestParam("cName") String cName,
			@RequestParam("cPhone1") String Phone1,
			@RequestParam("cPhone2") String Phone2,
			@RequestParam("cPhone3") String Phone3,
			ModelAndView mav,
			HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		CustomVO customVo = new CustomVO(cId, cName, Phone1,Phone2,Phone3);
		
		String resultPass = customDao.passSearch(customVo);
	
		String msg = null;
		Boolean bol = false;
		
		if(resultPass == null) {
			msg = "비밀번호를 찾을 수 없습니다. 정보를 정확하게 입력해 주세요";
			mav.addObject("url","custom/passSearch.do");
			bol = false;
		}
		else {
			bol = true;
			msg = "찾으시는 " + cId + "님의 비밀번호는   " + resultPass + " 입니다";
		}
		
		mav.addObject("msg",msg);
		mav.addObject("result",bol);
		
		mav.setViewName("jsonView");
		return mav;
	}
	
	
		
}
