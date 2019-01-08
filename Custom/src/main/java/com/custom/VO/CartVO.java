package com.custom.VO;

public class CartVO {

	private int cartCnt;
	private String userId;
	private int pSeq;
	private String pName;
	private String filelocation;
	private String pOption;
	private int optionPrice;
	private String cartState;
	private int cnt;
	
	public CartVO() {}
	public CartVO(int cartCnt, String userId,int pSeq, String pName, 
			String filelocation, String pOption, int optionPrice, int cnt,
			String cartState) {
		super();
		this.cartCnt = cartCnt;
		this.userId = userId;
		this.pSeq = pSeq;
		this.pName = pName;
		this.filelocation = filelocation;
		this.pOption = pOption;
		this.optionPrice = optionPrice;
		this.cnt = cnt;
		this.cartState = cartState;
	}
	
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public int getCartCnt() {
		return cartCnt;
	}
	public void setCartCnt(int cartCnt) {
		this.cartCnt = cartCnt;
	}
	public int getOptionPrice() {
		return optionPrice;
	}
	public void setOptionPrice(int optionPrice) {
		this.optionPrice = optionPrice;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public int getpSeq() {
		return pSeq;
	}
	public void setpSeq(int pSeq) {
		this.pSeq = pSeq;
	}
	public String getpName() {
		return pName;
	}
	public void setpName(String pName) {
		this.pName = pName;
	}
	public String getFilelocation() {
		return filelocation;
	}
	public void setFilelocation(String savefilename) {
		this.filelocation = savefilename;
	}
	public String getpOption() {
		return pOption;
	}
	public void setpOption(String pOption) {
		this.pOption = pOption;
	}
	public String getCartState() {
		return cartState;
	}
	public void setCartState(String cartState) {
		this.cartState = cartState;
	}
	
	
}
