# From https://medium.com/@cnadeau_/docker-as-a-cordova-android-application-builder-9e292298c08e
# Creates an environement containing java 8, android SDKs 23/24, node 5.6.0, python 2.7, git, cordova and ionic.
FROM ubuntu

RUN apt-get update

### JAVA
RUN set -x && \
 apt-get install -y --no-install-recommends software-properties-common && \
 # use WebUpd8 PPA
 add-apt-repository ppa:webupd8team/java -y && \
 apt-get update -y

# automatically accept the Oracle license
RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 seen true" | debconf-set-selections

RUN apt-get install -y --no-install-recommends oracle-java8-installer && \
 apt-get install -y --no-install-recommends oracle-java8-set-default && \

 # clean up
 rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
 apt-get purge -y — auto-remove software-properties-common && \
 apt-get autoremove -y && \
 apt-get clean

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

### Android SDKs
ENV ANDROID_SDK_URL=”https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz" \
 ANDROID_BUILD_TOOLS_VERSION=23.0.3 \
 # Supported SDKs
 ANDROID_APIS=”android-23" \
 ANT_HOME=”/usr/share/ant” \
 MAVEN_HOME=”/usr/share/maven” \
 GRADLE_HOME=”/usr/share/gradle” \
 ANDROID_HOME=”/opt/android-sdk-linux”

ENV PATH $PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$ANDROID_HOME/build-tools/$ANDROID_BUILD_TOOLS_VERSION:$ANT_HOME/bin:$MAVEN_HOME/bin:$GRADLE_HOME/bin

RUN dpkg — add-architecture i386 && \
 apt-get -qq update && \
 apt-get -qq install -y --no-install-recommends curl libstdc++6:i386 zlib1g:i386 && \
 # Installs Android SDK
 curl -sL ${ANDROID_SDK_URL} | tar xz -C /opt && \
 echo y | android update sdk -a -u -t platform-tools,${ANDROID_APIS},build-tools-${ANDROID_BUILD_TOOLS_VERSION} && \
 chmod a+x -R $ANDROID_HOME && \
 chown -R root:root $ANDROID_HOME && \
 # clean up
 rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
 apt-get purge -y — auto-remove curl && \
 apt-get autoremove -y && \
 apt-get clean

### NodeJS
ENV NODEJS_VERSION=5.6.0 \
 PATH=$PATH:/opt/node/bin

RUN apt-get -qq update && \
 apt-get -qq install -y --no-install-recommends curl ca-certificates && \
 mkdir -p /opt/node && \
 cd /opt/node && \
 curl -sL https://nodejs.org/dist/v${NODEJS_VERSION}/node-v${NODEJS_VERSION}-linux-x64.tar.gz | tar xz — strip-components=1 && \
 cd ../.. && \
 rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
 apt-get purge -y — auto-remove curl && \
 apt-get autoremove -y && \
 apt-get clean

### Python 2.7 & Git
RUN apt-get -qq update && \
 apt-get -qq install -y --no-install-recommends git python && \
 rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
 apt-get purge -y — auto-remove && \
 apt-get autoremove -y && \
 apt-get clean
 # install cordova, bower and grunt

RUN npm install -g cordova && \
 npm install -g bower && \
 npm install -g grunt-cli && \
 npm cache clean
