package com.krishagni.catissueplus.core.audit.services;

import com.krishagni.catissueplus.core.audit.domain.UserApiCallLog;


public interface ApiAuditService {

	public void insertApiCallLog(UserApiCallLog userAuditLog);
	
	public long getTimeSinceLastApiCall(Long userId, String token);
}
