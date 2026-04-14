# Ferramentas opcionais — quando faz sentido adotar

> Lista de ferramentas que **não** são necessárias no dia 1, mas podem entrar conforme o roadmap avança. Cada uma tem um gatilho de adoção: só instale quando o gatilho aparecer — evita complexidade prematura.
>
> O ambiente-base (pandas + sklearn + Jupyter + postgres do Pi) cobre ~80% da jornada. As ferramentas abaixo cobrem os outros 20%.

## Resumo em uma tabela

| Ferramenta | Gatilho de adoção | Onde roda bem neste ambiente |
|---|---|---|
| Docker Desktop / OrbStack | Precisa de serviço isolado ou banco extra | Mac M1 (use OrbStack, mais leve) |
| Postgres local em container | Não quer mexer no Pi para testar migrations/queries | Mac M1 (imagem arm64) |
| JupyterLab (no lugar do clássico) | Quer abas, terminal integrado, file browser | Mac M1 |
| MLflow | Quer versionar experimentos (params, métricas, modelos) | Mac M1 (sqlite local) ou Pi (serviço) |
| DuckDB | Queries analíticas locais sobre parquet/CSV sem Postgres | Mac M1, excelente em arm64 |
| PySpark (local) | Didática de dataframes distribuídos / Fase “big data” | Mac M1 local (overkill para fintrack) |
| PySpark em container | Ambiente reprodutível, evita poluir host | Mac M1 via arm64 image |
| DVC | Versionar datasets grandes ou modelos | Mac M1 |
| Prefect / Dagster | Orquestrar pipelines recorrentes | Pi (serviço) |
| PyTorch + MPS | Começar deep learning | Mac M1 (GPU integrada) |

## 1. OrbStack (substituto leve do Docker Desktop no Mac M1)

**Por que**: Docker Desktop é pesado no M1. OrbStack é nativo arm64, consome muito menos RAM, e tem integração com arquivos do host.

**Instalar**:
```bash
brew install orbstack
```

Depois disso, `docker` e `docker compose` funcionam normalmente.

## 2. Postgres local em container (opcional)

**Gatilho**: você quer brincar com schemas, migrations, ou testar queries sem risco no banco do Pi.

`docker-compose.yml` na raiz (criar quando necessário):
```yaml
services:
  postgres:
    image: postgres:16-alpine
    platform: linux/arm64/v8
    ports: ["5433:5432"]  # 5433 para não conflitar com o do Pi
    environment:
      POSTGRES_USER: sandbox
      POSTGRES_PASSWORD: sandbox
      POSTGRES_DB: sandbox
    volumes:
      - pgdata:/var/lib/postgresql/data
volumes:
  pgdata:
```

## 3. DuckDB (excelente para analytics local)

**Gatilho**: quer rodar SQL analítico rápido sobre arquivos parquet/CSV sem subir banco.

```bash
uv pip install duckdb
```

Caso de uso aqui: exportar snapshot do fintrack para parquet (uma vez) e rodar análises offline, sem depender do Pi.

```python
import duckdb
con = duckdb.connect()
df = con.execute("SELECT * FROM 'snapshots/expenses.parquet' WHERE amount > 1000").df()
```

## 4. PySpark — quando e por quê

**Gatilho didático**: fase de "big data" do roadmap (se entrar). Os dados do fintrack cabem tranquilamente em pandas — **não há razão técnica** para Spark aqui. Mas há razão **didática**: aprender a API de DataFrame distribuído.

### Opção A — PySpark local (mais simples)
```bash
uv pip install -e ".[spark]"  # já incluso como extra
```
Precisa de Java (JDK 17+):
```bash
brew install openjdk@17
```

Roda em local mode usando os cores do M1. Suficiente para treinar o conceito.

### Opção B — PySpark em container (reprodutível)

`docker-compose.yml` parcial:
```yaml
services:
  pyspark:
    image: bitnami/spark:3.5
    platform: linux/arm64
    ports:
      - "8888:8888"  # jupyter
      - "4040:4040"  # spark UI
    volumes:
      - ./practice:/workspace/practice
      - ./data:/workspace/data
    working_dir: /workspace
    command: >
      bash -c "pip install jupyter pyspark &&
               jupyter notebook --ip=0.0.0.0 --no-browser --allow-root"
```

⚠️ **Realismo**: Spark no M1 funciona, mas é pesado. Para o volume do fintrack (~11k transações no total), é **matar mosquito com bazuca**. Use Spark para:
- Praticar API (DataFrame, Window functions, SQL distribuído).
- Um capítulo específico do roadmap ("Fase big data").
- Preparar currículo para vagas que pedem Spark.

Não use no dia a dia.

## 5. MLflow (rastreio de experimentos)

**Gatilho**: começa a comparar muitos modelos/params e perde o fio do que funcionou melhor.

```bash
uv pip install mlflow
mlflow ui --backend-store-uri sqlite:///mlflow.db
```

Com UI rodando na porta 5000, você registra runs dos notebooks:
```python
import mlflow
mlflow.set_tracking_uri("sqlite:///mlflow.db")
with mlflow.start_run():
    mlflow.log_param("alpha", 0.1)
    mlflow.log_metric("rmse", 42.3)
    mlflow.sklearn.log_model(modelo, "model")
```

Pode rodar como serviço no Pi para manter histórico 24/7.

## 6. DVC (versionar dados)

**Gatilho**: você começa a criar snapshots dos dados do fintrack e quer reproduzibilidade.

```bash
uv pip install dvc
dvc init
dvc remote add -d local /Volumes/ExternalDrive/dvc-storage  # ou similar
```

Baixo atrito aqui: snapshots em parquet, versionados via `dvc add`.

## 7. Prefect ou Dagster (orquestração)

**Gatilho**: quer rodar um pipeline (ex: "todo dia exporta snapshot e treina modelo de forecast") de forma automatizada.

Rodar no Pi faz sentido — ele já está ligado 24/7. Comece com Prefect (mais simples) para um primeiro pipeline.

## 8. PyTorch com MPS (GPU do M1)

**Gatilho**: entrou na fase de deep learning.

```bash
uv pip install -e ".[deeplearning]"
```

```python
import torch
device = torch.device("mps" if torch.backends.mps.is_available() else "cpu")
modelo = MeuModelo().to(device)
```

Bom para MLPs pequenas, CNNs de brinquedo, embeddings. Para modelos grandes (transformers treinados do zero), sair do M1.

---

## Regra do tutor

Ao considerar adotar uma ferramenta desta lista, o aluno e o Claude devem responder juntos:

1. **Qual problema concreto ela resolve agora?** (se não há, não instale)
2. **A ferramenta-base resolveria com mais esforço?** (se sim, prefira a base — aprende mais)
3. **Custa barato desligar se não funcionar?** (se não, pense duas vezes)

Complexidade é um custo. Cada ferramenta nova é mais uma coisa para configurar, debugar e manter. Aprender acontece melhor com **menos** ferramentas, mais profundamente.
