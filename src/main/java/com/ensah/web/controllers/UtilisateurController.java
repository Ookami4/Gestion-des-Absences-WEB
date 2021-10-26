package com.ensah.web.controllers;

import java.util.ArrayList;
import java.util.List;

import javax.validation.Valid;

import org.apache.log4j.Logger;
import org.hibernate.annotations.Parameter;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.ensah.core.bo.CadreAdministrateur;
import com.ensah.core.bo.Enseignant;
import com.ensah.core.bo.Etudiant;
import com.ensah.core.bo.Utilisateur;
import com.ensah.core.exceptions.ValidationErrorCustom;
import com.ensah.core.services.IUtilisateurService;
import com.ensah.web.models.RoleModel;
import com.ensah.web.models.TestModel;
import com.ensah.web.models.UserModel;


@RestController
@RequestMapping(value="admin", consumes = { MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE })

public class UtilisateurController {
	
	@Autowired
	IUtilisateurService UserSer;
	protected final Logger TRACER = Logger.getLogger(getClass());
	//@RequestMapping(value="createUser",  method = RequestMethod.POST,consumes="application/json",headers = "content-type=application/x-www-form-urlencoded")
	@PostMapping(value="createUser", consumes = { MediaType.ALL_VALUE }, produces="application/json")
	public UserModel createUser(@Valid UserModel user, BindingResult bindingResult, Model model) throws Exception{
		String[] string =  null;
		
		System.out.println("inside userController: "+user.toString());
		
		
		if(user.getCne() == null) {
			user.setCne("");
		}
		if(user.getGrade() == null) {
			user.setGrade("");
		}
		if(user.getSpecialite() == null) {
			user.setSpecialite("");
		}
		
		//now we will check the role of the user
		//Administrateur
		/*
		 * cne and grade must be empty
		 * 
		 * */
		
		//check if email is unique
		if(bindingResult.hasErrors()) {
			//converting errors to string for the purpose of returing error in json format 
			//we will split the errors in the front	
			System.out.println("we have errors:" + bindingResult.getAllErrors().get(0).getDefaultMessage());
			System.out.println("error ebject: "+bindingResult.getFieldErrors().get(0).getField() );
			
			
			int size = bindingResult.getErrorCount();
			String Error = "";
			for(int i=0; i<size;++i) {
				
				if(user.getTypePerson() != 3 && bindingResult.getFieldErrors().get(i).getField().equals("cne")) {
					continue;
				}
				if(user.getTypePerson() != 2 && bindingResult.getFieldErrors().get(i).getField().equals("specialite")) {
					continue;
				}
				if(user.getTypePerson() != 1 && bindingResult.getFieldErrors().get(i).getField().equals("grade")) {
					continue;
				}				
				Error += bindingResult.getFieldErrors().get(i).getField() +":"+
						bindingResult.getAllErrors().get(i).getDefaultMessage()+",";
			}
			
			TRACER.error("Validation Error: " + Error);
			
			//cases for only cne error when user is not a student
			if(size > 2 || (user.getTypePerson() == 3 &&size == 1 && bindingResult.getFieldErrors().get(0).getField().equals("cne"))
				||(user.getTypePerson() == 2 &&size == 1 && bindingResult.getFieldErrors().get(0).getField().equals("specialite")) 
				|| (user.getTypePerson() == 1 &&size == 1 && bindingResult.getFieldErrors().get(0).getField().equals("grade"))) {
				throw new ValidationErrorCustom(Utilisateur.class, Error);
			}
			
		
		//throw new error
		
		
		}
		
		if(user.getTypePerson() == 1 && user.getCne().equals("") && user.getSpecialite().equals("")){
			CadreAdministrateur admin = new CadreAdministrateur();
			BeanUtils.copyProperties(user, admin);
			UserSer.addPerson(admin, 1);
		}
		//Enseignant
		else if(user.getTypePerson() == 2 && user.getCne().equals("") && user.getGrade().equals("")) {
			Enseignant prof = new Enseignant();
			BeanUtils.copyProperties(user, prof);
			UserSer.addPerson(prof, 2);
		}
		//Etudiant
		else if(user.getTypePerson() == 3 && user.getSpecialite().equals("") && user.getGrade().equals("")) {

			Etudiant etud= new Etudiant();
			BeanUtils.copyProperties(user, etud);
			UserSer.addPerson(etud, 3);
		}
		
		return new UserModel();

		
	}
	
	
	@GetMapping(value="getUsers", consumes = { MediaType.ALL_VALUE }, produces="application/json")
	public List<UserModel> GetUser() {
		List<Utilisateur> users = UserSer.getAllPersons();
		List<UserModel> persons = new ArrayList<>();
		
		for (int i = 0; i < users.size(); i++) {
			UserModel umodel = new UserModel();
			BeanUtils.copyProperties(users.get(i), umodel);
			persons.add(umodel);
			persons.get(i).setTypePerson(0);
		}
		
		//BeanUtils.copyProperties(source, target);
		System.out.println(persons);
		return persons; 
	}
	
	
	@PostMapping(value="changeRole", consumes = { MediaType.ALL_VALUE }, produces="application/json")
	public String changeRole(RoleModel Role) {
		System.out.println(Role.getRoleId());
		Long role = Role.getRoleId();
		Long id = Role.getId();
		UserSer.updatePerson(UserSer.getPersonById(id), role.intValue());
		
		return "hello";
	}
	

	@DeleteMapping(value="deleteUser/{id}", consumes = { MediaType.ALL_VALUE }, produces="application/json")
	public String deleteUser(@PathVariable Long id) {
		
		System.out.println("id" + id);
		UserSer.deletePerson(id);
		return "Success";
	}
	
	
	
	
    @GetMapping(value = "/hello")
    public String helloBoy(@RequestParam String name) {
        return "Hello, " + name;
    }
	
	
}
