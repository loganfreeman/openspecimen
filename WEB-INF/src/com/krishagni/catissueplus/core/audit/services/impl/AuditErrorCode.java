package com.krishagni.catissueplus.core.audit.services.impl;

import com.krishagni.catissueplus.core.common.errors.ErrorCode;


public enum AuditErrorCode implements ErrorCode {

	TABLE_NOT_FOUND;
	
	@Override
	public String code() {
		return "AUDIT_" + this.name();
	}

}
