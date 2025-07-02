# Use uma imagem oficial e leve do Python.
# https://hub.docker.com/_/python
FROM python:3.13.5-alpine3.22

# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia o arquivo de dependências para o diretório de trabalho
# Copiamos este arquivo primeiro para aproveitar o cache de camadas do Docker.
# Se o requirements.txt não mudar, esta camada não será reconstruída.
COPY requirements.txt .

# Instala os pacotes necessários especificados no requirements.txt
# --no-cache-dir: Desativa o cache, o que reduz o tamanho da imagem.
# -r requirements.txt: Instala a partir do arquivo de requisitos.
RUN pip install --no-cache-dir -r requirements.txt

# Copia o resto do código da aplicação para o diretório de trabalho
COPY . .

# Expõe a porta em que o aplicativo é executado
EXPOSE 8000

# Comando para executar a aplicação usando uvicorn
# --host 0.0.0.0 torna o aplicativo acessível de fora do contêiner
# app:app refere-se à instância 'app' no arquivo 'app.py'
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]