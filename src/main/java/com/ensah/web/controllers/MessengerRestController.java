package com.ensah.web.controllers;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.util.Base64Utils;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ensah.core.bo.Compte;
import com.ensah.core.bo.Conversation;
import com.ensah.core.bo.Message;
import com.ensah.core.bo.Utilisateur;
import com.ensah.core.exceptions.ValidationErrorCustom;
import com.ensah.core.services.IMessengerService;
import com.ensah.core.services.ISessionService;
import com.ensah.web.models.ConversationModel;
import com.ensah.web.models.MessageModel;
import com.ensah.web.models.MessengerAccountModel;

@RestController
@RequestMapping(value="/api/messenger")
public class MessengerRestController {
	@Autowired
	ISessionService sesService;
	
	@Autowired
	IMessengerService service;
	
	static final public String[] months = {"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};
	
	private Utilisateur getUser()
	{
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		String username = "";
		
		if (principal instanceof UserDetails) {
		  username = ((UserDetails)principal).getUsername();
		} else {
		  username = principal.toString();
		}
		return service.getUserByUserName(username);
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
		return sesService.getIdIns(username);
	}
	
	private String getUsername()
	{
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		String username = "";
		
		if (principal instanceof UserDetails) {
		  username = ((UserDetails)principal).getUsername();
		} else {
		  username = principal.toString();
		}
		return username;
	}
	
	@GetMapping(value = "/getAccs", consumes = { MediaType.ALL_VALUE }, produces="application/json")
    public List<MessengerAccountModel> getUsers()  throws Exception {
		List<MessengerAccountModel> res = new ArrayList<MessengerAccountModel>();
		System.out.println(this.getUsername());
		for(Compte c : service.getUsers(this.service.getAccByUserName(this.getUsername())))
		{
			MessengerAccountModel tmp = new MessengerAccountModel();
			Utilisateur tmpUser = c.getProprietaire();
			tmp.setFullName(tmpUser.getNom().toUpperCase()+" "+tmpUser.getPrenom());
			tmp.setIdAcc(c.getIdCompte());
			String photo = "";
			if(tmpUser.getPhoto()!=null)
				photo = new String(Base64Utils.decode(tmpUser.getPhoto()));
			tmp.setPhoto(photo);
			res.add(tmp);
		}
		return res;
    }
	
	@GetMapping(value = "/getConvs", consumes = { MediaType.ALL_VALUE }, produces="application/json")
    public List<ConversationModel> getConvs() {
		List<Conversation> cnv = service.getConversationOpened(getUsername());
		List<ConversationModel> list = new ArrayList<ConversationModel>();
		if(cnv == null) {
			return list;
		}
		for(Conversation c : cnv)
		{
			ConversationModel tmp = new ConversationModel();
			tmp.setEtat(c.getEtat());
			tmp.setIdConv(c.getIdConversation());
			tmp.setIdCreator(c.getCreateurConversation().getIdCompte());
			tmp.setTitle(c.getTitre());
			tmp.setType(c.getType());
			tmp.setMessages(new ArrayList<>());
			List<Message> msgs = c.getMessages();
			Collections.sort(msgs, new Comparator<Message>() {
			    public int compare(Message m1, Message m2) {
			    	return m2.getDateHeure().compareTo(m1.getDateHeure());
			    }
			});
			if(msgs.size()>0)
			{
				Message m = msgs.get(0);
				MessageModel ms = new MessageModel();
				ms.setContent(m.getTexte());
				ms.setIdMess(m.getIdMessage());
				ms.setIdSender(m.getExpediteur().getIdCompte());
				ms.setTime(m.getDateHeure());
				tmp.getMessages().add(ms);
			}
			tmp.setParts(new ArrayList<Long>());
			for(Compte cmpt : c.getParticipant())
			{
				tmp.getParts().add(cmpt.getIdCompte());
			}
			list.add(tmp);
		}
		return list;
    }
	
	@GetMapping(value = "/getConv/{id}", consumes = { MediaType.ALL_VALUE }, produces="application/json")
    public ConversationModel getConvOne(@PathVariable("id") Long id) throws Exception {
		Conversation c = service.getConversationById(id);
		Compte mine = service.getAccByUserName(getUsername());
		if(!service.checkParticipation(c, getUsername()))
			throw new ValidationErrorCustom(Conversation.class,"Vous n'êtes pas le droit");
			ConversationModel tmp = new ConversationModel();
			tmp.setEtat(c.getEtat());
			tmp.setIdConv(c.getIdConversation());
			tmp.setIdCreator(c.getCreateurConversation().getIdCompte());
			tmp.setTitle(c.getTitre());
			tmp.setType(c.getType());
			tmp.setMessages(new ArrayList<>());
			List<Message> msgs = c.getMessages();
			Collections.sort(msgs, new Comparator<Message>() {
			    public int compare(Message m1, Message m2) {
			        return m1.getDateHeure().compareTo(m2.getDateHeure());
			    }
			});
			for(Message m : msgs)
			{
				MessageModel ms = new MessageModel();
				ms.setContent(m.getTexte());
				ms.setIdMess(m.getIdMessage());
				/* Optimisation */
				Long idSender = m.getExpediteur().getIdCompte();
				ms.setIdSender(idSender);
				ms.setTime(m.getDateHeure());
				/* Optimisation */
				Utilisateur tmpUser = m.getExpediteur().getProprietaire();
				ms.setSenderName(tmpUser.getNom().toUpperCase()+" "+tmpUser.getPrenom());
				if(idSender==mine.getIdCompte())
					ms.setOwnership(true);
				else
					ms.setOwnership(false);
				tmp.getMessages().add(ms);
			}
			tmp.setParts(new ArrayList<Long>());
			for(Compte cmpt : c.getParticipant())
			{
				tmp.getParts().add(cmpt.getIdCompte());
			}
		return tmp;
    }
	
	@PostMapping(value = "/addMsg", consumes = { MediaType.ALL_VALUE }, produces="application/json")
    public Object addMessage(@RequestParam Map<String,String> body) throws Exception {
		String id = body.get("id");
		String msg = body.get("msg");
		if(id==null || id.isBlank())
			throw new ValidationErrorCustom(Conversation.class,"ID conversation est vide");
		if(msg==null || msg.isBlank())
			throw new ValidationErrorCustom(Conversation.class,"Message est vide");
		Message m = new Message();
		Conversation cv = service.getConversationById(Long.parseLong(id));
		if(cv.getEtat()!=1)
			throw new ValidationErrorCustom(Conversation.class,"La conversation est déjà fermée");
		m.setConversation(cv);
		m.setDateHeure(new Date());
		Compte c = service.getAccByUserName(this.getUsername());
		boolean flag=false;
		for(Compte cs : cv.getParticipant())
		{
			if(cs.getIdCompte()==c.getIdCompte())
				flag=true;
		}
		if(!flag)
			throw new ValidationErrorCustom(Conversation.class,"Vous n'avez pas le droit");
		m.setExpediteur(c);
		m.setTexte(msg);
		service.addMessage(m);
		return body;
    }
	
	@PostMapping(value = "/addConv", consumes = { MediaType.ALL_VALUE }, produces="application/json")
    public Object addConv(@RequestParam Map<String,String> body) throws Exception {
		String id = body.get("id");
		if(id==null || id.isBlank())
			throw new ValidationErrorCustom(Conversation.class,"ID est vide");
		Conversation c = new Conversation();
		Compte me = service.getAccByUserName(this.getUsername());
		c.addCreator(me);
		c.setEtat(1);
		c.addAccount(service.getAccountByID(Long.parseLong(id)));
		c.addAccount(me);
		c.setType("Messenger");
		c.setTitre("Default Title");
		return service.openConversation(c);
    }
	
	@PostMapping(value = "/addPeople/{idConv}", consumes = { MediaType.ALL_VALUE }, produces="application/json")
    public Object addPeople(@RequestParam Map<String,String> body,@PathVariable("idConv") Long idConv) throws Exception {
		String id = body.get("id");
		if(id==null || id.isBlank())
			throw new ValidationErrorCustom(Conversation.class,"ID conversation est vide");
		if(idConv==null)
			throw new ValidationErrorCustom(Conversation.class,"ID est vide");
		Conversation c = service.getConversationById(idConv);
		if(c==null)
			throw new ValidationErrorCustom(Conversation.class,"Conversation est non trouvée");
		Compte me = service.getAccByUserName(this.getUsername());
		if(!c.getCreateurConversation().getIdCompte().equals(me.getIdCompte()))
			throw new ValidationErrorCustom(Conversation.class,"Vous n'êtes pas le créateur");
		Compte cmp = service.getAccountByID(Long.parseLong(id));
		if(c.getParticipant().contains(cmp))
			throw new ValidationErrorCustom(Conversation.class,"Compte déjà existe");
		c.addAccount(cmp);
		service.updateConversation(c);
		return c.getIdConversation();
    }
	
	@PostMapping(value = "/addTitle", consumes = { MediaType.ALL_VALUE }, produces="application/json")
    public Object addTitle(@RequestParam Map<String,String> body) throws Exception {
		String id = body.get("id");
		String title = body.get("title");
		if(id==null || id.isBlank())
			throw new ValidationErrorCustom(Conversation.class,"ID conversation est vide");
		if(title==null || title.isBlank())
			throw new ValidationErrorCustom(Conversation.class,"Titre est vide");
		Conversation c = service.getConversationById(Long.parseLong(id));
		if(!service.checkParticipation(c, getUsername()))
			throw new ValidationErrorCustom(Conversation.class,"Vous n'êtes pas le droit");
		c.setTitre(title);
		service.updateConversation(c);
		return body;
    }
	
	@DeleteMapping(value = "/deteleConv/{id}", consumes = { MediaType.ALL_VALUE }, produces="application/json")
    public Object deleteConv(@PathVariable("id") Long id) throws Exception {
		if(id==null)
			throw new ValidationErrorCustom(Conversation.class,"ID conversation est vide");
		Conversation c = service.getConversationById(id);
		if(!service.checkParticipation(c, getUsername()))
			throw new ValidationErrorCustom(Conversation.class,"Vous n'êtes pas le droit");
		c.setEtat(0);
		service.updateConversation(c);
		return id;
    }
}
