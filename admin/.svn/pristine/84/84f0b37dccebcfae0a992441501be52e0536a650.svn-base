package com.admin.controller;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.admin.VO.CustomVO;
import com.admin.VO.ProductVO;
import com.admin.dao.CustomDao;
import com.nexacro.xapi.data.DataSet;
import com.nexacro.xapi.data.DataTypes;
import com.nexacro.xapi.data.PlatformData;
import com.nexacro.xapi.data.VariableList;
import com.nexacro.xapi.tx.HttpPlatformRequest;
import com.nexacro.xapi.tx.HttpPlatformResponse;
import com.nexacro.xapi.tx.PlatformException;
import com.nexacro.xapi.tx.PlatformType;

@Controller
@RequestMapping(value = "/custom")
public class CustomController {


	private int pageSize = 10;
	private int blockCount = 10;

	@Autowired
	private CustomDao customDao;
	 
	@RequestMapping({ "/list.do" })
	public void list(
			//@RequestParam(value = "pageNum", defaultValue = "") int currentPage,
			//@RequestParam(value = "keyField", defaultValue = "") String keyField,
			//@RequestParam(value = "keyWord", defaultValue = "") String keyWord, 
			HttpServletRequest request,
			HttpServletResponse response) throws PlatformException, UnsupportedEncodingException {

		System.out.println("/list in");
		// Xplatform basic object creation
		PlatformData pdata = new PlatformData();

		int nErrorCode = 0;
		String strErrorMsg = "START";

		//keyWord = new String(request.getParameter("keyWord").getBytes("iso8859-1"), "UTF-8");

		try {
			System.out.println("HttpPlatformRequest in");
			HttpPlatformRequest req = new HttpPlatformRequest(request);

			req.receiveData();
			pdata = req.getData();

			DataSet pds = new DataSet("customDataset");

			pds.addColumn("cId", DataTypes.STRING, 4);
			pds.addColumn("pName", DataTypes.STRING, 300);
			pds.addColumn("pAddCode", DataTypes.STRING, 10);
			pds.addColumn("pAdd", DataTypes.STRING, 50);
			pds.addColumn("pAddDetail", DataTypes.STRING, 50);
		
//			if (keyWord.toString().equals("undefined"))
//				keyWord = "";
			// DAO
//			System.out.println("keyField = " + keyField);
//			System.out.println("KeyWord = " + keyWord);

			HashMap<String, Object> map = new HashMap();

//			map.put("keyField", keyField);
//			map.put("keyWord", keyWord);

			int count = 0;
//			if (keyField.toString().equals("orgfilename")) {
//				System.out.println("filecount");
//				count = productDao.getfileCount(map);
//			} else {
//				System.out.println("boardcount");
//				count = productDao.getCount(map);
//			}

//			System.out.println("count = " + count);
//			System.out.println("currentPage = " + currentPage);
			
//			Paging page = new Paging(keyField, keyWord, currentPage, count, this.pageSize, this.blockCount, "list.do");
//
//			map.put("start", Integer.valueOf(page.getStartCount()));
//			map.put("end", Integer.valueOf(page.getEndCount()));

			
			List<CustomVO> list = customDao.list();
			
			System.out.println("list.size() = " + list.size());
			// int number = count - (currentPage - 1) * this.pageSize;
			// public List<BoardVO> list(Map<String, Object> map)
	
			
			CustomVO pvo = new CustomVO();

			for (int i = 0; i < list.size(); i++) {

				int row = pds.newRow(); // new Row feed

				pvo = list.get(i);
				pds.set(row, "cId", pvo.getcId());
				pds.set(row, "pName", pvo.getcName());
				pds.set(row, "pAddCode", pvo.getcAddCode());
				pds.set(row, "pAdd", pvo.getcAdd());
				pds.set(row, "pAddDetail", pvo.getcAddDetail());
				
			} // for

			pdata.addDataSet(pds);

			// set the ErrorCode and ErrorMsg about success
			nErrorCode = 0;
			strErrorMsg = "SUCC";
			strErrorMsg = String.valueOf(count);

		} catch (Throwable th) {
			// set the ErrorCode and ErrorMsg about fail
			nErrorCode = -1;
			strErrorMsg = th.getMessage();
			System.out.println("ERROR:" + strErrorMsg);
			th.printStackTrace();
		} // try

		// save the ErrorCode and ErrorMsg for sending Client
		VariableList varList = pdata.getVariableList();

		varList.add("ErrorCode", nErrorCode);
		varList.add("ErrorMsg", strErrorMsg);

		// send the result data(XML) to Client
		HttpPlatformResponse res = new HttpPlatformResponse(response, PlatformType.CONTENT_TYPE_XML, "UTF-8");

		res.setData(pdata);
		res.sendData(); // Send Data

	}

}
