package com.custom.dao;

import java.util.List;
import java.util.Map;

import com.custom.VO.FileVO;
import com.custom.VO.OptionVO;
import com.custom.VO.PhotoVO;
import com.custom.VO.ProductVO;


public interface ProductDao {

	public abstract List<ProductVO> productlist();

	public abstract int getCount(Map<String, Object> paramMap);
	
	public abstract String insert(ProductVO vo);
	
	public String optionInsert(OptionVO vo);
	
	public abstract ProductVO getInfo(int pSeq);
	
	public abstract List<OptionVO> getOptionInfo(int pSeq);
	
	public abstract int addHit(int pSeq);

	public abstract int delete(int pSeq);
	
	public abstract int getMaxSeq();
	
	public abstract int updateOk(ProductVO vo);
	
	public abstract int stepUp(ProductVO vo);
	
	public abstract List<ProductVO> getBoard();
	
	public abstract int fileInsert(FileVO fileVO);
	
	public abstract List<PhotoVO> photoGetInfo(int pSeq);

	public abstract int fileDelete(FileVO filevo);
	
	public int getfileCount(Map<String, Object> map);

	public abstract int updateFilename(ProductVO vo);
	
	
}
