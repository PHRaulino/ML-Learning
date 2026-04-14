# Roadmap de ML — Vivo

> Este arquivo é **vivo**. Ajuste a ordem, adicione/remova tópicos conforme o aprendizado avança e novas lacunas aparecem. A ordem inicial é um ponto de partida razoável — não dogma.

## Status legenda
- ⬜ não iniciado
- 🟨 em andamento (há branch ativa)
- ✅ dominado (já em main)
- 🔁 precisa revisar

## Fase 0 — Fundamentos matemáticos e de dados
- ⬜ Álgebra linear essencial (vetores, matrizes, produto escalar, normas)
- ⬜ Cálculo para ML (derivada, gradiente, regra da cadeia — intuição, não prova)
- ⬜ Probabilidade básica (distribuições, Bayes, esperança)
- ⬜ Estatística descritiva (média, variância, correlação, viés)
- ⬜ Pandas + NumPy na prática (com dados fintrack)
- ⬜ Visualização exploratória (matplotlib, seaborn)

## Fase 1 — Supervisionado clássico
- ⬜ O que é aprendizado supervisionado? Labels, features, generalização
- ⬜ Train/validation/test split, data leakage
- ⬜ Regressão linear (da intuição ao gradiente descendente)
- ⬜ Regressão polinomial e overfitting
- ⬜ Regularização (L1, L2, ElasticNet)
- ⬜ Regressão logística (classificação binária)
- ⬜ Árvores de decisão
- ⬜ Random Forest
- ⬜ Gradient Boosting (XGBoost/LightGBM — conceitos)
- ⬜ k-NN
- ⬜ Naive Bayes
- ⬜ SVM (intuição de margem, kernel)

## Fase 2 — Avaliação e tuning
- ⬜ Métricas de regressão (MAE, MSE, RMSE, R²)
- ⬜ Métricas de classificação (accuracy, precision, recall, F1, ROC/AUC)
- ⬜ Matriz de confusão
- ⬜ Cross-validation (k-fold, stratified)
- ⬜ Hyperparameter tuning (grid, random, bayesian)
- ⬜ Curvas de aprendizado e de validação

## Fase 3 — Feature engineering
- ⬜ Encoding categórico (one-hot, target, ordinal)
- ⬜ Escalonamento (standardization, normalization)
- ⬜ Tratamento de missing values
- ⬜ Feature creation (temporal, agregações, interação)
- ⬜ Seleção de features

## Fase 4 — Não supervisionado
- ⬜ K-means e variantes
- ⬜ Clustering hierárquico
- ⬜ DBSCAN
- ⬜ PCA (intuição + aplicação)
- ⬜ t-SNE / UMAP (visualização)
- ⬜ Detecção de anomalias

## Fase 5 — Séries temporais
- ⬜ Decomposição (tendência, sazonalidade, ruído)
- ⬜ ARIMA/SARIMA
- ⬜ Prophet
- ⬜ Forecast com ML (features temporais)

## Fase 6 — Deep learning (introdução)
- ⬜ Redes neurais do zero (perceptron, MLP)
- ⬜ Backpropagation (intuição)
- ⬜ Frameworks (PyTorch básico)
- ⬜ CNN (breve intro)
- ⬜ RNN/LSTM (breve intro)
- ⬜ Transformers (alto nível)

## Fase 7 — MLOps / produção (overview)
- ⬜ Pipelines (sklearn Pipeline)
- ⬜ Serialização (joblib, pickle)
- ⬜ Versionamento de modelo e dados
- ⬜ Drift e monitoramento

---

## Como atualizar este roadmap

Ao concluir um tópico:
1. Marque como ✅.
2. Se descobriu que o tópico precisava ser quebrado em sub-tópicos, quebre.
3. Se identificou que outro tópico deveria vir antes, reordene.
4. Se apareceu uma lacuna inesperada, adicione.

O aluno e o tutor devem manter esse arquivo honesto — ele é o GPS do projeto.
