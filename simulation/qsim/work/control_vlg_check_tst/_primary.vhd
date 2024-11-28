library verilog;
use verilog.vl_types.all;
entity control_vlg_check_tst is
    port(
        A               : in     vl_logic;
        B               : in     vl_logic;
        cuenta          : in     vl_logic;
        Habilitacion    : in     vl_logic;
        M0              : in     vl_logic;
        M1              : in     vl_logic;
        M2              : in     vl_logic;
        M3              : in     vl_logic;
        R               : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end control_vlg_check_tst;
