FROM tairoroberto/base:latest

MAINTAINER Tairo Roberto <tairoroberto@gmail.com>

RUN cd /opt

RUN mkdir android-sdk-linux && cd android-sdk-linux/

RUN dpkg --add-architecture i386 \
    && apt-get -qq update

RUN apt-get update -qq \
  && apt-get install -y software-properties-common  --no-install-recommends \
  && apt-get install -y python-software-properties \
  && apt-get install -y libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386 \

  # use WebUpd8 PPA
  && add-apt-repository ppa:webupd8team/java -y \
  &&  apt-get update -y \

  # PHP repository
  && add-apt-repository -y ppa:ondrej/php \
  && apt-get update -y \

  # automatically accept the Oracle license
  && echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections \
  && apt-get install -y oracle-java8-installer \
  && apt-get install -y oracle-java8-set-default

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

RUN apt-get update -qq \
  && apt-get install -y wget \
  && apt-get install -y maven \
  && apt-get install -y ant \
  && apt-get install -y gradle \
  && apt-get install -y expect \
  && apt-get install -y zip \
  && apt-get install -y unzip \
  && apt-get install -y g++ \
  && apt-get install -y gcc \
  && apt-get install -y make \
  && apt-get install -y subversion \
  && apt-get install -y rar \
  && apt-get install -y curl \
  && apt-get install -y git-core \
  && apt-get install -y apache2 \
  && apt-get install -y php5.6 \
  && apt-get install -y php5.6-dev \
  && apt-get install -y php5.6-curl \
  && apt-get install -y php5.6-json \
  && apt-get install -y php5.6-ldap \
  && apt-get install -y php5.6-odbc \
  && apt-get install -y php5.6-pgsql \
  && apt-get install -y php5.6-mcrypt \
  && apt-get install -y php5.6-sybase \
  && apt-get install -y php5.6-xml \
  && apt-get install -y php5.6-zip \
  && apt-get install -y php5.6-soap \
  && apt-get install -y php5.6-gd \
  && apt-get install -y php5.6-sqlite3 \
  && apt-get install -y php-memcached \
  && apt-get install -y libapache2-mod-php5.6 \
  && apt-get install -y php5.6-bcmath

ENV ANT_HOME=/usr/share/ant
ENV MAVEN_HOME=/usr/share/maven
ENV GRADLE_HOME=/usr/share/gradle


RUN a2enmod rewrite \
  && curl --silent --location https://deb.nodesource.com/setup_8.x | bash -

RUN apt-get update -qq \
  && apt-get install -y nodejs


RUN pecl  uninstall xdebug \
  && pecl  install xdebug \
  && pathxdebug="/usr/lib/php/20170718/xdebug.so" \
  && echo "[XDebug]" >> /etc/php/5.6/apache2/php.ini \
  && echo "zend_extension=$pathxdebug" >> /etc/php/5.6/apache2/php.ini \
  && echo "xdebug.default_enable = 1" >> /etc/php/5.6/apache2/php.ini \
  && echo "xdebug.show_exception_trace = 1" >> /etc/php/5.6/apache2/php.ini \
  && echo "xdebug.show_local_vars = 1" >> /etc/php/5.6/apache2/php.ini \
  && echo "xdebug.var_display_max_data   = -1" >> /etc/php/5.6/apache2/php.ini \
  && echo "xdebug.max_nesting_level = 250" >> /etc/php/5.6/apache2/php.ini \
  && echo "xdebug.remote_enable = 1" >> /etc/php/5.6/apache2/php.ini \
  && echo "xdebug.remote_port = 9000" >> /etc/php/5.6/apache2/php.ini \
  && echo "xdebug.remote_autostart = 1" >> /etc/php/5.6/apache2/php.ini \
  && echo "xdebug.remote_handler=dbgp" >> /etc/php/5.6/apache2/php.ini \
  && echo "xdebug.remote_connect_back = 1" >> /etc/php/5.6/apache2/php.ini \
  && echo "xdebug.idekey=\"PHPSTORM\"" >> /etc/php/5.6/apache2/php.ini \
  && echo "xdebug.remote_host=127.0.0.1" >> /etc/php/5.6/apache2/php.ini \
  && echo -e "\n" >> /etc/php/5.6/apache2/php.ini \
  && echo "[XDebug]" >> /etc/php/5.6/cli/php.ini \
  && echo "zend_extension=$pathxdebug" >> /etc/php/5.6/cli/php.ini \
  && echo "xdebug.default_enable = 1" >> /etc/php/5.6/cli/php.ini \
  && echo "xdebug.show_exception_trace = 1" >> /etc/php/5.6/cli/php.ini \
  && echo "xdebug.show_local_vars = 1" >> /etc/php/5.6/cli/php.ini \
  && echo "xdebug.var_display_max_data   = -1" >> /etc/php/5.6/cli/php.ini \
  && echo "xdebug.max_nesting_level = 250" >> /etc/php/5.6/cli/php.ini \
  && echo "xdebug.remote_enable = 1" >> /etc/php/5.6/cli/php.ini \
  && echo "xdebug.remote_port = 9000" >> /etc/php/5.6/cli/php.ini \
  && echo "xdebug.remote_autostart = 1" >> /etc/php/5.6/cli/php.ini \
  && echo "xdebug.remote_handler=dbgp" >> /etc/php/5.6/cli/php.ini \
  && echo "xdebug.remote_connect_back = 1" >> /etc/php/5.6/cli/php.ini \
  && echo "xdebug.idekey=\"PHPSTORM\"" >> /etc/php/5.6/cli/php.ini \
  && echo "xdebug.remote_host=127.0.0.1" >> /etc/php/5.6/cli/php.ini \
  && echo -e "\n" >> /etc/php/5.6/cli/php.ini \
  && echo "date.timezone = America/Sao_Paulo" >> /etc/php/5.6/apache2/php.ini \
  && echo -e "\n" >> /etc/php/5.6/apache2/php.ini \
  && echo -e "default_charset = \"ISO-8859-1\"" >> /etc/php/5.6/apache2/php.ini \
  && echo -e "\n" >> /etc/php/5.6/apache2/php.ini \
  && echo "date.timezone = America/Sao_Paulo" >> /etc/php/5.6/cli/php.ini \
  && echo -e "\n" >> /etc/php/5.6/cli/php.ini \
  && echo -e "default_charset = \"ISO-8859-1\"" >> /etc/php/5.6/cli/php.ini \
  && echo -e "\n" >> /etc/php/5.6/cli/php.ini \
  && curl -s https://getcomposer.org/installer | php \
  && mv composer.phar /usr/local/bin/composer \
  && composer global require "laravel/installer" \
  && echo "export PATH=$PATH:/home/$USER/.config/composer/vendor/bin" >> /home/$USER/.bashrc \
  && source /home/$USER/.bashrc
  
RUN wget https://dl.google.com/android/repository/tools_r25.2.3-linux.zip

RUN unzip tools_r25.2.3-linux.zip -d /opt/android-sdk-linux

RUN rm -rf tools_r25.2.3-linux.zip

ENV ANDROID_HOME /opt/android-sdk-linux

ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools

RUN echo y | android update sdk --no-ui --all --filter platform-tools | grep 'package installed'

# SDKs
# Please keep these in descending order!
RUN echo y | android update sdk --no-ui --all --filter android-27 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter android-25 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter android-24 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter android-23 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter android-18 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter android-16 | grep 'package installed'

# OR you can install everything like this
# RUN echo y | android update sdk --no-ui | grep 'package installed'

# build tools
# Please keep these in descending order!
RUN echo y | android update sdk --no-ui --all --filter build-tools-27.0.2 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter build-tools-25.0.2 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter build-tools-25.0.1 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter build-tools-25.0.0 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter build-tools-24.0.3 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter build-tools-24.0.2 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter build-tools-24.0.1 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter build-tools-23.0.3 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter build-tools-23.0.2 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter build-tools-23.0.1 | grep 'package installed'

RUN android list sdk --all

# Update SDK
# This is very important. Without this, your builds wouldn't run. Your image would aways get this error:
# You have not accepted the license agreements of the following SDK components: 
# [Android SDK Build-Tools 24, Android SDK Platform 24]. Before building your project, 
# you need to accept the license agreements and complete the installation of the missing 
# components using the Android Studio SDK Manager. Alternatively, to learn how to transfer the license agreements 
# from one workstation to another, go to http://d.android.com/r/studio-ui/export-licenses.html

#So, we need to add the licenses here while it's still valid.
# The hashes are sha1s of the licence text, which I imagine will be periodically updated, so this code will 
# only work for so long.
RUN mkdir "$ANDROID_HOME/licenses" || true
RUN echo -e "\n8933bad161af4178b1185d1a37fbf41ea5269c55" > "$ANDROID_HOME/licenses/android-sdk-license"
RUN echo -e "\n84831b9409646a918e30573bab4c9c91346d8abd" > "$ANDROID_HOME/licenses/android-sdk-preview-license"

RUN apt-get clean

RUN chown -R 1000:1000 $ANDROID_HOME

VOLUME ["/opt/android-sdk-linux"]

RUN chmod -R 777 /var/www

WORKDIR /var/www

ADD ./ /var/www

# Clean up
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    apt-get purge -y --auto-remove $buildDeps && \
    apt-get autoremove -y && apt-get clean
