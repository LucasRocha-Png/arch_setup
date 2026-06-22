#!/bin/bash

# Define o IP do seu celular
CELULAR_IP="192.168.4.7:5555"

echo "🧹 Limpando instâncias e dispositivos virtuais antigos..."
# 1. Derruba qualquer scrcpy que tenha ficado travado em background
killall -q scrcpy

# 2. Desconecta o ADB preventivamente para não dar conflito de "já conectado"
adb disconnect $CELULAR_IP 2>/dev/null

# 3. Procura os IDs dos módulos de áudio órfãos e os descarrega
pactl list short modules | grep -E 'VirtualMic|Microfone_Celular' | awk '{print $1}' | xargs -r pactl unload-module

echo "🔌 Conectando ao ADB via Wi-Fi em $CELULAR_IP..."
adb connect $CELULAR_IP

echo "🎙️ Criando os canais de áudio virtuais..."
# Carrega os módulos de áudio e salva os IDs gerados para podermos destruí-los no final
SINK_ID=$(pactl load-module module-null-sink sink_name=VirtualMic sink_properties=device.description="Microfone_Celular")
SOURCE_ID=$(pactl load-module module-remap-source master=VirtualMic.monitor source_name=Microfone_Celular_In source_properties=device.description="Microfone_Celular_Input")

echo "🚀 Iniciando a captura de áudio com baixa latência..."
echo "Pressione [CTRL+C] a qualquer momento para encerrar e limpar tudo."

# O pulo do gato: PULSE_SINK=VirtualMic força o scrcpy a nascer já plugado no cabo virtual!
PULSE_SINK=VirtualMic scrcpy --no-video --audio-source=mic --audio-buffer=20 -s $CELULAR_IP

echo ""
echo "🧹 Limpando os dispositivos virtuais e desconectando..."
pactl unload-module $SOURCE_ID 2>/dev/null
pactl unload-module $SINK_ID 2>/dev/null
adb disconnect $CELULAR_IP

echo "✅ Tudo finalizado e limpo!"
