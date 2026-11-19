# Changelog

Todas as mudanças relevantes deste projeto são registradas aqui.
O formato segue o [Keep a Changelog](https://keepachangelog.com/pt-BR/1.1.0/) e o versionamento segue o [SemVer](https://semver.org/lang/pt-BR/).

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