### Segue a explicação linha por linha do script de monitoramento!
1. ```#!/bin/bash``` -> indica que o script deve ser executado usando o interpretador bash, garante que os comandos sejam interpretados corretamente.
2. ```PATH=/usr/bin:/bin:/usr/local/bin``` -> Define o PATH (variável de ambiente que indica onde o sistema procura executáveis), garante que comandos como ```curl``` e ```date``` sejam encontrados.
3. ```# CONFIGURAÇÕES``` -> Comentário para marcar o início da seção onde ficam as variáveis configuráveis do script.
4. ```SITE="http://localhost"``` -> define a URL do site a ser monitorado
5. ```LOG="/var/log/monitoramento.log"``` -> define o caminho do arquivo de log onde as mensagens de status serão gravadas. O arquivo "monitoramento.log" foi criado e usado para guardar esse histórico.
6. ```DATA=$(date "+%d.%m.%Y %H:%M:%S")``` -> executa o comando para pegar a hora e data atual formatada. %d.%m.%Y → dia.mês.ano | %H:%M:%S → hora:minuto:segundo.
7. ```DISCORD_WEBHOOK``` -> Token gerado do Webhook
8. ```TELEGRAM_BOT_TOKEN``` -> Token gerado do Bot do Telegram
9. ```TELEGRAM_CHAT_ID``` -> ID do chat gerado do Telegram. Do tópico 7 ao 9 são as chaves/tokens e IDs que o script vai usar para enviar notificações. Você deve substituir esses valores pelas suas informações reais. Por questões de segurança, muito cuidado ao expô-los.
10. ```STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$SITE")``` -> Aqui ocorre a verificação do status do site. O ```curl``` é uma ferramenta para fazer requisições HTTP. O parâmetro ```-s```: mostra de forma silenciosa, sem mostrar progresso ou mensagens. O ```-o /dev/null```: descarta a saída do conteúdo da página (não salva). ```-w "%{http_code}"```: escreve na saída do código HTTP retornando. O resultado é capturado e armazenado na variável ```STATUS```.
11. ```if ["STATUS" != "200"]; then``` -> Testa se o código HTTP não é igual a 200 (que significa “OK”, site funcionando normalmente). Se for diferente, considera que o site está fora do ar (ou inacessível). Se for 200, o site está OK.
  12. ```MSG="[$DATA] SITE FORA DO AR: $SITE retornou status $STATUS"``` -> Cria uma mensagem formatada com data, url do site e código de erro HTTP.
  13. ```echo "$MSG" >> "$LOG"``` -> ```echo``` imprime a mensagem e ```>>``` redirecionada a saída para o arquivo ```LOG``` no modo append (acrescenta sem apagar o que já tem)
  14. ```curl -s -H "Content-Type: application/json" \``` -> usa ```curl``` para enviar um POST para a URL do webhook. ```-s``` silencioso: ```-H "Content-Type: application/json" ```: define o cabeçalho para JSON.
  15. ```-X POST \``` -> método HTTP POST.
  16. ```-d "{\"content\": \"$MSG\"}" \``` -> corpo da requisição JSON com a chave ```content``` contendo a mensagem.
  17. ```"$DISCORD_WEBHOOK"``` -> URL do webhook do Discord.
  18. ```curl -s -X POST "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage" \``` -> Envia uma requisição POST para a API do Telegram para enviar mensagem. Endpoint usado: ```sendMessage``` do bot.
  19. ```-d "chat_id=$TELEGRAM_CHAT_ID&text=$MSG" ``` -> dados enviados via ```-d```. ```chat_id```: id do chat onde a mensagem será enviada. ```text```: texto da mensagem (a variável MSG). O token do bot é usado na URL para autenticação.
  20. ```echo "[$DATA] SITE OK ($STATUS)" >> "$LOG" ``` -> No ```else``` (quando o site está ok). Apenas registra no arquivo de log que o site respondeu OK. Não envia nenhuma notificação para o Discord e nem o Telegram.
  21. ```if ! systemctl is-active --quiet nginx; then``` -> verifica se o serviço Nginx está rodando. O --quiet faz o comando rodar silenciosamente, sem saída. o ! inverte o resultado: se o Nginx **não** estiver ativo, o if entra no bloco, se estiver ativo, pula o bloco.
  22. ```RESTART_MSG="[$DATA] nginx parado. Reiniciando serviço"``` -> Monta uma mensagem informativa pra ser gravada no log, com a data e hora.
  23. ```echo "$RESTART_MSG" >> "$LOG"``` -> Grava a mensagem no arquivo de log definido em $LOG, usando ```>>``` para acrescentar ao final do arquivo, sem apagar dados anteriores.
  24. ```systemctl restart nginx``` -> comando que reinicia o serviço nginx
  25. ``` echo "[$DATA] nginx reiniciado." >> "$LOG" ``` -> após reiniciar, grava nos logs a informação de que o nginx foi reiniciado.
  26. ```fi``` -> fecha o bloco if
  27. ```if [ -f "$FLAG" ]; then``` -> Se o arquivo-flag existe, significa que ele estava parado antes e agora voltou
  28.``` UP_MSG="[$DATA] SERVIDOR DE VOLTA AO AR!!"``` -> Monta a mensagem de "volta ao ar" com timestamp vindo de $DATA
  29. ```echo "$UP_MSG" >> "$LOG"``` -> Registra a mensagem no arquivo de log definido em $LOG
  30.```curl -s -H "Content-Type: application/json" \``` ->
  31. ```-X POST \```
  32. ```-d "{\"content\": \"$UP_MSG\"}" \```
  33. ```"$DISCORD_WEBHOOK"```
  34. ```curl -s -X POST "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/    sendMessage>``` -> faz uma requisição para a API do Telegram falando para enviar a mensagem
  35. ```-d "chat_id=$TELEGRAM_CHAT_ID&text=$UP_MSG"``` -> define para quem enviar e qual texto mandar
  36. ```rm "$FLAG"``` -> remove o arquivo que marcava que o servidor estava fora do ar, para evitar notificações repetidas
  37. ```fi``` -> fecha o bloco if


### Resumo Geral de como funciona:
1. O script é executado de 1 em 1 minuto (pelo cron).
2. Faz uma requisição HTTP para o site configurado e recebe o código de resposta.
3. Se o código não for 200, registra no log o problema e envia alertas para o Discord e o Telegram.
4. Se o código for 200, registra no log que o site está funcionando normalmente.
5. Também faz a verificação do Nginx para saber se está ativo:
   5.1 se estiver parado, registra no log, reinicia o serviço e cria um arquivo de flag para marcar a ocorrência.
   5.2 se voltar a funcionar e a flag existir, registra no log e enviar notificações informando a recuperação, depois remove essa flag.

### Pontos importantes!
-> **Permissão:** o script precisa de permissão para gravar no arquivo /var/log/monitoramento.log. É necessário acrescentar a permissão com o comando ```chmod +x ``` + o caminho na qual o seu arquivo .sh se encontra.

-> **Substituir os Tokens**: os valores das variáveis do Discord e do Telegram devem ser reais para que as notificações funcionem.

## Configuração do Cron
O Cron é um agendador de tarefas do Linux que permite executar comandos/scripts automaticamente em intervalos regulares.
1. Abra o crontab para edição:
```bash
crontab -e 
```
2. Adicione a seguinte linha para executar o script a cada 1 minuto:
```bash
* * * * * /caminho/para/seu/script.sh
```
**Detalhe importante:** use o caminho absoluto para o script e verifique se ele tem permissão de execução (chmod +x script.sh).

3. Salve e feche o editor. Assim o cron irá rodar o seu script automaticamente a cada minuto.


