module vending_machine(i1,i2,i3,clk,m1,m5,rst,leda,ledb,ledc,ledd,lede,ledf,ledg,led1,led2,led3,led4,led5,led6,led7,l1,l2,l3,l4,l5,l6,l7);

   output reg leda,ledb,ledc,ledd,lede,ledf,ledg,led1,led2,led3,led4,led5,led6,led7,l1,l2,l3,l4,l5,l6,l7; //Seven segment display outputs
 
   input i1,i2,i3;		// Items
   input m1,m5; 		//currency used
   input clk,rst;
   reg [6:0] seg_data1,seg_data2,seg_data3;

   always @(posedge clk)
     begin																			// some possible combinations of item selected and money entered
		if (rst==0)
			begin
			seg_data1=7'b0000001; seg_data2=7'b0000001; seg_data3=7'b0000001; 
			end
		else 
		begin 
			if (i1==1 && m1==1)
			begin
			seg_data1=7'b1001111; seg_data2=7'b0000001; seg_data3=7'b0000001;
				end
       else if (i1==1 && m5==1)
			begin 
			seg_data1=7'b1001111; seg_data2=7'b1001100; seg_data3=7'b0000001;
            end
       
      else if (i2==1 && m1==1)
			begin 
			seg_data1=7'b0010010; seg_data2=7'b0000001; seg_data3=7'b1001111;
			end
	   
       else if (i2==1 && m5==1) 
			begin
            seg_data1=7'b0010010; seg_data2=7'b0000110; seg_data3=7'b0000001; 
			end
		else if (i3==1 && m1==1)
			begin  
			seg_data1=7'b0000110; seg_data2=7'b0000001; seg_data3=7'b0010010;
			end
		else if (i3==1 && m5==1)
			begin 
			seg_data1=7'b0000110; seg_data2=7'b0010010; seg_data3=7'b0000001;
			end			 
       else
			begin 
			seg_data1=7'b0000000; seg_data2=7'b0000000; seg_data3=7'b0000000; 
			end
	end
	ledg =seg_data1[0];			//seven segment display outputs
	ledf =seg_data1[1];
	lede =seg_data1[2];
	ledd =seg_data1[3];
	ledc =seg_data1[4];
	ledb =seg_data1[5];
	leda =seg_data1[6];
	
	led7 =seg_data2[0];
	led6=seg_data2[1];
	led5=seg_data2[2];
	led4=seg_data2[3];
	led3=seg_data2[4];
	led2=seg_data2[5];
	led1=seg_data2[6];
	
	l7=seg_data3[0];
	l6=seg_data3[1];
	l5=seg_data3[2];
	l4=seg_data3[3];
	l3=seg_data3[4];
	l2=seg_data3[5];
	l1=seg_data3[6];
 
endmodule
