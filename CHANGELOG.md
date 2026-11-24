# Changelog

Todas as mudanças relevantes deste projeto são registradas aqui.
O formato segue o [Keep a Changelog](https://keepachangelog.com/pt-BR/1.1.0/) e o versionamento segue o [SemVer](https://semver.org/lang/pt-BR/).

## [0.1.3] - 2026-11-23

Versão em desenvolvimento: troca a opção **R** do menu principal pelo download da pasta `tools`, amplia a remoção de apps do Debloat e acrescenta ajustes de acessibilidade às Otimizações gerais. Todas as alterações abaixo fazem parte da mesma versão **0.1.3**.

### Adicionado
- Menu principal: opção **D – Baixar pasta Tools**. Baixa a pasta `tools` do repositório no GitHub (branch `main`) e a salva ao lado do `.cmd`, mantendo arquivos extras que já estejam lá, e abre a pasta no Explorer ao terminar. Se o download falhar, mostra uma mensagem e volta ao menu.
- **Otimizações gerais:** passaram a garantir as configurações de acessibilidade.
  - **Teclas de Aderência:** atalho do Shift cinco vezes, ícone na barra de tarefas, bloqueio com duas pressões, desligar com duas teclas e som, tudo desativado.
  - **Teclas do Mouse:** desativadas, sem atalho, aviso, som, ícone ou CTRL/SHIFT, com velocidade máxima (`MaximumSpeed`) e aceleração (`TimeToMaximumSpeed`) nos padrões do Windows.
- **Debloat > Desinstalar Apps Inuteis** (opção 2 e **A – Aplicar tudo**): passa a remover também estes itens.
  - **Apps da Store:** 3D Viewer, Dev Home, Remote Desktop Client, Tips, Bing Search, Get Help, Mixed Reality, Microsoft 365 (Office), People, Skype, To Do, Copilot, Family, Filmes e TV, Outlook for Windows, Quick Assist, Sticky Notes, Phone Link, Cortana, Feedback Hub, News, OneNote, Solitaire Collection, Teams e Wallet. Os pacotes provisionados também são removidos.
  - **Recursos do Windows:** WordPad, reconhecimento facial do Windows Hello, Gravador de Passos, Quick Assist, escrita à mão (todos os idiomas), Internet Explorer e Recall.
  - **OneDrive** (desinstalado) e **OneSync** (serviço de sincronização desativado).
- O Debloat mostra o progresso item por item: `[OK]` (removido), `[--]` (já não estava instalado) e `[CHECK]` (o Windows não deixou remover).

### Alterado
- Título do menu principal e demais referências atualizados para **0.1.3**.
- A opção **R – Reversões / Correções** deixou de existir no menu principal, já que cada menu tem a própria reversão. O menu de Reversões continua acessível pela opção **R** dentro de **Ajustes do Windows**.
- Texto da tela inicial atualizado: a reversão agora é indicada pela opção **Reverter** de cada menu, junto com **Backup / Restauração [P]**.
- A remoção de apps do Debloat passou a usar uma única rotina PowerShell, compartilhada pela opção 2 e por **A – Aplicar tudo**, no lugar dos dois blocos duplicados. Todos os apps que já eram removidos continuam na lista (Weather, Maps, Apps Bing e os pacotes antigos).
- **Otimizações gerais:** a linha que gravava `0` nas Teclas do Mouse e nas Teclas de Filtro foi separada; as Teclas de Filtro continuam em `0` e as Teclas do Mouse passam a ter configuração própria (`Flags` em `0`).

### Removido
- Opção **R** do menu principal (substituída pela **D**).

## [0.1.2] - 2026-11-22

Versão em desenvolvimento: reúne a nova aba de **Rede**, opções adicionais de **Disco**, **Jogos e Tela** e **CPU**, melhorias no Debloat, simulação, registros de sessão, backups e correções nos menus. Todas as alterações abaixo fazem parte da mesma versão **0.1.2**.

### Adicionado
- Nova aba **14 – Ajustes de Rede**:
  - Otimizações de rede: desativa a economia de energia da placa, Gigabit Lite, EEE e o algoritmo de Nagle, coloca velocidade e duplex no máximo e ajusta RSS e TCP.
  - Teste e aplicação do DNS mais rápido.
  - Aprimoramento de Wi-Fi: ajustes do adaptador, análise dos canais vizinhos e teste de estabilidade.
  - Reversão própria dentro da aba.
- **Ajustes de disco:** três opções novas.
  - **4 –** verificar TRIM e o modo do controlador (AHCI/NVMe).
  - **5 –** otimizar SSD, desativando indexação e desfragmentação agendada.
  - **6 –** mover a pasta Temp para a unidade mais rápida.
- **Ajustes de GPU:** três opções novas.
  - **4 – Jogos e Tela:** HAGS, MPO e otimizações de tela cheia.
  - **5 – Perfil por jogo:** prioridade de CPU e GPU para um jogo escolhido.
  - **6 – GPU integrada Intel:** plano gráfico, efeitos visuais e memória de vídeo.
- **Ajustes de CPU:** ajustes extras de boost agressivo, CPU híbrida e afinidade de interrupções.
- **Debloat:** novas opções **8 – Otimizar Serviços (preset seguro)**, **9 – Modo Jogo** (pausa serviços pesados enquanto você joga e retoma depois), **10 – Desativar Game DVR e Game Bar** e **11 – Remover OneDrive**.
  - A remoção do OneDrive preserva as pastas e os arquivos locais, verifica arquivos disponíveis somente na nuvem, bloqueia a sincronização e permite reinstalar o OneDrive pela reversão do Debloat.
- **Medidor antes/depois:** passou a medir também o tempo em DPC e em interrupções (a medição leva cerca de 5 segundos).
- **Reversões / Correções:** cinco opções novas.
  - **17 –** Rede.
  - **18 –** Jogos e Tela.
  - **19 –** Disco.
  - **20 –** CPU extra.
  - **21 –** GPU integrada Intel.
- Opção de reiniciar o PC na hora, direto na tela de saída do utilitário.
- Modo de simulação `-DryRun` ou `/DryRun` para visualizar, sem aplicar, as operações do Debloat e suas reversões. A simulação não abrange os demais menus.
- Logs por sessão em `%USERPROFILE%\ART_Backups\Logs`, com registro de ações, avisos e operações simuladas.
- Registro do estado original de ajustes reversíveis em `%USERPROFILE%\ART_Backups\ART_Tweaks_State.json`.
- Detecção de notebook pelo tipo de chassi SMBIOS, usando a presença de bateria como critério de desempate quando necessário.

### Alterado
- Título do menu principal atualizado para **0.1.2**.
- **Relatório / Checagens** passou da opção 14 para a **15**, e **Ajustes de Rede** ocupa a **14**.
- Mensagem de saída reescrita: agora mostra o nome do usuário, pergunta se deseja reiniciar o PC e fecha direto, sem esperar uma tecla.
- O MPO deixou de ser alterado pelas **Otimizações gerais** e passou a ser controlado em **GPU > Ajustes de Jogos e Tela**. As Otimizações gerais continuam respeitando a configuração de tela cheia de cada jogo.

### Corrigido
- Mensagem de saída aparecia cortada (", obrigado por usar...") porque o texto entre dois pontos de exclamação era consumido pelo Batch.
- A opção **3** dos Ajustes de disco (economia de energia do SSD/NVMe) voltava ao menu principal. Agora volta ao menu de disco.

### Removido
- Chaves de Latency Tolerance (energia e GPU) e limiares de idle do driver NVIDIA (`RMLpwr*`), por não terem ganho comprovado.

## [0.1.1] - 2026-11-21

Versão de limpeza: remove ajustes sem efeito comprovado nos testes, ou que mexiam em proteções do sistema sem necessidade, e organiza os menus.

### Alterado
- Título do menu principal atualizado para **0.1.1** e arte do título redimensionada para ocupar toda a largura da caixa.
- Alinhamento dos menus corrigido (borda do rodapé do menu principal) e opção **X – Sair** centralizada na mesma linha de **R** e **P**.
- Telas de boas-vindas, ponto de restauração e perfil redesenhadas e alinhadas.
- **Otimizações gerais:** passou a incluir os ajustes de jogos em janela, VRR e Overlay (MPO), que eram a antiga opção 14. Agora eles não apagam as outras opções gráficas do usuário.
- **Ajustes de CPU:** não pede mais para escolher entre AMD e Intel. Um único conjunto de ajustes (Core Parking, resfriamento, estado mínimo do processador em 100% e Throttle States).
- **Ajustes de disco:** a economia de energia do SSD agora é feita pelo Idle Power Management do StorPort (SSD/NVMe), com contagem de dispositivos ajustados. Trim/desfragmentação otimiza todas as unidades encontradas e informa erros.
- **Corrigir arquivos:** execução em 3 etapas (DISM RestoreHealth, SFC e limpeza de componentes do WinSxS), com mensagem de erro do DISM/defrag quando algo falha.
- **Ajustes de energia:** Timer Coalescing substituído por Link State Power Management.
- **Ajustes do Windows:** efeitos visuais aplicados direto em Personalizar, sem abrir a janela de Opções de Desempenho.
- **Debloat:** a lista de apps desinstalados foi reduzida e passou a incluir 3D Viewer e os apps Bing (`Microsoft.Bing*`).
- **Mitigações:** ao reativar, o utilitário também reativa o VirtualizationBasedSecurity.
- Otimização de **GPU**: adicionado ajuste de cache de memória do NTFS e, para AMD, Adaptive De-Interlacing.
- **USB:** aviso para reiniciar o PC depois de aplicar os ajustes.
- A numeração do menu mudou: **Relatório / Checagens** passou da opção 15 para a **14**.

### Adicionado
- Reversão própria do Debloat (opção **R** dentro do Debloat), com a opção **A – Reverter tudo** e uma reversão para cada item: telemetria, apps, telemetria do Office, impressão e mapas, Pesquisa/Cortana, autologgers e programa de experiência.
- Em **Reversões / Correções**, nova opção 16: reativar o Gerenciamento de Energia Ocioso do StorPort.
- Opção **X – Voltar** na tela de tamanho da fila de dados do mouse e teclado.

### Removido
- Opção **14 – Otimização de Tela Cheia** do menu principal (conteúdo movido para as Otimizações gerais).
- Escolha entre Windows 10 e Windows 11 do ajuste de tela cheia (FSE).
- **Modo Jogo** como opção separada (ativar/desativar) e a pergunta de Modo Jogo ao aplicar a categoria Windows.
- **Desativar Bluetooth** e **Desativar Manutenção** dos Ajustes do Windows (a reversão continua disponível em Reversões / Correções).
- **Desativar GameDVR** e **Desativar Xbox** do Debloat (a reversão continua disponível em Reversões / Correções).
- **Excluir planos de energia inúteis**.
- **Mitigações:** deixaram de ser desativados ExceptionChainValidation, SEHOP, CFG, Protection Mode e ASLR.
- **CPU:** Distribute Timers, TSX, Event Processor, todos os processadores lógicos, C-States e P-States.
- **Otimizações gerais:** prioridade de IRQ8/IRQ16, IO Time Stamp e redução do tempo de encerramento de processos.
- **Memória/RAM:** ajuste de Cache de Sistema Grande e "Otimizando Memory Management".
- **GPU:** alocação de memória contígua, Write Combining, Preemption, consulta de VRAM, Anti-Aliasing, Anisotropic Filtering, redução automática de profundidade de cor, De-Lag, Frame Rate Target, DMA e Thermal Throttling.
- **USB:** Thread Priority, MSI Mode e prioridade de dispositivos USB.
- **Mouse e teclado:** CSRSS em tempo real.
- Da lista de desinstalação do Debloat: Alarmes, Câmera, Email e Calendário, Gravador de Voz, Seu Telefone, Groove Música e as extensões HEIF, WebP e Web Media.
- Atalho **[T] Abrir Gerenciador de Tarefas** das telas de GPU, CPU, RAM e fila de dados.

## [0.1.0] - 2026-11-19

### Adicionado
- Tela de perfil logo após a criação do ponto de restauração: **PC recém-formatado** ou **PC em uso**.
  - PC recém-formatado: instala VC++, DirectX e .NET via winget, abre a página oficial de driver da GPU, impede o Windows Update de trocar o driver de vídeo e desativa Delivery Optimization, Inicialização Rápida e apps em segundo plano.
- Aba **15 – Relatório / Checagens**:
  - Relatório do PC (notebook ou desktop, CPU, GPU, RAM, discos, drivers, espaço livre).
  - Medidor antes/depois (RAM em uso, processos, serviços, apps na inicialização e tempo de boot).
  - Verificações de hardware (XMP/EXPO, taxa de atualização do monitor, saúde do SSD, idade do driver de vídeo).
  - Visão "PC em uso" (processos que mais usam RAM, itens de inicialização e serviços de terceiros), sem alterar nada.
- Backup e restauração de chaves de registro, tipos de inicialização de serviços e estado de tarefas agendadas.
- Interface totalmente em português do Brasil, sem acentos para evitar caracteres quebrados no console.
- Fonte maior e janela maximizada na inicialização.
- Cores da interface em verde.

### Removido
- Remoção do Microsoft Edge (opção do Debloat e a opção correspondente em Reversões), por ser código de terceiros.
- Ajustes de Superfetch/Prefetch e `ClearPageFileAtShutdown` na otimização de RAM.
