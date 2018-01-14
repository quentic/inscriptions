FROM giraf:2.3

LABEL maintainer Christian Quentin <christian.quentin@architecte-du-web.com> \
      version="1.1" \
      description="Saisie des équipages NOREV"

#ENV http_proxy "http://proxy.xtsfrance.com:8000"
#ENV https_proxy "http://proxy.xtsfrance.com:8000"
#ENV http_proxy "http://10.14.1.48:3128"
#ENV https_proxy "http://10.14.1.48:3128"
#RUN export http_proxy=$http_proxy
#RUN export https_proxy=$https_proxy
 
RUN apt-get update -qq \
    && apt-get install -y \
       ssmtp \
    && rm -rf /var/lib/apt/lists/*
           
# copier le fichier de config de sSMTP
COPY config/pour_ssmtp/ssmtp.conf /etc/ssmtp/

ENV RAILS_ENV production 
ENV RACK_ENV production

# Configure the main working directory. This is the base
# directory used in any further RUN, COPY, and ENTRYPOINT
# commands.
ENV INSTALL_PATH /myapp
RUN mkdir -p $INSTALL_PATH
WORKDIR $INSTALL_PATH

COPY Gemfile Gemfile.lock ./ 
RUN gem install bundler && bundle install --jobs 4 --without development test

COPY . .

# A priori, il faut effectuer cette opération dans le conteneur app pour que les assets précompilés restent sous public/assets
# Sinon, la pré-compilation a bien lieu mais le résultat est stocké dans un conteneur provisoire qui est détruit ensuite
#RUN rake assets:precompile

# Start puma
CMD bundle exec puma -C config/puma.rb
