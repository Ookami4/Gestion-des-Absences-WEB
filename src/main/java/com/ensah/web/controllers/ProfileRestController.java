package com.ensah.web.controllers;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.validation.Valid;

import org.apache.log4j.Logger;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.ui.Model;
import org.springframework.util.Base64Utils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ensah.core.bo.Absence;
import com.ensah.core.bo.Utilisateur;
import com.ensah.core.exceptions.ValidationErrorCustom;
import com.ensah.core.services.IProfileService;
import com.ensah.core.services.ISessionService;
import com.ensah.web.models.FicheModel;
import com.ensah.web.models.ProfileModel;

@RestController
@RequestMapping(value="/api/profile")
public class ProfileRestController {
	protected final Logger TRACER = Logger.getLogger(getClass());
	
	@Autowired
	IProfileService service;
	
	@Autowired
	ISessionService sesService;
	
	static final public String[] months = {"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};
	
	private Utilisateur getUser()
	{
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		String username = "";
		
		if (principal instanceof UserDetails) {
		  username = ((UserDetails)principal).getUsername();
		} else {
		  username = principal.toString();
		}
		return service.getUserByUserName(username);
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
	
	@GetMapping(value = "/getDetails", consumes = { MediaType.ALL_VALUE }, produces="application/json")
    public ProfileModel getData() {
		Utilisateur user = getUser();
		if(user==null)
			throw new ValidationErrorCustom(Utilisateur.class, "Vous n'êtes pas connectée");
		String photo = "";
		if(user.getPhoto()!=null)
			photo = new String(Base64Utils.decode(user.getPhoto()));
		ProfileModel model = new ProfileModel(user.getEmail(),user.getTelephone(),photo);
		return model;
    }
	
	@PostMapping(value = "/update", consumes = { MediaType.ALL_VALUE }, produces="application/json")
    public ProfileModel addPiece(@Valid ProfileModel profil, BindingResult bindingResult, Model model) throws Exception {    
		if(bindingResult.hasErrors()) {
			int size = bindingResult.getErrorCount();
			String Error = "";
			for(int i=0; i<size;++i) {				
				Error += bindingResult.getFieldErrors().get(i).getField() +":"+
						bindingResult.getAllErrors().get(i).getDefaultMessage()+",";
			}
			TRACER.error("Validation Error: " + Error);
			throw new ValidationErrorCustom(Utilisateur.class, Error);
		}
		Utilisateur user = getUser();
		if(user == null)
			throw new ValidationErrorCustom(Utilisateur.class, "Session expired ou bien non connecté");
		service.UpdateDetails(user, profil.getEmail(), profil.getTelephone(), Base64Utils.encode(profil.getPhoto().getBytes()));
		return profil;
    }
	
	@GetMapping(value = "/getAbsence", consumes = { MediaType.ALL_VALUE }, produces="application/json")
    public HashMap<String,List<FicheModel>> getAbsence() {
		Long idIns = this.getInsID();
		List<Absence> list = service.getAbsences(idIns);
		HashMap<String,List<FicheModel>> res = new HashMap<String,List<FicheModel>>();
		List<FicheModel> help = new ArrayList<FicheModel>();
		for(Absence i : list)
		{
			String year = String.valueOf(i.getDateHeureDebutAbsence().getYear()+1900);
			FicheModel tmp = null;
			int index = 0;
			boolean flag=false;
			for(FicheModel j : help)
			{
				if(j.getYear().equals(year))
				{
					tmp=j;
					flag=true;
					break;
				}
				index++;
			}
			if(tmp==null)
			{
				tmp = new FicheModel();
				tmp.setA(0);
				tmp.setJ(0);
				tmp.setNJ(0);
				tmp.setYear(year);
				tmp.setHelper(null);
			}
			if(i.getEtat()==1)
				tmp.setNJ(tmp.getNJ()+1);
			if(i.getEtat()==0)
				tmp.setJ(tmp.getJ()+1);
			if(i.getEtat()==2)
				tmp.setA(tmp.getA()+1);
			if(flag)
			{
				help.set(index, tmp);
			}
			else
				help.add(tmp);
		}
		res.put("total", help);
		help = new ArrayList<FicheModel>();
		for(Absence i : list)
		{
			String year = String.valueOf(i.getDateHeureDebutAbsence().getYear()+1900);
			String typeS = i.getTypeSeance().getAlias();
			FicheModel tmp = null;
			int index = 0;
			boolean flag=false;
			for(FicheModel j : help)
			{
				if(j.getYear().equals(year)&&j.getHelper().equals(typeS))
				{
					tmp=j;
					flag=true;
					break;
				}
				index++;
			}
			if(tmp==null)
			{
				tmp = new FicheModel();
				tmp.setA(0);
				tmp.setJ(0);
				tmp.setNJ(0);
				tmp.setYear(year);
				tmp.setHelper(typeS);
			}
			if(i.getEtat()==1)
				tmp.setNJ(tmp.getNJ()+1);
			if(i.getEtat()==0)
				tmp.setJ(tmp.getJ()+1);
			if(i.getEtat()==2)
				tmp.setA(tmp.getA()+1);
			if(flag)
			{
				help.set(index, tmp);
			}
			else
				help.add(tmp);
		}
		res.put("bySeance", help);
		help = new ArrayList<FicheModel>();
		for(Absence i : list)
		{
			String year = String.valueOf(i.getDateHeureDebutAbsence().getYear()+1900);
			String typeS = i.getMatiere().getNom();
			FicheModel tmp = null;
			int index = 0;
			boolean flag=false;
			for(FicheModel j : help)
			{
				if(j.getYear().equals(year)&&j.getHelper().equals(typeS))
				{
					tmp=j;
					flag=true;
					break;
				}
				index++;
			}
			if(tmp==null)
			{
				tmp = new FicheModel();
				tmp.setA(0);
				tmp.setJ(0);
				tmp.setNJ(0);
				tmp.setYear(year);
				tmp.setHelper(typeS);
			}
			if(i.getEtat()==1)
				tmp.setNJ(tmp.getNJ()+1);
			if(i.getEtat()==0)
				tmp.setJ(tmp.getJ()+1);
			if(i.getEtat()==2)
				tmp.setA(tmp.getA()+1);
			if(flag)
			{
				help.set(index, tmp);
			}
			else
				help.add(tmp);
		}
		res.put("byMatiere", help);
		return res;
    }
	
	public String getRealYear(String year)
	{
		return String.valueOf(Integer.parseInt(year)+1900);
	}
}
