import requests
import time

# ==================== CONFIGURAÇÃO ====================
API_KEY = "de36de7ab892116793c01c5c42924131"          # pegue grátis em: https://openweathermap.org/api
CIDADE = "São Paulo,BR"        # sua região de café 
UNIDADE = "metric"             # "metric" para °C

def pegar_previsao_chuva():
    url = f"http://api.openweathermap.org/data/2.5/forecast?q={CIDADE}&appid={API_KEY}&units={UNIDADE}"
    try:
        resp = requests.get(url, timeout=8)
        data = resp.json()
        prob_chuva = 0
        for item in data["list"][:3]:  # próximas 3 horas
            prob = item.get("pop", 0) * 100    # probabilidade de chuva
            if prob > prob_chuva:              
                prob_chuva = int(prob)         
        print(f"\nPrevisão de chuva (próximas 3h): {prob_chuva}%")
        return prob_chuva
    except:
        print("Erro ao consultar API. Usando valor manual.")
        return int(input("Digite manualmente a % de chuva (0-100): "))

print("=== FarmTech Solutions - Ir Além 1 (OpenWeather) ===")
while True:
    chuva = pegar_previsao_chuva()   # aqui você pode usar o valor para acionar o sistema de irrigação
    print(f"Digite no Serial do Wokwi:  CHUVA:{chuva}")     
    print("-" * 50)  
    time.sleep(60)   # atualiza a cada 1 minuto