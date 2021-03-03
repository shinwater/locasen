package com.dgrm.domain;

import java.util.Calendar;
import java.util.Date;


public class LocaVO {

	private String loca_cd;					// 위치 코드
	private String loca_nm;					// 위치명
	private String up_loca_cd;				// 상위 위치 코드
	private String up_loca_nm;				// 상위 위치명
	private String loca_lvl;				// 레벨
	private String loca_sort;				// 정렬 순서
	private String use_yn;					// 사용 여부
	private Calendar fnl_mdfc_dtm;			// 최종 수정일자
	
	private String sensor_cnt;				// 위치에 따른 샌서 개수
	
	
	public String getSensor_cnt() {
		return sensor_cnt;
	}
	public void setSensor_cnt(String sensor_cnt) {
		this.sensor_cnt = sensor_cnt;
	}
	
	
	public String getLoca_cd() {
		return loca_cd;
	}
	public void setLoca_cd(String loca_cd) {
		this.loca_cd = loca_cd;
	}
	public String getLoca_nm() {
		return loca_nm;
	}
	public void setLoca_nm(String loca_nm) {
		this.loca_nm = loca_nm;
	}
	public String getUp_loca_cd() {
		return up_loca_cd;
	}
	public void setUp_loca_cd(String up_loca_cd) {
		this.up_loca_cd = up_loca_cd;
	}
	public String getUp_loca_nm() {
		return up_loca_nm;
	}
	public void setUp_loca_nm(String up_loca_nm) {
		this.up_loca_nm = up_loca_nm;
	}
	public String getLoca_lvl() {
		return loca_lvl;
	}
	public void setLoca_lvl(String loca_lvl) {
		this.loca_lvl = loca_lvl;
	}
	public String getLoca_sort() {
		return loca_sort;
	}
	public void setLoca_sort(String loca_sort) {
		this.loca_sort = loca_sort;
	}
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	public Calendar getFnl_mdfc_dtm() {
		return fnl_mdfc_dtm;
	}
	public void setFnl_mdfc_dtm(Calendar fnl_mdfc_dtm) {
		this.fnl_mdfc_dtm = fnl_mdfc_dtm;
	}
}
