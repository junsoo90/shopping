package com.custom.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

import com.custom.VO.FileVO;
import com.custom.VO.OptionVO;
import com.custom.VO.PhotoVO;
import com.custom.VO.ProductVO;



@Component
public class ProductDaoImpl extends CommonDao  implements ProductDao {

	
	@Override
	public List<ProductVO> productlist() {
		return getSqlSession().selectList("productList");
	}

	public int getCount(Map<String, Object> map) {
		return ((Integer) getSqlSession().selectOne("productCount")).intValue();
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
	
	public List<OptionVO> getOptionInfo(int pSeq) {
		return getSqlSession().selectList("optionInfo",pSeq);
	}
	
	public int addHit(int pSeq){
		return getSqlSession().update("addHit",pSeq);
	}
	
	public int delete(int pSeq){
		return getSqlSession().delete("boardDelete",pSeq);
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
	
	public List<PhotoVO> photoGetInfo(int pSeq){	
		return getSqlSession().selectList("photogetInfo", pSeq);
	}
	
}
