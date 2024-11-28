library verilog;
use verilog.vl_types.all;
entity control_vlg_sample_tst is
    port(
        C               : in     vl_logic;
        clock           : in     vl_logic;
        GD              : in     vl_logic;
        GI              : in     vl_logic;
        O0              : in     vl_logic;
        O1              : in     vl_logic;
        reset           : in     vl_logic;
        S               : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end control_vlg_sample_tst;
