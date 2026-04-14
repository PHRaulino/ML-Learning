# Ambiente de estudo

> Contexto do hardware e da topologia onde o aprendizado acontece. Claude deve **ler este arquivo** antes de sugerir ferramentas, tamanhos de dados ou arquiteturas de modelo — o que roda bem em um MacBook Air M1 é diferente do que roda em um servidor x86 com GPU.

## Máquinas

### Dev principal — MacBook Air M1
- **CPU**: Apple Silicon M1 (ARM64, 8 cores)
- **GPU**: integrada Apple (Metal) — útil via PyTorch MPS, não CUDA
- **RAM**: limitada (trabalhar com datasets que caibam em memória, evitar DataFrames > alguns GB)
- **Storage**: SSD interno
- **SO**: macOS (darwin)

**Implicações práticas**
- ✅ Bom para: notebooks, sklearn, pandas, modelos leves, PyTorch via MPS.
- ⚠️ Evitar: TensorFlow-GPU (sem CUDA), imagens de Docker x86 sem `--platform linux/arm64`, datasets que não cabem em RAM.
- 📦 Python: use versão arm64 nativa (`uv`, `pyenv` ou Homebrew) — evita emulação Rosetta.

### Servidor de apoio — Raspberry Pi
- **CPU**: ARM (provavelmente Pi 4 ou Pi 5)
- **RAM**: limitada (1–8 GB)
- **Papel**: hospedar serviços 24/7 — em especial, o **Postgres do fintrack**.

**Implicações práticas**
- ✅ Bom para: rodar o Postgres, agendar jobs leves (cron), servir APIs pequenas.
- ❌ NÃO treinar modelos pesados no Pi — CPU e RAM insuficientes.
- 🔌 O Pi fica ligado na rede local; o MacBook acessa o banco via LAN.

### Banco de dados — Postgres no Pi
- Hospeda o schema do fintrack.
- Acessado por: MCP postgres (nas sessões com Claude) e pela biblioteca `psycopg2`/`sqlalchemy` nos notebooks.
- **Somente leitura** durante os estudos (ver `docs/tools.md`).

## Topologia

```
┌────────────────────────┐         LAN          ┌──────────────────────┐
│ MacBook Air M1 (dev)   │ ───────────────────▶ │ Raspberry Pi         │
│  - Jupyter / notebooks │   TCP 5432 (psql)    │  - Postgres fintrack │
│  - Claude Code         │                      │  - Serviços 24/7     │
│  - Git                 │                      │                      │
└────────────────────────┘                      └──────────────────────┘
```

## Variáveis de ambiente

Ver `.env.example` na raiz. Copie para `.env` local (não versionado) e ajuste:

```
PGHOST=raspberrypi.local   # ou IP fixo do Pi
PGPORT=5432
PGDATABASE=fintrack
PGUSER=...
PGPASSWORD=...
DATABASE_URL=postgresql+psycopg2://...
```

Nos notebooks:
```python
import os
from dotenv import load_dotenv
load_dotenv()
DATABASE_URL = os.environ["DATABASE_URL"]
```

## Decisões com base no hardware

Quando o tutor (Claude) propuser técnicas, considerar este ambiente:

| Situação | Decisão |
|---|---|
| Dataset cabe em RAM do Mac (até ~4 GB) | Pandas + sklearn direto no notebook |
| Dataset maior | Sample primeiro; ou agregar via SQL no Pi antes de trazer |
| Modelo precisa de GPU NVIDIA (CUDA) | ❌ não disponível — buscar alternativa CPU, MPS ou serviço externo |
| Deep learning leve | PyTorch com `device="mps"` no Mac |
| Deep learning pesado | Fora do escopo local; pausar e discutir alternativa |
| Job recorrente / agendado | Pi via cron, se fizer sentido |

## Instalação do ambiente Python

Recomendado: `uv` (mais rápido, suporte arm64 nativo).

```bash
# Uma vez
brew install uv

# No repositório
uv venv
source .venv/bin/activate
uv pip install -e .

# Para funcionalidades opcionais (instale só quando precisar)
uv pip install -e ".[boosting]"
uv pip install -e ".[timeseries]"
uv pip install -e ".[deeplearning]"
```

Alternativa com pip tradicional:
```bash
python3.11 -m venv .venv
source .venv/bin/activate
pip install -e .
```
