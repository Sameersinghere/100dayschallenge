module testbench;
    // Testbench variables
    reg [31:0] a, b;
    wire [31:0] result;

    // Instantiate the floating-point adder
    floating_point_adder fpa (
        .a(a),.b(b),.result(result));
  // Testbench initial block
initial begin
    // Initialize inputs
    a = 32'b0; b = 32'b0;
    #10;

    // Test Case 1: Add two positive numbers
    a = 32'h3f800000; // 1.0 in IEEE 754 format
    b = 32'h40000000; // 2.0 in IEEE 754 format
    #10;

    // Test Case 2: Add a positive and a negative number
    a = 32'hbf800000; // -1.0 in IEEE 754 format
    b = 32'h3f800000; // 1.0 in IEEE 754 format
    #10;

    // Test Case 3: Add two negative numbers
    a = 32'hbf800000; // -1.0 in IEEE 754 format
    b = 32'hbf800000; // -1.0 in IEEE 754 format
    #10;

    // Additional test cases can be added here

    // End simulation
    $finish;
end

// Monitor changes
initial begin
    $monitor("Time = %d : a = %h, b = %h, result = %h", $time, a, b, result);
end
