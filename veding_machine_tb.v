// Code your testbench here
// or browse Examples
`timescale 1ns/1ps

module vending_machine_tb;

    reg clk;
    reg rst;
    reg [1:0] in;

    wire out;
    wire [1:0] c;


    // Instantiate Design Under Test (DUT)

    vending_machine dut (
        .clk(clk),
        .rst(rst),
        .in(in),
        .out(out),
        .c(c)
    );


    // Clock Generation

    always #5 clk = ~clk;


    // Stimulus

    initial begin

        // Initialize signals
        clk = 0;
        rst = 0;
        in  = 2'b00;

        // Dump waveform
        $dumpfile("vending_machine.vcd");
        $dumpvars(0, vending_machine_tb);


        // Apply Reset
        #10;
        rst = 1;


        // -----------------------------------
        // TEST CASE 1
        // ₹5 + ₹5 + ₹10 = ₹20
        // -----------------------------------

        #10;
        in = 2'b01;      // ₹5

        #10;
        in = 2'b01;      // ₹5

        #10;
        in = 2'b10;      // ₹10 -> DISPENSE

        #10;
        in = 2'b00;


        // -----------------------------------
        // TEST CASE 2
        // ₹10 + ₹10 = ₹20
        // -----------------------------------

        #10;
        in = 2'b10;      // ₹10

        #10;
        in = 2'b10;      // ₹10 -> DISPENSE

        #10;
        in = 2'b00;


        // -----------------------------------
        // TEST CASE 3
        // ₹5 + ₹10 + ₹5 = ₹20
        // -----------------------------------

        #10;
        in = 2'b01;      // ₹5

        #10;
        in = 2'b10;      // ₹10

        #10;
        in = 2'b01;      // ₹5 -> DISPENSE

        #10;
        in = 2'b00;


        // -----------------------------------
        // TEST CASE 4
        // ₹5 + ₹10 + ₹10 = ₹25
        // DISPENSE + ₹5 CHANGE
        // -----------------------------------

        #10;
        in = 2'b01;      // ₹5

        #10;
        in = 2'b10;      // ₹10

        #10;
        in = 2'b10;      // ₹10 -> DISPENSE + CHANGE

        #10;
        in = 2'b00;


        // Finish Simulation

        #20;

        $finish;

    end


    // Monitor values

    initial begin

        $monitor(
            "Time=%0t | rst=%b | in=%b | state=%b | out=%b | change=%b",
            $time,
            rst,
            in,
            dut.c_state,
            out,
            c
        );

    end


endmodule
