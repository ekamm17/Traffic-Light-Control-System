module traffic_light_controller (
    input wire clk,
    input wire rst,
    input wire CR_vehicle_detect,
  	output reg [11:0] lights,
    output reg [2:0] state,
    output reg [5:0] counter
);

// State encoding
localparam [2:0] STATE0 = 3'b000;
localparam [2:0] STATE1 = 3'b001;
localparam [2:0] STATE2 = 3'b010;
localparam [2:0] STATE3 = 3'b011;
localparam [2:0] STATE4 = 3'b100;
localparam [2:0] STATE5 = 3'b101;
localparam [2:0] STATE6 = 3'b110;


// Traffic light configurations for each state
localparam [11:0] LIGHTS_STATE0 = 12'b1010_0011_1000;
localparam [11:0] LIGHTS_STATE1 = 12'b0100_0101_1000;
localparam [11:0] LIGHTS_STATE2 = 12'b1000_1001_0011;
localparam [11:0] LIGHTS_STATE3 = 12'b1000_0101_0100;
localparam [11:0] LIGHTS_STATE4 = 12'b0011_1000_1010;
localparam [11:0] LIGHTS_STATE5 = 12'b1000_1000_0110;
localparam [11:0] LIGHTS_STATE6 = 12'b0110_0100_1000;


// Time counts for each state
localparam [5:0] TIME_STATE0 = 6'b111111;
localparam [5:0] TIME_STATE1 = 6'b000011;
localparam [5:0] TIME_STATE2 = 6'b001111;
localparam [5:0] TIME_STATE3 = 6'b000011;
localparam [5:0] TIME_STATE4 = 6'b010011;
localparam [5:0] TIME_STATE5 = 6'b000011;
localparam [5:0] TIME_STATE6 = 6'b000011;

// Named bits for lights
wire HW1_R = lights[0];
wire HW1_Y = lights[1];
wire HW1_GS = lights[2];
wire HW1_GR = lights[3];
wire HW2_R = lights[4];
wire HW2_Y = lights[5];
wire HW2_GS = lights[6];
wire HW2_GL = lights[7];
wire CR_R = lights[8];
wire CR_Y = lights[9];
wire CR_GL = lights[10];
wire CR_GR = lights[11];
  
always @(posedge clk or posedge rst) begin
    if (rst) 
        begin
        state <= STATE0;
        counter <= 6'b000000;
        lights <= LIGHTS_STATE0;
    	end 
  	else 
      	begin
        counter <= counter + 1;
        case (state)
            STATE0:
            begin
                if (counter >= TIME_STATE0)
                	begin
                        counter <= 6'b000000;
                        if (CR_vehicle_detect)
                            begin
                            state <= STATE1;
                            lights <= LIGHTS_STATE1;
                            end
                        else
                            begin
                            state <= STATE6;
                            lights <= LIGHTS_STATE6;
                            end
            		end
            end
          
            STATE1:
            begin
            	if (counter >= TIME_STATE1)
                	begin
                    counter <= 6'b000000;
                    state <= STATE2;
                    lights <= LIGHTS_STATE2;
                    end
            end
                    	
            STATE2:
            begin
            if (counter >= TIME_STATE2)
                	begin
                    counter <= 6'b000000;
                    state <= STATE3;
                    lights <= LIGHTS_STATE3;
                    end
            end
          
            STATE3:
            begin
            if (counter >= TIME_STATE3)
                	begin
                    counter <= 6'b000000;
                    state <= STATE4;
                    lights <= LIGHTS_STATE4;
                    end
            end
          
            STATE4:
            begin
              if (counter >= TIME_STATE4)
                	begin
                    counter <= 6'b000000;
                    state <= STATE5;
                    lights <= LIGHTS_STATE5;
                    end
            end
          
            STATE5:
            begin
              if (counter >= TIME_STATE5)
                	begin
                    counter <= 6'b000000;
                    state <= STATE0;
                    lights <= LIGHTS_STATE0;
                    end
            end
          
            STATE6:
                begin
                if (counter >= TIME_STATE6)
                	begin
                    counter <= 6'b00000;
                    state <= STATE4;
                    lights <= LIGHTS_STATE4;
                    end
                end
          
            default: 
                begin
                state <= STATE0;
                counter <= 6'b00000;
                lights <= LIGHTS_STATE0;
                end
        endcase
    end
end
endmodule