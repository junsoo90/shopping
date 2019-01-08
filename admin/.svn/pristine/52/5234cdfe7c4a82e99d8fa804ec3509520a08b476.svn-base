package com.admin.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

import com.admin.VO.FileVO;
import com.admin.VO.OptionVO;
import com.admin.VO.ProductVO;



@Component
public class ProductDaoImpl extends CommonDao  implements ProductDao {

	
	@Override
	public List<ProductVO> list() {
		return getSqlSession().selectList("productList");
	}

	public int getCount(Map<String, Object> map) {
		return ((Integer) getSqlSession().selectOne("boardCount", map)).intValue();
	}
	public int getfileCount(Map<String, Object> map) {
		return ((Integer) getSqlSession().selectOne("boardfileCount", map)).intValue();
	}
	
	public String insert(ProductVO vo){
		int n = getSqlSession().insert("productInsert",vo);
		if(n > 0)
			return String.valueOf(vo.getpSeq());
		else
			return "";
	}
	public String optionInsert(OptionVO vo){
		int n = getSqlSession().insert("optionInsert",vo);
		if(n > 0)
			return String.valueOf(vo.getpSeq());
		else
			return "";
	}
	
	public ProductVO getInfo(int pSeq){
		return getSqlSession().selectOne("getInfo",pSeq);
	}
	
	public int addHit(int seq){
		return getSqlSession().update("addHit",seq);
	}
	
	public int delete(int seq){
		return getSqlSession().delete("boardDelete",seq);
	}
	
	public int fileDelete(FileVO filevo) {
		return getSqlSession().delete("fileDelete",filevo);
	}
	
	public int getMaxSeq(){
		System.out.println(getSqlSession().selectOne("getMaxSeq"));
		return getSqlSession().selectOne("getMaxSeq");
	}
	
	public int fileInsert(FileVO fileVO) {
		System.out.println(fileVO.getFilelocation());
		return getSqlSession().insert("fileInsert", fileVO);
	}
	
	public int updateFilename(ProductVO vo){
		return getSqlSession().update("updateFilename",vo);
	}
	
	public int updateOk(ProductVO vo){
		return getSqlSession().update("updateOk",vo);
	}
	
	public int stepUp(ProductVO vo){
		return getSqlSession().update("stepUp",vo);
	}
	
	public List<ProductVO> getBoard(){	
		return getSqlSession().selectList("getBoard");
	}
	
	public List<FileVO> filegetInfo(int seq){	
		return getSqlSession().selectList("filegetInfo", seq);
	}
	
	public List<OptionVO> getOptionInfo(int pSeq){
		return getSqlSession().selectList("optionInfo", pSeq);
	}
}
