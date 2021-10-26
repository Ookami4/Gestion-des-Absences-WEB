package com.ensah.web.controllers;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.validation.Valid;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ensah.core.bo.Absence;
import com.ensah.core.bo.Compte;
import com.ensah.core.services.IFormAbsService;
import com.ensah.core.services.ISessionService;
import com.ensah.web.models.AbsenceModel;
import com.ensah.web.models.FicheModel;
import com.ensah.web.models.StudentFormModel;

@RestController
@RequestMapping(value="/api/CadreAdmin")
public class StdAbsFormRestController {
	protected final Logger TRACER = Logger.getLogger(getClass());
	
	@Autowired 
	IFormAbsService formService;
	
	@Autowired
	ISessionService SessionService;
	
	@GetMapping(value = "/getStudent", consumes = { MediaType.ALL_VALUE }, produces="application/json")
	public List<StudentFormModel> getStudent() throws Exception{
		List<StudentFormModel> res = new ArrayList<StudentFormModel>();
		List<Compte> list = formService.getStudent();
		if(list==null)
			return res;
		for(Compte c : list)
		{
			StudentFormModel model = new StudentFormModel();
			model.setFullname(c.getProprietaire().getNom()+" "+c.getProprietaire().getPrenom());
			model.setIdInsc(SessionService.getIdIns(c.getLogin()));
			res.add(model);
		}
		return res;
	}
	
	@GetMapping(value = "/getStudentAbsences/{id}", consumes = {MediaType.ALL_VALUE }, produces = "application/json")
	public HashMap<String,List<FicheModel>> getAbsences(@PathVariable("id") Long id) {
		Long idIns = id;
		List<Absence> list = formService.getAbsenceByStudent(idIns);
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
}
