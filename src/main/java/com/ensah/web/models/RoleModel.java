package com.ensah.web.models;

import javax.validation.constraints.NotBlank;

public class RoleModel {
	private Long roleId;
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	private Long id;
	
	public Long getRoleId() {
		return roleId;
	}

	public void setRoleId(Long roleId) {
		this.roleId = roleId;
	}

	@Override
	public String toString() {
		return "RoleModel [roleId=" + roleId + ", id=" + id + "]";
	}

	
	
}
