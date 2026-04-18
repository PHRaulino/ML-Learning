# Performance — Estatística Descritiva

## Status
🟨 Em andamento

## Sessões

### 2026-04-15 — Sessão 1 (introdução socrática)

**O que foi coberto:**
- Diferença entre média e variância (conceitual)
- Derivação da fórmula da variância do zero, por raciocínio socrático
- Desvio padrão como raiz da variância (unidade original)
- Validação com pandas na prática (aluno implementou por conta própria)

**Pontos fortes:**
- Chegou à ideia de "elevar ao quadrado para eliminar o sinal" sem dica direta
- Implementou o cálculo manualmente no pandas antes mesmo de receber o notebook
- Entendeu a interpretação prática (alta vs baixa dispersão) com facilidade

**Dificuldades / lacunas:**
- Confundiu variância com quartis inicialmente (associou dispersão a percentis)
- Não sabia que a soma dos desvios em relação à média é sempre zero
- Erro aritmético ao somar desvios (corrigido rapidamente)
- Raiz quadrada como inverso de potência não estava clara de imediato

**Conceitos ainda não vistos:**
- Mediana, moda, quartis, IQR
- Outliers formais (regra do 1.5*IQR)
- Correlação
- Assimetria (skewness)
- Visualizações (histograma, boxplot)

### 2026-04-15 — Sessão 1 (continuação — ddof e correção de Bessel)

**O que foi coberto:**
- Descoberta da diferença entre `.std()` padrão do pandas vs cálculo manual
- Parâmetro `ddof` (degrees of freedom)
- Variância populacional (÷n) vs variância amostral (÷n-1)
- Intuição da correção de Bessel: amostras tendem a subestimar a dispersão real

**Pontos fortes:**
- Foi direto na documentação oficial para entender o parâmetro
- Corrigiu a fórmula manual sozinho após entender o conceito
- Verificou com números concretos qual divisão resulta em valor maior

**Dificuldades:**
- Confundiu a direção do viés inicialmente (disse "superestimar" quando é "subestimar")
- Conceito de graus de liberdade ainda é abstrato — aparecerá novamente em outros contextos

## Assessment final
_Pendente — a fazer ao concluir o notebook 01_
