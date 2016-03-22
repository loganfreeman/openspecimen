package com.krishagni.catissueplus.core.audit.events;


public class RequestRevisionEvent {
	private String entityType;

	private Long entityId;

	public String getEntityType() {
		return entityType;
	}

	public void setEntityType(String entityType) {
		this.entityType = entityType;
	}

	public Long getEntityId() {
		return entityId;
	}

	public void setEntityId(Long entityId) {
		this.entityId = entityId;
	}
}
