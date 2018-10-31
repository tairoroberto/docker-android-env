FROM tairoroberto/base:latest

MAINTAINER Tairo Roberto <tairoroberto@gmail.com>

ENV VERSION_SDK_TOOLS "4333796"

ENV ANDROID_HOME /opt/android-sdk-linux
ENV ANDROID_COMPILE_SDK: "27"
ENV ANDROID_BUILD_TOOLS: "27.0.0"
ENV ANDROID_SDK_TOOLS: "27.0.2"
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools
ENV DEBIAN_FRONTEND noninteractive

RUN mkdir -p $ANDROID_HOME 
RUN cd $ANDROID_HOME

RUN apt-get -qq update && \
    apt-get install -qqy --no-install-recommends \
      bzip2 \
      curl \
      wget \
      usbutils \
      libusb-1.0-0-dev \
      openjdk-8-jdk \
      libc6-i386 \
      lib32stdc++6 \
      lib32gcc1 \
      lib32ncurses5 \
      lib32z1 \
      unzip \
      locales \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    
RUN locale-gen en_US.UTF-8

ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

RUN rm -f /etc/ssl/certs/java/cacerts; \
    /var/lib/dpkg/info/ca-certificates-java.postinst configure

RUN wget https://dl.google.com/android/repository/tools_r25.2.3-linux.zip

RUN unzip tools_r25.2.3-linux.zip -d /opt/android-sdk-linux

RUN rm -rf tools_r25.2.3-linux.zip

# SDKs
RUN mkdir -p $ANDROID_HOME/licenses/ \
  && echo "8933bad161af4178b1185d1a37fbf41ea5269c55\nd56f5187479451eabf01fb78af6dfcb131a6481e" > $ANDROID_HOME/licenses/android-sdk-license \
  && echo "84831b9409646a918e30573bab4c9c91346d8abd\n504667f4c0de7af1a06de9f4b1727b84351f2910" > $ANDROID_HOME/licenses/android-sdk-preview-license

ADD packages.txt $ANDROID_HOME
RUN mkdir -p /root/.android && \
  touch /root/.android/repositories.cfg && \
  ${ANDROID_HOME}/tools/bin/sdkmanager --update 

RUN while read -r package; do PACKAGES="${PACKAGES}${package} "; done < $ANDROID_HOME/packages.txt && \
    ${ANDROID_HOME}/tools/bin/sdkmanager ${PACKAGES}


RUN echo no | $ANDROID_HOME/tools/bin/sdkmanager "system-images;android-27;google_apis;x86"

RUN yes | ${ANDROID_HOME}/tools/bin/sdkmanager --licenses

RUN echo no | $ANDROID_HOME/tools/bin/avdmanager create avd -n testAVD -k "system-images;android-27;google_apis;x86" -b x86 -c 100M -d 7 -f

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libqt5widgets5

ENV QT_QPA_PLATFORM offscreen

ENV LD_LIBRARY_PATH ${ANDROID_HOME}/tools/lib64:${ANDROID_HOME}/emulator/lib64:${ANDROID_HOME}/emulator/lib64/qt/lib
