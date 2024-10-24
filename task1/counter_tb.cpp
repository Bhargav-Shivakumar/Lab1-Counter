#include "Vcounter.h"
#include "verilated.h"
#include "verilated_vcd_c.h"


int main(int argc, char **argv, char **env){
    int i;
    int clk;

    Verilated::commandArgs(argc, argv);
    //init top verilog instance
    Vcounter* top = new Vcounter;
    //init trace dump
    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace (tfp, 99);
    tfp->open ("counter.vcd");

    //initilaze simulation inputs
    top->clk = 1;
    top->rst = 1;
    top->en = 0;

    //run simulation for many clock 
    for(i = 0; i < 300; i++){

        //dump variables into VCD file and toggle clock
        for(clk = 0; clk < 2; clk++){
            tfp->dump(2*i+clk);         //dumping trace for both rising and falling edges
            top->clk = !top->clk;
            top->eval();
        }
        //Challenge
        // stop counting for 3 cycles at when count reaches 9
        if(top->count == 10){
            for(int j = 0; j < 2; j++){
                i++;
            }
        }
        //when clock is less than 2 or at 15 reset
        top->rst = (i < 2) | (i == 15);
        top->en = (i > 4); // start counting when clock goes bigger than 4
        if(Verilated::gotFinish()) exit(0);
    }
    tfp->close();
    exit(0);
}