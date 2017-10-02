FROM ruby:2.3-slim

#ENV http_proxy "http://proxyprod.xtsfrance.com:8000"
#ENV https_proxy "http://proxyprod.xtsfrance.com:8000"
#RUN export http_proxy=$http_proxy
#RUN export https_proxy=$https_proxy

RUN apt-get update -qq \
    && apt-get install -y build-essential \
       mysql-client libmysqlclient-dev \
       imagemagick libmagickcore-dev libmagickwand-dev \
       pdftk \
       ssmtp \
    && rm -rf /var/lib/apt/lists/*
           
# copier le fichier de config de sSMTP
COPY config/pour_ssmtp/ssmtp.conf /etc/ssmtp/

ENV RAILS_ENV=development   
ENV RACK_ENV=development

# On sépare la zone des gems (qui ne bouge pas souvent)
# de la zone de l'appli (qui est plus susceptible de changer)
# => le bundle install est le souvent ignoré lors d'un docker-compose build
COPY Gemfile* /tmp/
WORKDIR /tmp
RUN gem install bundler && bundle install

ENV INSTALL_PATH /myapp
RUN mkdir $INSTALL_PATH
WORKDIR $INSTALL_PATH
COPY . .

#RUN bundle exec rake db:migrate
#RUN bundle exec rake db:seed
RUN bundle exec rake assets:precompile

MAINTAINER Christian Quentin <christian.quentin@architecte-du-web.com>

LABEL version="1.0" \
      description="Saisie des équipages NOREV"

# Start puma
CMD bundle exec puma -C config/puma.rb
