package com.custom.VO;

public class OrderVO {

	private int purchaseSeq;
	private String pName;
	private String orderDate;
	private String cId;
	private int pSeq;
	private String pOption;
	private int optionCnt;
	private int optionPrice;
	
	private String savefilename;
	private String orderState;
	private String delRequestMsg;
	private String payName; 
	private String orderPay;
	private String cartCnt;
	
	private String orderStateCheck;
	
	private String bNo;

	private int refund;
	
	
	public int getRefund() {
		return refund;
	}

	public void setRefund(int refund) {
		this.refund = refund;
	}

	public String getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}

	public String getSavefilename() {
		return savefilename;
	}

	public void setSavefilename(String savefilename) {
		this.savefilename = savefilename;
	}

	public String getOrderStateCheck() {
		return orderStateCheck;
	}

	public void setOrderStateCheck(String orderStateCheck) {
		this.orderStateCheck = orderStateCheck;
	}

	public String getCartCnt() {
		return cartCnt;
	}

	public void setCartCnt(String cartCnt) {
		this.cartCnt = cartCnt;
	}

	public int getPurchaseSeq() {
		return purchaseSeq;
	}

	public void setPurchaseSeq(int purchaseSeq) {
		this.purchaseSeq = purchaseSeq;
	}

	public String getpName() {
		return pName;
	}

	public void setpName(String pName) {
		this.pName = pName;
	}


	public String getcId() {
		return cId;
	}

	public void setcId(String cId) {
		this.cId = cId;
	}

	public int getpSeq() {
		return pSeq;
	}

	public void setpSeq(int pSeq) {
		this.pSeq = pSeq;
	}

	public String getpOption() {
		return pOption;
	}

	public void setpOption(String pOption) {
		this.pOption = pOption;
	}

	public int getOptionCnt() {
		return optionCnt;
	}

	public void setOptionCnt(int optionCnt) {
		this.optionCnt = optionCnt;
	}

	public int getOptionPrice() {
		return optionPrice;
	}

	public void setOptionPrice(int optionPrice) {
		this.optionPrice = optionPrice;
	}

	public String getOrderState() {
		return orderState;
	}

	public void setOrderState(String orderState) {
		this.orderState = orderState;
	}

	public String getDelRequestMsg() {
		return delRequestMsg;
	}

	public void setDelRequestMsg(String delRequestMsg) {
		this.delRequestMsg = delRequestMsg;
	}

	public String getPayName() {
		return payName;
	}

	public void setPayName(String payName) {
		this.payName = payName;
	}

	public String getOrderPay() {
		return orderPay;
	}

	public void setOrderPay(String orderPay) {
		this.orderPay = orderPay;
	}

	public String getbNo() {
		return bNo;
	}

	public void setbNo(String bNo) {
		this.bNo = bNo;
	}

	
	
}
