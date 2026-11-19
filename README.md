# ART Tweaking Utility

<p align="center">
  **Uma ferramenta para otimização, personalização e diagnóstico do Windows.**
</p>

Utilitário desenvolvido em Batch e PowerShell, com o objetivo de reunir diferentes ferramentas de otimização, manutenção e diagnóstico do Windows em um único lugar.

O projeto permite aplicar ajustes no sistema, gerenciar configurações de hardware e software, realizar limpezas, criar backups e acompanhar possíveis mudanças no desempenho do computador.

Atualmente, o projeto está em desenvolvimento.

## Funcionalidades

### 1. Otimizações gerais
- Aplicação de ajustes gerais no Windows.
- Configurações relacionadas à latência e ao desempenho.
- Ajustes de inicialização e execução do sistema.
- Configurações de recursos em segundo plano.
- Ajustes relacionados à experiência de uso.

### 2. Otimização de mouse e teclado
- Ajustes de registro para mouse e teclado.
- Personalização de parâmetros de entrada.
- Configurações de resposta e latência.
- Diferentes perfis de configuração para CPUs.

### 3. Ajustes do Windows
- Configurações específicas para Windows 10 e Windows 11.
- Gerenciamento do Modo de Jogo.
- Personalização de recursos da interface.
- Ajustes de animações.
- Desativação de recursos selecionados do Windows.
- Configurações de privacidade e telemetria.

### 4. Limpeza do sistema
- Exclusão de arquivos temporários.
- Limpeza de cache do Windows Update.
- Limpeza de cache de shaders.
- Limpeza de cache de navegadores.
- Limpeza de miniaturas e relatórios de erros.
- Limpeza de cache DNS.
- Limpeza da Lixeira.
- Integração com a Limpeza de Disco do Windows.

### 5. Otimização de memória RAM
- Ajustes relacionados ao gerenciamento de memória.
- Configurações de compressão de memória.
- Personalização de parâmetros do sistema relacionados à RAM.

### 6. Gerenciador de inicialização
- Listagem de programas iniciados com o Windows.
- Identificação de aplicativos habilitados e desabilitados.
- Ativação e desativação de itens de inicialização.
- Visualização dos caminhos e comandos associados aos programas.

### 7. Ajustes de GPU
- Configurações específicas para NVIDIA.
- Configurações específicas para AMD.
- Configurações específicas para Intel.
- Ajustes relacionados ao desempenho gráfico.
- Acesso às páginas oficiais de download de drivers.

### 8. Ajustes de CPU
- Configurações específicas para processadores AMD.
- Configurações específicas para processadores Intel.
- Ajustes relacionados ao gerenciamento de energia.
- Configurações de Core Parking e outros parâmetros do processador.

### 9. Ajustes de USB
- Personalização de configurações relacionadas às portas USB.
- Ajustes de gerenciamento de energia e dispositivos.

### 10. Ajustes de energia
- Gerenciamento de planos de energia.
- Configuração do plano de Desempenho Máximo.
- Ajustes de hibernação e Inicialização Rápida.
- Configurações relacionadas à economia de energia.
- Opções para reverter alterações.

### 11. Debloat do sistema
- Desativação de recursos e componentes selecionados do Windows.
- Ajustes de serviços e recursos em segundo plano.
- Personalização de configurações do sistema.

### 12. Ajustes de disco
- Configurações relacionadas ao armazenamento.
- Ajustes de gerenciamento de energia do SSD.
- Personalização de parâmetros relacionados ao sistema de arquivos.

### 13. Correção de arquivos
- Acesso a ferramentas nativas de diagnóstico e reparação do Windows.

### 14. Otimização de tela cheia
- Ajustes relacionados às otimizações de tela cheia do Windows.
- Personalização de configurações utilizadas por jogos e aplicativos.

### 15. Relatórios e diagnósticos
- Identificação de processador e placa de vídeo.
- Informações sobre memória RAM.
- Identificação do tipo de armazenamento.
- Identificação de notebook ou desktop.
- Informações sobre drivers de vídeo.
- Verificação de espaço disponível em disco.
- Verificação da velocidade configurada da memória RAM.
- Verificação da taxa de atualização do monitor.
- Consulta da saúde dos dispositivos de armazenamento.

### 16. Monitoramento antes e depois
- Registro do consumo de RAM.
- Contagem de processos em execução.
- Contagem de serviços ativos.
- Quantidade de aplicativos na inicialização.
- Consulta do tempo de inicialização do Windows.
- Comparação entre medições realizadas antes e depois das alterações.

### 17. Backup e restauração
- Criação de pontos de restauração do Windows.
- Backup de configurações do Registro.
- Backup das configurações de inicialização dos serviços.
- Backup dos estados das tarefas agendadas.
- Restauração de configurações salvas.
- Acesso à pasta de backups.

### 18. Reversões e correções
- Opções para reverter diferentes ajustes aplicados pelo utilitário.
- Restauração de configurações selecionadas do Windows.
- Integração com o sistema de backup para recuperar configurações anteriores.

## Tecnologias utilizadas

- **Batch (.cmd):** estrutura principal do utilitário e interface de menus.
- **PowerShell:** execução de rotinas administrativas, diagnósticos e gerenciamento do Windows.
- **Registro do Windows:** personalização de configurações do sistema.
- **WMI/CIM:** consulta de informações de hardware e software.
- **Windows CMD:** integração com ferramentas nativas do sistema.

## Requisitos

- Windows 10 ou Windows 11.
- Permissões de administrador para determinadas operações.
- PowerShell disponível no sistema.
- Winget para instalação automatizada de alguns componentes opcionais.

Algumas funcionalidades dependem da versão do Windows e do hardware utilizado.

## Como utilizar

1. Execute o arquivo `Art_TWEAKING_UTILITY.cmd`.
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

## Licença

Este projeto está licenciado sob a licença MIT. Consulte o arquivo [LICENSE](LICENSE) para mais informações.

## Status do projeto

**Versão atual: 0.1 — Em desenvolvimento.**

Novas funcionalidades, melhorias de compatibilidade, correções e otimizações estão previstas para as próximas versões.
