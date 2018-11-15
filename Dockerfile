# Usando uma imagem do ruby 
FROM ruby:2.5.0-slim
# Instalando dependências
RUN apt-get update && \
    apt-get install -y gnupg build-essential wget \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list \
    && apt-get update && apt-get -y install google-chrome-stable
# Setando variaveis 
ENV APP_HOME /app \
    HOME /root
# Criando a pasta app
WORKDIR $APP_HOME
# Copiando o Gemfile pra pasta app
COPY Gemfile* $APP_HOME/
# Intalando as gems
RUN bundle install
# Copiando o projeto para pasta app
COPY . $APP_HOME
# Colocando o comando default
CMD bundle exec cucumber
`Å