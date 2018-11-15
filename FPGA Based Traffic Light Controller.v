module led(n1s,n1r,n2s,n2r,n2l,es,el,ws,wr,leda,ledb,ledc,ledd,lede,ledf,ledg,p1,p2,p3,p4,reset,clk,ir,b1);
output reg [0:2] n1s,n1r,n2s,n2r,n2l,es,el,ws,wr;   //Traffic lights
input reset,clk;
parameter [2:0]s1=3'b000,s2=3'b001,s3=3'b010,s4=3'b011,s5=3'b100,s6=3'b101,s7=3'b110,s8=3'b111;
reg [2:0]state;
parameter [28:0]delay10=5000000000, delay3=150000000;     //Counters for 10s and 3s delay
reg [28:0]count;
reg [31:0]count1;
reg [3:0]counter;
output leda,ledb,ledc,ledd,lede,ledf,ledg; //segments of seven segment display
reg [6:0] seg_data;
output reg p1,p2,p3,p4;   //Pedestrian switches
input ir, b1;             //sensor and pedestrian button

	always@(posedge clk or posedge reset)
 
	if(reset==1)                           //when reset is 1 the state is s1 and stays there until reset is 0
	 begin 
	     state<=s1;
		 count<=0;
	 end
	 
	else
	 begin
	       case(state)
		   s1: if(count<delay10)
					begin
						state<=s1;
						count<=count+1;
					end
				else
					begin
						state<=s2;
						count<=0;
					end
			s2: if(count<delay3)			//Delay for s2 is 3s
			    begin
						state<=s2;
						count<=count+1;
					end
				else
					begin
						state<=s3;
						count<=0;
					end
			s3: if(count<delay10)			//Delay for s3 is 10s
			    begin
						state<=s3;
						count<=count+1;
					end
				else
					begin
						state<=s4;
						count<=0;
					end
 			s4: if(count<delay3)			//Delay for s4 is 3s
			    begin
						state<=s4;
						count<=count+1;
					end
				else
					begin
						state<=s5;
						count<=0;
					end
			s5: if(count<delay3)			//Delay for s5 is 3s
			    begin
						state<=s5;
						count<=count+1;
					end
				else
					begin
						state<=s6;
						count<=0;
					end
	        s6: if(count<delay10)			// Delay for s6 is 10s
			    begin
						state<=s6;
						count<=count+1;
					end
				else
					begin
						state<=s7;
						count<=0;
					end
            s7: if(count<delay10)			// Delay for s7 is 10s
			    begin
						state<=s7;
						count<=count+1;
					end
				else
					begin
						state<=s8;
						count<=0;
					end
			s8: if(count<delay3)  			// Delay for s6 is 10s
			    begin
						state<=s8;
						count<=count+1;
					end
				else
					begin
						state<=s1;
						count<=0;
		      		end	
            default: state<=s1;
			endcase
		end	
	always@(*)
		begin
		case(state)
			s1: begin n1s<=3'b100; n1r<=3'b001; n2s<=3'b001; n2l<=3'b001; es<=3'b100; el<=3'b001; ws<=3'b100; wr<=3'b100; p1<=0;p2<=0;p3<=0;p4<=1; 
			if(b1==1 && ir==1) begin n1r<=3'b100;p1<=1;end end
			s2: begin n1s<=3'b100; n1r<=3'b010; n2s<=3'b001; n2l<=3'b010; es<=3'b100; el<=3'b010; ws<=3'b100; wr<=3'b100; p1<=0;p2<=0;p3<=0;p4<=1; end
			s3: begin n1s<=3'b001; n1r<=3'b100; n2s<=3'b001; n2l<=3'b100; es<=3'b100; el<=3'b100; ws<=3'b100; wr<=3'b100; p1<=0;p3<=0;p4<=1;p2<=1; end
			s4: begin n1s<=3'b001; n1r<=3'b100; n2s<=3'b010; n2l<=3'b100; es<=3'b100; el<=3'b100; ws<=3'b100; wr<=3'b001; p4<=1;p2<=1;p3<=1;p1<=0; end
			s5: begin n1s<=3'b010; n1r<=3'b100; n2s<=3'b100; n2l<=3'b100; es<=3'b100; el<=3'b100; ws<=3'b001; wr<=3'b001; p3<=1;p2<=1;p4<=0;p1<=0; end
			s6: begin n1s<=3'b100; n1r<=3'b100; n2s<=3'b100; n2l<=3'b100; es<=3'b001; el<=3'b100; ws<=3'b001; wr<=3'b010; p1<=1;p3<=1;p2<=0;p4<=0; end
			s7: begin n1s<=3'b100; n1r<=3'b100; n2s<=3'b100; n2l<=3'b100; es<=3'b001; el<=3'b100; ws<=3'b001; wr<=3'b100; p1<=1;p3<=1;p2<=0;p4<=0; end
			s8: begin n1s<=3'b100; n1r<=3'b100; n2s<=3'b100; n2l<=3'b100; es<=3'b010; el<=3'b100; ws<=3'b010; wr<=3'b100; p1<=1;p3<=1;p2<=0;p4<=0; end
		    default: begin n1s<=3'b100; n1r<=3'b001; n2s<=3'b001; n2l<=3'b001; es<=3'b100; el<=3'b001; ws<=3'b100; wr<=3'b100; p1<=0;p2<=0;p3<=0;p4<=1; end
		endcase
		end
	always @(posedge clk)
		begin
			if (reset ==1)
			begin
				count1<=27'd0;
				counter <= 4'b0;
			end  
			else if (count1==27'd50000000)
			begin
				count1 <=27'd0;
				if (counter < 9) counter <= counter +1;
				else  counter <= 0;
			end
			else
				count1<=count1+1;
    end
	always @(counter)							//Seven segment display
		case (counter)
		4'b0000:seg_data=7'b0000001;
		4'b0001:seg_data=7'b1001111;
		4'b0010:seg_data=7'b0010010;
		4'b0011:seg_data=7'b0000110;
		4'b0100:seg_data=7'b1001100;
		4'b0101:seg_data=7'b0100100;
		4'b0110:seg_data=7'b0100000;
		
		4'b0111:seg_data=7'b0001111;
		4'b1000:seg_data=7'b0000000;
		4'b1001:seg_data=7'b0001100;
		endcase
 
 
	assign ledg=seg_data[0];
	assign ledf=seg_data[1];
	
	assign lede=seg_data[2];
	assign ledd=seg_data[3];
	assign ledc=seg_data[4];
	assign ledb=seg_data[5];
	assign leda=seg_data[6];
	
endmodule	
		
