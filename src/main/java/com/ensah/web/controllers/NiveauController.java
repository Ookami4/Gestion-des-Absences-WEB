package com.ensah.web.controllers;

 
import java.io.IOException;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.ensah.core.bo.Filiere;
import com.ensah.core.bo.Niveau;
import com.ensah.core.services.IFiliereService;
import com.ensah.core.services.INiveauService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class NiveauController {

	
	
	@Autowired
	private INiveauService niveauService;
	@Autowired
	private IFiliereService filiereService;
	
	
	@RequestMapping(value = "/niveau")
	public  String NiveauPage() throws JsonProcessingException {
		return "classe";
	}
	@RequestMapping(value = "/niveau/add", method = RequestMethod.POST)
	@ResponseBody
	public  String addNiveau(@RequestBody String data) throws IOException, ParseException {
		ObjectMapper mapper = new ObjectMapper();
		JsonNode actualObj = mapper.readTree(data);
		JsonNode Fi = actualObj.get("Filiere");
		JsonNode Ni = actualObj.get("Niveau");
		Niveau N =   mapper.treeToValue(Ni, Niveau.class);
		String Fs =   mapper.treeToValue(Fi, String.class);
		if(!Fs.isBlank()) {
			N.setFiliere(filiereService.getFiliereById(Long.parseLong(Fs)));
		}		
		niveauService.addNiveau(N);

		return toJson(true);
	}
	@RequestMapping(value = "/niveau/modifier/{id}", method = RequestMethod.POST)
	@ResponseBody
	public  String updateNiveau(@RequestBody String data,@PathVariable Long id ) throws IOException, ParseException {
		ObjectMapper mapper = new ObjectMapper();
		JsonNode actualObj = mapper.readTree(data);
		JsonNode Fi = actualObj.get("Filiere");
		JsonNode Ni = actualObj.get("Niveau");
		Niveau N =  niveauService.getNiveauById(id);
		String Fs =   mapper.treeToValue(Fi, String.class);
		N.setTitre(mapper.treeToValue(Ni.get("titre"), String.class));
		N.setAlias(mapper.treeToValue(Ni.get("alias"), String.class));
		if(!Fs.isBlank()) {
			N.setFiliere(filiereService.getFiliereById(Long.parseLong(Fs)));
		}
		else {
			N.setFiliere(null);
		}
		niveauService.updateNiveau(N);

		return toJson(true);
	}
	@RequestMapping(value = "/niveau/delete/{id}", method = RequestMethod.DELETE,produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public  String deleteNiveau(@PathVariable Long id) throws JsonProcessingException {
		niveauService.deleteNiveau(id);
		return toJson(true);
	}
	
	@RequestMapping(value = "/Niveau/data", method = RequestMethod.GET,produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public  String allDataJson() throws JsonProcessingException {
		List<HashMap<String,Object>> allf= new ArrayList<HashMap<String,Object>>();
		Collection<Niveau> ns =niveauService.getAllNiveaus();
		for(Niveau ne : ns) {
			HashMap<String,Object> coordi = new HashMap<String,Object>();
			coordi.put("idNiveau", ne.getIdNiveau());
			coordi.put("alias", ne.getAlias());
			coordi.put("titre", ne.getTitre());
			HashMap<String,Object> x =new HashMap<String,Object>();
			Filiere f_n = ne.getFiliere();
			if(f_n!=null) {
				x.put("titre",f_n.getTitreFiliere());
				x.put("id",f_n.getIdFiliere());
			}
			coordi.put("filiere",x);
			allf.add(coordi);
		}
		return toJson(allf);
	}
	
	
	
	public String toJson(Object o) throws JsonProcessingException {
		ObjectMapper objectMapper = new ObjectMapper();
		return objectMapper.writeValueAsString(o);
	}

	

}
