#!/bin/bash

# Define o IP do seu celular (Deixe configurado para quando o Wi-Fi estiver disponível)
CELULAR_IP="192.168.4.12:5555"

echo "🧹 Limpando instâncias e dispositivos virtuais antigos..."
killall -q scrcpy 2>/dev/null
pactl list short modules | grep -E 'VirtualMic|Microfone_Celular' | awk '{print $1}' | xargs -r pactl unload-module 2>/dev/null

echo "🔌 Tentando conexão..."
# Tenta desconectar para evitar conflitos de cache e conecta no Wi-Fi
adb disconnect $CELULAR_IP 2>/dev/null
adb connect $CELULAR_IP 2>/dev/null

# Pega o ID do primeiro dispositivo que estiver com o status 'device'
DEVICE_ID=$(adb devices | grep -w "device" | head -n 1 | awk '{print $1}')

# Se a variável estiver vazia, nem o Wi-Fi nem o USB foram detectados
if [ -z "$DEVICE_ID" ]; then
    echo "❌ Nenhum dispositivo encontrado! Verifique se está no cabo ou se o IP está correto."
    exit 1
fi

if [[ "$DEVICE_ID" == *":"* ]]; then
    echo "📱 Dispositivo conectado via Wi-Fi: $DEVICE_ID"
else
    echo "📱 Dispositivo conectado via USB: $DEVICE_ID"
fi

echo "🎙️ Criando os canais de áudio virtuais..."
SINK_ID=$(pactl load-module module-null-sink sink_name=VirtualMic sink_properties=device.description="Microfone_Celular")
SOURCE_ID=$(pactl load-module module-remap-source master=VirtualMic.monitor source_name=Microfone_Celular_In source_properties=device.description="Microfone_Celular_Input")

echo "🚀 Iniciando a captura de áudio com baixa latência..."
echo "Pressione [CTRL+C] a qualquer momento para encerrar e limpar tudo."

# Roda o scrcpy apontando especificamente para o DEVICE_ID que encontramos
PULSE_SINK=VirtualMic scrcpy --no-video --audio-source=mic --audio-buffer=20 -s "$DEVICE_ID"

echo ""
echo "🧹 Limpando os dispositivos virtuais e desconectando..."
pactl unload-module $SOURCE_ID 2>/dev/null
pactl unload-module $SINK_ID 2>/dev/null

# Se estávamos usando Wi-Fi, desconecta a sessão IP
if [[ "$DEVICE_ID" == *":"* ]]; then
    adb disconnect "$DEVICE_ID" 2>/dev/null
fi

echo "✅ Tudo finalizado e limpo!"
