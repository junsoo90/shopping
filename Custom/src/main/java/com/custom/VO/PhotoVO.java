package com.custom.VO;

public class PhotoVO {
	private int filecnt; // ���ϰ���
	private String orgfilename; // ���������̸�
	private String filelocation; // ���� ��ġ
	private String savefilename; // ����� ���� �̸�
	
	
	private int pSeq; // ���Ϲ�ȣ 
	
	
	public int getpSeq() {
		return pSeq;
	}
	public void setpSeq(int pSeq) {
		this.pSeq = pSeq;
	}
	public int getFilecnt() {
		return filecnt;
	}
	public void setFilecnt(int filecnt) {
		this.filecnt = filecnt;
	}
	public String getOrgfilename() {
		return orgfilename;
	}
	public void setOrgfilename(String orgfilename) {
		this.orgfilename = orgfilename;
	}
	public String getFilelocation() {
		return filelocation;
	}
	public void setFilelocation(String filelocation) {
		this.filelocation = filelocation;
	}
	public String getSavefilename() {
		return savefilename;
	}
	public void setSavefilename(String savefilename) {
		this.savefilename = savefilename;
	}
	
}
