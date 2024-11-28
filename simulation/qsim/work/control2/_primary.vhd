library verilog;
use verilog.vl_types.all;
entity control2 is
    port(
        clk             : in     vl_logic;
        s               : in     vl_logic;
        tc1             : in     vl_logic;
        tc2             : in     vl_logic;
        O1              : in     vl_logic;
        O0              : in     vl_logic;
        GI              : in     vl_logic;
        GD              : in     vl_logic;
        reset           : in     vl_logic;
        M3              : out    vl_logic;
        M2              : out    vl_logic;
        M1              : out    vl_logic;
        M0              : out    vl_logic
    );
end control2;
