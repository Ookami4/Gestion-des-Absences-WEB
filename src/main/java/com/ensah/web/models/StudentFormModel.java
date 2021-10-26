package com.ensah.web.models;

import java.util.Date;

public class StudentFormModel {
	
	private String fullname;
	
	private Long idInsc;
	
	public String getFullname() {
		return fullname;
	}
	public void setFullname(String fullname) {
		this.fullname = fullname;
	}
	public Long getIdInsc() {
		return idInsc;
	}
	public void setIdInsc(Long idInsc) {
		this.idInsc = idInsc;
	}
	@Override
	public String toString() {
		return "StudentFormModel [fullname=" + fullname + ", idInsc=" + idInsc + "]";
	}
	
	
}
