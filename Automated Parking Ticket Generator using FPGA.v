module ESP(out,I1,led,c_mode,sw,reset);
input sw;				// sensor/switch
input reset;
output reg out;			// Input to ESP8266
output reg I1;			//FPGA input
output reg led;
output reg c_mode;		//AT command mode
always @ (posedge reset)
if (sw==1 && reset==1) 		//Sends Text message
begin
I1=1;
out=1;
led=1;
c_mode=0;
end
else if (sw==0 && reset==1) 	//Does not send text message
begin
I1=0;
out=0;
led=0;
c_mode=0;
end
else 							// Reset mode
begin						
I1=0;
out=0;
led=0;
c_mode=1;
end
endmodule

