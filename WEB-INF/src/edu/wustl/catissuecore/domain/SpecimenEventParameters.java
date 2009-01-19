/**
 * <p>Title: SpecimenEventParameters Class>
 * <p>Description:  Attributes associated with a specific specimen event. </p>
 * Copyright:    Copyright (c) year
 * Company: Washington University, School of Medicine, St. Louis.
 * @author Aniruddha Phadnis
 * @version 1.00
 * Created on Apr 7, 2005
 */

package edu.wustl.catissuecore.domain;

import java.text.ParseException;
import java.util.Calendar;
import java.util.Date;
import edu.wustl.catissuecore.actionForm.EventParametersForm;
import edu.wustl.catissuecore.actionForm.SpecimenEventParametersForm;
import edu.wustl.catissuecore.util.SearchUtil;
import edu.wustl.common.actionForm.AbstractActionForm;
import edu.wustl.common.actionForm.IValueObject;
import edu.wustl.common.domain.AbstractDomainObject;
import edu.wustl.common.exception.AssignDataException;
import edu.wustl.common.util.Utility;
import edu.wustl.common.util.logger.Logger;

/**
 * Attributes associated with a specific specimen event.
 * @hibernate.class table="CATISSUE_SPECIMEN_EVENT_PARAM"
 * @author aniruddha_phadnis
 */
public abstract class SpecimenEventParameters extends AbstractDomainObject
	implements java.io.Serializable, Cloneable
{
	/**
	 * logger Logger - Generic logger.
	 */
	private static org.apache.log4j.Logger logger = Logger.getLogger(SpecimenEventParameters.class);

	/**
	 * Serial Version ID.
	 */
	private static final long serialVersionUID = 1234567890L;

	/**
	 * System generated unique id.
	 */
	protected Long id;

	/**
	 * Date and time of the event.
	 */
	protected Date timestamp;

	/**
	 * User who performs the event.
	 */
	protected User user;

	/**
	 * Text comment on event.
	 */
	protected String comment;

	/**
	 * Object of AbstractSpecimen.
	 */
	protected AbstractSpecimen specimen;
	/**
	 * Name : Ashish Gupta.
	 * Reviewer Name : Sachin Lale.
	 * Bug ID: 2741
	 * Patch ID: 2741_5
	 * Description: Many to 1 association between SpecimenEventParameters and SCG.
	*/
	protected SpecimenCollectionGroup specimenCollectionGroup;

	/**
	 * Get Timestamp.
	 * @return Date object.
	 */
	public Date getTimestamp()
	{
		return timestamp;
	}

	/**
	 * Set Timestamp.
	 * @param timestamp of Date type.
	 */
	public void setTimestamp(Date timestamp)
	{
		this.timestamp = timestamp;
	}

	/**
	 * Get User.
	 * @return User.
	 */
	public User getUser()
	{
		return user;
	}

	/**
	 * Set User.
	 * @param user User.
	 */
	public void setUser(User user)
	{
		this.user = user;
	}

	/**
	 * Get Comment.
	 * @return String.
	 */
	public String getComment()
	{
		return comment;
	}

	/**
	 * Set Comment.
	 * @param comment as String.
	 */
	public void setComment(String comment)
	{
		this.comment = comment;
	}

	/**
	 * set identifier.
	 * @param identifier Long type.
	 */
	public void setId(Long identifier)
	{
		this.id = identifier;
	}

	/**
	 * Returns System generated unique id.
	 * @return System generated unique id.
	 * @see #setId(Integer)
	 * @hibernate.id name="id" column="IDENTIFIER" type="long" length="30"
	 * unsaved-value="null" generator-class="native"
	 * @hibernate.generator-param name="sequence" value="CATISSUE_SPEC_EVENT_PARAM_SEQ"
	 */
	public Long getId()
	{
		return id;
	}

	/**
	 * @return the specimenCollectionGroup
	 * @hibernate.many-to-one column="SPECIMEN_COLL_GRP_ID"
	 * class="edu.wustl.catissuecore.domain.SpecimenCollectionGroup"
	 */
	public SpecimenCollectionGroup getSpecimenCollectionGroup()
	{
		return specimenCollectionGroup;
	}

	/**
	 * @param specimenCollectionGroup the specimenCollectionGroup to set
	 */
	public void setSpecimenCollectionGroup(SpecimenCollectionGroup specimenCollectionGroup)
	{
		this.specimenCollectionGroup = specimenCollectionGroup;
	}

	/**
	 * @hibernate.many-to-one column="SPECIMEN_ID" class="edu.wustl.catissuecore.domain.Specimen"
	 * constrained="true"
	 * @see #setParticipant(Site)
	 * @return AbstractSpecimen object.
	 */
	public AbstractSpecimen getSpecimen()
	{
		return specimen;
	}

	/**
	 * @param specimen The specimen to set.
	 */
	public void setSpecimen(AbstractSpecimen specimen)
	{
		this.specimen = specimen;
	}

	/* (non-Javadoc)
	 * @see edu.wustl.catissuecore.domain.EventParameters#setAllValues(
	 * edu.wustl.catissuecore.actionForm.AbstractActionForm)
	 */
	/**
	 * Set All Values of the form.
	 * @param valueObject of IValueObject type.
	 * @throws AssignDataException AssignDataException.
	 */
	public void setAllValues(IValueObject valueObject) throws AssignDataException
	{
		AbstractActionForm abstractForm = (AbstractActionForm) valueObject;
		EventParametersForm form = (EventParametersForm) abstractForm;
		if (SearchUtil.isNullobject(user))
		{
			user = new User();
		}
		if (SearchUtil.isNullobject(timestamp))
		{
			timestamp = Calendar.getInstance().getTime();
		}
		this.comment = form.getComments();
		user.setId(Long.valueOf(form.getUserId()));
		if (form.getDateOfEvent() != null && form.getDateOfEvent().trim().length() != 0)
		{
			setDateTimeFromCalender(form);
		}
		if (abstractForm.isAddOperation())
		{
			specimen = new Specimen();
		}
		SpecimenEventParametersForm specimenEventParametersForm =
			(SpecimenEventParametersForm) abstractForm;
		logger.debug("specimenEventParametersForm.getSpecimenId()" +
			"............................." + specimenEventParametersForm.getSpecimenId());
		if (specimen != null)
		{
			specimen.setId(Long.valueOf(specimenEventParametersForm.getSpecimenId()));
		}
	}

	/**
	 * @param form EventParametersForm.
	 * @throws AssignDataException AssignDataException.
	 */
	private void setDateTimeFromCalender(EventParametersForm form) throws AssignDataException
	{
		Calendar calendar = Calendar.getInstance();
		Date date;
		try
		{
			date = Utility.parseDate(form.getDateOfEvent(),
					Utility.datePattern(form.getDateOfEvent()));
			calendar.setTime(date);
			this.timestamp = calendar.getTime();
			calendar.set(Calendar.HOUR_OF_DAY, Integer.parseInt(form.getTimeInHours()));
			calendar.set(Calendar.MINUTE, Integer.parseInt(form.getTimeInMinutes()));
			this.timestamp = calendar.getTime();
		}
		catch (ParseException e)
		{
			throw new AssignDataException(e);
		}
	}

	/**
	 * Create Clone.
	 * @return Object of specimen event parameter type.
	 * @throws CloneNotSupportedException CloneNotSupportedException.
	 */
	public Object clone() throws CloneNotSupportedException
	{
		return super.clone();
	}

	/**
	* Returns message label to display on success add or edit.
	* @return String.
	*/
	public String getMessageLabel()
	{
		return "specimen with label '" + getSpecimen().getLabel() + "'";
	}
}