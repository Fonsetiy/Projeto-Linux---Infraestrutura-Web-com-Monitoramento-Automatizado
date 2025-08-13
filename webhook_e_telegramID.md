## Como conseguir o Webhook no Discord e o token e o chat ID do Telegram ##
### Como criar um Webhook no Discord ###

1. Abra o Discord e vá até o servidor onde você quer receber as notificações.

2. Clique na seta para baixo ao lado do nome do servidor e selecione “Configurações do servidor”.
<img width="316" height="535" alt="a1" src="https://github.com/user-attachments/assets/ba9b678a-fd59-4d67-977d-4f6d35cc73df" />



3. Clique em “Integrações”.
<img width="242" height="119" alt="a2" src="https://github.com/user-attachments/assets/2b817026-15ec-44fc-aa5e-1ca63604843b" />


4. Clique em “Webhooks” e depois em “Novo Webhook”.
<img width="339" height="109" alt="image" src="https://github.com/user-attachments/assets/7326ee3f-4eef-4f3a-a42c-4b0bf7978edc" /> 
<img width="303" height="85" alt="image" src="https://github.com/user-attachments/assets/897f1d49-14b5-4a7f-84f5-4813494a245e" />


5. Configure o webhook -> escolha o nome e o canal de notificações a qual ele irá pertencer.
<img width="669" height="302" alt="image" src="https://github.com/user-attachments/assets/7a7aab80-a571-4f6a-8576-12d3797b0e92" />

6. Clicando em “Copiar URL do Webhook”, você terá a sua variável "DISCORD_WEBHOOK" na qual você irá usar no seu script.
7. Por último, salve as alterações feitas clicando em “Salvar”.

------------------------------------------------------------------------------------------------------------------------------------------
## Como conseguir o chat ID e o token do Telegram
1. Abra o Telegram e procure pelo usuário "@BotFather". Ele é um bot oficial que gerencia todos os bots dentro do Telegram.
<img width="336" height="260" alt="image" src="https://github.com/user-attachments/assets/4b615735-331f-4e47-bc0d-b659501f170d" />


2. Crie um novo bot com o comando ```/newbot```. Siga as instruções, coloque um nome e um usuário único, sendo necessário que o usuário precisa terminar com ```bot```.
<img width="660" height="192" alt="image" src="https://github.com/user-attachments/assets/ca54ad25-89e6-482f-9bd8-6fe2a2df2e6a" />


3. Depois de criar o bot, o BotFather vai enviar uma mensagem com o Token (uma sequência de letras e números). Este token vai ser utilizado na variável "TELEGRAM_BOT_TOKEN".
<img width="485" height="343" alt="a3" src="https://github.com/user-attachments/assets/c2ee19b4-7599-4c8c-9f11-d60005b1f13c" />


4. É necessário descobrir o chat ID adicionando o bot em um grupo e enviando uma mensagem qualquer para o bot. Para obter o ID via API, abra o navegador e digite "https://api.telegram.org/botSEU_TOKEN_DO_BOT/getUpdates" -> Substitua o SEU_TOKEN_DO_BOT pelo token do passo 3. Na resposta JSON, procure pelo campo "chat":{"id": ...}, esse será o TELEGRAM_CHAT_ID.
<img width="267" height="86" alt="a4" src="https://github.com/user-attachments/assets/4f119635-3d9e-44aa-b9ff-b15e0d0e3a19" />


5. Adicione o chat_id e o token do bot ao script nas suas próprias variáveis.


## ATENÇÃO!
-> Nunca compartilhe o token ou chat_id publicamnetes por questões de segurança.
-> Em repositórios públicos, substitua token e chat_id por valores fictício ou variáveis de ambiente.


