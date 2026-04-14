# Banco fintrack — resumo de schema

> Mapa rápido do banco para orientar queries e escolha de problemas ML. Fonte: introspecção via `information_schema`. Schema: `public`.
>
> ⚠️ Sempre confirme com query antes de assumir. Schemas evoluem.

## Organização geral

Multi-tenant por `workspace_id` (uuid). Quase toda tabela "de domínio" carrega esse campo. Ao filtrar, descobrir primeiro qual workspace é o seu (normalmente é único nas queries pessoais).

Ids são `uuid`. Valores monetários são `numeric`. Datas de transação são `date`; timestamps são `timestamp with time zone`.

## Tabelas de domínio (as importantes pra ML)

### Transações
| Tabela | Linhas* | Descrição | Chaves para ML |
|---|---:|---|---|
| `expenses` | ~3.8k | Despesas em conta | `transaction_date`, `amount`, `description`, `category_id`, `sub_category_id`, `account_id` |
| `incomes` | ~1.8k | Receitas em conta | idem |
| `card_expenses` | ~5.6k | Despesas em cartão | idem + `card_id`, `billing_month` |
| `card_payments` | ~186 | Pagamentos de fatura | `amount`, `account_id`, `card_id`, `billing_month` |
| `transfers` | ~293 | Transferências entre contas | `source_account_id`, `destination_account_id` |
| `investment_deposits` | ~24 | Aportes | `investment_id`, `account_id` |
| `investment_withdrawals` | ~34 | Resgates | idem |
| `investment_value_history` | 0* | Valor histórico dos investimentos | vazia por ora |

_* contagens aproximadas, tiradas na criação deste doc; reconfirme com `SELECT COUNT(*)`._

Período dos dados: **2017 → 2026** (para `expenses`, `incomes`, `card_expenses`). Muito material para séries temporais.

### Dimensões
| Tabela | Descrição |
|---|---|
| `accounts` | Contas (`CHECKING`, `SAVINGS`, `WALLET`, `INVESTMENT`, `CRIPTO`, `CRIPTOWALLET`) |
| `cards` | Cartões de crédito (com `credit_limit`, `closing_date`, `due_date`) |
| `categories` | Categorias (`INCOME`, `EXPENSE`, `GOALS`) com coluna `vector` (embedding) |
| `sub_categories` | Sub-categorias, também com `vector` |
| `tags` | Tags livres |
| `currencies` / `exchange_rates` | Moedas e cotações |

### Recorrências e planejamento
| Tabela | Descrição |
|---|---|
| `recurring_expenses` / `recurring_incomes` | Templates recorrentes com `frequency` |
| `recurring_card_transactions` | Idem para cartões |
| `recurring_transfers` | Transferências recorrentes |
| `budgets` | Orçamento planejado por `category_id` / `month` / `year` |
| `goals` + `goal_deposits` + `goal_investments` | Metas financeiras |
| `invoices` | Faturas de cartão |

### Utilitárias
| Tabela | Descrição |
|---|---|
| `staged_transactions` | Área de staging para imports (CSV, etc.) com `data jsonb` |
| `import_sessions` | Sessões de import |
| `category_embeddings` | Embeddings de categoria (pré-calculados) |
| `recurring_match_aliases` | Apelidos para casar transações a recorrências |

### Auth / infra (ignorar para ML)
`users`, `user_identities`, `workspaces`, `workspace_members`, `workspace_invites`, `api_keys`, `mfa_*`, `passkey_*`, `refresh_tokens`, `password_reset_tokens`, `email_verification_tokens`, `account_deletion_tokens`, `webauthn_sessions`, `notifications`, `user_preferences`.

## ENUMs úteis

```
account_type:           CHECKING, SAVINGS, WALLET, INVESTMENT, CRIPTO, CRIPTOWALLET
category_type:          INCOME, EXPENSE, GOALS
goal_priority:          HIGH, MEDIUM, LOW
goal_type:              MANUAL, INVESTMENT
index_type:             CDI, IPCA, SELIC, FIXED
investment_type:        CDB, LCI, LCA, TESOURO_DIRETO, FUNDO, ACAO, FII, CRYPTO, POUPANCA, OUTRO
invoice_status:         OPEN, PAID, OVERDUE
liquidity_type:         DAILY, MONTHLY, AT_MATURITY
staged_transaction_*:   (vários)
transaction_frequency:  DAILY, WEEKLY, BIWEEKLY, MONTHLY, BIMONTHLY, QUARTERLY, YEARLY
transaction_status:     VALIDATING, PAID, PENDING, IGNORE
user_identity_provider: github, google, native
```

## Joins mais comuns

```sql
-- Despesa com nome da categoria e conta
SELECT e.transaction_date, e.description, e.amount,
       c.name AS categoria, sc.name AS subcategoria,
       a.name AS conta
FROM expenses e
JOIN categories c       ON c.id = e.category_id
LEFT JOIN sub_categories sc ON sc.id = e.sub_category_id
JOIN accounts a         ON a.id = e.account_id
WHERE e.deleted_at IS NULL
  AND e.transaction_status = 'PAID';

-- Despesa em cartão com cartão e categoria
SELECT ce.transaction_date, ce.description, ce.amount,
       c.name AS categoria, card.name AS cartao, ce.billing_month
FROM card_expenses ce
JOIN categories c ON c.id = ce.category_id
JOIN cards card   ON card.id = ce.card_id
WHERE ce.deleted_at IS NULL
  AND ce.transaction_status = 'PAID';
```

## Boas práticas ao puxar dados

1. **Filtrar `deleted_at IS NULL`** em tabelas com soft delete (`expenses`, `incomes`, `card_expenses`, `transfers`, `investment_*`, `accounts`, `cards`).
2. **Filtrar por `transaction_status`** — normalmente só interessa `PAID`. `VALIDATING`/`PENDING`/`IGNORE` podem distorcer análises.
3. **Cuidado com multi-moeda**: `accounts.currency_code` — considerar converter via `exchange_rates` antes de somar.
4. **Cuidado com recorrências**: cada transação real vive nas tabelas principais (`expenses`, `incomes`, etc.). `recurring_*` são templates — não somar junto.
5. **Cartão**: despesa (`card_expenses`) ≠ pagamento de fatura (`card_payments`). Não somar os dois como "gasto" (seria duplicado).

## Ideias de problemas ML que este schema suporta

- **Classificação de texto** → categorizar `description` de `card_expenses`/`expenses` em `categories`/`sub_categories`. Embeddings já existem em `categories.vector`.
- **Regressão** → prever `amount` agregado mensal por categoria a partir de histórico.
- **Séries temporais** → forecast de saldo, de gastos por categoria, de receitas.
- **Clustering** → agrupar meses ou categorias por padrão de gasto.
- **Anomalia** → detectar transações fora do padrão por categoria/conta.
- **Classificação binária** → prever se uma transação é recorrente (existe em `recurring_*`).
