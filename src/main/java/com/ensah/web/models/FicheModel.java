package com.ensah.web.models;

public class FicheModel {
	
	private String year;
	
	private Integer NJ;
	
	private Integer J;
	
	private Integer A;
	
	private Object helper;

	public Object getHelper() {
		return helper;
	}

	public void setHelper(Object helper) {
		this.helper = helper;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public Integer getNJ() {
		return NJ;
	}

	public void setNJ(Integer nJ) {
		NJ = nJ;
	}

	public Integer getJ() {
		return J;
	}

	public void setJ(Integer j) {
		J = j;
	}

	public Integer getA() {
		return A;
	}

	public void setA(Integer a) {
		A = a;
	}

	@Override
	public String toString() {
		return "FicheModel [year=" + year + ", NJ=" + NJ + ", J=" + J + ", A=" + A + ", helper=" + helper + "]";
	}
	
	
}
