`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/10 16:55:13
// Design Name: 
// Module Name: ALU
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


module ALU(
            input [31:0] Read1, Read2, imm,                                                         //imm��Ҫ������չ
            input ALUSrcA,
            input ALUSrcB,
            input [4:0] sa,                          
            input [3:0] ALUOp,
            output wire bcon,
            output reg [31:0] result);
	 
	 initial begin
        result = 0;
    end
 
    wire [31:0] A;
    wire [31:0] B;
    
    assign A[31:0] = ALUSrcA? sa[4:0] : Read1[31:0];                         //Ϊ1���͸�sa����ȻsaΪ5λ�����������
    assign B[31:0] = ALUSrcB? imm[31:0] : Read2[31:0];
    assign bcon = (result? 0 : 1);                                //������ָ֧��ʱ��Ч�������жϽ����result=0����������ȣ�bcon=1
	 //ALU�ļ��㲻�ǿ�CLK�������ģ�������ALU��A��B֮ǰ�ټӸ������ӳ���ͬ��ʱ���ź�
	 //A��B����wire�ͣ�������һ��֮�󲻻ᱣ��ԭ�����źţ�����һ���Ե�
	always @(A or B) begin                                                                                                                                                                            
        case(ALUOp)                                            //��CU����ִ��ʲô���͵Ĳ������ӡ�������λ�ȣ�������Ӧ���źŴ���ALUִ��
            4'b0000: result = A + B;                     //func�����Ҳ��CU�жϣ�ALUֻ�ܽ�������
            4'b0001: result = A - B;  
            4'b0010: result = A | B;  
            4'b0011: result = A & B;          
            4'b0100: result = A^B;                      //���
            4'b0101: result = ~(A | B);                 //nor
            4'b0110: result = A << B;                  //sll, zero-extend
            4'b0111: result = A >> B;                  //srl
            4'b1000: result = (A < B ? 1 : 0);       //slt
        default: result = 0;
    endcase
    end
	 
endmodule


