module counter #(
    parameter WIDTH = 8
)(
    // interface signals
    input logic clk, //clock
    input logic rst, //reset
    input logic en, //counter enable
    output logic [WIDTH-1:0] count //count output
);

always_ff @ (posedge clk) // at each clk rising edge execute code below
    if (rst) count <= {WIDTH{1'b0}}; //if reset is high change all bits to 0
    //else count <= count + {{WIDTH-1{1'b0}}, en};
    //Challenge
    else if (en) count <= count + 1; //if enable is high count up
    else count <= count - 1; //if enable is low count down

endmodule
