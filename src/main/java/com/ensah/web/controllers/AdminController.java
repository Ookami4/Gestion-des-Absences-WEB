package com.ensah.web.controllers;

import org.springframework.stereotype.Controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ensah.web.models.UserModel;

@Controller
@RequestMapping("admin")
public class AdminController {

	@GetMapping("addUsersForm")
	public String AddUsersForm(Model model) {
		UserModel user = new UserModel();
		
		model.addAttribute("UserModel", user);
		
		return "admin/userform";
	}
	@GetMapping("addAccountForm")
	public String addAccountForm() {
		return "admin/accountPage";
	}
	
}
