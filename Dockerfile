FROM giraf:2.3

LABEL maintainer Christian Quentin <christian.quentin@architecte-du-web.com> \
      version="1.1" \
      description="Saisie des équipages NOREV"

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
RUN gem install bundler && bundle install --jobs 4 --without development test assets

COPY . .

# Pour que les assets précompilés restent sous public/assets et soient copiés dans le conteneur de Nginx, 
# lancer la commande suivante dans un terminal (voir dans la branche production) :
# sudo make

# Start puma
CMD bundle exec puma -C config/puma.rb
