#!/bin/bash 
# Caminho absoluto no cron
PATH=/usr/bin:/bin:/usr/local/bin

# CONFIGURAÇÕES
SITE="http://localhost"
LOG="/var/log/monitoramento.log"
DATA=$(date "+%d.%m.%Y %H:%M:%S")

# Webhooks 
DISCORD_WEBHOOK="TOEKN_DO_WEBOOK"
TELEGRAM_BOT_TOKEN="TOEKN_DO_BOT_DO_TELEGRAM"
TELEGRAM_CHAT_ID="CHAT_ID_DO_TELEGRAM"

# VERIFICAÇÃO
STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$SITE")

if [ "$STATUS" != "200" ]; then
    # Mensagem
    MSG="[$DATA] SITE FORA DO AR: $SITE retornou status $STATUS"

    # Log
    echo "$MSG" >> "$LOG"

    # Envia para Discord
    curl -s -H "Content-Type: application/json" \
         -X POST \
         -d "{\"content\": \"$MSG\"}" \
         "$DISCORD_WEBHOOK"

    # Envia para Telegram
    curl -s -X POST "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage" \
         -d "chat_id=$TELEGRAM_CHAT_ID&text=$MSG"
else
    echo "[$DATA] SITE OK ($STATUS)" >> "$LOG"
fi
