package com.admin.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.admin.VO.FileVO;
import com.admin.VO.OptionVO;
import com.admin.VO.ProductVO;
import com.admin.dao.ProductDao;
import com.nexacro.xapi.data.DataSet;
import com.nexacro.xapi.data.DataTypes;
import com.nexacro.xapi.data.PlatformData;
import com.nexacro.xapi.data.VariableList;
import com.nexacro.xapi.tx.HttpPlatformRequest;
import com.nexacro.xapi.tx.HttpPlatformResponse;
import com.nexacro.xapi.tx.PlatformException;
import com.nexacro.xapi.tx.PlatformType;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@Controller
@RequestMapping(value = "/product")
public class ProductController {

	private int pageSize = 10;
	private int blockCount = 10;

	@Autowired
	private ProductDao productDao;

	@RequestMapping(value = "/list.do")
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

			DataSet pds = new DataSet("productDataset");

			pds.addColumn("pSeq", DataTypes.INT, 4);
			pds.addColumn("pName", DataTypes.STRING, 300);
			pds.addColumn("pStock", DataTypes.INT, 10);
			pds.addColumn("pPrice", DataTypes.INT, 50);
		
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

			
			List<ProductVO> list = productDao.list();
			
			System.out.println("list.size() = " + list.size());
			// int number = count - (currentPage - 1) * this.pageSize;
			// public List<BoardVO> list(Map<String, Object> map)
	
			
			ProductVO pvo = new ProductVO();

			for (int i = 0; i < list.size(); i++) {

				int row = pds.newRow(); // new Row feed

				pvo = list.get(i);
				
				pds.set(row, "pSeq",pvo.getpSeq());
				pds.set(row, "pName",pvo.getpName());
				pds.set(row, "pPrice",pvo.getpPrice());
				

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

	@SuppressWarnings({ "deprecation", "null" })
	@RequestMapping(value = "/insert.do")
	public void insert(HttpServletRequest request, HttpServletResponse response
	// ,ModelAndView mv, BoardVO board
	) throws PlatformException {
		
		System.out.println("insert.do");
		PlatformData pdata = new PlatformData();

		int nErrorCode = 0;
		String strErrorMsg = "START";

		try {
			// receive client request
			// not need to receive

			// create HttpPlatformRequest for receive data from client
			HttpPlatformRequest req = new HttpPlatformRequest(request);

			req.receiveData();
			pdata = req.getData();

			DataSet pds = pdata.getDataSet("productDataSet");
			DataSet opds = pdata.getDataSet("optionDataSet");

			int seq = productDao.getMaxSeq() + 1;
			System.out.println("Seq = " + seq);
			int ref = pds.getInt(0, "pRef");
			int step = pds.getInt(0, "pStep");
			int lev = pds.getInt(0, "pLev");

			if (ref == 0) {
				System.out.println("초기");
				ref = seq;
			} else {
				ProductVO vo = new ProductVO();
				// if(votemp.getRef() == ref)
				// ref = board_seq;

				// vo.setRef(ref);
				// vo.setStep(step);

				productDao.stepUp(vo);

				lev = lev + 1;
				step = step + 1;
			}
			ProductVO pvo = new ProductVO();

			pvo.setpName(pds.getString(0, "pName"));
			pvo.setpPrice(pds.getInt(0, "pPrice"));
			pvo.setpDetail(pds.getString(0, "pDetail"));

			pvo.setpRef(ref);
			pvo.setpLev(lev);
			pvo.setpStep(step);

			System.out.println("name = " + pds.getString(0, "pName"));
			System.out.println("price = " + pds.getInt(0, "pPrice"));
			System.out.println("detail = " + pds.getString(0, "pDetail"));
			System.out.println("stock = " + pds.getInt(0, "pStock"));
			productDao.insert(pvo);
			
			// optionDataSet

			int opdsCnt = opds.getRowCount();
			
			
			System.out.println("Seq = " + seq);
			for (int i = 0; i < opdsCnt; i++) {
				OptionVO opvo = new OptionVO();
				
				int optionCnt = opds.getInt(i, "cnt");
				String opdsOption = opds.getString(i, "option");
				int opdsStock = opds.getInt(i, "optionStock");
				int opdsPrice = opds.getInt(i, "optionPrice");
				
				
				System.out.println("option = " + opdsOption);
				System.out.println("opdsStock = " + opdsStock);
				System.out.println("opdsPrice = " + opdsPrice);
				opvo.setpSeq(seq);
				opvo.setpOption(opdsOption);
				opvo.setOptionCnt(optionCnt);
				opvo.setOptionPrice(opdsPrice);
				opvo.setOptionStock(opdsStock);
				System.out.println("...............");
				productDao.optionInsert(opvo);
			}

			
			
			// VALUES(pSeq.nextval,#{pName},#{pPrice},#{pStock},#{pDetail}
			// #{pLev},#{pRef},#{pStep})

			// set the ErrorCode and ErrorMsg about success
			nErrorCode = 0;
			// strErrorMsg = productDao.insert( board );

		} catch (Throwable th) {
			// set the ErrorCode and ErrorMsg about fail
			nErrorCode = -1;
			strErrorMsg = th.getMessage();
			th.printStackTrace();
			System.out.println("ERROR:" + strErrorMsg);
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

	@RequestMapping(value = "/detail.do")
	public void detail(HttpServletRequest request, HttpServletResponse response) throws PlatformException {

		PlatformData pdata = new PlatformData();

		int nErrorCode = 0;
		String strErrorMsg = "START";

		try {
			System.out.println("HttpPlatformRequest in");
			HttpPlatformRequest req = new HttpPlatformRequest(request);

			req.receiveData();
			pdata = req.getData();

			int pSeq = Integer.parseInt(request.getParameter("pSeq"));
			System.out.println("pSeq = " + pSeq);

			DataSet pds = new DataSet("productDataset");
			DataSet fileds = new DataSet("fileDataSet");
			DataSet opds = new DataSet("optionDataSet");
			
			opds.addColumn("cnt", DataTypes.INT, 256);
			opds.addColumn("option", DataTypes.STRING, 256);
			opds.addColumn("optionStock", DataTypes.INT, 256);
			opds.addColumn("optionPrice", DataTypes.INT, 256);
			
			pds.addColumn("pSeq", DataTypes.STRING, 256);
			pds.addColumn("pName", DataTypes.STRING, 256);
			pds.addColumn("pStock", DataTypes.INT, 256);
			pds.addColumn("pPrice", DataTypes.INT, 256);
			pds.addColumn("pDetail", DataTypes.STRING, 256);
			
			fileds.addColumn("pSeq", DataTypes.INT, 256);
			fileds.addColumn("filecnt", DataTypes.INT, 256);
			fileds.addColumn("orgfilename", DataTypes.STRING, 256);
			fileds.addColumn("savefilename", DataTypes.STRING, 256);
			fileds.addColumn("filelocation", DataTypes.STRING, 1000);
			fileds.addColumn("location", DataTypes.STRING, 1000);
			

			HashMap<String, Object> map = new HashMap();

			ProductVO vo = productDao.getInfo(pSeq);
			
			List<FileVO> filelist = productDao.filegetInfo(pSeq);
			
			int row = pds.newRow();
			
			pds.set(0, "pSeq", vo.getpSeq());
			pds.set(0, "pName", vo.getpName());
			pds.set(0, "pPrice", vo.getpPrice());
			pds.set(0, "pDetail", vo.getpDetail());
			
			System.out.println(vo.getpDetail());
			System.out.println(vo.getpSeq());
			System.out.println(vo.getpName());
			System.out.println(vo.getpPrice());
			

			for (int i = 0; i < filelist.size(); i++) {
				int filerow = fileds.newRow();
				System.out.println(filelist.get(i).getSavefilename());
				fileds.set(filerow, "filecnt", i + 1);
				fileds.set(filerow, "pSeq", filelist.get(i).getpSeq());
				fileds.set(filerow, "orgfilename", filelist.get(i).getOrgfilename());
				fileds.set(filerow, "savefilename", filelist.get(i).getSavefilename());
				fileds.set(filerow, "filelocation", filelist.get(i).getFilelocation());
			}

			List<OptionVO> optionList = productDao.getOptionInfo(pSeq);
			
			for(int i=0; i<optionList.size(); i++) {
				int oprow = opds.newRow();
				opds.set(oprow, "cnt", i);
				opds.set(oprow, "option", optionList.get(i).getpOption());
				opds.set(oprow, "optionStock", optionList.get(i).getOptionStock());
				opds.set(oprow, "optionPrice", optionList.get(i).getOptionPrice());				
			}
			
			//productDao.addHit(pSeq);
			pdata.addDataSet(pds);
			pdata.addDataSet(fileds);
			pdata.addDataSet(opds);

			// set the ErrorCode and ErrorMsg about success
			nErrorCode = 0;
			strErrorMsg = "SUCC";

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

	@RequestMapping(value = "/download.do")
	public void download(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		System.out.println();
		System.out.println("download.do in");

		String sRealPath = request.getSession().getServletContext().getRealPath("/");
		String sPath = sRealPath + "upload";
		String sName = request.getParameter("file");
		String sFile = new String(sName.getBytes("iso8859-1"), "UTF-8");

		System.out.println("spath = " + sPath);
		System.out.println("sName = " + sName);
		System.out.println("sFile = " + sFile);
		byte[] buffer = new byte[1024];

		ServletOutputStream out_stream = null;
		BufferedInputStream in_stream = null;

		File fis = new File(sPath + "/" + sFile);

		if (fis.exists()) {
			try {
				response.setContentType("utf-8");
				response.setContentType("application/octet;charset=utf-8");
				response.setHeader("Content-Disposition", "attachment;filename=" + sFile);

				// out.clear();
				// out = pageContext.pushBody();
				out_stream = response.getOutputStream();
				in_stream = new BufferedInputStream(new FileInputStream(fis));
				int nCnt = 0;
				while ((nCnt = in_stream.read(buffer, 0, 1024)) != -1) {
					out_stream.write(buffer, 0, nCnt);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if (in_stream != null) {
					try {
						in_stream.close();
					} catch (Exception e) {
					}
				}
				if (out_stream != null) {
					try {
						out_stream.close();
					} catch (Exception e) {
					}
				}
			}
		} else {
			response.sendRedirect("unknownfile");
		}
	}

	@RequestMapping(value = "/delete.do")
	public void delete(HttpServletRequest request, HttpServletResponse response) throws PlatformException {

		int seq = Integer.valueOf(request.getParameter("seq"));

		PlatformData pdata = new PlatformData();

		int nErrorCode = 0;
		String strErrorMsg = "START";

		try {
			HttpPlatformRequest req = new HttpPlatformRequest(request);

			req.receiveData();
			pdata = req.getData();
			List<FileVO> list = productDao.filegetInfo(seq);
			int n = productDao.delete(seq);

			System.out.println("list.size() = " + list.size());
			if (!list.isEmpty()) {
				for (int i = 0; i < list.size(); i++) {
					String savepath = list.get(i).getFilelocation();
					String filename = list.get(i).getSavefilename();

					File file = new File(savepath);
					if (file.exists()) {
						file.delete();
					}
				}
			}

			if (n > 0) {
				strErrorMsg = "SUCC";
			} else {
				strErrorMsg = "FAIL";
			}

			nErrorCode = 0;

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

	@RequestMapping(value = "/fileupload.do")
	public void fileUpload(HttpServletRequest request, HttpServletResponse response)
			throws UnsupportedEncodingException, PlatformException {

		int seq = productDao.getMaxSeq();
		// int seq = Integer.parseInt(request.getParameter("seq"));

		String sHeader = request.getHeader("Content-Type");
		if (sHeader == null) {
			return;
		}
		request.setCharacterEncoding("utf-8");
		String sRealPath = request.getSession().getServletContext().getRealPath("/");
		String sPath = request.getParameter("PATH");
		String sUpPath = sRealPath + sPath;

		System.out.println(sUpPath);
		System.out.println("spath - " + sPath);

		int nMaxSize = 500 * 1024 * 1024;

		PlatformData resData = new PlatformData();
		VariableList resVarList = resData.getVariableList();

		String sMsg = " A ";
		try {
			MultipartRequest multi = new MultipartRequest(request, sUpPath, nMaxSize, "utf-8",
					new DefaultFileRenamePolicy());
			Enumeration files = multi.getFileNames();

			String sName = "";
			String savefilename = "";
			String orgfilename = "";
			int filesize = 0;
			File f = null;

			while (files.hasMoreElements()) {
				sName = (String) files.nextElement();
				savefilename = multi.getFilesystemName(sName);
				orgfilename = multi.getOriginalFileName(sName);
				f = multi.getFile(sName);

				if (f != null) {
					Long filesize_long = f.length();
					filesize = filesize_long.intValue();

					FileVO fileVO = new FileVO();

					fileVO.setSeq(seq);
					fileVO.setFilelocation(sUpPath + "\\" + savefilename);
					fileVO.setOrgfilename(orgfilename);
					fileVO.setSavefilename(savefilename);

					productDao.fileInsert(fileVO);
					
					System.out.println("path = " + sUpPath);
					System.out.println("orgfilename = " + orgfilename);
					System.out.println("savefilename = " + savefilename);

				}

			}

			resVarList.add("ErrorCode", 200);
			resVarList.add("ErrorMsg", "fileUpload");
		} catch (Exception e) {
			resVarList.add("ErrorCode", 500);
			resVarList.add("ErrorMsg", sMsg + " " + e);
			e.printStackTrace();
		}

		HttpPlatformResponse res = new HttpPlatformResponse(response);
		res.setData(resData);
		res.sendData();

	}

	@RequestMapping(value = "/update.do")
	public void update(HttpServletRequest request, HttpServletResponse response)
			throws UnsupportedEncodingException, PlatformException {

		PlatformData pdata = new PlatformData();

		int nErrorCode = 0;
		String strErrorMsg = "START";

		try {
			// receive client request
			// not need to receive

			// create HttpPlatformRequest for receive data from client
			HttpPlatformRequest req = new HttpPlatformRequest(request);

			req.receiveData();
			pdata = req.getData();

			// DataSet ds = pdata.getDataSet("bbsDataSet");

			// DAO
			ProductVO productVO = new ProductVO();

			productDao.updateOk(productVO);

			// set the ErrorCode and ErrorMsg about success
			nErrorCode = 0;
			strErrorMsg = "SUCC";

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

	@RequestMapping(value = "/filedelete.do")
	public void fileDelete(HttpServletRequest request, HttpServletResponse response)
			throws UnsupportedEncodingException, PlatformException {
		System.out.println("filedelete.do");

		int seq = Integer.valueOf(request.getParameter("seq"));
		PlatformData pdata = new PlatformData();

		int nErrorCode = 0;
		String strErrorMsg = "START";

		try {
			HttpPlatformRequest req = new HttpPlatformRequest(request);

			req.receiveData();
			pdata = req.getData();
			DataSet delds = pdata.getDataSet("delfileDataSet");
			System.out.println(delds.getRowCount());

			if (delds.getRowCount() != 0) {
				for (int i = 0; i < delds.getRowCount(); i++) {
					FileVO filevo = new FileVO();

					String savepath = delds.getString(i, "filelocation");
					String savefilename = delds.getString(i, "savefilename");

					System.out.println(delds.getString(i, "savefilename"));
					System.out.println(delds.getString(i, "filelocation"));
					System.out.println("seq = " + seq);
					filevo.setSeq(seq);
					filevo.setSavefilename(savefilename);

					productDao.fileDelete(filevo);
					File file = new File(savepath);

					if (file.exists()) {
						file.delete();
					}
				}
			}

			nErrorCode = 0;

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
