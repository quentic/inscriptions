FROM hypriot/rpi-ruby 

#ENV http_proxy = "http://proxyprod.xtsfrance.com:8000" \
#    https_proxy = "http://proxyprod.xtsfrance.com:8000"
#RUN export http_proxy=$http_proxy && \
#     export https_proxy=$https_proxy

ENV BUILD_PACKAGES="curl-dev ruby-dev build-base" \ 
    DEV_PACKAGES="tzdata mysql mysql-dev mysql-client nodejs" \
    RAILS_VERSION="5.1.1" 

RUN \ 
  apk --update --upgrade add --no-cache $BUILD_PACKAGES $DEV_PACKAGES

RUN \
  #gem install -N nokogiri -- --use-system-libraries && \ 
  #gem install -N rails --version "$RAILS_VERSION" && \ 
  echo 'gem: --no-document' >> ~/.gemrc && \ 
  cp ~/.gemrc /etc/gemrc && \ 
  chmod uog+r /etc/gemrc && \ 
  
  # cleanup and settings 
  #bundle config --global build.nokogiri "--use-system-libraries" && \ 
  #bundle config --global build.nokogumbo "--use-system-libraries" && \ 
  find / -type f -iname \*.apk-new -delete && \ 
  rm -rf /var/cache/apk/* && \ 
  rm -rf /usr/lib/lib/ruby/gems/*/cache/* && \ 
  rm -rf ~/.gem 


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

#RUN bundle exec rake db:migrate
#RUN bundle exec rake db:seed
RUN bundle exec rake assets:precompile

MAINTAINER Christian Quentin <christian.quentin@xerox.com>
LABEL version="1.0" \
      description="Saisie des équipages NOREV"

# Start puma
CMD bundle exec puma -C config/puma.rb
