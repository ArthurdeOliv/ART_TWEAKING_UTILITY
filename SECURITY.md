# Política de segurança

## Versões com suporte

| Versão | Suporte |
| ------ | ------- |
| 0.1.x  | Sim     |

## Como reportar um problema de segurança

Se você encontrou um comportamento que possa causar perda de dados, abrir brechas no sistema ou que não esteja descrito na documentação, **não abra uma issue pública**.

Use o recurso **Security > Report a vulnerability** deste repositório (relatório privado) ou entre em contato diretamente com o mantenedor pelo perfil do GitHub.

Inclua, se possível:

- Versão do utilitário e do Windows.
- O que você fez, o que esperava e o que aconteceu.
- Qual opção do menu foi usada.

Você receberá uma resposta assim que possível. Correções serão publicadas em uma nova versão e registradas no [CHANGELOG](CHANGELOG.md).

## Sobre o que o utilitário faz

O script é texto puro (Batch e PowerShell) e não é ofuscado. Fora os pacotes oficiais instalados via winget no perfil "PC recém-formatado", ele não baixa nem executa código externo. Qualquer pessoa pode ler o arquivo `ART_TWEAKING_UTILITY.cmd` antes de executar. Ele altera Registro, serviços e tarefas agendadas do Windows; veja a seção de segurança e restauração do [README](README.md).
