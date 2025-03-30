// EcoMender Bot : Task 1A : PWM Generator
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.
This file is used to design a module which will scale down the 1MHz Clock Frequency to 500Hz and perform Pulse Width Modulation on it.

Recommended Quartus Version : 20.1
The submitted project file must be 20.1 compatible as the evaluation will be done on Quartus Prime Lite 20.1.

Warning: The error due to compatibility will not be entertained.
-------------------
*/

//PWM Generator
//Inputs : clk_1MHz, pulse_width
//Output : clk_500Hz, pwm_signal

module pwm_generator(
    input clk_1MHz,
    input [3:0] pulse_width,
    output reg clk_500Hz, pwm_signal
);

initial begin
    clk_500Hz = 1; pwm_signal = 1;
end

/////////////////DO NOT MAKE ANY CHANGES ABOVE THIS LINE//////////////////

/*
Add your logic here
*/

reg [10:0] counter1 = 0; // Single counter to handle both 500Hz clock and PWM signal generation

always @ (posedge clk_1MHz) begin
    // Increment the counter
    counter1 = counter1 + 1'b1;

    // Toggle clk_500Hz every 1000 cycles (1 MHz -> 500 Hz)
    if (counter1 == 11'd1001 ) begin
        clk_500Hz = ~clk_500Hz;
    end

    // Reset counter1 every 2000 cycles
    if (counter1 == 11'd2001) begin
		  clk_500Hz = ~clk_500Hz;
        counter1 = 1;
    end
end 

always @ (posedge clk_1MHz) begin
    // Generate PWM signal based on pulse_width
    // The pulse width is a percentage of 2000 (since 1 full cycle of the counter is 2000 counts)
    if (counter1 <= (pulse_width * 100)) begin
        pwm_signal = 1;
    end else begin
        pwm_signal = 0;
    end
end

//////////////////DO NOT MAKE ANY CHANGES BELOW THIS LINE//////////////////

endmodule
