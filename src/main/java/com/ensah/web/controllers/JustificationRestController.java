package com.ensah.web.controllers;

import java.util.ArrayList;


import java.util.List;


import javax.validation.Valid;

import org.apache.log4j.Logger;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.ensah.core.bo.Absence;
import com.ensah.core.bo.PieceJustificative;
import com.ensah.core.bo.Utilisateur;
import com.ensah.core.exceptions.ValidationErrorCustom;
import com.ensah.core.services.ICompteService;
import com.ensah.core.services.IJustificationService;
import com.ensah.core.services.IUtilisateurService;
import com.ensah.web.models.JustificationModel;

@RestController
@RequestMapping(value="/api/justification")
public class JustificationRestController {
	protected final Logger TRACER = Logger.getLogger(getClass());
	
	@Autowired
	IJustificationService service;
	
	@PostMapping(value = "/add", consumes = { MediaType.ALL_VALUE }, produces="application/json")
    public JustificationModel addPiece(@Valid JustificationModel justification, BindingResult bindingResult, Model model) throws Exception {    
		Long idIscr = this.getInsID();
		if(bindingResult.hasErrors()) {
			int size = bindingResult.getErrorCount();
			String Error = "";
			for(int i=0; i<size;++i) {				
				Error += bindingResult.getFieldErrors().get(i).getField() +":"+
						bindingResult.getAllErrors().get(i).getDefaultMessage()+",";
			}
			TRACER.error("Validation Error: " + Error);
			throw new ValidationErrorCustom(PieceJustificative.class, Error);
		}
		PieceJustificative jus = new PieceJustificative();
		justification.setEtat(1);
		justification.setDateLivraison(JustificationModel.getDateNow());
		justification.setSource("Etudiant");
		String[] absenceString = justification.getArrayAbsenceString().split(",");
		int sizeOfAbsence = absenceString.length;
		if(sizeOfAbsence==0)
			throw new ValidationErrorCustom(PieceJustificative.class, "Absence est vide");
		Long[] absenceIds = new Long[sizeOfAbsence];
		for(int j=0;j<sizeOfAbsence;j++)
		{
			absenceIds[j]=Long.parseLong(absenceString[j]);
		}
		justification.setAbsences(absenceIds);
		BeanUtils.copyProperties(justification, jus);
		jus.addAbsences(service.getAbsencesByIdsNJ(absenceIds,idIscr));
		service.addJustification(jus);
		return justification;
    }
	@PostMapping(value = "/edit", consumes = { MediaType.ALL_VALUE }, produces="application/json")
    public JustificationModel updatePiece(@Valid JustificationModel justification, BindingResult bindingResult, Model model) throws Exception {    
		Long idIscr = this.getInsID();
		if(!service.checkOwnerity(justification.getIdPieceJustificative(), idIscr))
			throw new ValidationErrorCustom(PieceJustificative.class, "Vous n'avez pas le droit");
		if(bindingResult.hasErrors()) {
			int size = bindingResult.getErrorCount();
			String Error = "";
			for(int i=0; i<size;++i) {				
				Error += bindingResult.getFieldErrors().get(i).getField() +":"+
						bindingResult.getAllErrors().get(i).getDefaultMessage()+",";
			}
			TRACER.error("Validation Error: " + Error);
			throw new ValidationErrorCustom(PieceJustificative.class, Error);
		}
		PieceJustificative jus = new PieceJustificative();
		jus = service.findJustificationById(justification.getIdPieceJustificative());
		justification.setDateLivraison(JustificationModel.getDateNow());
		justification.setSource("Etudiant");
		justification.setEtat(1);
		String[] absenceString = justification.getArrayAbsenceString().split(",");
		int sizeOfAbsence = absenceString.length;
		if(sizeOfAbsence==0)
			throw new ValidationErrorCustom(PieceJustificative.class, "Absence est vide");
		Long[] absenceIds = new Long[sizeOfAbsence];
		for(int j=0;j<sizeOfAbsence;j++)
		{
			absenceIds[j]=Long.parseLong(absenceString[j]);
		}
		justification.setAbsences(absenceIds);
		BeanUtils.copyProperties(justification, jus);
		jus.removeAllAbsences();
		jus.addAbsences(service.getAbsencesByIdsNJ(absenceIds,idIscr));
		service.updateJustification(jus);
		return justification;
    }
	
	@GetMapping(value = "/getOne/{id}", consumes = { MediaType.ALL_VALUE }, produces="application/json")
    public JustificationModel getOne(@PathVariable("id") Long id) {
		Long idIscr = this.getInsID();
		if(!service.checkOwnerity(id, idIscr))
			throw new ValidationErrorCustom(PieceJustificative.class, "Vous n'avez pas le droit");
		JustificationModel model = new JustificationModel();
		PieceJustificative jus = service.findJustificationById(id);
		BeanUtils.copyProperties(jus, model);
		model.getAbsenceByAbsences(jus.getAbsence());
        return model;
    }
	
	@DeleteMapping(value = "/delete/{id}", consumes = { MediaType.ALL_VALUE }, produces="application/json")
    public boolean deleteOne(@PathVariable("id") Long id) {
		Long idIscr = this.getInsID();
		if(!service.checkOwnerity(id, idIscr))
			throw new ValidationErrorCustom(PieceJustificative.class, "Vous n'avez pas le droit");
		PieceJustificative jus = service.findJustificationById(id);
		try {
			jus.removeAllAbsences();
			service.deleteJustification(id);
			return true;
		}
		catch(Exception e)
		{
			return false;
		}
    }
	
	@GetMapping(value = "/getDataStudent", consumes = { MediaType.ALL_VALUE }, produces="application/json")
	 public List<JustificationModel> getData() {
		List<JustificationModel> list = new ArrayList<JustificationModel>();
		List<PieceJustificative> listJus = service.findAllByStudent(this.getInsID());
		if(listJus==null)
			return null;
		for(PieceJustificative i : listJus)
		{
			JustificationModel tmp = new JustificationModel();
			BeanUtils.copyProperties(i, tmp);
			tmp.getAbsenceByAbsences(i.getAbsence());
			list.add(tmp);
		}
		return list;
    }
	
	@GetMapping(value = "/getAbsences/{id}", consumes = { MediaType.ALL_VALUE }, produces="application/json")
    public String[] getAbsences(@PathVariable("id") Long id) {
		Long idIscr = this.getInsID();
		if(!service.checkOwnerity(id, idIscr))
			throw new ValidationErrorCustom(PieceJustificative.class, "Vous n'avez pas le droit");
		PieceJustificative jus = service.findJustificationById(id);
		List<Absence> list = jus.getAbsence();
		int size = list.size();
		String[] texts = new String[size];
		for(int i = 0;i<size;i++)
		{
			Absence tmp = list.get(i);
			texts[i]= tmp.getMatiere().getNom() + " - " + tmp.getDateHeureDebutAbsence().toLocaleString() + " - " + tmp.getDateHeureFinAbsence().toLocaleString();
		}
		return texts;
    }
	
	@GetMapping(value = "/upload", consumes = { MediaType.ALL_VALUE }, produces="application/json")
    public Long upload() {
		Long idIscr = this.getInsID();
		//if(!service.checkOwnerity(id, idIscr))
		//	throw new ValidationErrorCustom(PieceJustificative.class, "Vous n'avez pas le droit");
		
		return null;
    }
	
	private Long getInsID()
	{
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		String username = "";
		
		if (principal instanceof UserDetails) {
		  username = ((UserDetails)principal).getUsername();
		} else {
		  username = principal.toString();
		}
		return service.getIdIns(username);
	}
}
