# =====================================================
# FARMTECH SOLUTIONS - IR ALÉM 2 (Data Science)
# Análise Estatística + Gráficos para Decisão de Irrigação
# Cultura: Café (dados Embrapa + simulação do projeto)
# =====================================================

cat("=== FarmTech Solutions - Análise Estatística em R ===\n")
cat("Decisão inteligente de irrigação + gráficos completos\n\n")

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

if (media_umidade < 60 && cor_umidade_bomba < -0.4) {
  decisao <- "✅ RECOMENDADO LIGAR A BOMBA (solo seco + correlação forte)"
} else {
  decisao <- "❌ NÃO LIGAR A BOMBA (solo suficientemente úmido)"
}

cat("\n\n🚀 DECISÃO ESTATÍSTICA DA BOMBA:", decisao, "\n")

# ==================== GRÁFICOS ====================

# 1. Gráfico de Barras - Umidade ao longo dos dias
png("assets/grafico_barras_umidade.png", width = 800, height = 500)
barplot(dados$Umidade, 
        names.arg = dados$Data,
        col = "darkgreen",
        main = "Umidade do Solo ao Longo dos Dias (Café)",
        ylab = "Umidade (%)",
        xlab = "Data",
        ylim = c(0, 80))
abline(h = 60, col = "red", lwd = 2, lty = 2)  # linha de referência 60%
text(1:8, dados$Umidade + 3, labels = dados$Umidade, cex = 1.1)
dev.off()
cat("\n📸 Gráfico de Barras salvo em: assets/grafico_barras_umidade.png")

# 2. Gráfico de Pizza - Proporção de dias com bomba ligada
ligada <- sum(dados$Bomba_Ligada)
desligada <- length(dados$Bomba_Ligada) - ligada

png("assets/grafico_pizza_bomba.png", width = 600, height = 600)
pie(c(ligada, desligada),
    labels = c(paste("Ligada\n", ligada, "dias"), 
               paste("Desligada\n", desligada, "dias")),
    col = c("darkgreen", "red"),
    main = "Proporção de Dias com Bomba de Irrigação Ligada")
dev.off()
cat("\n📸 Gráfico de Pizza salvo em: assets/grafico_pizza_bomba.png\n")

cat("\n✅ Análise em R concluída com sucesso! (3 gráficos gerados)\n")