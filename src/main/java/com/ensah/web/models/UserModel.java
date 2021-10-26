package com.ensah.web.models;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;

public class UserModel {

	public static final int TYPE_PROF = 1;
	public static final int TYPE_STUDENT = 2;
	public static final int TYPE_CADRE_ADMIN = 3;


	
	private Long idUtilisateur;

	@NotBlank(message = "Le nom est requis")
	private String nom;

	@NotBlank(message = "Le prenom est requis")
	private String prenom;
	
	@NotBlank(message = "L'ID nationale est requis")
	@Pattern(regexp = "^[A-Z]{2}[0-9]{8}", message= "L'ID national doit être composé de 2 lettres majuscules suivies de 8 chiffres")
	private String cin;
	
	@Pattern(regexp = "^[A-Z]{1}[0-9]{9}", message= "L'ID d'étudiant doit être composé d'une lettre suivies de 9 chiffres")
	private String cne;
	
	@Email(message = "l'email doit être valid")
	@NotBlank(message="L'email est requis")
	private String email;

    @NotBlank(message = "Le numero de telephone est requis")
    @Pattern(regexp = "^[0-9]{9}", message = "Le numero de telephone doit être composé de 9 chiffres")
	private String telephone;

	@NotBlank(message = "Le nom arabe est requis")
	private String nomArabe;

	@NotBlank(message = "Le prenom arabe est requis")
	private String prenomArabe;

	private String photo;

	private String specialite;

	private String grade;

	private int typePerson;
	
	
	public UserModel() {
		
	}

	public UserModel(int typePerson) {
		this.typePerson = typePerson;
	}



	public Long getIdUtilisateur() {
		return idUtilisateur;
	}

	public void setIdUtilisateur(Long idUtilisateur) {
		this.idUtilisateur = idUtilisateur;
	}

	public String getNom() {
		return nom;
	}

	public void setNom(String nom) {
		this.nom = nom;
	}

	public String getPrenom() {
		return prenom;
	}

	public void setPrenom(String prenom) {
		this.prenom = prenom;
	}

	public String getCin() {
		return cin;
	}

	public void setCin(String cin) {
		this.cin = cin;
	}

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

	public String getNomArabe() {
		return nomArabe;
	}

	public void setNomArabe(String nomArabe) {
		this.nomArabe = nomArabe;
	}

	public String getPrenomArabe() {
		return prenomArabe;
	}

	public void setPrenomArabe(String prenomArabe) {
		this.prenomArabe = prenomArabe;
	}

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public String getSpecialite() {
		return specialite;
	}

	public void setSpecialite(String specialite) {
		this.specialite = specialite;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public int getTypePerson() {
		return typePerson;
	}

	public void setTypePerson(int typePerson) {
		this.typePerson = typePerson;
	}

	public static int getTypeProf() {
		return TYPE_PROF;
	}

	public static int getTypeStudent() {
		return TYPE_STUDENT;
	}

	public static int getTypeCadreAdmin() {
		return TYPE_CADRE_ADMIN;
	}

	public String getCne() {
		return cne;
	}

	public void setCne(String cne) {
		this.cne = cne;
	}

	@Override
	public String toString() {
		return "PersonModel [idPerson=" + idUtilisateur + ", nom=" + nom + ", prenom=" + prenom + ", cin=" + cin + ", cne="
				+ cne + ", email=" + email + ", telephone=" + telephone + ", nomArabe=" + nomArabe + ", prenomArabe="
				+ prenomArabe + ", photo=" + photo + ", specialite=" + specialite + ", grade=" + grade + ", typePerson="
				+ typePerson + "]";
	}

}
