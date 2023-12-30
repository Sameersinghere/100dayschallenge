module cache_memory(
    input wire clk,
    input wire reset,
    input wire enable,
    input wire write,
    input wire [3:0] address, // Assuming a 4-bit address for simplicity
    inout wire [7:0] data     // 8-bit data width
);

// Parameters for cache size
parameter CACHE_DEPTH = 16;
parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 4;

// Cache line structure: valid bit, tag, and data
typedef struct packed {
    bit valid;
    bit [ADDR_WIDTH-1:0] tag;
    bit [DATA_WIDTH-1:0] data;
} cache_line_t;

// Memory to represent the cache
cache_line_t cache[CACHE_DEPTH];

// Tag and index extraction from address
wire [ADDR_WIDTH-1:0] tag = address;
wire [ADDR_WIDTH-1:0] index = address;

// Cache hit logic
wire hit = cache[index].valid && (cache[index].tag == tag);

// Data output control
assign data = (enable && !write && hit) ? cache[index].data : 8'bz;

// Cache operation
always @(posedge clk) begin
    if (reset) begin
        // Invalidate all cache lines on reset
        for (int i = 0; i < CACHE_DEPTH; i++) begin
            cache[i].valid <= 0;
        end
    end
    else if (enable && write) begin
        // Write operation
        cache[index].valid <= 1'b1;
        cache[index].tag <= tag;
        cache[index].data <= data;
    end
end

endmodule
