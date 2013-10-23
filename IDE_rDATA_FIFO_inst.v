IDE_rDATA_FIFO	IDE_rDATA_FIFO_inst (
	.aclr ( aclr_sig ),
	.clock ( clock_sig ),
	.data ( data_sig ),
	.rdreq ( rdreq_sig ),
	.wrreq ( wrreq_sig ),
	.almost_empty ( almost_empty_sig ),
	.empty ( empty_sig ),
	.q ( q_sig ),
	.usedw ( usedw_sig )
	);
