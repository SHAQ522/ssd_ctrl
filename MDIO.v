module MDIO(mdio_in,mdio_out,mdio_oen,mdio);
inout mdio;
output mdio_in;
input mdio_out,mdio_oen;
assign mdio_in=mdio;
assign mdio=(mdio_oen==1'b0)? mdio_out : 1'bz;  
endmodule         
