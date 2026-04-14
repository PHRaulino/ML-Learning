#!/usr/bin/env bash
# SessionStart hook — injeta contexto do projeto ML Learning no Claude.
# A saída stdout vira additionalContext para a sessão.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$REPO_ROOT"

BRANCH="$(git branch --show-current 2>/dev/null || echo 'desconhecida')"

echo "=== ML Learning — Contexto da sessão ==="
echo ""
echo "Branch atual: $BRANCH"
echo ""

echo "--- Metodologia (resumo) ---"
echo "Você é tutor socrático. NUNCA entregue a resposta pronta de labs/exercícios."
echo "Pergunte antes de ensinar. Dê pistas incrementais. Corrija explicando o porquê."
echo "Exceção: modo didático explícito do aluno → pode explicar conceito a fundo."
echo ""
echo "--- Ambiente (resumo) ---"
echo "Dev: MacBook Air M1 (ARM64, sem CUDA). Banco: Postgres no Raspberry Pi (LAN)."
echo "Para detalhes: docs/environment.md, docs/database.md, docs/optional-tools.md."
echo ""

if [ -f "planning/current-focus.md" ]; then
    echo "--- planning/current-focus.md ---"
    cat planning/current-focus.md
    echo ""
fi

if [ -f "memory/progress.md" ]; then
    echo "--- memory/progress.md (resumo) ---"
    head -n 40 memory/progress.md
    echo ""
fi

# Se estamos em uma branch de tópico, puxar performance daquele tópico.
if [[ "$BRANCH" == topic/* ]]; then
    TOPIC="${BRANCH#topic/}"
    PERF_FILE="memory/performance/${TOPIC}.md"
    if [ -f "$PERF_FILE" ]; then
        echo "--- $PERF_FILE ---"
        cat "$PERF_FILE"
        echo ""
    else
        echo "Nota: branch $BRANCH ativa mas $PERF_FILE ainda não existe."
        echo "Criar este arquivo na primeira sessão do tópico."
        echo ""
    fi

    CONCEPT_FILE="planning/concepts/${TOPIC}.md"
    if [ -f "$CONCEPT_FILE" ]; then
        echo "--- $CONCEPT_FILE ---"
        cat "$CONCEPT_FILE"
        echo ""
    fi
fi

echo "--- Checklist para esta sessão ---"
echo "1. Confirmar qual tópico está em andamento."
echo "2. Antes de sugerir próximo passo, ler arquivos citados acima."
echo "3. Ao fim da sessão, atualizar memory/progress.md e memory/performance/<topico>.md."
echo "4. Lembrar: NÃO entregar resposta de exercício. Guiar."
echo ""
echo "=== fim do contexto ==="
