package com.krishagni.catissueplus.core.audit.dao.impl;

import java.sql.Timestamp;
import java.util.List;

import com.krishagni.catissueplus.core.audit.dao.AuditDao;
import com.krishagni.catissueplus.core.audit.events.AuditDetail;
import com.krishagni.catissueplus.core.common.repository.AbstractDao;


public class AuditDaoImpl extends AbstractDao<AuditDetail> implements AuditDao{
	
	@Override
	@SuppressWarnings("unchecked")
	public AuditDetail getAuditDetail(String auditTable, Long entityId) {
		String sql = String.format(GET_COMMON_AUDIT_DETAIL_SQL, auditTable, auditTable);
		List<Object[]> rows = sessionFactory.getCurrentSession()
				.createSQLQuery(sql)
				.setLong("entityId", entityId)
				.list();

		return rows.isEmpty() ? null : getRevisionEntity(rows.iterator().next());
	}

	private AuditDetail getRevisionEntity(Object[] row) {
		AuditDetail detail = new AuditDetail();
		detail.setCreatedBy(String.valueOf(row[0]));
		detail.setCreatedOn(getTimeStamp(row[1]));
		detail.setLastModifiedBy(String.valueOf(row[2]));
		detail.setLastModifiedOn(getTimeStamp(row[3]));
		return detail;
	}

	private Long getTimeStamp(Object timestamp) {
		if(timestamp == null){
			return null;
		}
		return Timestamp.valueOf(String.valueOf(timestamp)).getTime();
	}

	private static final String GET_COMMON_AUDIT_DETAIL_SQL = 
			" select " + 
			"   creator.createdBy, creator.createdOn, modifier.modifiedBy, modifier.modifiedOn " +
			" from " +
			"   (select " +
			"      aud.identifier, concat(u.first_name, ' ', u.last_name) as createdBy, rev.revtstmp as createdOn " +
			"    from " +
			"      os_revisions rev " +  
      "      inner join %s aud on rev.rev = aud.rev " +
      "      inner join catissue_user u on u.identifier = rev.user_id " +
      "    where " +
      "      aud.identifier = :entityId and aud.revtype = 0) creator " +
      "   left join " + 
	    "   (select " +
      "      aud.identifier, concat(u.first_name, ' ', u.last_name) as modifiedBy, rev.revtstmp as modifiedOn " +
	    "    from " +
      "      os_revisions rev " +  
      "      inner join %s aud on rev.rev = aud.rev " + 
      "      inner join catissue_user u on u.identifier = rev.user_id " +
      "    where " +
      "      aud.identifier = :entityId and aud.revtype = 1 " +
      "    order by " +
      "      rev.revtstmp desc limit 1) modifier " +
      "   on creator.identifier = modifier.identifier ";

}
