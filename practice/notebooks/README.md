# Notebooks de prática

Cada tópico tem um ou mais notebooks aqui, nomeados com o prefixo do tópico:

```
regressao-linear-01-intuicao.ipynb
regressao-linear-02-gradiente.ipynb
regressao-linear-03-aplicado-fintrack.ipynb
```

## Estrutura padrão de um notebook didático

1. **Objetivo** — o que vamos aprender/construir.
2. **Pré-requisitos** — o que o aluno já precisa saber.
3. **Dados** — carregamento (idealmente via MCP postgres/fintrack).
4. **Células de exploração** — guiadas por perguntas do tutor.
5. **Células de implementação** — com TODOs e pistas, **sem código pronto**.
6. **Validação** — o aluno verifica o próprio resultado.
7. **Reflexão** — perguntas para pensar.

## Regra de ouro para Claude

- ❌ Não gere notebooks com as células de implementação já preenchidas.
- ✅ Gere notebooks com células vazias marcadas como `# TODO: implemente X` e contexto suficiente para guiar.
- ✅ Se o aluno travar, dê pistas incrementais, não o código.

## Template mínimo

Primeiro notebook de cada tópico deve ter:
- Célula markdown com objetivo e pré-requisitos.
- Célula de import (Claude pode preencher).
- Célula de carga de dados (Claude pode preencher).
- Células de exercício vazias com orientação em markdown.
