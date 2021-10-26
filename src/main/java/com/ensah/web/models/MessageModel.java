package com.ensah.web.models;

import java.util.Date;

public class MessageModel {
	
	private Long idMess;
	
	private Long idSender;
	
	private String content;
	
	private Date time;
	
	private String senderName;
	
	private boolean ownership;

	public Long getIdMess() {
		return idMess;
	}

	public void setIdMess(Long idMess) {
		this.idMess = idMess;
	}

	public Long getIdSender() {
		return idSender;
	}

	public void setIdSender(Long idSender) {
		this.idSender = idSender;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public String getSenderName() {
		return senderName;
	}

	public void setSenderName(String senderName) {
		this.senderName = senderName;
	}

	public boolean isOwnership() {
		return ownership;
	}

	public void setOwnership(boolean ownership) {
		this.ownership = ownership;
	}

	@Override
	public String toString() {
		return "MessageModel [idMess=" + idMess + ", idSender=" + idSender + ", content=" + content + ", time=" + time
				+ ", senderName=" + senderName + ", ownership=" + ownership + "]";
	}

	
	
}
