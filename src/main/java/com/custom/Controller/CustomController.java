package com.custom.Controller;

import java.io.UnsupportedEncodingException;
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

import com.custom.VO.CustomVO;
import com.custom.dao.CustomDao;


@Controller
public class CustomController {

	@Autowired
	CustomDao customDao;
	
	
	// custom update get
	@RequestMapping(value = "/customUpdate.do", method = RequestMethod.GET)
	public ModelAndView updateGet( ModelAndView mav, HttpSession session) {
		
		CustomVO customVo = (CustomVO) session.getAttribute("custom");
	
		
		if(session.getAttribute("loginSession") == null
				|| customVo == null)
			mav.setViewName("login");
			
		else {
			mav.setViewName("customUpdate");
			CustomVO loginCustomVo = customDao.customLogin( String.valueOf(customVo.getcId()) );
			
			mav.addObject("customVo", loginCustomVo);
		}
		return mav;
	}
	
	// pass check
	@RequestMapping(value = "/passCheck.do", method = RequestMethod.POST)
	@ResponseBody
	public String passCheck(@RequestBody Map customMap, HttpSession session) throws ParseException {

		Boolean bol = false;
		System.out.println("passCheck-----------------------------\n");
		System.out.println(customMap);
		
		//String cInputOldPass = jsonStr.get("cInputOldPass").toString();
		//String cChangePass = jsonStr.get("cChangePass").toString();
		//String cId = jsonStr.get("cId").toString();

		String cInputOldPass = customMap.get("cInputOldPass").toString();
		String cId = customMap.get("cId").toString();
		String cChangePass = customMap.get("cChangePass").toString();
		
		System.out.println("cInputOldPass = " + cInputOldPass);
		System.out.println("cId = " + cId);
		System.out.println("cChangePass = " + cChangePass);
		
		String cOldPass = customDao.passCheck(cId);
	
		if(!cInputOldPass.equals(cOldPass)) {
			bol = false;
		}
		else {
			bol = true;
		}
		
		System.out.println("bol = " + bol);
		return String.valueOf(bol);
	}


	// delete
	@RequestMapping(value = "/customDelete.do", method = RequestMethod.POST)
	@ResponseBody
	public String customDelete(
			@RequestBody Map customMap,
			ModelAndView mav,
			HttpServletRequest request, HttpSession session, HttpServletResponse response){
		
		System.out.println("-----------------------------customDelete\n");
		System.out.println("cId = " + customMap.get("cId"));
		
		customDao.customDelete(String.valueOf(customMap.get("cId")));
		System.out.println("삭제 완료");
		return "true";
	}
	
	
	// update
	@RequestMapping(value = "/customUpdate.do", method = RequestMethod.POST)
	@ResponseBody
	public String customUpdate(@RequestBody Map customMap,
			ModelAndView mav,
			HttpServletRequest request, HttpSession session, HttpServletResponse response){
		
		System.out.println("customUpdate");
		
		System.out.println("cId = " + customMap.get("cId"));
		System.out.println("cChangePass = " + customMap.get("cChangePass"));
		System.out.println("cName = " + customMap.get("cName"));
		System.out.println("cAddDetail = " + customMap.get("cAddDetail"));

		customDao.customUpdate(customMap);
		return "true";
	}

}
