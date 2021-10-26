package com.ensah.web.controllers;


import java.io.IOException;
import java.text.ParseException; 
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ensah.core.bo.Coordination;
import com.ensah.core.bo.Enseignant;
import com.ensah.core.bo.Filiere;
import com.ensah.core.bo.Niveau;
import com.ensah.core.services.ICoordinationService;
import com.ensah.core.services.IEnseignantService;
import com.ensah.core.services.IFiliereService;
import com.ensah.core.services.INiveauService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class FiliereController {

	
	@Autowired
	private IFiliereService filiereService;
	@Autowired
	private INiveauService niveauService;
	@Autowired
	private IEnseignantService enseignantService;
	@Autowired
	private ICoordinationService coordinationService;
	
	
	@RequestMapping(value = "/filiere")
	public  String filierePage() throws JsonProcessingException {
		return "filiere";
	}
	
	@RequestMapping(value = "/filieres/add", method = RequestMethod.POST)
	@ResponseBody
	public  String addFiliere(@RequestBody String data) throws IOException, ParseException {
		ObjectMapper mapper = new ObjectMapper();
		JsonNode actualObj = mapper.readTree(data);
		JsonNode Co = actualObj.get("Coordination");
		Filiere f =   mapper.treeToValue(actualObj.get("Filiere"), Filiere.class);
		boolean Niveau_add = mapper.treeToValue(actualObj.get("Niveau_add"), boolean.class);
		String idU = mapper.treeToValue(Co.get("idUtilisateur"), String.class);
		String debut = mapper.treeToValue(Co.get("dateDebut"), String.class);
		String fin = mapper.treeToValue(Co.get("dateFin"), String.class);
		String t = f.getTitreFiliere().toUpperCase();
		
		if(!t.isEmpty()) {
			String[] s= {"de","et","a","à","ou","du"," ","l","d","le","la","les","des"};
			t=t.replaceAll("l’", "");
			t=t.replaceAll("d’", "");
			t=t.replaceAll("l'", "");
			t=t.replaceAll("d'", "");
			String[] x = t.split(" ");
			String id="";
            ArrayList<String> nidp = new ArrayList<String>();
            for(String s1 : x) {
            	if(!Arrays.asList(s).contains(s1.toLowerCase())) {
            		id+=s1.charAt(0);
        			nidp.add(s1);
            	}
            }
            id=alphabetwithoutAccents(id);
            int i,j,k,n = nidp.size();
            i=k=1;j=2;
            while(filiereService.getFiliereBycodeFiliere(id).size()>0){
            	id = nidp.get(0).charAt(0)+"";
            	for(int h=1 ; h < n ; h++) {
            		String el = nidp.get(h);
            		if(i<=h) id += el.substring(0, (j<el.length())?j:el.length());
            		else  id += (k<el.length())?el.substring(0,k):el.substring(0,el.length());
            	}
            	i++;
            	if(i==n) {j++;k++;i=1;}
            	id=alphabetwithoutAccents(id);
            }
            f.setCodeFiliere(id);
		}
		
			filiereService.addFiliere(f);
			if(Niveau_add) {
				addNiveau(f.getCodeFiliere()+"1", "Première année "+f.getTitreFiliere(), f);
				addNiveau(f.getCodeFiliere()+"2", "Deuxième année "+f.getTitreFiliere(), f);
				addNiveau(f.getCodeFiliere()+"3", "Troisième année "+f.getTitreFiliere(), f);
			}
			if(!idU.isBlank()) {
				List<Coordination> Cl = coordinationService.getCoordinationByIdUtilisateur(idU);
				if(Cl.size()>0) {
					Coordination c = Cl.get(0);
					c.setFiliere(f);
					if(!debut.isBlank())
						c.setDateDebut(new SimpleDateFormat("yyyy-MM-dd").parse(debut));
					if(!fin.isBlank())
						c.setDateFin(new SimpleDateFormat("yyyy-MM-dd").parse(fin));
					coordinationService.updateCoordination(c);
				}
				else {
					Coordination c = new Coordination(debut, fin, enseignantService.getEnseignantById(Long.parseLong(idU)), f);
					coordinationService.addCoordination(c);
				}
				
			}
		
		return toJson(true);
	}
	
	@RequestMapping(value = "/filieres/modifier/{id}", method = RequestMethod.POST)
	@ResponseBody
	public  String updateFiliere(@RequestBody String data,@PathVariable Long id) throws IOException, ParseException {
		Filiere f = filiereService.getFiliereById(id);
		ObjectMapper mapper = new ObjectMapper();
		JsonNode actualObj = mapper.readTree(data);
		JsonNode Fi = actualObj.get("Filiere");
		JsonNode Co = actualObj.get("Coordination");
		
		f.setAnneeaccreditation(mapper.treeToValue(Fi.get("anneeaccreditation"), Integer.class));
		f.setAnneeFinaccreditation(mapper.treeToValue(Fi.get("anneeFinaccreditation"), Integer.class));
		f.setTitreFiliere(mapper.treeToValue(Fi.get("titreFiliere"), String.class));
		
		String idU = mapper.treeToValue(Co.get("idUtilisateur"), String.class);
		String debut = mapper.treeToValue(Co.get("dateDebut"), String.class);
		String fin = mapper.treeToValue(Co.get("dateFin"), String.class);
		
		if(idU!=null) {
				List<Coordination> Cl = coordinationService.getCoordinationByIdUtilisateur(idU);
				if(Cl.size()>0) {
					Coordination c = Cl.get(0);
					c.setFiliere(f);
					if(!debut.isBlank())
						c.setDateDebut(new SimpleDateFormat("yyyy-MM-dd").parse(debut));
					if(!fin.isBlank())
						c.setDateFin(new SimpleDateFormat("yyyy-MM-dd").parse(fin));
					coordinationService.updateCoordination(c);
				}
				else {
					Coordination c = new Coordination(debut, fin, enseignantService.getEnseignantById(Long.parseLong(idU)), f);
					coordinationService.addCoordination(c);
					Cl.add(c);
					
				}
				
				f.setPeriodeCoordination(Cl);
			}
		
		filiereService.updateFiliere(f);
		return toJson(true);
	}
	
	
	@RequestMapping(value = "/filiere/data", method = RequestMethod.GET,produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public  String allDataJson() throws JsonProcessingException {
		
		List<HashMap<String,Object>> allf= new ArrayList<HashMap<String,Object>>();
		Collection<Filiere> f=filiereService.getAllFilieres();
		for(Filiere fe : f) {
			List<Object> cr = new ArrayList<Object>();
			HashMap<String,Object> onef = new HashMap<String,Object>();
			onef.put("titreFiliere", fe.getTitreFiliere());
			onef.put("codeFiliere", fe.getCodeFiliere());
			onef.put("anneeaccreditation", fe.getAnneeaccreditation());
			onef.put("anneeFinaccreditation", fe.getAnneeFinaccreditation());
			onef.put("idFiliere", fe.getIdFiliere());
			
			if(fe.getPeriodeCoordination().size()>0) {
				
				for(Coordination coo : fe.getPeriodeCoordination()) {
					HashMap<String,Object> coordi = new HashMap<String,Object>();
					coordi.put("id", coo.getCoordonateur().getIdUtilisateur());
					coordi.put("name", coo.getCoordonateur().getNom()+" "+ coo.getCoordonateur().getPrenom());
					coordi.put("debut", coo.getDateDebut());
					coordi.put("fin", coo.getDateFin());

					cr.add(coordi);
				}
			}
			onef.put("coordinateur", cr);
			allf.add(onef);
		}
		return toJson(allf);
	}
	
	@RequestMapping(value = "/filiere/delete/{id}", method = RequestMethod.DELETE,produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public  String findFiliere(@PathVariable Long id) throws JsonProcessingException {
		filiereService.deleteFiliere(id);
		return toJson(true);
	}

	
	@RequestMapping(value = "/filiere/ensignet", method = RequestMethod.GET,produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public  String getEns() throws JsonProcessingException {
		List<HashMap<String,Object>> allf= new ArrayList<HashMap<String,Object>>();
		Collection<Enseignant> f=enseignantService.getAllEnseignants();
		for(Enseignant fe : f) {
			HashMap<String,Object> onef = new HashMap<String,Object>();
			onef.put("id", fe.getIdUtilisateur());
			onef.put("nom", fe.getNom());
			onef.put("prenom", fe.getPrenom());
			onef.put("cin", fe.getCin());
			allf.add(onef);
		}
		return toJson(allf);
	}
	
	
	
	public   void addNiveau(String CodeFiliere,String Titre,Filiere f)  {
		niveauService.addNiveau(new Niveau(CodeFiliere, Titre, f));
	}
	public String toJson(Object o) throws JsonProcessingException {
		ObjectMapper objectMapper = new ObjectMapper();
		return objectMapper.writeValueAsString(o);
	}
	public String alphabetwithoutAccents(String s){
		Map<String,String> alphabetAccent = new HashMap<String,String>();
		alphabetAccent.put("Š", "S");
		alphabetAccent.put("š", "s");
		alphabetAccent.put("Đ", "D");
		alphabetAccent.put("đ", "d");
		alphabetAccent.put("Ž", "Z");
		alphabetAccent.put("ž", "z");
		alphabetAccent.put("Č", "C");
		alphabetAccent.put("č", "c");
		alphabetAccent.put("Ć", "C");
		alphabetAccent.put("ć", "c");
		alphabetAccent.put("À", "A");
		alphabetAccent.put("Á", "A");
		alphabetAccent.put("Â", "A");
		alphabetAccent.put("Ã", "A");
		alphabetAccent.put("Ä", "A");
		alphabetAccent.put("Å", "A");
		alphabetAccent.put("Æ", "A");
		alphabetAccent.put("Ç", "C");
		alphabetAccent.put("È", "E");
		alphabetAccent.put("É", "E");
		alphabetAccent.put("Ê", "E");
		alphabetAccent.put("Ë", "E");
		alphabetAccent.put("Ì", "I");
		alphabetAccent.put("Í", "I");
		alphabetAccent.put("Î", "I");
		alphabetAccent.put("Ï", "I");
		alphabetAccent.put("Ñ", "N");
		alphabetAccent.put("Ò", "O");
		alphabetAccent.put("Ó", "O");
		alphabetAccent.put("Ô", "O");
		alphabetAccent.put("Õ", "O");
		alphabetAccent.put("Ö", "O");
		alphabetAccent.put("Ø", "O");
		alphabetAccent.put("Ù", "U");
		alphabetAccent.put("Ú", "U");
		alphabetAccent.put("Û", "U");
		alphabetAccent.put("Ü", "U");
		alphabetAccent.put("Ý", "Y");
		alphabetAccent.put("Þ", "B");
		alphabetAccent.put("ß", "S");
		alphabetAccent.put("à", "a");
		alphabetAccent.put("á", "a");
		alphabetAccent.put("â", "a");
		alphabetAccent.put("ã", "a");
		alphabetAccent.put("ä", "a");
		alphabetAccent.put("å", "a");
		alphabetAccent.put("æ", "a");
		alphabetAccent.put("ç", "c");
		alphabetAccent.put("è", "e");
		alphabetAccent.put("é", "e");
		alphabetAccent.put("ê", "e");
		alphabetAccent.put("ë", "e");
		alphabetAccent.put("ì", "i");
		alphabetAccent.put("í", "i");
		alphabetAccent.put("î", "i");
		alphabetAccent.put("ï", "i");
		alphabetAccent.put("ð", "o");
		alphabetAccent.put("ñ", "n");
		alphabetAccent.put("ò", "o");
		alphabetAccent.put("ó", "o");
		alphabetAccent.put("ô", "o");
		alphabetAccent.put("õ", "o");
		alphabetAccent.put("ö", "o");
		alphabetAccent.put("ø", "o");
		alphabetAccent.put("ù", "u");
		alphabetAccent.put("ú", "u");
		alphabetAccent.put("û", "u");
		alphabetAccent.put("ý", "y");
		alphabetAccent.put("þ", "b");
		alphabetAccent.put("ÿ", "y");
		alphabetAccent.put("Ŕ", "R");
		alphabetAccent.put("ŕ", "r");	
		
		String r="";
		for(char c : s.toCharArray()) {
    		r+=alphabetAccent.containsKey(c+"")?alphabetAccent.get(c+""):c;
		}
		return r;
	}
	

	

}
