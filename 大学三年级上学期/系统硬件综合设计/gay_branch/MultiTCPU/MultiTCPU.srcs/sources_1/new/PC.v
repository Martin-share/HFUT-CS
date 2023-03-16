`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/08 21:06:24
// Design Name: 
// Module Name: PC
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
module PC(
    input res,
    input PCWre,
    input [1:0] PCSrc,
    input [31:0] addr,
    input [31:0] imm,
    input [31:0] Reg,
    output reg [31:0] pc1);                   //��ǰ��PC

    reg [31:0] nextPC;

    initial begin
        pc1 <= 0;
        nextPC <= 0;                     //��һ��ָ��δ֪����һ��PC��֪����ôȡ��������Ϊ0
    end
    
    always @(PCWre) begin
            if (res)  pc1 = 0;               //resΪ1Ҫ����    
            else if (PCWre) begin
                pc1 = nextPC;
            end
        end

    always @(PCSrc or imm or addr or Reg) begin         //������תҲ���м����ź�,��ͬ��ָ��
         case(PCSrc)    //imm��addr��reg������һ���ᷢ���仯������������PC+4Ҳ�ܹ���
                   2'b00: nextPC = pc1 + 4;
                   2'b01: nextPC = pc1 + 4 + imm * 4;                //���ԼĴ����ĵ�ַ
                   2'b10: nextPC = Reg;                           //jump��������ת
                   2'b11: nextPC = addr;
          endcase
    end
    
endmodule
