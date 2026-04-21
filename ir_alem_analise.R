# =====================================================
# FARMTECH SOLUTIONS - IR ALÉM 2 (Data Science)
# Análise Estatística + Gráficos para Decisão de Irrigação
# Cultura: Café (dados Embrapa + simulação do projeto)
# =====================================================

# Instala ggplot2 se necessário
if (!require(ggplot2)) install.packages("ggplot2")
library(ggplot2)

cat("=== FarmTech Solutions - Análise Estatística em R (ggplot2) ===\n\n")

# ==================== DETECÇÃO AUTOMÁTICA DA PASTA ====================
if (rstudioapi::isAvailable()) {
  # Pega automaticamente a pasta onde o arquivo .R está salvo
  setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
  cat("✅ Diretório detectado automaticamente pelo RStudio\n")
} else {
  cat("⚠️  RStudio não detectado - usando diretório atual\n")
}

cat("📍 Diretório atual:", getwd(), "\n")

# Cria a pasta assets caso não exista
if (!dir.exists("assets")) {
  dir.create("assets")
  cat("✅ Pasta 'assets/' criada automaticamente!\n")
}

# ==================== DADOS HISTÓRICOS ====================
dados <- data.frame(
  Data         = c("2026-04-15", "2026-04-16", "2026-04-17", "2026-04-18",
                   "2026-04-19", "2026-04-20", "2026-04-21", "2026-04-22"),
  Umidade      = c(45, 55, 62, 38, 71, 52, 48, 65),
  pH           = c(5.2, 5.8, 6.1, 4.9, 5.5, 5.7, 5.3, 5.9),
  N_ok         = c(1, 1, 1, 0, 1, 1, 1, 0),
  P_ok         = c(1, 1, 0, 1, 1, 1, 1, 1),
  K_ok         = c(1, 1, 1, 1, 0, 1, 1, 1),
  Bomba_Ligada = c(1, 1, 0, 1, 0, 1, 1, 0)
)

# ==================== ANÁLISE DESCRITIVA ====================
cat("📊 RESUMO ESTATÍSTICO:\n")
print(summary(dados))

cat("\nMédia de Umidade..............:", round(mean(dados$Umidade), 1), "%")
cat("\nDesvio Padrão da Umidade.....:", round(sd(dados$Umidade), 2))
cat("\nMédia de pH...................:", round(mean(dados$pH), 2))
cat("\nCorrelação Umidade x Bomba....:", round(cor(dados$Umidade, dados$Bomba_Ligada), 3))

# ==================== DECISÃO ESTATÍSTICA ====================
media_umidade <- mean(dados$Umidade)
cor_umidade_bomba <- cor(dados$Umidade, dados$Bomba_Ligada)

decisao <- ifelse(media_umidade < 60 && cor_umidade_bomba < -0.4,
                  "✅ RECOMENDADO LIGAR A BOMBA",
                  "❌ NÃO LIGAR A BOMBA")

cat("\n\n🚀 DECISÃO ESTATÍSTICA DA BOMBA:", decisao, "\n\n")

# ==================== GRÁFICOS COM GGPLOT2 ====================

# Gráfico de Barras
grafico_barras <- ggplot(dados, aes(x = Data, y = Umidade)) +
  geom_col(fill = "darkgreen", width = 0.7) +
  geom_hline(yintercept = 60, color = "red", linetype = "dashed", size = 1) +
  geom_text(aes(label = Umidade), vjust = -0.5, size = 5) +
  labs(title = "Umidade do Solo ao Longo dos Dias (Café)",
       x = "Data", y = "Umidade (%)") +
  theme_minimal(base_size = 14)

print(grafico_barras)
ggsave("assets/grafico_barras_umidade.png", grafico_barras, width = 10, height = 6, dpi = 300)

# Gráfico de Pizza
ligada <- sum(dados$Bomba_Ligada)
desligada <- length(dados$Bomba_Ligada) - ligada

dados_pizza <- data.frame(Status = c("Bomba Ligada", "Bomba Desligada"), 
                          Dias = c(ligada, desligada))

grafico_pizza <- ggplot(dados_pizza, aes(x = "", y = Dias, fill = Status)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y") +
  geom_text(aes(label = paste(Dias, "dias")), position = position_stack(vjust = 0.5), size = 5) +
  labs(title = "Proporção de Dias com Bomba de Irrigação Ligada") +
  scale_fill_manual(values = c("darkgreen", "red")) +
  theme_void(base_size = 14) +
  theme(legend.position = "bottom")

print(grafico_pizza)
ggsave("assets/grafico_pizza_bomba.png", grafico_pizza, width = 8, height = 8, dpi = 300)

cat("✅ Gráficos gerados com sucesso e salvos na pasta assets/!\n")
