package com.ensah.web.models;

public class StudentsListModel {
	
	private String fname;
	
	private String lname;
	
	private String cin;
	
	private String cne;
	
	private String tele;
	
	private String email;
	
	private String photo;

	private String nomArabe;
	
	private String prenomArabe;
	
	private Long idEtd;

	public String getFname() {
		return fname;
	}

	public void setFname(String fname) {
		this.fname = fname;
	}

	public String getLname() {
		return lname;
	}

	public void setLname(String lname) {
		this.lname = lname;
	}

	public String getCin() {
		return cin;
	}

	public void setCin(String cin) {
		this.cin = cin;
	}

	public String getTele() {
		return tele;
	}

	public void setTele(String tele) {
		this.tele = tele;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public String getNomArab() {
		return nomArabe;
	}

	public void setNomArab(String nomArab) {
		this.nomArabe = nomArab;
	}

	public String getPrenomArab() {
		return prenomArabe;
	}

	public void setPrenomArab(String prenomArab) {
		this.prenomArabe = prenomArab;
	}

	public String getCne() {
		return cne;
	}

	public void setCne(String cne) {
		this.cne = cne;
	}
	
	
	
	public Long getIdEtd() {
		return idEtd;
	}

	public void setIdEtd(Long idEtd) {
		this.idEtd = idEtd;
	}

	@Override
	public String toString() {
		return "StudentsListModel [fname=" + fname + ", lname=" + lname + ", cin=" + cin + ", cne=" + cne + ", tele="
				+ tele + ", email=" + email + ", photo=" + photo + ", nomArabe=" + nomArabe + ", prenomArabe="
				+ prenomArabe + ", idEtd=" + idEtd + "]";
	}

	
	
}
