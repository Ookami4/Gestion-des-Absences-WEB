package com.ensah.web.models;

public class MessengerAccountModel {
	private Long idAcc;
	
	private String fullName;
	
	private String photo;

	public Long getIdAcc() {
		return idAcc;
	}

	public void setIdAcc(Long idAcc) {
		this.idAcc = idAcc;
	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	@Override
	public String toString() {
		return "MessengerAccountModel [idAcc=" + idAcc + ", fullName=" + fullName + ", photo=" + photo + "]";
	}
	
	

}
