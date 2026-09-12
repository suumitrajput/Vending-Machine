module vending_machine(clk, rst, in, out, c);

    input clk, rst;
    input [1:0] in;
    
    output reg out;
    output reg [1:0] c;

    // States representing current amount
    parameter s0 = 2'b00;   // ₹0
    parameter s1 = 2'b01;   // ₹5
    parameter s2 = 2'b10;   // ₹10
    parameter s3 = 2'b11;   // ₹15

    reg [1:0] c_state, n_state;

    // Sequential block
    always @(posedge clk or negedge rst) begin
        if (!rst)
            c_state <= s0;
        else
            c_state <= n_state;
    end


    // Combinational block - Mealy FSM
    always @(*) begin

        // Default values
        n_state = c_state;
        out = 0;
        c = 2'b00;

        case (c_state)

            // Current amount = ₹0
            s0: begin
                if (in == 2'b00) begin
                    n_state = s0;
                end

                else if (in == 2'b01) begin
                    n_state = s1;      // ₹0 + ₹5
                end

                else if (in == 2'b10) begin
                    n_state = s2;      // ₹0 + ₹10
                end
            end


            // Current amount = ₹5
            s1: begin
                if (in == 2'b00) begin
                    n_state = s1;
                end

                else if (in == 2'b01) begin
                    n_state = s2;      // ₹5 + ₹5 = ₹10
                end

                else if (in == 2'b10) begin
                    n_state = s3;      // ₹5 + ₹10 = ₹15
                end
            end


            // Current amount = ₹10
            s2: begin
                if (in == 2'b00) begin
                    n_state = s2;
                end

                else if (in == 2'b01) begin
                    n_state = s3;      // ₹10 + ₹5 = ₹15
                end

                else if (in == 2'b10) begin
                    n_state = s0;      // ₹10 + ₹10 = ₹20
                    out = 1;           // DISPENSE
                end
            end


            // Current amount = ₹15
            s3: begin
                if (in == 2'b00) begin
                    n_state = s3;
                end

                else if (in == 2'b01) begin
                    n_state = s0;      // ₹15 + ₹5 = ₹20
                    out = 1;           // DISPENSE
                end

                else if (in == 2'b10) begin
                    n_state = s1;      // ₹15 + ₹10 = ₹25
                    out = 1;           // DISPENSE
                    c = 2'b01;         // ₹5 CHANGE
                end
            end


            default: begin
                n_state = s0;
                out = 0;
                c = 2'b00;
            end

        endcase

    end

endmodule
