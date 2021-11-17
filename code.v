//Implement MIPS processor that performs and, or, add, subtract operations in verilog. 
//Simulate the output across 4 clock cycles each cycle for 1 operation.
//Mips processor R-type

module ClockGen (clock);
output reg clock;

initial
clock = 0;
always
#5 
clock = ~clock;
endmodule


module CPU (clock); 
input clock; 

reg[31:0] PC;
reg [31:0] Regs[0:31];  //regFile
reg [31:0] IMemory[0:1023];
reg[31:0] IR;  //instruction
reg[31:0] ALUOut;  

wire [4:0] rs, rt,rd; 
wire [31:0] Ain, Bin; 
wire [5:0] op;

assign rs = IR[25:21]; 
assign rt = IR[20:16]; 
assign op = IR[31:26];
assign rd = IR[15:11];

initial 
begin 
ALUOut=32'b00000000000000000000000000000000;
PC=32'b00000000000000000000000000000000;
IMemory[0] = 32'b 000000_00111_00001_00011_00000_100000;
IMemory[1] = 32'b 000000_00111_00001_00011_00000_100010;
IMemory[2] = 32'b 000000_00111_00001_00011_00000_100100;
IMemory[3] = 32'b 000000_00111_00001_00011_00000_100101;

end 
assign Ain[31:0]=rs;
assign Bin[31:0]=rt;

always @ (posedge clock) 

begin 
IR <= IMemory[PC>>2];
PC <= PC + 4; 

if (op == 6'b000000) 
case (IR[5:0])

32 : ALUOut = Ain + Bin;   //add
34 : ALUOut = Ain - Bin;   //sub
36 : ALUOut = Ain & Bin;   //and
37 : ALUOut = Ain | Bin;   //or
endcase
Regs[rd]=ALUOut;

end
endmodule

module tb_cpu();

wire clock;
ClockGen habiba(clock);
CPU habibaa(clock); 
endmodule
