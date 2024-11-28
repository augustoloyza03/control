library ieee;
use ieee.std_logic_1164.all;

entity control2 is
    port(
        clk      : in  std_logic;
        s, tc1, tc2, O1, O0, GI, GD : in std_logic;
        reset    : in  std_logic;
        M: out std_logic_vector (3 downto 0)
    );
end entity;

architecture rtl of control2 is
    -- Definición de los estados del autómata
    type state_type is (at, rp);
    signal state : state_type; -- Estado actual
    signal GI_prev, GD_prev : std_logic := '0'; -- Para detectar flancos positivos en GI y GD

    -- Registros para las salidas
    signal M3_reg, M2_reg, M1_reg, M0_reg : std_logic := '0';

begin

    -- Lógica de transición de estados
    process (clk, reset)
    begin
        if reset = '1' then
            state <= at;
        elsif rising_edge(clk) then
            case state is
                when at =>
                    if (s = '0')  then
                        state <= at;
                    elsif (s = '1' and (tc1 = '0' or tc2 = '0')) then
                        state <= rp;
                    else
                        state <= at;
                    end if;
                when rp =>
                    -- Detectar flancos positivos en GI o GD
                    if (GI = '1' and GI_prev = '0') or (GD = '1' and GD_prev = '0') then
                        state <= at;
                    else
                        state <= rp;
                    end if;
            end case;
        end if;
    end process;

    -- Actualizar el estado previo de GI y GD (para detectar flancos positivos)
    process (clk)
    begin
        if rising_edge(clk) then
            GI_prev <= GI;
            GD_prev <= GD;
        end if;
    end process;

    -- Lógica de salida basada en el estado actual
    process (clk, state, O1, O0,reset)
    begin
        if reset = '1' then
            M3_reg <= '0';
            M2_reg <= '0';
            M1_reg <= '0';
            M0_reg <= '0';
        elsif rising_edge(clk) then
            case state is
                when at =>
                    -- Mantener las salidas iguales a las del estado anterior (rp)
                    null; -- No hacer nada, las salidas permanecen constantes
                when rp =>
                    -- En el estado `rp`, asignar las salidas según los valores de O1 y O0
                    

                    if (O1 = '0' and O0 = '0') then
                        M1_reg <= '1';
                    elsif (O1 = '0' and O0 = '1') then
                        M2_reg <= '1';
                    elsif (O1 = '1' and O0 = '0') then
                        M0_reg <= '1';
                    elsif (O1 = '1' and O0 = '1') then
                        M3_reg <= '1';
                    end if;
            end case;
        end if;
    end process;

    -- Asignar las salidas a los registros
    M <= M3_reg & M2_reg & M1_reg & M0_reg;
  
end architecture;
