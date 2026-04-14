# Workflow — Branches, Sessões e Memória

## Branches: um tópico = uma branch

### Criar branch de tópico
```bash
git checkout main
git pull
git checkout -b topic/<nome-curto>
```

Exemplos:
- `topic/regressao-linear`
- `topic/arvore-decisao`
- `topic/feature-engineering`
- `topic/avaliacao-modelo`

### Durante o estudo
Commits frequentes, mensagens descritivas:
```bash
git commit -m "lab: regressão simples preços fintrack"
git commit -m "assessment: score 6/10 em gradiente descendente"
git commit -m "notes: resumo de overfitting"
```

### Fechar tópico (merge pra main)
Só acontece quando o aluno passa no assessment final (ver `docs/methodology.md`).

```bash
# Na branch do tópico
git checkout main
git merge --no-ff topic/<nome>
git branch -d topic/<nome>
```

O conteúdo de `memory/performance/<nome>.md` é movido pra `memory/completed/<nome>.md` como registro permanente.

## Sessão de estudo (dia a dia)

### Início de sessão
O hook `.claude/hooks/session-context.sh` roda automaticamente no `SessionStart` e injeta:
- Branch atual
- Conteúdo de `planning/current-focus.md`
- Resumo de `memory/progress.md`
- Performance do tópico atual (se existir)

Se o hook não injetar (primeira vez, fora do Claude Code, etc.), leia os arquivos manualmente.

### Durante a sessão
- Claude propõe próximo passo com base no contexto.
- Aluno executa (notebook, lab, responder assessment).
- Claude valida, provoca, nunca entrega a resposta.

### Fim de sessão
Claude DEVE atualizar:
1. `memory/performance/<topico>.md` — o que avançou, onde travou, próximos passos.
2. `memory/progress.md` — marcador geral (datas, tópicos em andamento).
3. `planning/current-focus.md` — se mudou foco.

Commit com mensagem descritiva daquela sessão.

## Assessments

Ficam em `planning/assessments/<topico>.md`. Formato:
- **Baseline**: antes de começar o tópico.
- **Checkpoint(s)**: durante o estudo.
- **Final**: gate pra merge em main.

Cada assessment tem perguntas conceituais + mini-desafios práticos. Claude NÃO dá as respostas — apenas corrige após o aluno tentar.

## Trocar de tópico temporariamente

Se precisar pausar um tópico para estudar outro:
1. Commit tudo na branch atual.
2. Atualize `planning/current-focus.md` na `main` dizendo qual branch está pausada e por quê.
3. `git checkout -b topic/<novo>`.

O tópico pausado fica vivo na sua branch; retome quando quiser.

## Quando NÃO criar branch nova

Revisão rápida, leitura de teoria solta, exploração de dados sem commit de aprendizado: pode ficar direto em `main` se não gerar artefato. Qualquer coisa que vire nota, lab ou assessment → branch.
