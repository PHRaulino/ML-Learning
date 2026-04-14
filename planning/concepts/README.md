# Conceitos

Decomposição detalhada dos tópicos do `roadmap.md` em sub-conceitos atômicos.

## Por que existe esta pasta

O roadmap lista tópicos em alto nível ("Regressão linear"). Um tópico é, na verdade, um conjunto de sub-conceitos que precisam ser dominados separadamente:

- Função de custo
- Gradiente descendente
- Normal equation
- Interpretação dos coeficientes
- Pressupostos do modelo
- Diagnóstico de resíduos
- ...

Cada tópico recebe seu arquivo `<topico>.md` aqui, listando esses sub-conceitos. Isso serve de checklist para saber **o que ainda falta** antes de considerar o tópico dominado.

## Estrutura de um arquivo de conceito

```markdown
# Conceitos: <tópico>

## Sub-conceitos
- [ ] Sub-conceito 1 — o que é, por que importa
- [ ] Sub-conceito 2 — ...
- [ ] ...

## Pré-requisitos
Tópicos que precisam estar sólidos antes de atacar este.

## Armadilhas comuns
Erros típicos de quem está aprendendo.

## Perguntas que o aluno deve conseguir responder
1. ...
2. ...

## Exercícios propostos (aplicados ao fintrack)
1. ...
```

## Regra

Estes arquivos são criados **junto com a branch** do tópico, logo no início. Servem como guia para o aluno e para o Claude durante o estudo daquele tema.
