
// =====================================================
// PROJETO FASE 2 - FarmTech Solutions
// Cultura: CAFÉ
// ESP32 -(Toggle + pH suave)
// =====================================================

// =====================================================
// FARMTECH SOLUTIONS - FASE 2 + IR ALÉM (Python + R)
// Cultura: CAFÉ
// =====================================================

#include <DHT.h>

// ==================== PINOS ====================
#define PIN_BOTAO_N 25
#define PIN_BOTAO_P 26
#define PIN_BOTAO_K 27
#define PIN_LDR 34
#define PIN_DHT 23
#define PIN_RELE 5
#define PIN_LED_BOMBA 2

#define DHTTYPE DHT22

DHT dht(PIN_DHT, DHTTYPE);

// ==================== VARIÁVEIS ====================
bool N_ok = false, P_ok = false, K_ok = false;
float umidade = 0.0, pH = 0.0;
int rainProbability = 0; // NOVO: vem do Python via Serial
bool bombaLigada = false;

// Debounce botões
unsigned long lastDebounceN = 0, lastDebounceP = 0, lastDebounceK = 0;
const int debounceDelay = 200;

void setup()
{
  Serial.begin(115200);
  Serial.println("\n=== FarmTech Solutions - Irrigação Café + IR ALÉM ===");
  Serial.println("Digite CHUVA:XX  (ex: CHUVA:75) para simular previsão de chuva\n");

  pinMode(PIN_BOTAO_N, INPUT_PULLUP);
  pinMode(PIN_BOTAO_P, INPUT_PULLUP);
  pinMode(PIN_BOTAO_K, INPUT_PULLUP);
  pinMode(PIN_RELE, OUTPUT);
  pinMode(PIN_LED_BOMBA, OUTPUT);

  digitalWrite(PIN_RELE, LOW);
  digitalWrite(PIN_LED_BOMBA, LOW);
  dht.begin();
}

void loop()
{
  // Toggle botões NPK
  if (digitalRead(PIN_BOTAO_N) == LOW && millis() - lastDebounceN > debounceDelay)
  {
    N_ok = !N_ok;
    lastDebounceN = millis();
  }
  if (digitalRead(PIN_BOTAO_P) == LOW && millis() - lastDebounceP > debounceDelay)
  {
    P_ok = !P_ok;
    lastDebounceP = millis();
  }
  if (digitalRead(PIN_BOTAO_K) == LOW && millis() - lastDebounceK > debounceDelay)
  {
    K_ok = !K_ok;
    lastDebounceK = millis();
  }

  // Leitura sensores
  umidade = dht.readHumidity();
  int ldrRaw = analogRead(PIN_LDR);
  pH = 5.5 - (ldrRaw * 20.0 / 4095.0);   

  // ==================== NOVO: LER PREVISÃO DE CHUVA VIA SERIAL ====================
  if (Serial.available())
  {
    String comando = Serial.readStringUntil('\n');
    comando.trim();
    if (comando.startsWith("CHUVA:"))
    {
      rainProbability = comando.substring(6).toInt();
      Serial.printf("→ Previsão de chuva atualizada: %d%%\n", rainProbability);
    }
  }

  // ==================== LÓGICA DE IRRIGAÇÃO (Embrapa + IR ALÉM) ====================
  bool condUmidade = (umidade < 60.0);
  bool condPH = (pH >= 5.0 && pH <= 6.0);
  bool condNPK = (N_ok && P_ok && K_ok);
  bool condChuva = (rainProbability <= 40); // suspende se >40% chance de chuva

  bombaLigada = condUmidade && condPH && condNPK && condChuva;

  digitalWrite(PIN_RELE, bombaLigada ? HIGH : LOW);
  digitalWrite(PIN_LED_BOMBA, bombaLigada ? HIGH : LOW);

  // Exibição
  Serial.printf("N:%s P:%s K:%s | pH:%.2f Umidade:%.1f%% | Chuva:%d%% | Bomba:%s\n",
                N_ok ? "OK" : "--", P_ok ? "OK" : "--", K_ok ? "OK" : "--",
                pH, umidade, rainProbability,
                bombaLigada ? "LIGADA" : "desligada");

  delay(1000);
}