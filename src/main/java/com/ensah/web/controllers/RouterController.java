package com.ensah.web.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class RouterController {
	
	@GetMapping("/justification/add")
	public String addJustification() {
		return "justification/addJustification";
	}
	
	@GetMapping("/profil")
	public String profilChange() {
		return "profil/profil";
	}
	
	@GetMapping("/reclamation")
	public String reclamation() {
		return "reclamation/student";
	}
	
	@GetMapping("/messages")
	public String messages()
	{
		return "messenger/index";
	}
}
