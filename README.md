<h1 align="center">ART Tweaking Utility</h1>

<p align="center">
  <strong>Ferramenta para otimização, personalização e diagnóstico do Windows.</strong>
</p>

<!--
  Adicione aqui um print do menu principal:
  <p align="center"><img src="assets/menu.png" alt="Menu principal do ART Tweaking Utility" width="800"></p>
-->

Utilitário desenvolvido em Batch e PowerShell que reúne ferramentas de otimização, manutenção e diagnóstico do Windows em um único lugar.

Permite aplicar ajustes no sistema, gerenciar configurações de hardware e software, fazer limpezas, criar backups e medir o efeito das alterações no desempenho do computador.

> O projeto está em desenvolvimento. Consulte o [CHANGELOG](CHANGELOG.md) para ver o que mudou em cada versão.

## Como o menu funciona

Ao abrir, o utilitário pergunta se você quer criar um ponto de restauração e, em seguida, qual é o perfil do seu PC:

- **PC recém-formatado:** instala VC++, DirectX e .NET via winget, abre a página oficial de driver da sua GPU, impede o Windows Update de trocar o driver de vídeo e desativa Delivery Optimization, Inicialização Rápida e apps em segundo plano.
- **PC em uso:** segue direto para o menu principal. O relatório do que está pesando no sistema fica na opção 14.

## Funcionalidades

O menu principal tem as opções numeradas de 1 a 14, mais as letras **R**, **X** e **P**.

### 1. Otimizações gerais
- Ajustes gerais de latência e desempenho no Registro e no `bcdedit`.
- Ajustes de inicialização e de execução do sistema.
- Ajustes para jogos em janela, VRR e Overlay (MPO), respeitando a configuração de tela cheia de cada jogo e sem apagar as outras opções gráficas.

### 2. Otimização de mouse e teclado
- Ajustes de Registro para mouse e teclado.
- Tamanho da fila de dados com perfis de 14, 17 e 20 (CPU topo de linha, média e básica).

### 3. Ajustes do Windows
- Configurações para Windows 10 e Windows 11.
- Efeitos visuais personalizados, transparência, notificações, Pesquisa do Windows, sincronização, diagnósticos, rastreamento, apps em segundo plano, SmartScreen, feed de atividades e relatório de erros.
- Submenu de ajustes do Windows 11: Copilot, Recall, Widgets e menu clássico do botão direito.
- Opção de reverter a categoria.

### 4. Limpeza do PC
- Limpeza de dados temporários de dispositivos.
- Limpeza de Disco do Windows.
- Limpeza completa: temporários, cache do Windows Update, shaders (NVIDIA, AMD e DirectX), caches de navegadores, miniaturas, relatórios de erro, cache DNS e Lixeira.

### 5. Otimização de memória/RAM
- Ajustes de Registro relacionados à memória, de acordo com a quantidade de RAM instalada.
- Compressão de memória e outros parâmetros do gerenciamento de memória.

### 6. Gerenciador de inicialização
- Lista os programas que iniciam com o Windows e o estado de cada um.
- Liga e desliga itens de inicialização pelo mesmo mecanismo do Gerenciador de Tarefas (nada é excluído).

### 7. Ajustes de GPU
- Otimizações específicas para NVIDIA, AMD e Intel.

### 8. Ajustes de CPU
- Um único conjunto de ajustes para processadores AMD e Intel, sem precisar escolher o fabricante.
- Desativação de Core Parking, resfriamento ativo, estado mínimo do processador em 100% e Throttle States.

### 9. Ajustes de USB
- Ajustes de gerenciamento de energia das portas e dispositivos USB.

### 10. Ajustes de energia
- Plano de energia Desempenho Máximo.
- Desativação de Power Throttling, Link State Power Management, hibernação, Inicialização Rápida e telemetria de energia.

### 11. Debloat do sistema
- Desativação de telemetria, telemetria do Office, impressão e mapas, autologgers e programa de experiência do cliente.
- Desinstalação de apps pré-instalados desnecessários e da Cortana.
- Reversão própria (opção **R**), com **A – Reverter tudo** ou item por item.

### 12. Ajustes de disco
- Trim nos SSDs e desfragmentação nos HDs, em todas as unidades encontradas.
- Cache de gravação do usuário.
- Desativação da economia de energia do SSD/NVMe (Idle Power Management do StorPort).

### 13. Corrigir arquivos
- Atalho para as ferramentas nativas de reparo do Windows, em 3 etapas: DISM RestoreHealth, verificação de arquivos do sistema (SFC) e limpeza de componentes do WinSxS.

### 14. Relatório / Checagens
- **Relatório do PC:** notebook ou desktop, CPU, GPU, RAM por módulo, tipo de armazenamento, driver de vídeo e espaço livre.
- **Medidor antes/depois:** salva RAM em uso, processos, serviços ativos, apps na inicialização e tempo de boot, e compara as duas medições depois dos ajustes.
- **Verificações de hardware:** RAM abaixo da velocidade nominal (XMP/EXPO desligado), taxa de atualização do monitor abaixo do máximo, saúde do SSD e idade do driver de vídeo.
- **PC em uso:** mostra os processos que mais usam RAM, os itens de inicialização e os serviços de terceiros. Só exibe, quem decide o que desligar é você.

### R. Reversões / Correções
- Reverte ajustes específicos aplicados pelo utilitário (planos de energia, apps, Xbox, GameDVR, notificações, Bluetooth, hibernação, manutenção, impressão e mapas, SmartScreen, diagnósticos, relatório de erros, ajustes do Windows 11 e de energia e Idle Power Management do StorPort).

### P. Backup / Restauração
- Criação de ponto de restauração do Windows.
- Backup de chaves de Registro, tipos de inicialização de serviços e estado de tarefas agendadas.
- Restauração de um backup salvo e acesso à pasta de backups (`Art_Backups`, dentro da sua pasta de usuário).

### X. Sair do utilitário

## Níveis de risco

Nem todo ajuste tem o mesmo impacto. Como referência:

| Nível | Exemplos | Observação |
| --- | --- | --- |
| Seguro | Relatórios, medidor antes/depois, verificações, gerenciador de inicialização, limpeza de temporários e caches | Não alteram o comportamento do sistema ou são facilmente refeitos. |
| Moderado | Ajustes do Windows, mouse e teclado, memória, USB, disco, energia, GPU e CPU | Alteram Registro e serviços. Cobertos por backup e reversões. |
| Avançado | Desativar mitigações de CPU, desativar Inicialização Rápida/hibernação, debloat e desinstalação de apps | Podem reduzir a segurança ou remover recursos. Leia a descrição antes de aplicar. |

## Tecnologias utilizadas

- **Batch (.cmd):** estrutura principal do utilitário e interface de menus.
- **PowerShell:** rotinas administrativas, diagnósticos e gerenciamento do Windows.
- **Registro do Windows:** personalização de configurações do sistema.
- **WMI/CIM:** consulta de informações de hardware e software.
- **Ferramentas nativas do Windows:** DISM, winget, powercfg, entre outras.

## Requisitos

- Windows 10 ou Windows 11.
- Permissões de administrador para determinadas operações.
- PowerShell disponível no sistema.
- Winget para instalação automatizada de alguns componentes opcionais.

Algumas funcionalidades dependem da versão do Windows e do hardware utilizado.

## Como utilizar

1. Execute o arquivo `ART_TWEAKING_UTILITY.cmd`.
2. Autorize a execução como administrador quando necessário.
3. Escolha o perfil de utilização do computador.
4. Navegue pelos menus e selecione os ajustes desejados.

**Recomendação:** leia as descrições e os avisos antes de aplicar qualquer alteração.

## Segurança e restauração

O utilitário realiza alterações em configurações importantes do Windows, incluindo Registro, serviços e recursos do sistema.

Antes de aplicar ajustes:

- Crie um ponto de restauração.
- Faça backup das configurações.
- Verifique a descrição de cada opção.
- Evite aplicar configurações experimentais sem conhecer seus efeitos.

Nem todas as alterações podem ser desfeitas automaticamente pelo utilitário. Algumas podem exigir restauração manual ou recuperação do Windows.

Para reportar um problema de segurança, veja a [política de segurança](SECURITY.md).

## Contribuindo

Sugestões e correções são bem-vindas. Leia o [guia de contribuição](CONTRIBUTING.md) antes de abrir uma issue ou um pull request.

## Licença

Este projeto está licenciado sob a licença MIT. Consulte o arquivo [LICENSE](LICENSE) para mais informações.

## Status do projeto

**Versão atual: 0.1.1 — Em desenvolvimento.**

Novas funcionalidades, melhorias de compatibilidade, correções e otimizações estão previstas para as próximas versões.
