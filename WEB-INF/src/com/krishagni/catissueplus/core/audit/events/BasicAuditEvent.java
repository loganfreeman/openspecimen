package com.krishagni.catissueplus.core.audit.events;

import java.text.SimpleDateFormat;
import java.util.Date;


public class BasicAuditEvent {

	private Long createdBy;

	private Date createdOn;

	private Long lastModifiedBy;

	private Date lastModifiedOn;
	
	private String createdOnTime;
	
	private String lastModifiedOnTime;

	public Long getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(Long createdBy) {
		this.createdBy = createdBy;
	}

	public Date getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(Date createdOn) {
		this.createdOn = createdOn;
	}

	public Long getLastModifiedBy() {
		return lastModifiedBy;
	}

	public void setLastModifiedBy(Long lastModifiedBy) {
		this.lastModifiedBy = lastModifiedBy;
	}

	public Date getLastModifiedOn() {
		return lastModifiedOn;
	}

	public void setLastModifiedOn(Date lastModifiedOn) {
		this.lastModifiedOn = lastModifiedOn;
	}
	
	public String getCreatedOnTime() {
		return createdOnTime;
	}

	public void setCreatedOnTime(String createdOnTime) {
		this.createdOnTime = createdOnTime;
	}

	public String getLastModifiedOnTime() {
		return lastModifiedOnTime;
	}

	public void setLastModifiedOnTime(String lastModifiedOnTime) {
		this.lastModifiedOnTime = lastModifiedOnTime;
	}

	public static BasicAuditEvent ok (Long createdBy, Date createdOn, Long lastModifiedBy, Date lastModifiedOn) {
		BasicAuditEvent resp = new BasicAuditEvent();
		resp.setCreatedBy(createdBy);
		resp.setCreatedOn(createdOn);
		resp.setLastModifiedBy(lastModifiedBy);
		resp.setLastModifiedOn(lastModifiedOn);
		resp.setCreatedOnTime(setupTime(createdOn));
		resp.setLastModifiedOnTime(setupTime(lastModifiedOn));
		return resp;
	}
	
	private static String setupTime(Date time){
		if (time == null ) {
			return null;
		}
		StringBuilder temp = new StringBuilder();
		temp.append(new SimpleDateFormat("dd MMM yyyy HH:mm a").format(time.getTime()));
//		temp.append(CalendarUtils.getTimeZoneCstm(DateTimeZone.getDefault()));
		return temp.toString();
		
	}
}
