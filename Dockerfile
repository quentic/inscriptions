FROM hypriot/rpi-ruby

RUN apt-get update -qq
RUN apt-get install -y build-essential \
       mysql-client libmysqlclient-dev \
    && rm -rf /var/lib/apt/lists/*
           
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
COPY . $INSTALL_PATH

RUN bundle exec rake assets:precompile

MAINTAINER Christian Quentin <christian.quentin@xerox.com>
LABEL version="1.0" \
      description="Saisie des équipages NOREV"

# Start puma
CMD bundle exec puma -C config/puma.rb
