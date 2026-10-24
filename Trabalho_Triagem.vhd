library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Trabalho_Triagem is
    Port ( 
        -- Padrão DE2-115: 18 chaves, do 17 ao 0.
        SW        : in  std_logic_vector(17 downto 0); 
        resultado : out integer range 1 to 5;      
        
        -- Declarando TODOS os 8 displays para bloquear o lixo eletrônico
        hex7      : out std_logic_vector(0 to 6);  
        hex6      : out std_logic_vector(0 to 6);
        hex5      : out std_logic_vector(0 to 6);
        hex4      : out std_logic_vector(0 to 6);
        hex3      : out std_logic_vector(0 to 6);
        hex2      : out std_logic_vector(0 to 6);
        hex1      : out std_logic_vector(0 to 6);
        hex0      : out std_logic_vector(0 to 6)
    );
end Trabalho_Triagem;

architecture Behavioral of Trabalho_Triagem is
    signal s_resultado : integer range 1 to 5;
begin

    process(SW)
    begin
        -- PRIORIDADE 1: EMERGÊNCIA (NÍVEL 5)
        if ( (SW(0)='1' and SW(4)='1' and SW(7)='1') or    
             (SW(0)='1' and SW(10)='1' and SW(15)='1') or   
             SW(11)='1' or SW(12)='1' or SW(14)='1' or SW(17)='1' ) then 
            
            s_resultado <= 5;

        -- PRIORIDADE 2: URGENTE (NÍVEL 4)
        elsif ( (SW(8)='1' and SW(9)='1' and SW(10)='1') or 
                (SW(4)='1' and SW(5)='1' and SW(6)='1') or   
                SW(0)='1' or SW(1)='1' or SW(3)='1' or SW(4)='1' or SW(7)='1' or SW(15)='1' ) then 
            
            s_resultado <= 4;

        -- PRIORIDADE 3: INTERMEDIÁRIO (NÍVEL 3)
        elsif ( (SW(2)='1' and SW(6)='1' and SW(16)='1') or 
                (SW(10)='1' and SW(13)='1') or              
                SW(8)='1' or SW(9)='1' or SW(10)='1' ) then 
            
            s_resultado <= 3;

        -- PRIORIDADE 4: LEVE (NÍVEL 2)
        elsif (SW(2)='1' or SW(5)='1' or SW(6)='1' or SW(13)='1' or SW(16)='1') then 
            
            s_resultado <= 2;

        -- PADRÃO: SEM RISCO / NÃO URGENTE (NÍVEL 1)
        else
            s_resultado <= 1; 
        end if;
        
    end process;
    
    resultado <= s_resultado;
    
	
	-- Desligando TODOS os displays que não vão ser usados (do 7 ao 1)
    hex7 <= "1111111";
    hex6 <= "1111111";
    hex5 <= "1111111";
    hex4 <= "1111111";
    hex3 <= "1111111";
    hex2 <= "1111111";
    hex1 <= "1111111";
    
    -- Lógica focada apenas no hex0 (o display mais à direita)
    with s_resultado select
        hex0 <= "1001111" when 1, -- Acende apenas 'b' e 'c'
                "0010010" when 2, -- Acende 'a','b','d','e','g'
                "0000110" when 3, -- Acende 'a','b','c','d','g'
                "1001100" when 4, -- Acende 'b','c','f','g'
                "0100100" when 5, -- Acende 'a','c','d','f','g'
                "1111111" when others; -- Apaga tudo por segurança

end Behavioral;
