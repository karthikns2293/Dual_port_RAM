//T---------------------------------Test-bench for the 8-bit dual-port RAM--------------------------------//
//--------------------------------------------AUTHOR: Karthik N S----------------------------------------//
//--------------------------------------------DATE: 21st June, 2025--------------------------------------//

`timescale 1ns/1ps
module dual_port_tb;
       reg wr_enA, wr_enB,clk;
       reg [3:0] addr_A, addr_B;
       reg [7:0] wr_dataA, wr_dataB;
       wire [7:0] rd_dataA, rd_dataB;
       
       //Module Instantiation
       
       dual_port_8bRAM dut(.wr_enA(wr_enA),
                           .wr_enB(wr_enB),
                           .clk(clk),
                           .addr_A(addr_A),
                           .addr_B(addr_B),
                           .wr_dataA(wr_dataA),
                           .wr_dataB(wr_dataB),
                           .rd_dataA(rd_dataA),
                           .rd_dataB(rd_dataB));
                           
        //Clock generation (10ns Time Period)
        always #5 clk = ~clk; 
        
        //Generation of stimulus
        initial begin
        //Initialize 
        wr_enA = 0; wr_enB = 0; clk = 0;
        addr_A = 0; addr_B = 0;
        wr_dataA = 0; wr_dataB = 0; 
        
        //Writing into separate addresses by both ports
        #10
        wr_enA = 1; 
        addr_A = 4'h3;
        wr_dataA = 8'hAA;
        
        #10
        wr_enB = 1;
        addr_B = 4'h5;
        wr_dataB = 8'hBB;
        
        //Reading from separate addresses by both ports
        #10
        wr_enA = 0; wr_enB = 0;
        addr_A = 4'h3; addr_B = 4'h5;
        
        //Write-write conflict test case
        #10
        wr_enA = 1; wr_enB = 1;
        addr_A = 4'h8; addr_B = 4'h8;
        wr_dataA = 8'hCC; wr_dataB = 8'hDD;
        //Read from address 8 to see if port A won (expected)
        #10
        wr_enA = 0; wr_enB = 0;
        addr_A = 4'h8;
        
        //Read_write conflict test case (Port A is trying to read, while port B is writing into the same address)
        #10
        wr_enA = 0; wr_enB = 1;
        addr_A = 4'h8; addr_B = 4'h8;
        wr_dataB = 8'hEE;
        
        #10 $finish;
        end
        
        //Capturing the responses
        initial begin
        $monitor("Time = %0t, clk = %b, wr_enA = %b, wr_enB = %b, addr_A = %h, addr_B = %h, wr_dataA = %h, wr_dataB = %h,rd_dataA = %h, rd_dataB = %h",$time,clk, wr_enA,wr_enB, addr_A, addr_B, wr_dataA, wr_dataB, rd_dataA, rd_dataB);
        end
        
        //Simulation
        initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, dual_port_tb);
        end
endmodule
        
       
       
