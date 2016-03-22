package com.krishagni.catissueplus.core.audit.events;

import java.util.List;
import java.util.Map;


public class AuditDetail {

	private String createdBy;
	
	private Long createdOn;
	
	private String lastModifiedBy;
	
	private Long lastModifiedOn;
	
	private List<Map<String, Object>> modifiedAttrs;
	
	public String getCreatedBy() {
		return createdBy;
	}
	
	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}

	public String getLastModifiedBy() {
		return lastModifiedBy;
	}
	
	public void setLastModifiedBy(String lastModifiedBy) {
		this.lastModifiedBy = lastModifiedBy;
	}
	
	public Long getCreatedOn() {
		return createdOn;
	}
	
	public void setCreatedOn(Long createdOn) {
		this.createdOn = createdOn;
	}
	
	public Long getLastModifiedOn() {
		return lastModifiedOn;
	}

	public void setLastModifiedOn(Long lastModifiedOn) {
		this.lastModifiedOn = lastModifiedOn;
	}

	public List<Map<String, Object>> getModifiedAttrs() {
		return modifiedAttrs;
	}
	
	public void setModifiedAttrs(List<Map<String, Object>> modifiedAttrs) {
		this.modifiedAttrs = modifiedAttrs;
	}
	
}
