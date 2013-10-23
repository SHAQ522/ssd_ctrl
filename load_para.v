// load_para.v

// This file was auto-generated as part of a SOPC Builder generate operation.
// If you edit it your changes will probably be lost.

module load_para (
		input  wire        clk,                 // clock_reset.clk
		input  wire        in_avs_chipselect_n, //      in_avs.chipselect_n
		input  wire        in_avs_write_n,      //            .write_n
		input  wire        in_avs_read_n,       //            .read_n
		input  wire [8:0]  in_avs_address,      //            .address
		input  wire [31:0] in_avs_writedata,    //            .writedata
		output wire [31:0] in_avs_readdata,     //            .readdata
		output wire        wr_n,                // conduit_end.export
		output wire        rd_n,                //            .export
		output wire [8:0]  addr,                //            .export
		output wire [31:0] wdata,               //            .export
		input  wire [31:0] rdata                //            .export
	);

	avalon_slave_export_v2 load_para (
		.clk                 (clk),                 // clock_reset.clk
		.in_avs_chipselect_n (in_avs_chipselect_n), //      in_avs.chipselect_n
		.in_avs_write_n      (in_avs_write_n),      //            .write_n
		.in_avs_read_n       (in_avs_read_n),       //            .read_n
		.in_avs_address      (in_avs_address),      //            .address
		.in_avs_writedata    (in_avs_writedata),    //            .writedata
		.in_avs_readdata     (in_avs_readdata),     //            .readdata
		.wr_n                (wr_n),                // conduit_end.export
		.rd_n                (rd_n),                //            .export
		.addr                (addr),                //            .export
		.wdata               (wdata),               //            .export
		.rdata               (rdata)                //            .export
	);

endmodule
