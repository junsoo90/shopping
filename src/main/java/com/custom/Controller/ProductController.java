package com.custom.Controller;

import java.net.StandardSocketOptions;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.custom.VO.OptionVO;
import com.custom.VO.PhotoVO;
import com.custom.VO.ProductVO;
import com.custom.dao.ProductDao;
import com.custom.paging.Paging;

import net.sf.json.JSONArray;

@Controller
public class ProductController {

	private int pageSize = 10;
	private int blockCount = 10;

	@Autowired
	private ProductDao productDao;

	@RequestMapping("/insert")
	public String customInset() {

		return "customInset";
	}

	@RequestMapping(value = "/productList.do")
	public ModelAndView productList(
			@RequestParam(value = "pageNum", defaultValue = "1") int currentPage,
			@RequestParam(value = "keyField", defaultValue = "") String keyField,
			@RequestParam(value = "keyWord", defaultValue = "") String keyWord, 
			HttpSession session, HttpServletRequest request) throws Exception {
		@SuppressWarnings({ "unchecked", "rawtypes" })

		
		String pagingHtml = "";
		System.out.println("============ productList.do =============");
		HashMap<String, Object> map = new HashMap();
		
		keyWord = URLDecoder.decode(keyWord, "UTF-8");
				//new String(request.getParameter("keyWord").getBytes("iso8859-1"),
				 //"UTF-8");
		 //URLDecoder.decode(keyWord, "UTF-8") ;
	
		String param = "?keyWord=" + keyWord +"&pageNum=" + currentPage;
		session.setAttribute("keyWord", keyWord);
		session.setAttribute("pageNum", currentPage);
		
		session.setAttribute("url","productList.do"+param);
		
		map.put("keyField", keyField);
		map.put("keyWord", keyWord);
		
		System.out.println(request.getRequestURL());
		System.out.println(request.getRequestURI());
		
		System.out.println("keyField = " + keyField);
		System.out.println("keyWord = " + keyWord);
		
		int count = productDao.getCount(map);
		System.out.println("count = " + count);
		
		Paging page = new Paging(keyField, keyWord, currentPage, count, 
						this.pageSize, this.blockCount, "productList.do");

		pagingHtml = page.getPagingHtml().toString();

		map.put("start", Integer.valueOf(page.getStartCount()));
		map.put("end", Integer.valueOf(page.getEndCount()));

		System.out.println(page.getStartCount());
		System.out.println(page.getEndCount());

		System.out.println("current page = " + currentPage);
		List<ProductVO> list = null;
		
//		if (count > 0) {
//			list = productDao.productlist(map);
//		} else {
//			list = Collections.emptyList();
//		}

		list = productDao.productlist(map);
		
		
		int number = count - (currentPage - 1) * this.pageSize;
		int endPage = (count / pageSize) + ((count % pageSize == 0) ? 0 : 1);

		ModelAndView mav = new ModelAndView();

		mav.setViewName("productList");
		
		mav.addObject("count", Integer.valueOf(count));
		mav.addObject("currentPage", Integer.valueOf(currentPage));
		mav.addObject("list", list);
		mav.addObject("pagingHtml", pagingHtml);
		mav.addObject("number", Integer.valueOf(number));
		mav.addObject("endPage", endPage);
		mav.addObject("keyField",keyField);
		mav.addObject("keyWord",keyWord);
		
		// System.out.println("list keyfiled = " + keyField);

		session.removeAttribute("purchaseList");
		return mav;
	}

	@RequestMapping(value = "/detail.do", method = RequestMethod.GET)
	public ModelAndView detail(ModelAndView mav, HttpServletRequest request) throws Exception {
		System.out.println("------- detail ---------");
		System.out.println(request.getRequestURL());
		System.out.println(request.getSession().getAttribute("url"));
		System.out.println(request.getParameter("seq"));
		try {
			int seq = Integer.parseInt(request.getParameter("seq"));
			System.out.println("seq = " + seq);
			ProductVO vo = productDao.getInfo(seq);
			
			String param = "?seq="+seq;
			
			request.getSession().setAttribute("url", "detail.do" + param);
			System.out.println("request url = " + request.getSession().getAttribute("url"));
		
			
			List<OptionVO> list = productDao.getOptionInfo(seq);

			
			if (list.isEmpty() || list.size() == 0) {
				mav.setViewName("productEmpty");
				return mav;
			}
			for (int i = 0; i < list.size(); i++)
				System.out.println(list.get(i).getpOption());

			List<PhotoVO> photolist = productDao.photoGetInfo(seq);
			
			System.out.println("filelocation = " + photolist.get(0).getFilelocation());

			mav.addObject("filelocation", photolist.get(0).getFilelocation());
			mav.addObject("photolist", photolist);
			mav.addObject("vo", vo);
			mav.addObject("optionlist", list);

			JSONArray jsonArray = new JSONArray();
			mav.addObject("jsonList", jsonArray.fromObject(list));
			System.out.println(jsonArray.fromObject(list));
			mav.setViewName("productDetail");
			
		} catch (Exception e) {
			e.printStackTrace();
			mav.setViewName("productEmpty");
		}
		return mav;
	}

	@RequestMapping(value = "/customInsert.do", method = RequestMethod.GET)
	public ModelAndView insertGet(ModelAndView mav) throws Exception {
		mav.setViewName("customInsert");
		return mav;
	}



}
