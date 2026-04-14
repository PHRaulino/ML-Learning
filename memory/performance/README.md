# Performance por tópico

Aqui ficam os arquivos de desempenho, **um por tópico ativo**. Eles acompanham a branch do tópico.

## Formato do arquivo `<topico>.md`

```markdown
# Performance: <tópico>

## Branch
topic/<nome>

## Datas
- Início: YYYY-MM-DD
- Última sessão: YYYY-MM-DD

## Assessments realizados
| Tipo | Data | Score | Observações |
|---|---|---|---|
| Inicial | ... | X/10 | ... |
| Checkpoint | ... | X/10 | ... |
| Final | ... | X/10 | ... |

## Pontos fortes
- ...

## Lacunas / onde travou
- ...

## Erros recorrentes
- ...

## Sessões
### YYYY-MM-DD
- Atividade: ...
- O que o aluno conseguiu: ...
- Onde precisou de ajuda: ...
- Próximo passo combinado: ...

## Estado
em-andamento | pausado | pronto-para-merge | dominado
```

## Regra

Claude **deve** atualizar este arquivo ao fim de cada sessão significativa daquele tópico. É a fonte da verdade sobre como o aluno está indo.

Quando o tópico for dominado e a branch for mergeada, mover este arquivo para `memory/completed/`.
