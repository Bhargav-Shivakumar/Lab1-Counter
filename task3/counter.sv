module counter #(
  parameter WIDTH = 8
)(
  // interface signals
  input  logic             clk,      // clock
  input  logic             rst,      // reset
  input  logic             ld,       // load counter from data
  input  logic [WIDTH-1:0] v,        // value to preload
  output logic [WIDTH-1:0] count     // count output
);

always_ff @ (posedge clk)
    
    if (rst) count <= {WIDTH{1'b0}};
    // Step 1: Loadable counter
    //else count <= ld ? v : count + {{WIDTH-1{1'b0}},1'b1}; //if ld is true then count = v, if false - increment by 1
    // Step 2: Single Stepping
    else if (ld) count <= count + v;
endmodule
