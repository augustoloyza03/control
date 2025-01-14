-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- Generated by Quartus II Version 13.0.1 Build 232 06/12/2013 Service Pack 1 SJ Web Edition
-- Created on Sat Nov 23 16:28:13 2024

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY control IS
    PORT (
        reset : IN STD_LOGIC := '0';
        clock : IN STD_LOGIC;
        S : IN STD_LOGIC := '0';
        GI : IN STD_LOGIC := '0'; --giros
        GD : IN STD_LOGIC := '0';
        O0 : IN STD_LOGIC := '0'; --orientacion
        O1 : IN STD_LOGIC := '0';--orientacion
        C : IN STD_LOGIC := '0'; --- '1' cuando el contador llega al numero deseado
		  M3 : OUT bit;
        M2 : OUT bit;
        M1 : OUT bit;
        M0 : OUT bit;
        Habilitacion : OUT bit;   --- es un bit extra que le mando al siguiente bloque para decirle que puede mirar lo que estoy mandando
        R : OUT bit;   -- reset del contador, va a estar siempre en 1 excepto cuando sea utilizado
        cuenta : OUT bit -- va a ser la entrada de clk del contador, se va a ser 1 y 0 sucesivamente hasta llegar al valor deseado en el contador
    );
END control;

ARCHITECTURE BEHAVIOR OF control IS
    TYPE state_type IS (I,auxI,D,auxD,RPD,RPI,RP,Atencion);
    
    SIGNAL state : state_type;
BEGIN
    
    PROCESS (state,S,GI,GD,O0,O1,C)
    BEGIN
	 
	  if reset='1' then
	     state<= atencion;
        M3 <= '0';
        M2 <= '0';
        M1 <= '0';
        M0 <= '0';
        Habilitacion <= '0';
        R <= '1';
        cuenta <= '0';
		  elsif (rising_edge(clock)) then
        CASE state IS
            WHEN I =>
                IF ((C = '0')) THEN
                    state <= auxI;
                ELSIF (((S = '1') AND (C = '1'))) THEN
                    state <= RPI;
                ELSIF (((S = '0') AND (S = '1'))) THEN
                    state <= Atencion;
                -- Inserting 'else' block to prevent latch inference
                ELSE
                    state <= I;
                END IF;
                cuenta<='0' ; R<='0';
                IF (((((C = '1') AND (S = '1')) AND (O1 = '0')) AND (O0 = '1'))) THEN
                    M3 <= '1';
                -- Inserting 'else' block to prevent latch inference
                
                END IF;

                IF (((((C = '1') AND (S = '1')) AND (O1 = '0')) AND (O0 = '0'))) THEN
                    M2 <= '1';
                -- Inserting 'else' block to prevent latch inference
               
                END IF;

                IF (((((C = '1') AND (S = '1')) AND (O1 = '1')) AND (O0 = '1'))) THEN
                    M0 <= '1';
                -- Inserting 'else' block to prevent latch inference
                
                END IF;

                IF (((((C = '1') AND (S = '1')) AND (O1 = '1')) AND (O0 = '0'))) THEN
                    M1 <= '1';
                -- Inserting 'else' block to prevent latch inference
                
                END IF;

--                IF ((C = '0')) THEN
--                    R <= '0';
--                ELSIF ((C = '1')) THEN
--                    R <= '1';
--                -- Inserting 'else' block to prevent latch inference
--                ELSE
--                    R <= '0';
--                END IF;

                IF ((C = '0')) THEN
                    Habilitacion <= '0';
                ELSIF (((C = '1') AND (S = '1'))) THEN
                    Habilitacion <= '1';
                -- Inserting 'else' block to prevent latch inference
                ELSE
                    Habilitacion <= '0';
                END IF;
            WHEN auxI =>
                state <= I;

 				cuenta <= '1'; Habilitacion<='0';
             R<= '0'; 
          WHEN D =>
                IF ((C = '0')) THEN
                    state <= auxD;
                ELSIF (((C = '1') AND (S = '1'))) THEN
                    state <= RPD;
                ELSIF (((S = '0') AND (S = '1'))) THEN
                    state <= Atencion;
                -- Inserting 'else' block to prevent latch inference
                ELSE
                    state <= D;
                END IF;
                 cuenta<='0'; R<='0' ;
					  
                IF (((((C = '1') AND (S = '1')) AND (O1 = '1')) AND (O0 = '0'))) THEN
                    M3 <= '1';
                -- Inserting 'else' block to prevent latch inference
                
                END IF;

                IF (((((C = '1') AND (S = '1')) AND (O1 = '1')) AND (O0 = '1'))) THEN
                    M2 <= '1';
                -- Inserting 'else' block to prevent latch inference
              
                END IF;

                IF (((((C = '1') AND (S = '1')) AND (O1 = '0')) AND (O0 = '0'))) THEN
                    M0 <= '1';
                -- Inserting 'else' block to prevent latch inference
               
                END IF;

                IF (((((C = '1') AND (S = '1')) AND (O1 = '0')) AND (O0 = '1'))) THEN
                    M1 <= '1';
                -- Inserting 'else' block to prevent latch inference
             
                END IF;

--                IF ((C = '0')) THEN
--                    R <= '0';
--                ELSIF ((C = '1')) THEN
--                    R <= '1';
                -- Inserting 'else' block to prevent latch inference
--                ELSE
--                    R <= '0';
   --             END IF;

                IF ((C = '0')) THEN
                    Habilitacion <= '0';
                ELSIF (((C = '1') AND (S = '1'))) THEN
                    Habilitacion <= '1';
                -- Inserting 'else' block to prevent latch inference
                ELSE
                    Habilitacion <= '0';
                END IF;
          WHEN auxD =>
                state <= D;
                  Habilitacion<='0';
                cuenta <= '1';
          WHEN RPD =>
                IF (((GI = '1') AND (GD = '1'))) THEN
                    state <= I;
                -- Inserting 'else' block to prevent latch inference
                ELSE
                    state <= RPD;
                END IF;
                 cuenta<='0' ; Habilitacion<='0';
                R <= '1';
          WHEN RPI =>
                IF (((GI = '1') AND (GD = '1'))) THEN
                    state <= D;
                -- Inserting 'else' block to prevent latch inference
                ELSE
                    state <= RPI;
                END IF;
                cuenta<='0' ; Habilitacion<='0';
                R <= '1';
          WHEN RP =>
				
                IF (((GI = '1') AND (GD = '0'))) THEN
                    state <= I;
                ELSIF (((GI = '0') AND (GD = '1'))) THEN
                    state <= D;
                ELSIF ((GI = '0') AND (GD = '0')) or ((GI = '0') AND (GD = '0')) THEN
                    state <= Atencion;
                -- Inserting 'else' block to prevent latch inference
--                ELSE
--                    state <= RP;
                END IF;
                   cuenta<='0' ; Habilitacion<='0';
                IF (((GI = '0') AND (GD = '1'))) THEN
                    R <= '1';
                ELSIF (((GI = '0') AND (GD = '0'))) THEN
                    R <= '0';
                -- Inserting 'else' block to prevent latch inference
                ELSE
                    R <= '1';
                END IF;
            WHEN Atencion =>
			
                IF ((S = '1')) THEN
                    state <= RP;
               -- ELSIF ((S = '0')) THEN
                 --   state <= Atencion;
					ELSIF ((S='0' and GD = '1' and GI='0')) THEN
                    state <= D;
					ELSIF ((S='0' and GD = '0' and GI='1')) THEN
                    state <= I;	  
                -- Inserting 'else' block to prevent latch inference
                ELSE
                    state <= Atencion;
                END IF;

                IF ((((S = '1') AND (O1 = '1')) AND (O0 = '1'))) THEN
                    M3 <= '1';
                -- Inserting 'else' block to prevent latch inference
                
                END IF;

                IF ((((S = '1') AND (O1 = '0')) AND (O0 = '1'))) THEN
                    M2 <= '1';
                -- Inserting 'else' block to prevent latch inference
                
                END IF;

                IF ((((S = '1') AND (O1 = '1')) AND (O0 = '0'))) THEN
                    M0 <= '1';
                -- Inserting 'else' block to prevent latch inference
               
                END IF;

                IF ((((S = '1') AND (O1 = '0')) AND (O0 = '0'))) THEN
                    M1 <= '1';
                -- Inserting 'else' block to prevent latch inference
               
                END IF;

--                IF ((S = '0')) THEN
--                    R <= '1';
--                -- Inserting 'else' block to prevent latch inference
--                ELSE
--                    R <= '0';
               -- END IF;

                IF ((S = '0')) THEN
                    Habilitacion <= '0';
                ELSIF ((S = '1')) THEN
                    Habilitacion <= '1';
                -- Inserting 'else' block to prevent latch inference
                ELSE
                    Habilitacion <= '0';
                END IF;
           cuenta<= '0'; R <= '1';
        END CASE;
		 end if; 
    END PROCESS;
END BEHAVIOR;
