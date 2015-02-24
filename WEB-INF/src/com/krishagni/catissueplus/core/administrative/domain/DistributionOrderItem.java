package com.krishagni.catissueplus.core.administrative.domain;

import com.krishagni.catissueplus.core.administrative.domain.DistributionOrder.DistributionStatus;
import com.krishagni.catissueplus.core.biospecimen.domain.BaseEntity;
import com.krishagni.catissueplus.core.biospecimen.domain.Specimen;

public class DistributionOrderItem extends BaseEntity {
	private DistributionOrder order;
	
	private Double quantity;
	
	private Specimen specimen;

	public DistributionOrder getOrder() {
		return order;
	}

	public void setOrder(DistributionOrder order) {
		this.order = order;
	}

	public Double getQuantity() {
		return quantity;
	}

	public void setQuantity(Double quantity) {
		this.quantity = quantity;
	}

	public Specimen getSpecimen() {
		return specimen;
	}

	public void setSpecimen(Specimen specimen) {
		this.specimen = specimen;
	}
	
	public void distribute() {
		boolean closeAfterDistribution = getOrder().getStatus().equals(DistributionStatus.DISTRIBUTED_AND_CLOSED);
		specimen.distribute(quantity, closeAfterDistribution);
	}
}
