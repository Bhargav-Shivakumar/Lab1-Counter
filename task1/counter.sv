module counter #(
    parameter WIDTH = 8
)(
    // interface signals
    input logic clk, //clock
    input logic rst, //reset
    input logic en, //counter enable
    output logic [WIDTH-1:0] count //count output
);

//always_ff @ (posedge clk)
//Challenge
//adding asynchrous reset
always_ff @ (posedge clk, posedge reset) //at reset positive edge execute code below
    if (rst) count <= {WIDTH{1'b0}}; //if reset is high change all bits to 0
    else count <= count + {{WIDTH-1{1'b0}}, en}; // count takes the value of itself
                                                // + 1
                                                //all bits are 0 except LSB which is the value of enable
                                                //if high it adds 1, if low stays the same

endmodule
