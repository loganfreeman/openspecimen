package com.krishagni.catissueplus.core.audit.services.impl;

import java.util.HashMap;
import java.util.Map;

import com.krishagni.catissueplus.core.audit.AuditService;
import com.krishagni.catissueplus.core.audit.events.AuditDetail;
import com.krishagni.catissueplus.core.audit.events.RequestAudit;
import com.krishagni.catissueplus.core.biospecimen.repository.DaoFactory;
import com.krishagni.catissueplus.core.common.PlusTransactional;
import com.krishagni.catissueplus.core.common.events.RequestEvent;
import com.krishagni.catissueplus.core.common.events.ResponseEvent;


public class AuditServiceImpl implements AuditService {
	private static final Map<String, String> ENTITY_AUDIT_TABLE_MAP = new HashMap<String, String>();
	
	static {
		ENTITY_AUDIT_TABLE_MAP.put("SPECIMEN", "catissue_specimen_aud");
		ENTITY_AUDIT_TABLE_MAP.put("SITE", "catissue_site_aud");
		ENTITY_AUDIT_TABLE_MAP.put("COLLECTIONPROTOCOLEVENT", "catissue_coll_prot_event_aud");
		ENTITY_AUDIT_TABLE_MAP.put("COLLECTIONPROTOCOLREGISTRATION", "catissue_coll_prot_reg_aud");
		ENTITY_AUDIT_TABLE_MAP.put("COLLECTIONPROTOCOL", "cat_collection_protocol_aud");
		ENTITY_AUDIT_TABLE_MAP.put("INSTITUTE", "catissue_institution_aud");
		ENTITY_AUDIT_TABLE_MAP.put("PARTICIPANT", "catissue_participant_aud");
		ENTITY_AUDIT_TABLE_MAP.put("STORAGECONTAINER", "os_storage_containers_aud");
		ENTITY_AUDIT_TABLE_MAP.put("USER", "catissue_user_aud");
		ENTITY_AUDIT_TABLE_MAP.put("VISIT", "cat_specimen_coll_group_aud");
	}
	
	private DaoFactory daoFactory;
	
	public void setDaoFactory(DaoFactory daoFactory) {
		this.daoFactory = daoFactory;
	}
	
	@Override
	@PlusTransactional
	public ResponseEvent<AuditDetail> getAuditDetail(RequestEvent<RequestAudit> req) {
		try {
			RequestAudit reqEntity = req.getPayload();
			String entityType = reqEntity.getEntityType();

			String auditTable = ENTITY_AUDIT_TABLE_MAP.get(entityType.toUpperCase());
			if (auditTable == null) {
				return ResponseEvent.userError(AuditErrorCode.TABLE_NOT_FOUND);
			}
			
			Long entityId = reqEntity.getEntityId();
			AuditDetail auditDetail = daoFactory.getAuditDao().getAuditDetail(auditTable, entityId);
			
			return ResponseEvent.response(auditDetail);
		} catch (Exception ex) {
			return ResponseEvent.serverError(ex);
		}
	}
}