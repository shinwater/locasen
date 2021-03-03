package com.dgrm.domain;

import java.util.Date;

enum yn {
	Y,N
}
enum alarm_imp {
	알람중요도, ggg, aaa, bbb
}

/* enum type { 01, 02, 03 } */


public class SensorVO {

	private String loca_cd;						// 위치코드
	private String loca_nm;						// 위치명
	private String loca_addr;					// 위치 경로
	private String sensor_cd;					// 센서코드
	private String sensor_nm;					// 센서명
	private String sensor_type;					// 센서유형
	private String sensor_onoff;				// 센서온오프
	private String fnl_mdfc_dtm;					// 수정일시
	private String sensor_coord;				// 센서좌표
	private String sensor_act_yn;				// ���� ���� ����
	private String alarm_imptance;				// 알람 중요도
	private String alarm_yn;					// 알람 여부 
	
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
	public String getSensor_cd() {
		return sensor_cd;
	}
	public void setSensor_cd(String sensor_cd) {
		this.sensor_cd = sensor_cd;
	}
	public String getSensor_nm() {
		return sensor_nm;
	}
	public void setSensor_nm(String sensor_nm) {
		this.sensor_nm = sensor_nm;
	}
	public String getSensor_type() {
		return sensor_type;
	}
	public void setSensor_type(String sensor_type) {
		this.sensor_type = sensor_type;
	}
	public String getFnl_mdfc_dtm() {
		return fnl_mdfc_dtm;
	}
	public void setFnl_mdfc_dtm(String fnl_mdfc_dtm) {
		this.fnl_mdfc_dtm = fnl_mdfc_dtm;
	}
	public String getSensor_coord() {
		return sensor_coord;
	}
	public void setSensor_coord(String sensor_coord) {
		this.sensor_coord = sensor_coord;
	}
	public String getSensor_act_yn() {
		return sensor_act_yn;
	}
	public void setSensor_act_yn(String sensor_act_yn) {
		this.sensor_act_yn = sensor_act_yn;
	}
	public String getAlarm_imptance() {
		return alarm_imptance;
	}
	public void setAlarm_imptance(String alarm_imptance) {
		this.alarm_imptance = alarm_imptance;
	}
	public String getAlarm_yn() {
		return alarm_yn;
	}
	public void setAlarm_yn(String alarm_yn) {
		this.alarm_yn = alarm_yn;
	}
	public String getLoca_addr() {
		return loca_addr;
	}
	public void setLoca_addr(String loca_addr) {
		this.loca_addr = loca_addr;
	}
	public String getSensor_onoff() {
		return sensor_onoff;
	}
	public void setSensor_onoff(String sensor_onoff) {
		this.sensor_onoff = sensor_onoff;
	}
	
}	
