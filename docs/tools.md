# Ferramentas disponíveis

## Jupyter Notebooks
Ambiente principal de prática, em `practice/notebooks/`.

Setup recomendado (uma vez):
```bash
python -m venv .venv
source .venv/bin/activate
pip install jupyter numpy pandas matplotlib seaborn scikit-learn sqlalchemy psycopg2-binary
```

Rodar:
```bash
jupyter notebook practice/notebooks/
```

## MCP postgres (banco fintrack)

Acesso direto ao banco do fintrack via SQL. Use para **queries exploratórias** e carga de dados em notebooks.

Exemplos de uso:
- Entender schema: `SELECT table_name FROM information_schema.tables WHERE table_schema='public';`
- Amostrar dados: `SELECT * FROM transactions LIMIT 50;`
- Agregações para feature engineering.

**Regra**: somente leitura durante estudos. Nada de `INSERT`/`UPDATE`/`DELETE` via MCP postgres para não poluir dados reais.

## MCP fintrack

APIs de alto nível do fintrack — mais seguro e conveniente quando a pergunta é de negócio:
- `list_transactions`, `list_expenses`, `list_incomes`
- `get_financial_summary`, `get_budget_summary`
- `list_investments`, `get_portfolio`
- ...

Use quando você quer **dados estruturados** sem pensar em SQL.

## Regra de ouro

Dados do fintrack são o **material de prática preferido** porque:
1. Contexto familiar pro aluno (é o dinheiro dele).
2. Dados reais, com ruído real.
3. Suficientes tabelas pra cobrir regressão, classificação, clustering, séries temporais.

Exemplos de problemas ML sobre fintrack:
- Classificação: categorizar transação automaticamente pela descrição.
- Regressão: prever gasto mensal por categoria.
- Séries temporais: forecast de saldo.
- Clustering: agrupar padrões de gasto.
- Detecção de anomalia: transações fora do padrão.

## O que NÃO usar

- Datasets externos tipo Kaggle/UCI, exceto se o tópico exigir (ex: imagens, NLP genérico).
- Bibliotecas de alto nível que escondem o algoritmo (ex: AutoML) até o conceito estar dominado.
