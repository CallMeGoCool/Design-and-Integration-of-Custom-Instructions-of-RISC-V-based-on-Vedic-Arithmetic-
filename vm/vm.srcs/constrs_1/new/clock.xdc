# Tell Vivado you have a clock named 'clk' with 10ns period (i.e., 100 MHz)
create_clock -name clk -period 10.000 [get_ports clk]
