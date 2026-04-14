# Assessments

Aqui ficam os testes e perguntas usados para medir o nível do aluno em cada tópico.

## Tipos

- **`baseline.md`** — avaliação inicial geral, uma vez só no começo do projeto.
- **`<topico>-inicial.md`** — antes de começar a estudar aquele tópico.
- **`<topico>-checkpoint.md`** — durante o estudo, para calibrar rumo.
- **`<topico>-final.md`** — gate para merge na `main`.

## Estrutura de um assessment

```markdown
# Assessment: <tópico> — <fase>

## Data
<YYYY-MM-DD>

## Nível alvo
<iniciante | intermediário | avançado>

## Parte 1 — Conceitual
Perguntas abertas. Aluno responde por escrito em um arquivo de resposta
(`memory/performance/<topico>-<fase>-respostas.md`).

1. ...
2. ...

## Parte 2 — Prática
Mini-desafios que exigem código.

1. ...

## Critério de aprovação
- Parte 1: >= 70% correto.
- Parte 2: todos os desafios concluídos sem ajuda direta.
```

## Regra importante para Claude

Ao corrigir um assessment:
- ❌ Não dê a resposta certa junto com a correção inicial.
- ✅ Aponte onde está errado, peça para o aluno tentar de novo.
- ✅ Só revele a resposta completa depois de 2-3 tentativas ou a pedido explícito.
- ✅ Registre o score em `memory/performance/<topico>.md`.
