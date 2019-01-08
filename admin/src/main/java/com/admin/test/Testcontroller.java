package com.admin.test;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller(value = "/test")
public class Testcontroller {


	@RequestMapping("/test.do" )
	public String list( ){
		System.out.println(".......");
		return "NewFile";
	}
	
}
