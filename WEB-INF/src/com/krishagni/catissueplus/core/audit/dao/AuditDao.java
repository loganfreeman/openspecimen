package com.krishagni.catissueplus.core.audit.dao;

import com.krishagni.catissueplus.core.audit.events.AuditDetail;
import com.krishagni.catissueplus.core.common.repository.Dao;


public interface AuditDao extends Dao<AuditDetail>{
	public AuditDetail getAuditDetail(String auditTable, Long entityId);
}
