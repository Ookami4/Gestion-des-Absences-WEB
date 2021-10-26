package com.ensah.web.models;

public class AccountGestionModel {

	private Long idCompte;
	
	private boolean AccountNonExpired;
	
	private boolean AccountNonLocked;
	
	private boolean credentialsNonExpired;
	
	private boolean enabled; 
	
	private String nomRole;
	
	public String getNomRole() {
		return nomRole;
	}

	public void setNomRole(String nomRole) {
		this.nomRole = nomRole;
	}

	private String login;
	
	private String password;
	
	private String email;

	@Override
	public String toString() {
		return "AccountGestionModel [idCompte=" + idCompte + ", AccountNonExpired=" + AccountNonExpired
				+ ", AccountNonLocked=" + AccountNonLocked + ", credentialsNonExpired=" + credentialsNonExpired
				+ ", enabled=" + enabled + ", login=" + login + ", password=" + password + ", email=" + email + "]";
	}

	public Long getIdCompte() {
		return idCompte;
	}

	public void setIdCompte(Long idCompte) {
		this.idCompte = idCompte;
	}

	public boolean isAccountNonExpired() {
		return AccountNonExpired;
	}

	public void setAccountNonExpired(boolean accountNonExpired) {
		AccountNonExpired = accountNonExpired;
	}

	public boolean isAccountNonLocked() {
		return AccountNonLocked;
	}

	public void setAccountNonLocked(boolean accountNonLocked) {
		AccountNonLocked = accountNonLocked;
	}

	public boolean isCredentialsNonExpired() {
		return credentialsNonExpired;
	}

	public void setCredentialsNonExpired(boolean credentialsNonExpired) {
		this.credentialsNonExpired = credentialsNonExpired;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public String getLogin() {
		return login;
	}

	public void setLogin(String login) {
		this.login = login;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
	
	
}
