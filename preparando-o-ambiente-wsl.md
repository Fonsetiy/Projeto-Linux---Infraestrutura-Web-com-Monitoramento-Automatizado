# Preparando o ambinte WSL
## 1. Como instalar e configurar o WSL no Windows 10
#### Pré-requisitos: Windows 10 versão 2004 e superior (Build 19041 e superior) ou Windows 11 para usar os comandos abaixo.
Para realizar a instalação do WSL, abra o PowerShell como administrador e digite o comando:

```wsl --install```

Esse comando habilitará os recursos necessários para executar o WSL e instalar a distribuição do Ubuntu do Linux, que é a padrão.
Após a instalação, para garantir que as atualizações estejam em dia, utilize os comandos:

``` sudo apt update && sudo apt upgrade -y ```

## 2. Instalando o Nginx
Instalar o Nginx:

``` apt install nginx -y```

Habilitar o Nginx:

``` systemctl enable nginx ```

Ligar o Nginx:

 ``` systemctl start nginx ```

Verificar o status do Nginx (se aparecer "Active Running", está funcionando):

``` systemctl status nginx ```

Para verificar se a página do Nginx está on, podemos digital no navegador o endereço "http://localhost", a página padrão irá aparecer da seguinte forma:

![LocalHost do Nginx](https://github.com/user-attachments/assets/e8cdf4eb-1369-4652-b512-5e6e6df86795)

Para alterar a página web, criei um arquivo nomeado "index.html" dentro do diretório /var/www/html.
Utilizando o comando ``` nano ```, alterei o arquivo "index.html" para conseguir colocar outras cores e fontes na página fazendo o uso do código HTML.

![Código HTML alterado](https://github.com/user-attachments/assets/c4469a76-06b6-46ee-82f1-1088caaa0720)

