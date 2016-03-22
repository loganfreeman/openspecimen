
package com.krishagni.catissueplus.rest.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.krishagni.catissueplus.core.audit.AuditService;
import com.krishagni.catissueplus.core.audit.events.AuditDetail;
import com.krishagni.catissueplus.core.audit.events.RequestAudit;
import com.krishagni.catissueplus.core.common.events.RequestEvent;
import com.krishagni.catissueplus.core.common.events.ResponseEvent;

@Controller
@RequestMapping("/audit-detail")
public class AuditController {
	
	@Autowired
	private AuditService auditSvc;

	@RequestMapping(method = RequestMethod.GET)
	@ResponseStatus(HttpStatus.OK)
	@ResponseBody
	public Object getAuditDetail(
		@RequestParam(value="entityType", required=true)
		String entityType,
		
		@RequestParam(value="entityId", required=true) 
		Long entityId) {
			
		RequestAudit req = new RequestAudit();
		req.setEntityType(entityType);
		req.setEntityId(entityId);
		
		ResponseEvent<AuditDetail> resp = auditSvc.getAuditDetail(getRequest(req));
		resp.throwErrorIfUnsuccessful();
		
		return resp.getPayload();
	}
	
	private <T> RequestEvent<T> getRequest(T payload) {
		return new RequestEvent<T>(payload);
	}
}
