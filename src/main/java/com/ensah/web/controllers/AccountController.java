package com.ensah.web.controllers;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ensah.core.services.ICompteService;
import com.ensah.core.services.IUtilisateurService;
import com.ensah.web.models.AccountGestionModel;
import com.ensah.web.models.AccountModel;
import com.ensah.core.bo.Compte;

@RestController
@RequestMapping("admin")
public class AccountController {

	@Autowired
	ICompteService accountSer;
	
	@Autowired
	IUtilisateurService UserSer;
	
	@PostMapping(value="createAccount", consumes = { MediaType.ALL_VALUE }, produces="application/json")
	public String createAccount(AccountModel account) {
		
		String password = accountSer.createAccount(account.getRoleId(), account.getPersonId());
		System.out.println("Password:" + password);
		return password;
	}
	
	@GetMapping(value="getAccounts", consumes = { MediaType.ALL_VALUE }, produces="application/json")
	public List<AccountGestionModel> getAccounts(){

		
		List<Compte> accounts = accountSer.getAllAccounts();
		accounts.get(0).getProprietaire();
		List<AccountGestionModel> accountReturned= new ArrayList<>(); 
		
		for(int i=0; i<accounts.size(); ++i) {
			
			AccountGestionModel am = new AccountGestionModel();
			BeanUtils.copyProperties(accounts.get(i), am);
			am.setNomRole(accounts.get(i).getRole().getNomRole());
			am.setEmail(accounts.get(i).getProprietaire().getEmail());
			
			accountReturned.add(am);
			
		}
		
		return accountReturned;
	}
	
}
