package com.custom.Controller;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.custom.VO.CustomVO;
import com.custom.VO.OptionVO;
import com.custom.VO.PhotoVO;
import com.custom.VO.ProductVO;
import com.custom.dao.CustomDao;
import com.custom.dao.ProductDao;

import net.sf.json.JSONArray;

@Controller
public class CustomController {

	private int pageSize = 10;
	private int blockCount = 10;

	@Autowired
	private ProductDao productDao;


	@RequestMapping("/insert")
	public String customInset() {

		return "customInset";
	}

	@RequestMapping(value = "/productList.do")
	public ModelAndView productList() throws Exception {
		String pagingHtml = "";
		@SuppressWarnings({ "unchecked", "rawtypes" })

		HashMap<String, Object> map = new HashMap();
		// map.put("keyField", keyField);
		// map.put("keyWord", keyWord);

		int count = productDao.getCount(map);

		// Paging page = new Paging(keyField, keyWord, currentPage, count,
		// this.pageSize, this.blockCount, "list.do");

		// pagingHtml = page.getPagingHtml().toString();

		// map.put("start", Integer.valueOf(page.getStartCount()));
		// map.put("end", Integer.valueOf(page.getEndCount()));

		List<ProductVO> list = null;
		if (count > 0) {
			list = this.productDao.productlist();
		} else {
			list = Collections.emptyList();
		}
		// int number = count - (currentPage - 1) * this.pageSize;
		// int endPage = (count / pageSize) + ((count % pageSize == 0) ? 0 : 1);

		
		for(int i=0; i<list.size(); i++) {
			List<PhotoVO> fileList = productDao.photoGetInfo(list.get(i).getpSeq());
			for(int j=0; j<fileList.size(); j++) {
				String filelocation = fileList.get(0).getFilelocation();
				System.out.println(fileList.get(0).getFilelocation());
				list.get(i).setFilelocation(filelocation);
			}
		}
		
		
		ModelAndView mav = new ModelAndView();

		mav.setViewName("productList");
		mav.addObject("count", Integer.valueOf(count));
		// mav.addObject("currentPage", Integer.valueOf(currentPage));
		mav.addObject("list", list);
		// mav.addObject("pagingHtml", pagingHtml);
		// mav.addObject("number", Integer.valueOf(number));
		// mav.addObject("endPage",endPage);
		// mav.addObject("keyField",keyField);
		// mav.addObject("keyWord",keyWord);
		// System.out.println("list keyfiled = " + keyField);

		return mav;
	}

	@RequestMapping(value = "/detail.do", method = RequestMethod.GET)
	public ModelAndView detail(ModelAndView mav, HttpServletRequest request
								) throws Exception {

		int seq = Integer.parseInt(request.getParameter("seq"));
		System.out.println("seq = " + seq);
		ProductVO vo = productDao.getInfo(seq);
		
		OptionVO optionVo = new OptionVO();
		optionVo.setpOption("옵션을 선택해 주세요");
		
		List<OptionVO> list = productDao.getOptionInfo(seq);
		list.add(0, optionVo);		
		
		for (int i = 0; i < list.size(); i++)
			System.out.println(list.get(i).getpOption());
		
		List<PhotoVO> photolist = productDao.photoGetInfo(seq);
		System.out.println("filelocation = "  + photolist.get(0).getFilelocation());
		
		mav.addObject("filelocation", photolist.get(0).getFilelocation());
		mav.addObject("vo", vo);
		mav.addObject("optionlist", list);
		
		JSONArray jsonArray = new JSONArray();
		mav.addObject("jsonList", jsonArray.fromObject(list));
		System.out.println(jsonArray.fromObject(list));
		mav.setViewName("productDetail");
		return mav;
	}

	@RequestMapping(value = "/customInsert.do", method = RequestMethod.GET)
	public ModelAndView insertGet(ModelAndView mav) throws Exception {
		mav.setViewName("customInsert");
		return mav;
	}

	
	
}
