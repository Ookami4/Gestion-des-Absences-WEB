package com.ensah.web.models;

import java.util.Arrays;
import java.util.Date;
import java.util.HashSet;
import java.util.List;

import javax.persistence.ElementCollection;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;

import com.ensah.core.bo.Absence;

public class JustificationModel {
	
	private Long idPieceJustificative;
	
	private String cheminFichier;

	@NotBlank(message = "L'intitule est requis")
	private String intitule;

	private Date dateLivraison;

	private int etat;

	private String source;

	@NotBlank(message = "Absences sont requis")
	private String arrayAbsenceString;
	
	private Long[] absences;
	
	public Long[] getAbsences() {
		return absences;
	}

	public void setAbsences(Long[] absences) {
		this.absences = absences;
	}

	public Long getIdPieceJustificative() {
		return idPieceJustificative;
	}

	public void setIdPieceJustificative(Long idPieceJustificative) {
		this.idPieceJustificative = idPieceJustificative;
	}

	public String getCheminFichier() {
		return cheminFichier;
	}

	public void setCheminFichier(String cheminFichier) {
		this.cheminFichier = cheminFichier;
	}

	public String getIntitule() {
		return intitule;
	}

	public void setIntitule(String intitule) {
		this.intitule = intitule;
	}

	public Date getDateLivraison() {
		return dateLivraison;
	}

	public void setDateLivraison(Date dateLivraison) {
		this.dateLivraison = dateLivraison;
	}

	public int getEtat() {
		return etat;
	}

	public void setEtat(int etat) {
		this.etat = etat;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}
	
	public static Date getDateNow()
	{
		long millis=System.currentTimeMillis();  
		java.util.Date date=new java.util.Date(millis); 
		return date;
	}

	@Override
	public String toString() {
		return "JustificationModel [idPieceJustificative=" + idPieceJustificative + ", cheminFichier=" + cheminFichier
				+ ", intitule=" + intitule + ", dateLivraison=" + dateLivraison + ", etat=" + etat + ", source="
				+ source + ", arrayAbsenceString=" + arrayAbsenceString + ", absences=" + Arrays.toString(absences)
				+ "]";
	}

	public String getArrayAbsenceString() {
		return arrayAbsenceString;
	}

	public void setArrayAbsenceString(String arrayAbsenceString) {
		this.arrayAbsenceString = arrayAbsenceString;
	}

	
	public void getAbsenceByAbsences(List<Absence> list)
	{
		int size = list.size();
		if(size==0)
		{
			this.absences=null;
			return;
		}
		if(this.absences==null)
			this.absences = new Long[size];
		for(int j=0;j<size;j++)
		{
			this.absences[j]=list.get(j).getIdAbsence();
		}
	}
	
}
