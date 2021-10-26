package com.ensah.web.controllers;

import java.util.ArrayList;
import java.util.List;

import javax.validation.Valid;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.ui.Model;
import org.springframework.util.Base64Utils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ensah.core.bo.Absence;
import com.ensah.core.bo.Enseignant;
import com.ensah.core.bo.Etudiant;
import com.ensah.core.bo.Inscription;
import com.ensah.core.bo.Matiere;
import com.ensah.core.bo.Module;
import com.ensah.core.bo.TypeSeance;
import com.ensah.core.services.IAbsenceService;
import com.ensah.core.services.IEnseignantService;
import com.ensah.core.services.IEtudiantService;
import com.ensah.core.services.IFormAbsService;
import com.ensah.core.services.IMatiereService;
import com.ensah.core.services.IModuleService;
import com.ensah.core.services.ISessionService;
import com.ensah.core.services.ITypeSeanceService;
import com.ensah.web.models.AbsenceModel;
import com.ensah.web.models.StudentsListModel;

@RestController
@RequestMapping(value="/api/absence/CadreAdmin")
public class CaAbsenceRestController {
	
	protected final Logger TRACER = Logger.getLogger(getClass());
	
	@Autowired
	IAbsenceService absService;
	
	@Autowired 
	IFormAbsService formService;
	
	@Autowired
	ISessionService SessionService;
	
	@Autowired
	IEtudiantService EtdService;
	
	@Autowired
	IEnseignantService EnsgService;
	
	@Autowired
	IMatiereService MatService;
	
	@Autowired
	ITypeSeanceService TSService;
	
	@Autowired
	IModuleService ModService;
	
	//retourner la liste de tous les �tudiants
	
	@GetMapping(value = "/getAllStudents", consumes = {MediaType.ALL_VALUE}, produces = "application/json")
	public List<StudentsListModel> getAllStudents() throws Exception
	{
		List<StudentsListModel> res = new ArrayList<StudentsListModel>();
		List<Etudiant> list = EtdService.getAllEtudiants();
		if(list==null) return res;
		for(Etudiant c : list)
		{
			StudentsListModel stdModel = new StudentsListModel();
			stdModel.setFname(c.getPrenom());
			stdModel.setLname(c.getNom());
			stdModel.setNomArab(c.getNomArabe());
			stdModel.setPrenomArab(c.getPrenomArabe());
			String photo = "";
			if(c.getPhoto()!=null) {
				photo = new String(Base64Utils.decode(c.getPhoto()));
			}
			stdModel.setPhoto(photo);
			stdModel.setCne(c.getCne());
			stdModel.setEmail(c.getEmail());
			stdModel.setTele(c.getTelephone());
			stdModel.setIdEtd(c.getIdUtilisateur());		
			res.add(stdModel);
		}
		return res;
	}
	
	//retourner tous les absents d'un �tudiant selectionn�
	
	@GetMapping(value = "/getAllStudentAbsences/{id}", consumes = {MediaType.ALL_VALUE }, produces = "application/json")
	public List<AbsenceModel> getAbsences(@PathVariable("id") Long id) {
		
		Etudiant etd = EtdService.getEtudiantById(id);
		List<Inscription> list = etd.getInscriptions();
		List<Absence> absList = new ArrayList<Absence>();
		List<AbsenceModel> res = new ArrayList<AbsenceModel>();
		if(list == null) return res;
		for(Inscription ins : list) {
			absList = ins.getAbsences();
			if(absList == null)
				return res;
			for(Absence a : absList) {
				AbsenceModel absModel = new AbsenceModel();
				absModel.setIdAbsence(a.getIdAbsence());
				absModel.setDateHeureDebutAbsence(a.getDateHeureDebutAbsence());
				absModel.setDateHeureFinAbsence(a.getDateHeureFinAbsence());
				absModel.setEtat(a.getEtat());
				absModel.setTypeSaisie(a.getTypeSaisie());
				absModel.setNomMatier(a.getMatiere().getNom());
				absModel.setNomObservateur(a.getObservateur().getNom()+a.getObservateur().getPrenom());
				//absModel.setPathJustification(a.getPieceJustificative().getCheminFichier());
				res.add(absModel);
			}
		}
		
		return res;
	}
	
	@GetMapping(value = "/deleteAbsence/{id}", consumes = {MediaType.ALL_VALUE }, produces = "application/json")
	public boolean deleteAbsence(@PathVariable Long id){
		Absence abs = absService.findAbsenceById(id);
		if(abs.getIdAbsence() == null) return false;
		try {
			System.out.println("id" + id);
			absService.deleteAbsence(abs.getIdAbsence());
			return true;
		}catch(Exception e) {
			return false;
		}
	}
	
	// methodes a utilis�s dans createAbsence
	
	@GetMapping(value = "/getAllTypeSeances", consumes = { MediaType.ALL_VALUE }, produces="application/json")
	public List<TypeSeance> getAllTypeSeances(){
		List<TypeSeance> typeSeances = TSService.getAllTypeSeance();
		return typeSeances;
	}
	
	@GetMapping(value = "/getAllMatieres", consumes = { MediaType.ALL_VALUE }, produces="application/json")
	public List<Matiere> getAllMatieres(){
		List<Matiere> matieres = MatService.getAllMatieres();
		return matieres;
	}
	
	@GetMapping(value = "/getAllModules", consumes = { MediaType.ALL_VALUE }, produces="application/json")
	public List<Module> getAllModules(){
		List<Module> modules = ModService.getAllModules();
		return modules;
	}
	
	@GetMapping(value = "/getAllEnseignants", consumes = { MediaType.ALL_VALUE }, produces="application/json")
	public List<Enseignant> getAllEnseignants(){
		List<Enseignant> enseignants = EnsgService.getAllEnseignants();
		return enseignants;
	}
	

	
	
	@GetMapping(value = "/valideAbsence/{id}", consumes = { MediaType.ALL_VALUE }, produces="application/json")
	public Boolean valideAbsence(@PathVariable Long id) throws Exception{
		if(!absService.absenceExist(id)) return false;
		Absence abs = absService.findAbsenceById(id);
		abs.setEtat(1);
		try {
			absService.updateAbsence(abs);
			return true;
		}catch(Exception e) {
			return false;
		}
	}
	
	
	
}
