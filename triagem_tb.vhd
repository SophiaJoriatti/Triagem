library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity triagem_tb is
end triagem_tb;

architecture tb of triagem_tb is
    
    -- Sinais internos do testbench
    signal SW_tb        : std_logic_vector(17 downto 0) := (others => '0');
    signal resultado_tb : integer range 1 to 5;
    
    -- Sinais para todos os 8 displays hex
    signal hex7_tb      : std_logic_vector(0 to 6);
    signal hex6_tb      : std_logic_vector(0 to 6);
    signal hex5_tb      : std_logic_vector(0 to 6);
    signal hex4_tb      : std_logic_vector(0 to 6);
    signal hex3_tb      : std_logic_vector(0 to 6);
    signal hex2_tb      : std_logic_vector(0 to 6);
    signal hex1_tb      : std_logic_vector(0 to 6);
    signal hex0_tb      : std_logic_vector(0 to 6);
    
begin

    -- Instanciação do circuito
    uut: entity work.Trabalho_Triagem 
        port map(
            SW        => SW_tb, 
            resultado => resultado_tb,
            hex7      => hex7_tb,
            hex6      => hex6_tb,
            hex5      => hex5_tb,
            hex4      => hex4_tb,
            hex3      => hex3_tb,
            hex2      => hex2_tb,
            hex1      => hex1_tb,
            hex0      => hex0_tb
        );
        
    process
    begin
        -- Loop percorrendo todas as combinações de 18 bits (0 até 262143)
        for i in 0 to (2**18) - 1 loop
            -- Aplica o valor convertido
            SW_tb <= std_logic_vector(to_unsigned(i, 18));
            
            -- Aguarda 100 ps para garantir que o sinal propague antes da próxima iteração
            wait for 100 ps;
        end loop;
        
        -- Para a simulação ao terminar todas as combinações
        wait;
    end process;

end architecture tb;
