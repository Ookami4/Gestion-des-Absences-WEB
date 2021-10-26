package com.ensah.web.models;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class ConversationModel {
	private Long idConv;
	
	private String title;
	
	private Integer etat;
	
	private Long idCreator;
	
	private ArrayList<Long> parts;
	
	private String type;
	
	private List<MessageModel> messages;

	public Long getIdConv() {
		return idConv;
	}

	public void setIdConv(Long idConv) {
		this.idConv = idConv;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Integer getEtat() {
		return etat;
	}

	public void setEtat(Integer i) {
		this.etat = i;
	}

	public Long getIdCreator() {
		return idCreator;
	}

	public void setIdCreator(Long idCreator) {
		this.idCreator = idCreator;
	}

	public ArrayList<Long> getParts() {
		return parts;
	}

	public void setParts(ArrayList<Long> arrayList) {
		this.parts = arrayList;
	}

	public List<MessageModel> getMessages() {
		return messages;
	}

	public void setMessages(List<MessageModel> messages) {
		this.messages = messages;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	@Override
	public String toString() {
		return "ConversationModel [idConv=" + idConv + ", title=" + title + ", etat=" + etat + ", idCreator="
				+ idCreator + ", parts=" + parts + ", type=" + type + ", messages=" + messages + "]";
	}

	
	
}
