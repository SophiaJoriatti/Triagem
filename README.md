# Sistema de Triagem de Prioridades em VHDL

Este projeto contém a implementação de um sistema lógico combinacional desenvolvido para classificar níveis de prioridade clínica ou de atendimento numa escala de 1 a 5. O sistema processa 18 entradas booleanas simultâneas e está estruturado para a placa de desenvolvimento FPGA DE2-115, sendo compatível com o fluxo de síntese do Intel Quartus Prime.

## 🛠️ Arquitetura do Circuito (`Trabalho_Triagem.vhd`)

O módulo principal processa o estado de 18 interruptores (`SW(17 downto 0)`) e atribui o nível de gravidade mais alto correspondente através de uma arquitetura comportamental sequencial:
*   **Nível 5 (Emergência):** Ativado por variáveis de alto risco individuais (entradas 11, 12, 14, 17) ou por intersecções críticas de três variáveis.
*   **Nível 4 (Urgente):** Despoletado pelas entradas 0, 1, 3, 4, 7, 15 ou combinações lógicas secundárias.
*   **Nível 3 (Intermediário):** Dependente da ativação das chaves 8, 9, 10 ou das suas permutações agrupadas.
*   **Nível 2 (Leve):** Acionado por condições de baixo impacto (entradas 2, 5, 6, 13, 16).
*   **Nível 1 (Sem Risco/Padrão):** Estado de repouso assumido caso nenhuma das condições de prioridade superior seja verificada.

O circuito efetua também a descodificação direta do nível de prioridade para exibição no mostrador de 7 segmentos mais à direita (`hex0`). Para evitar consumo energético desnecessário e ruído visual, os restantes displays da placa (`hex7` a `hex1`) são forçados ao estado inativo (desligados).

## 🧪 Ambiente de Simulação (`triagem_tb.vhd`)

O ficheiro de *testbench* instancia a entidade principal e executa uma validação iterativa da matriz lógica. O algoritmo de simulação gera e aplica todas as 262.144 combinações possíveis ($2^{18}$) ao vetor de entrada. É aplicado um intervalo de propagação de 100 ps entre cada incremento, garantindo a estabilização dos sinais lógicos antes da avaliação do resultado.

## 📄 Documentação de Referência

A lógica de mapeamento das condições de entrada para a matriz de chaves deriva do documento de requisitos **"Tabela Verdade OFICIAL - Projeto 01 - PI.xlsx"**. A consulta deste ficheiro é essencial para compreender a associação exata entre cada bit do vetor `SW` e as premissas físicas do sistema de triagem.
