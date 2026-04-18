# Assessment Baseline — phraulino

> Data: 2026-04-15 (primeira sessão)

## Perfil geral

**Área de atuação:** Engenheiro de dados na AWS — arquitetura de dados escalável/segura, facilitação de processos com IA, enriquecimento de relatórios.

**Background técnico:** Dev de software anterior (Python, TypeScript, Go, Angular). Programador experiente e confortável com abstração.

## Pontos fortes identificados

| Área | Nível | Observação |
|---|---|---|
| Programação geral | ⭐⭐⭐⭐⭐ | Fluente em múltiplas linguagens |
| Python | ⭐⭐⭐⭐ | Confortável. Pandas básico dominado. |
| NumPy | ⭐ | Nunca usou de fato, mas aprenderá rápido |
| Jupyter | ⭐⭐⭐⭐ | Usa diariamente, inclusive Interactive Session |
| Intuição prática de ML | ⭐⭐ | Fez projeto de clustering (K-means + PCA + embeddings) com orientação |

## Lacunas identificadas

| Área | Situação |
|---|---|
| Matemática (cálculo) | Não lembra derivadas. Nunca viu gradiente. |
| Álgebra linear | Não lembra produto de matrizes. |
| Probabilidade e estatística | Nunca teve probabilidade formal. |
| Conceitos de ML supervisionado | Não conhece regressão vs classificação. |
| Overfitting / generalização | Nunca ouviu falar. |

## Experiência ML prévia

- Projeto de clustering de dores de clientes (atendimento):
  - Embeddings (text-embedding-3-small, OpenAI) → PCA → normalização → K-means
  - Elbow method com inércia + silhouette para escolha de K
  - Feito com apoio do Claude — aprendeu fazendo, mas sem base teórica formal
- **Conclusão:** tem vocabulário e intuição prática, mas os "porquês" ainda são caixas pretas

## Recomendação de ponto de entrada

Não começar com matemática pura (desmotivador e abstrato para o perfil).
Não pular direto para modelos (lacuna conceitual grande).

**Caminho proposto:**
1. Fase 0: Estatística descritiva + NumPy na prática (com dados do fintrack)
2. Fase 1: Conceitos de supervisionado → Regressão linear (matemática introduzida conforme necessário)
3. Matemática: contextual, introduzida quando o algoritmo exigir

## Próxima sessão após baseline

Branch: `topic/estatistica-descritiva`
Primeiro notebook: EDA com dados de transações do fintrack
