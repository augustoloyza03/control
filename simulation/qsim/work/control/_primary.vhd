library verilog;
use verilog.vl_types.all;
entity control is
    port(
        reset           : in     vl_logic;
        clock           : in     vl_logic;
        S               : in     vl_logic;
        GI              : in     vl_logic;
        GD              : in     vl_logic;
        O0              : in     vl_logic;
        O1              : in     vl_logic;
        C               : in     vl_logic;
        B               : out    vl_logic;
        A               : out    vl_logic;
        M3              : out    vl_logic;
        M2              : out    vl_logic;
        M1              : out    vl_logic;
        M0              : out    vl_logic;
        Habilitacion    : out    vl_logic;
        R               : out    vl_logic;
        cuenta          : out    vl_logic
    );
end control;
