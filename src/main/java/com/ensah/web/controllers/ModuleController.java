package com.ensah.web.controllers;

 
import java.io.IOException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.ensah.core.bo.Matiere;
import com.ensah.core.bo.Niveau;
import com.ensah.core.bo.Module;
import com.ensah.core.services.IMatiereService;
import com.ensah.core.services.IModuleService;
import com.ensah.core.services.INiveauService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;


@Controller
public class ModuleController {

	@Autowired
	private INiveauService niveauService;
	@Autowired
	private IModuleService moduleSerive;
	@Autowired
	private IMatiereService matiereSerive;
	
	@RequestMapping(value = "/modules")
	public  String NiveauPage() throws JsonProcessingException {
		return "module";
	}
	
	@RequestMapping(value = "/module/add", method = RequestMethod.POST)
	@ResponseBody
	public  String addModule(@RequestBody String data) throws IOException, ParseException {
		ObjectMapper mapper = new ObjectMapper();
		JsonNode actualObj = mapper.readTree(data);
		JsonNode Fi = actualObj.get("Module");
		JsonNode Ni = actualObj.get("Niveau");
		String Ns =   mapper.treeToValue(Ni, String.class);
		Module M =   mapper.treeToValue(Fi, Module.class);
		M.setNiveau(niveauService.getNiveauById(Long.parseLong(Ns)));
		
		moduleSerive.addModule(M);

		return toJson(true);
	}
	@RequestMapping(value = "/module/modifier/{id}", method = RequestMethod.POST)
	@ResponseBody
	public  String updateModule(@RequestBody String data,@PathVariable Long id) throws IOException, ParseException {
		ObjectMapper mapper = new ObjectMapper();
		JsonNode actualObj = mapper.readTree(data);
		JsonNode Fi = actualObj.get("Module");
		JsonNode Ni = actualObj.get("Niveau");
		String Ns =   mapper.treeToValue(Ni, String.class);
		Module M =  moduleSerive.getModuleById(id);
		M.setCode(mapper.treeToValue(Fi.get("code"), String.class));
		M.setTitre(mapper.treeToValue(Fi.get("titre"), String.class));
		M.setNiveau(niveauService.getNiveauById(Long.parseLong(Ns)));
		moduleSerive.updateModule(M);

		return toJson(true);
	}
	@RequestMapping(value = "/module/delete/{id}", method = RequestMethod.DELETE,produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public  String deleteModule(@PathVariable Long id) throws JsonProcessingException {
		moduleSerive.deleteModule(id);
		return toJson(true);
	}
	@RequestMapping(value = "/module/addmatiere/{id}", method = RequestMethod.POST,produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public  String addMatieres(@RequestBody String data,@PathVariable Long id) throws IOException {
		Module M = moduleSerive.getModuleById(id);
		ObjectMapper mapper = new ObjectMapper();
		JsonNode actualObj = mapper.readTree(data);
		JsonNode Fi = actualObj.get("matiere");
		
		Collection<Matiere> mcol_delete = M.getMatieres();
		System.out.println(mcol_delete.toString());
		for(Matiere m_ : mcol_delete) {
			System.out.println(m_.getNom());
			System.out.println(m_.getIdMatiere()+"_______");
			m_.setModule(null);
			matiereSerive.updateMatiere(m_);
			matiereSerive.deleteMatiere(m_.getIdMatiere());
		}
		List<LinkedHashMap> Mc =   mapper.treeToValue(Fi, List.class);
		System.out.println(Mc.getClass());
		Collection<Matiere> mcol = new ArrayList<Matiere>();
		for(LinkedHashMap m : Mc) {
			System.out.println(m.getClass()+"__________________");
			Matiere m_el = new Matiere();
			m_el.setCode((String) m.get("code"));
			m_el.setNom((String) m.get("nom"));
			m_el.setModule(M);
			matiereSerive.addMatiere(m_el);
			mcol.add(m_el);
		}

		
		M.setMatieres(new ArrayList<>());
		System.out.println(M.getMatieres().getClass());
		moduleSerive.updateModule(M);
		return toJson(true);
	}
	@RequestMapping(value = "/module/add")
	@ResponseBody
	public  String add(@ModelAttribute Matiere m) throws JsonProcessingException {
		
		matiereSerive.addMatiere(m);
		Module x = moduleSerive.getModuleById((long) 1);
		Collection<Matiere> n = new ArrayList<Matiere>();
		n.add(m);
		x.setMatieres(n);
		moduleSerive.updateModule(x);
		return toJson(true);
	}
	@RequestMapping(value = "/modules/data", method = RequestMethod.GET,produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public  String allDataJson() throws JsonProcessingException {
		List<HashMap<String,Object>> allf= new ArrayList<HashMap<String,Object>>();
		Collection<Module> ns = moduleSerive.getAllModules();
		for(Module ne : ns) {
			HashMap<String,Object> datamd = new HashMap<String,Object>();
			datamd.put("idModule", ne.getIdModule());
			datamd.put("code", ne.getCode());
			datamd.put("titre", ne.getTitre());
			HashMap<String,Object> x =new HashMap<String,Object>();
			Niveau f_n = ne.getNiveau();
			if(f_n!=null) {
				x.put("titre",f_n.getTitre());
				x.put("id",f_n.getIdNiveau());
			}
			datamd.put("classe",x);
			List<Object> xm =new ArrayList<Object>();
			Collection<Matiere> m_n = ne.getMatieres();
				for(Matiere m : m_n) {
					HashMap<String,Object> tmp =new HashMap<String,Object>();
					tmp.put("idMatiere", m.getIdMatiere());
					tmp.put("nom", m.getNom());
					tmp.put("code", m.getCode());
					xm.add(tmp);
				}
			
	
			datamd.put("matieres",xm);
			allf.add(datamd);
		}
		return toJson(allf);
	}
	
	public String toJson(Object o) throws JsonProcessingException {
		ObjectMapper objectMapper = new ObjectMapper();
		return objectMapper.writeValueAsString(o);
	}

	

}
