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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ensah.core.bo.Absence;
import com.ensah.core.exceptions.ValidationErrorCustom;
import com.ensah.core.services.IAbsenceService;
import com.ensah.core.services.IJustificationService;
import com.ensah.web.models.AbsenceModel;

@RestController
@RequestMapping(value="/api/absence")
public class AbsenceRestController {
	protected final Logger TRACER = Logger.getLogger(getClass());
	
	@Autowired
	IAbsenceService service;
	
	@Autowired
	IJustificationService serviceJus;
	
	@GetMapping(value = "/getAllNeeded", consumes = { MediaType.ALL_VALUE }, produces="application/json")
    public List<AbsenceModel> getAllNeeded() {
		Long id = getInsID();
        List<Absence> list = service.findAllAbsenceByStudentNJ(id);
        List<AbsenceModel> res = new ArrayList<AbsenceModel>();
        for(Absence i : list)
        {
        	AbsenceModel tmp = new AbsenceModel();
        	BeanUtils.copyProperties(i, tmp);
        	//git rid of Infinit retreiving or using @JsonIgnore
        	//and to avoid set null to bean while transaction is opened
        	tmp.getObservateur().setAbsencesMarquees(null);
        	tmp.getMatiere().setModule(null);
        	tmp.setPieceJustificative(null);
        	res.add(tmp);
        }
        return res;
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
		return serviceJus.getIdIns(username);
	}
}
