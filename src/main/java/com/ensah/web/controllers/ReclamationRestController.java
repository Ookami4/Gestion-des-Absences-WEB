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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ensah.core.bo.Absence;
import com.ensah.core.bo.Inscription;
import com.ensah.core.bo.PieceJustificative;
import com.ensah.core.bo.Reclamation;
import com.ensah.core.exceptions.ValidationErrorCustom;
import com.ensah.core.services.IReclamationService;
import com.ensah.core.services.ISessionService;
import com.ensah.web.models.ReclamationModel;

@RestController
@RequestMapping(value="/api/reclamation")
public class ReclamationRestController {
protected final Logger TRACER = Logger.getLogger(getClass());
	
	@Autowired
	IReclamationService service;
	
	@Autowired
	ISessionService sesService;
	
	@GetMapping(value = "/getStudent", consumes = { MediaType.ALL_VALUE }, produces="application/json")
    public List<ReclamationModel> getDataStudent() {
		//Long idIns = getInsID();
		Long idIns = 1l;
		List<ReclamationModel> list = new ArrayList<ReclamationModel>();
		List<Reclamation> data = service.findReclamationByIns(idIns);
		for(Reclamation i : data)
		{
			ReclamationModel tmp = new ReclamationModel();
			BeanUtils.copyProperties(i,tmp);
			tmp.setLabelAbsence(i.getAbsence().getMatiere().getNom()
					+" - "+i.getAbsence().getDateHeureDebutAbsence().toLocaleString()
					+" - "+i.getAbsence().getDateHeureFinAbsence().toLocaleString());
			list.add(tmp);
		}
		return list;
    }
	
	@DeleteMapping(value = "/delete/{id}", consumes = { MediaType.ALL_VALUE }, produces="application/json")
    public boolean deleteOne(@PathVariable("id") Long id) throws Exception {
		//Long idIns = getInsID();
		Long idIns = 1l;
		if(!service.checkOwnerity(id, idIns))
			throw new ValidationErrorCustom(PieceJustificative.class, "Vous n'avez pas le droit");
		Reclamation r = service.findReclamationById(id);
		try {
			r.removeAbsence();
			r.removeInscription();
			service.deleteReclemation(id);
			return true;
		}
		catch(Exception e)
		{
			return false;
		}
    }
	
	@PostMapping(value = "/add", consumes = { MediaType.ALL_VALUE }, produces="application/json")
    public ReclamationModel addOne(@Valid ReclamationModel reclamation, BindingResult bindingResult, Model model) throws Exception {
		//Long idIns = getInsID();
		Long idIns = 1l;
		if(bindingResult.hasErrors()) {
			int size = bindingResult.getErrorCount();
			String Error = "";
			for(int i=0; i<size;++i) {				
				Error += bindingResult.getFieldErrors().get(i).getField() +":"+
						bindingResult.getAllErrors().get(i).getDefaultMessage()+",";
			}
			TRACER.error("Validation Error: " + Error);
			throw new ValidationErrorCustom(Reclamation.class, Error);
		}
		Reclamation rec = new Reclamation();
		Inscription ins = service.getInscriptionByID(idIns);
		if(ins==null)
			throw new ValidationErrorCustom(Reclamation.class, "Forbidden Request");
		rec.setInscription(ins);
		Absence abs = service.getAbsenceByIdNJ(Long.parseLong(reclamation.getIdAbsence()), idIns);
		if(abs==null)
			throw new ValidationErrorCustom(Reclamation.class, "Absence déjà traité");
		rec.setAbsence(abs);
		BeanUtils.copyProperties(reclamation, rec);
		service.addReclamation(rec);
		return reclamation;
    }
	
	@PostMapping(value = "/edit", consumes = { MediaType.ALL_VALUE }, produces="application/json")
    public ReclamationModel editOne(@Valid ReclamationModel reclamation, BindingResult bindingResult, Model model) throws Exception {
		//Long idIns = getInsID();
		Long idIns = 1l;
		if(bindingResult.hasErrors()) {
			int size = bindingResult.getErrorCount();
			String Error = "";
			for(int i=0; i<size;++i) {				
				Error += bindingResult.getFieldErrors().get(i).getField() +":"+
						bindingResult.getAllErrors().get(i).getDefaultMessage()+",";
			}
			TRACER.error("Validation Error: " + Error);
			throw new ValidationErrorCustom(Reclamation.class, Error);
		}
		Long id = reclamation.getIdReclamation();
		if(!service.checkOwnerity(id,idIns))
			throw new ValidationErrorCustom(PieceJustificative.class, "Vous n'avez pas le droit");
		Reclamation rec = service.findReclamationById(id);
		if(rec.isAnswered())
			throw new ValidationErrorCustom(PieceJustificative.class, "Reclamation traité déjà");
		Absence abs = service.getAbsenceByIdNJ(Long.parseLong(reclamation.getIdAbsence()), idIns);
		if(abs==null)
			throw new ValidationErrorCustom(Reclamation.class, "Absence déjà traité");
		rec.removeAbsence();
		rec.setAbsence(abs);
		BeanUtils.copyProperties(reclamation, rec);
		service.updateReclamation(rec);
		return reclamation;
    }
	
	@GetMapping(value = "/getOne/{id}", consumes = { MediaType.ALL_VALUE }, produces="application/json")
    public ReclamationModel getOne(@PathVariable("id") Long id) {
		//Long idIns = getInsID();
		Long idIns = 1l;
		if(!service.checkOwnerity(id, idIns))
			throw new ValidationErrorCustom(Reclamation.class, "Vous n'avez pas le droit");
		ReclamationModel model = new ReclamationModel();
		Reclamation rec = service.findReclamationById(id);
		BeanUtils.copyProperties(rec, model);
		model.setIdAbsence(String.valueOf(rec.getAbsence().getIdAbsence()));
		return model;
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
		return sesService.getIdIns(username);
	}
}
