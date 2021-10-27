package com.ensah.web.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class RedouanRouterController {

	@GetMapping("/ca/fiche")
	public String showAbsenceForm() {
		return "CadreAdmin/index";
	}
	@GetMapping("/ca/listeEtudiants")
	public String showStudentList() {
		return "CadreAdmin/showListEtudiants";
	}
	@GetMapping("/ca/etudiantListeAbsences/{id}")
	public String showAbsencesStudent() {
		return "CadreAdmin/showAbsenceEtudiant";
	}
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