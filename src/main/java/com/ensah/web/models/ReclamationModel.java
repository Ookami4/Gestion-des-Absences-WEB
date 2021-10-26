package com.ensah.web.models;

import javax.validation.constraints.NotBlank;

public class ReclamationModel {
	private Long idReclamation;
	
	@NotBlank(message="titre est requis")
	private String title;

	@NotBlank(message="Reclamation text est requis")
	private String text;
	
	private String reponse;
	
	private boolean answered;
	
	private String idInscription;
	
	@NotBlank(message="Absence est requis")
	private String idAbsence;
	
	private String labelAbsence;
	

	public String getLabelAbsence() {
		return labelAbsence;
	}

	public void setLabelAbsence(String labelAbsence) {
		this.labelAbsence = labelAbsence;
	}

	public Long getIdReclamation() {
		return idReclamation;
	}

	public void setIdReclamation(Long idReclamation) {
		this.idReclamation = idReclamation;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getReponse() {
		return reponse;
	}

	public void setReponse(String reponse) {
		this.reponse = reponse;
	}

	public boolean isAnswered() {
		return answered;
	}

	public void setAnswered(boolean answered) {
		this.answered = answered;
	}

	public String getIdInscription() {
		return idInscription;
	}

	public void setIdInscription(String idInscription) {
		this.idInscription = idInscription;
	}

	public String getIdAbsence() {
		return idAbsence;
	}

	public void setIdAbsence(String idAbsence) {
		this.idAbsence = idAbsence;
	}

	@Override
	public String toString() {
		return "ReclamationModel [idReclamation=" + idReclamation + ", title=" + title + ", text=" + text + ", reponse="
				+ reponse + ", answered=" + answered + ", idInscription=" + idInscription + ", idAbsence=" + idAbsence
				+ "]";
	}
	
	
}
