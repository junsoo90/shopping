package com.custom.VO;

public class CustomVO {

	private String cId;
	private String cPass;
	private String cName;
	private String cAdd;
	private String cAddCode;
	private String cAddDetail;
	private String cPhone1;
	private String cPhone2;
	private String cPhone3;
	private int cSeq;
	private String loginSession;
	
	public CustomVO() {}
	
	public CustomVO(String cId, String loginSession) {
		super();
		this.cId = cId;
		this.loginSession = loginSession;
	}

	public CustomVO(String cId, String cName, String cPhone1, String cPhone2, String cPhone3) {
		super();
		this.cId = cId;
		this.cName = cName;
		this.cPhone1 = cPhone1;
		this.cPhone2 = cPhone2;
		this.cPhone3 = cPhone3;
	}

	public CustomVO(String cName, String cPhone1, String cPhone2, String cPhone3) {
		super();
		this.cName = cName;
		this.cPhone1 = cPhone1;
		this.cPhone2 = cPhone2;
		this.cPhone3 = cPhone3;
	}

	public CustomVO(String cId, String cPass, String cName, String cAdd, String cAddCode, String cAddDetail,
			String cPhone1, String cPhone2, String cPhone3) {
		this.cId = cId;
		this.cPass = cPass;
		this.cName = cName;
		this.cAdd = cAdd;
		this.cAddCode = cAddCode;
		this.cAddDetail = cAddDetail;
		this.cPhone1 = cPhone1;
		this.cPhone2 = cPhone2;
		this.cPhone3 = cPhone3;
	}

	
	public String getLoginSession() {
		return loginSession;
	}

	public void setLoginSession(String loginSession) {
		this.loginSession = loginSession;
	}

	public int getcSeq() {
		return cSeq;
	}

	public void setcSeq(int cSeq) {
		this.cSeq = cSeq;
	}

	public String getcAddCode() {
		return cAddCode;
	}
	public void setcAddCode(String cAddCode) {
		this.cAddCode = cAddCode;
	}
	public String getcAddDetail() {
		return cAddDetail;
	}
	public void setcAddDetail(String cAddDetail) {
		this.cAddDetail = cAddDetail;
	}
	public String getcPhone1() {
		return cPhone1;
	}
	public void setcPhone1(String cPhone1) {
		this.cPhone1 = cPhone1;
	}
	public String getcPhone2() {
		return cPhone2;
	}
	public void setcPhone2(String cPhone2) {
		this.cPhone2 = cPhone2;
	}
	public String getcPhone3() {
		return cPhone3;
	}
	public void setcPhone3(String cPhone3) {
		this.cPhone3 = cPhone3;
	}
	public String getcId() {
		return cId;
	}
	public void setcId(String cId) {
		this.cId = cId;
	}
	public String getcPass() {
		return cPass;
	}
	public void setcPass(String cPass) {
		this.cPass = cPass;
	}
	public String getcName() {
		return cName;
	}
	public void setcName(String cName) {
		this.cName = cName;
	}

	public String getcAdd() {
		return cAdd;
	}
	public void setcAdd(String cAdd) {
		this.cAdd = cAdd;
	}
	
}
