# FIAP - Faculdade de Informática e Administração Paulista

<p align="center">
  <a href="https://www.fiap.com.br/"><img src="assets/logo-fiap.png" alt="FIAP" border="0" width="40%" height="40%"></a>
</p>

<br>

# 📌 FarmTech Solutions – Irrigação Inteligente para Cafeicultura

## 👨‍🎓 Integrantes
- [Jeliel Cardoso](https://www.linkedin.com/in/jelielcardoso/)
- [Denis Paulo](https://www.linkedin.com/in/denispaulodiassilva/)
- [Deweyne Reuel](https://www.linkedin.com/in/deweyne-reuel-0695522a8/)
- [Matheus Nascimento](https://www.linkedin.com/in/mathnascimento/)

## 👩‍🏫 Professores
### Tutor(a)
- [Sabrina Otoni](https://www.linkedin.com/in/sabrina-otoni-22525519b/)
### Coordenador(a)
- [André Godoi](https://www.linkedin.com/in/andregodoichiovato/)

---

## 📖 Descrição

A **FarmTech Solutions** desenvolve soluções de Agricultura Digital para aumentar a produtividade e a sustentabilidade no campo. Nesta Fase 2 do projeto, construímos um **protótipo funcional de sistema de irrigação inteligente** direcionado à cultura do **Café**, principal lavoura de grande porte do Sudeste brasileiro.

O sistema monitora em tempo real os fatores críticos definidos pela Embrapa (Circular Técnica 152): umidade do solo, pH, e níveis de Nitrogênio (N), Fósforo (P) e Potássio (K). Quando todas as condições ideais são atendidas, a bomba de irrigação é acionada automaticamente. Caso haja previsão de chuva, o sistema suspende a irrigação para evitar desperdício de água.

**Diferenciais da solução:**
- Integração IoT com simulação física no Wokwi
- Integração com API OpenWeather para previsão meteorológica em tempo real
- Análise estatística em R com tomada de decisão baseada em dados históricos
- Lógica 100% baseada em recomendações técnicas da Embrapa

O resultado é um dispositivo inteligente que otimiza o uso de água, reduz custos operacionais e aumenta a eficiência da lavoura, alinhando-se aos pilares de Agricultura 4.0.

---

## 🚀 Funcionalidades

- Monitoramento em tempo real de umidade (DHT22), pH (LDR) e níveis NPK (botões com toggle)
- Decisão automática de irrigação conforme critérios da Embrapa
- Suspensão inteligente da irrigação com base na previsão de chuva (API OpenWeather)
- Interface via Monitor Serial para comando manual de chuva
- Análise estatística completa em R (média, desvio padrão, correlação e decisão inteligente)
- Geração automática de 3 gráficos profissionais (barras, pizza e dispersão)

---

## 🧠 Tecnologias Utilizadas

- **Hardware/Simulação**: ESP32 (Wokwi.com)
- **Linguagem Embarcada**: C/C++
- **Sensores**: DHT22, LDR, Pushbuttons, Relay Module
- **Integração Meteorológica**: Python + OpenWeatherMap API
- **Análise de Dados**: R + ggplot2 (gráficos)
- **Comunicação**: Monitor Serial (ESP32 ↔ Python)
- **Documentação**: Markdown + GitHub

---

## 📁 Estrutura de Pastas

```bash
FarmTech-Solutions-Fase2/
├── assets/                          # Imagens e gráficos gerados
│   ├── circuito-completo.png
│   ├── serial-monitor.png
│   ├── grafico_barras_umidade.png
│   ├── grafico_pizza_bomba.png
│   └── grafico_analise_irrigacao.png
├── src/
│   └── main.cpp                     # Código completo do ESP32
├── ir_alem_python.py                # Ir Além 1 – API OpenWeather
├── ir_alem_analise.R                # Ir Além 2 – Análise estatística em R
├── README.md
└── .gitignore

⚙️ Como Executar o Projeto
Pré-requisitos

Conta no Wokwi.com
Python 3.8+
RStudio (ou R + RStudio)
Biblioteca requests (Python)

Execução

Clone o repositórioBashgit clone <URL_DO_SEU_REPOSITORIO>
cd FarmTech-Solutions-Fase2
ESP32 (Wokwi)
Abra o projeto no Wokwi
Cole o código de src/main.cpp
Clique em Start

Ir Além 1 – Previsão de Chuva (Python)Bashpython ir_alem_python.pyCopie o comando CHUVA:XX e cole no Serial Monitor do Wokwi.
Ir Além 2 – Análise Estatística (R)
Abra ir_alem_analise.R no RStudio
Pressione Ctrl + Shift + Enter
Os gráficos serão gerados automaticamente na pasta assets/



🧪 Exemplos de Uso

Cenário ideal: umidade = 52%, pH = 5.6, N/P/K = OK, chuva = 25% → Bomba LIGADA
Cenário com chuva: previsão = 75% → Bomba SUSPENSA (mesmo com condições ideais)
Análise R: gera decisão estatística + 3 gráficos profissionais


🗃 Histórico de Versões

2.1.0 – 20/04/2026
Implementados os dois “Ir Além”
Integração Python + OpenWeather
Análise completa em R com 3 gráficos
README profissional

2.0.0 – 19/04/2026
Lógica de irrigação baseada na Embrapa
Toggle nos botões NPK e mapeamento suave de pH



🎯 Melhorias Futuras

Conexão Wi-Fi real com ESP32 e envio de dados para ThingsBoard ou AWS IoT
Dashboard web (Streamlit ou Power BI) com gráficos em tempo real
Integração com sensor de nutrientes real (EC-5 ou NPK 485)
Machine Learning para previsão de irrigação baseada em série histórica
Notificações via Telegram/WhatsApp quando a bomba é acionada


📄 Licença
<img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/cc.svg?ref=chooser-v1"><img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/by.svg?ref=chooser-v1"><p xmlns:cc="http://creativecommons.org/ns#" xmlns:dct="http://purl.org/dc/terms;"><a property="dct:title" rel="cc:attributionURL" href="https://github.com/agodoi/template">MODELO GIT FIAP</a> por <a rel="cc:attributionURL dct:creator" property="cc:attributionName" href="https://fiap.com.br">Fiap</a> está licenciado sobre <a href="http://creativecommons.org/licenses/by/4.0/?ref=chooser-v1" target="_blank" rel="license noopener noreferrer" style="display:inline-block;">Attribution 4.0 International</a>.</p>

**🎥 Vídeo de Demonstração (5 minutos):**  
[▶ Assista ao vídeo completo de funcionamento](https://youtu.be/ZhRJwmskorw)

FarmTech Solutions – Fase 2: Iniciando a coleta de Dados
Tecnólogo em Inteligência Artificial – FIAP