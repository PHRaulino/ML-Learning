# Labs

Labs são **roteiros de projeto** — maiores que um notebook simples, aplicando um ou mais conceitos em um problema real do fintrack.

## Estrutura de um lab

Cada lab é uma pasta `lab-<nn>-<nome>/` com:

```
lab-01-prever-gasto-mensal/
├── README.md          # Briefing do problema
├── dados/             # (opcional) extratos/queries SQL
├── notebooks/         # notebooks de trabalho
└── entrega.md         # o que o aluno concluiu + métrica final
```

## Briefing (README.md do lab)

Contém:
- **Problema de negócio** (ex: "prever quanto vou gastar com mercado no próximo mês")
- **Dataset** (quais tabelas/queries do fintrack usar)
- **Restrições** (quais técnicas PODE ou NÃO PODE usar — força aprendizado específico)
- **Critérios de sucesso** (métrica + threshold, ex: "MAE < X reais")
- **Etapas sugeridas** (alto nível — não é passo-a-passo)

## Regra para Claude

O briefing é aberto — dá o problema, não a solução.
- ❌ Não descreva o pipeline passo a passo.
- ❌ Não dê a arquitetura do modelo pronta.
- ✅ Faça perguntas guia ("como você trataria sazonalidade mensal aqui?").
- ✅ Valide a entrega do aluno com olhar crítico.

## Ideias de labs (banco de ideias)

- Classificar transações por categoria a partir da descrição (NLP básico).
- Prever saldo ao fim do mês (regressão / time series).
- Detectar transações anômalas (isolation forest, z-score).
- Clusterizar padrões de gasto (k-means sobre features agregadas).
- Forecast de receitas vs despesas (séries temporais).
- Recomendar orçamento por categoria (regressão sobre histórico).
