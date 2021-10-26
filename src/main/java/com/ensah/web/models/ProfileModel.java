package com.ensah.web.models;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;

public class ProfileModel {
	
	@NotBlank(message="Email est requis")
	@Email(message="Email est invalide")
	private String email;
	
	@NotBlank(message="Telephone est requis")
	@Pattern(regexp = "^[6|7][0-9]{8}", message = "Telephone est invalide")
	private String telephone;
	
	@NotBlank(message="Photo est requis")
	private String photo;

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	@Override
	public String toString() {
		return "ProfileModel [email=" + email + ", telephone=" + telephone + ", photo=" + photo + "]";
	}

	public ProfileModel(@NotBlank(message = "Email est requis") @Email(message = "Email est invalide") String email,
			@NotBlank(message = "Telephone est requis") @Pattern(regexp = "^[6|7][0-9]{8}", message = "Telephone est invalide") String telephone,
			@NotBlank(message = "Photo est requis") String photo) {
		this.email = email;
		this.telephone = telephone;
		this.photo = photo;
	}
	
	
}
