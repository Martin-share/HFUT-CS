`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/08 21:36:49
// Design Name: 
// Module Name: Reg
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module Reg(
        input RegRead, RegWr, MemToReg,
        input [4:0] rs, rt, rd,
        input RegDes,
        input [31:0] DataALU, DataMem,
        output reg [31:0] Read1, Read2);
 
        reg [31:0] i_data;	 
        reg [4:0] temp;
        reg [31:0] register [0:31];                                               //32���Ĵ�����ÿ��32λ������$0��Ϊ0
        integer i;
        
    initial begin
        temp = 0;
        for (i = 0 ; i < 32; i = i+1) 
		      register[i] = 0;
		 register[20] = 52;               //Ϊ�˲�����Ҫ������ֵ
    end
    

    always @(RegRead or RegWr) begin
           if (RegRead) begin                                                                                                        
                    if(RegDes)begin                                                                 //i��ָ�rt��Ϊд�Ĵ�����Ŀ��
                        temp = rt;
                    end
                    else begin
                        temp = rd;
                    end
            Read1 = register[rs];                                               
            Read2 = register[rt]; 
            end    
                      
            if (RegWr) begin   
                    i_data = MemToReg? DataMem:DataALU;            //1��ȡDataMem�ģ�������������        
                    if (temp != 0) begin                             //$0�Ĵ�����Զ����0
                            register[temp] <= i_data;
                    end
            end
    end
 
endmodule
