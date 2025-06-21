//-----------------------------------------------------Design file for a 8-bit dual-port RAM----------------------------------//
//------------------------------------------------------------AUTHOR: Karthik NS----------------------------------------------// 
//------------------------------------------------------------DATE: June 21, 2025---------------------------------------------//
module dual_port_8bRAM(clk,wr_enA,wr_enB,addr_A,addr_B,wr_dataA,wr_dataB,rd_dataA,rd_dataB);
      input clk;
      input wr_enA, wr_enB;
      input [3:0] addr_A, addr_B;
      input [7:0] wr_dataA, wr_dataB;
      output reg [7:0] rd_dataA, rd_dataB;
      reg [7:0] mem [0:15];
      //Always block for port-A
      //During read-write conflict, reading the old contents from the memory has been prioritized
      always @(posedge clk)
            begin
            rd_dataA <= mem[addr_A];
            if(wr_enA)
              mem[addr_A] <= wr_dataA;
            end
      //Always block for port-B
      always @(posedge clk)
            begin
            rd_dataB <= mem[addr_B];
            if(wr_enB && !(wr_enA && addr_A == addr_B)) //To supress port-B,prioritizing port-A, during write-write conflict
              begin
              mem[addr_B] <= wr_dataB;
              end
            end
endmodule
