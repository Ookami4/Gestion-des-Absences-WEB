package com.ensah.web.models;

import java.util.Date;
import java.util.Set;

import com.ensah.core.bo.Enseignant;
import com.ensah.core.bo.Matiere;
import com.ensah.core.bo.PieceJustificative;

public class AbsenceModel {
	
	private Long idAbsence;

	private Date dateHeureDebutAbsence;

	private Date dateHeureFinAbsence;

	private int etat;

	private String typeSaisie;
	
	private Matiere matiere;

	private Set<PieceJustificative> pieceJustificative;

	private Enseignant observateur;
	
	private String nomMatier;
	
	private String nomObservateur;
	
	private String pathJustification;

	public Long getIdAbsence() {
		return idAbsence;
	}

	public void setIdAbsence(Long idAbsence) {
		this.idAbsence = idAbsence;
	}

	public Date getDateHeureDebutAbsence() {
		return dateHeureDebutAbsence;
	}

	public void setDateHeureDebutAbsence(Date dateHeureDebutAbsence) {
		this.dateHeureDebutAbsence = dateHeureDebutAbsence;
	}

	public Date getDateHeureFinAbsence() {
		return dateHeureFinAbsence;
	}

	public void setDateHeureFinAbsence(Date dateHeureFinAbsence) {
		this.dateHeureFinAbsence = dateHeureFinAbsence;
	}

	public int getEtat() {
		return etat;
	}

	public void setEtat(int etat) {
		this.etat = etat;
	}

	public String getTypeSaisie() {
		return typeSaisie;
	}

	public void setTypeSaisie(String typeSaisie) {
		this.typeSaisie = typeSaisie;
	}

	public Matiere getMatiere() {
		return matiere;
	}

	public void setMatiere(Matiere matiere) {
		this.matiere = matiere;
	}

	public Set<PieceJustificative> getPieceJustificative() {
		return pieceJustificative;
	}

	public void setPieceJustificative(Set<PieceJustificative> pieceJustificative) {
		this.pieceJustificative = pieceJustificative;
	}

	public Enseignant getObservateur() {
		return observateur;
	}

	public void setObservateur(Enseignant observateur) {
		this.observateur = observateur;
	}

	
	
	
	public String getNomMatier() {
		return nomMatier;
	}

	public void setNomMatier(String nomMatier) {
		this.nomMatier = nomMatier;
	}

	public String getNomObservateur() {
		return nomObservateur;
	}

	public void setNomObservateur(String nomObservateur) {
		this.nomObservateur = nomObservateur;
	}

	public String getPathJustification() {
		return pathJustification;
	}

	public void setPathJustification(String pathJustification) {
		this.pathJustification = pathJustification;
	}

	@Override
	public String toString() {
		return "AbsenceModel [idAbsence=" + idAbsence + ", dateHeureDebutAbsence=" + dateHeureDebutAbsence
				+ ", dateHeureFinAbsence=" + dateHeureFinAbsence + ", etat=" + etat + ", typeSaisie=" + typeSaisie
				+ ", matiere=" + matiere + ", pieceJustificative=" + pieceJustificative + ", observateur=" + observateur
				+ "]";
	}
	
	
}
