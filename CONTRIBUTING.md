# Como contribuir

Obrigado pelo interesse em melhorar o ART Tweaking Utility.

## Antes de abrir uma issue

- Confira se já existe uma issue parecida.
- Informe a versão do utilitário, a versão do Windows (10 ou 11) e o hardware (CPU e GPU).
- Descreva qual opção do menu foi usada e o que aconteceu.

## Sugerindo um ajuste novo

Para cada ajuste proposto, descreva:

1. O que ele altera (chave de registro, serviço, tarefa ou comando).
2. O ganho esperado e como foi medido (use a aba 15 para medir antes e depois).
3. O risco e como reverter.

Ajustes sem efeito comprovado, que reduzam a segurança sem aviso claro ou que sejam apenas "placebo" não serão aceitos.

## Pull requests

- Mantenha o estilo do arquivo: textos em português do Brasil **sem acentos** nos menus do `.cmd`.
- Salve o `.cmd` com final de linha **CRLF** (o `.gitattributes` cuida disso).
- Não inclua código copiado de outros projetos sem licença compatível e sem crédito.
- Teste em uma máquina virtual ou em um PC com ponto de restauração criado.
- Quando alterar o Debloat ou suas reversões, confira também o modo de simulação (`-DryRun`); ele não cobre os demais menus.
- Atualize o `README.md` e acrescente as mudanças à seção **0.1.3** do `CHANGELOG.md`, enquanto esta versão continuar sendo a versão publicada/em desenvolvimento.
