FROM ruby:2.3-slim
MAINTAINER Christian Quentin <christian.quentin@xerox.com>
LABEL version="1.0" \
      description="Application de gestion des offres d'impression"

ENV http_proxy "http://proxyprod.xtsfrance.com:8000"
ENV https_proxy "http://proxyprod.xtsfrance.com:8000"
RUN export http_proxy=$http_proxy
RUN export https_proxy=$https_proxy

RUN apt-get update -qq
RUN apt-get install -y build-essential \
       mysql-client \
       pdftk
           
ENV RAILS_ENV=production  
ENV RACK_ENV=production

# On sépare la zone des gems (qui ne bouge pas souvent)
# de la zone de l'appli (qui est plus susceptible de changer)
# => le bundle install est le souvent ignoré lors d'un docker-compose build
COPY Gemfile* /tmp/
WORKDIR /tmp
RUN bundle install

ENV INSTALL_PATH /myapp
RUN mkdir $INSTALL_PATH
WORKDIR $INSTALL_PATH
ADD . $INSTALL_PATH

#RUN bundle exec rake db:migrate
#RUN bundle exec rake db:seed
RUN bundle exec rake assets:precompile

CMD ["rails","server","-b","0.0.0.0"]
