`timescale 1s/100ms  // Time unit is 1 nanosecond, precision is 1 picosecond

module traffic_light_controller_tb();
reg clk, rst, CR_vehicle_detect;
wire [11:0] lights;
wire [2:0] state;
wire [5:0] counter;

traffic_light_controller uut(clk,rst,CR_vehicle_detect,lights,state,counter);

initial
begin
    $dumpfile("traffic_waveform.vcd");
    $dumpvars(1);
    clk=1;
    forever #0.5 clk=~clk;
end

initial
begin
    rst = 1;
    CR_vehicle_detect = 1;
    # 5;
    rst=0;
    #112
    CR_vehicle_detect = 0;
	#78
    CR_vehicle_detect = 1;
    #84
    CR_vehicle_detect = 0;
    #163
    $finish();
end 
endmodule
