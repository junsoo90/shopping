package com.custom.VO;

public class FileVO {

	private int seq; // ���Ϲ�ȣ 
	private int filecnt; // ���ϰ���
	private String orgfilename; // ���������̸�
	private String filelocation; // ���� ��ġ
	private String savefilename; // ����� ���� �̸�
	
	public int getFilecnt() {
		return filecnt;
	}
	public void setFilecnt(int filecnt) {
		this.filecnt = filecnt;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
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
	public void setSavefilename(String savafilename) {
		this.savefilename = savafilename;
	}
	
	
}
