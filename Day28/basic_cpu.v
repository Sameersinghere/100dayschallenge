module basic_cpu(
    input clk,
    input reset,
    output reg [7:0] program_counter,
    inout [7:0] data_bus,
    output [7:0] address_bus,
    output reg write_enable
);

// Instruction opcodes
localparam LD   = 2'b00; // Load instruction
localparam ST   = 2'b01; // Store instruction
localparam ADD  = 2'b10; // Add instruction
localparam BZ   = 2'b11; // Branch if zero instruction

// CPU registers
reg [7:0] register_A;
reg [7:0] register_B;
reg [7:0] instruction_register;
reg [7:0] memory_data_register;
reg [1:0] opcode;
reg [5:0] operand;

assign address_bus = operand; // For simplicity, the address is part of the operand
assign data_bus = (write_enable) ? register_A : 8'bz; // Tri-state bus

always @(posedge clk) begin
    if (reset) begin
        program_counter <= 0;
        register_A <= 0;
        register_B <= 0;
        instruction_register <= 0;
        memory_data_register <= 0;
        write_enable <= 0;
    end else begin
        // Fetch instruction
        instruction_register <= data_bus;
        opcode <= instruction_register[7:6];
        operand <= instruction_register[5:0];
        
        // Decode and execute
        case (opcode)
            LD: begin
                // Load operand into register A
                register_A <= data_bus;
            end
            ST: begin
                // Store register A into memory at operand address
                write_enable <= 1;
            end
            ADD: begin
                // Add operand to register A and store in register A
                register_A <= register_A + data_bus;
            end
            BZ: begin
                // Branch to operand if register A is zero
                if (register_A == 0) begin
                    program_counter <= operand;
                end
            end
        endcase
        // Increment program counter
        program_counter <= program_counter + 1;
        // Reset write enable
        write_enable <= 0;
    end
end

endmodule
