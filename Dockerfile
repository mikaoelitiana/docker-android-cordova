# From https://medium.com/@cnadeau_/docker-as-a-cordova-android-application-builder-9e292298c08e
# Creates an environement containing java 8, android SDKs 23/24, node 5.6.0, python 2.7, git, cordova and ionic.
FROM codenvy/ubuntu_android

### NodeJS
ENV NODEJS_VERSION=5.6.0 \
 PATH=$PATH:/opt/node/bin

RUN sudo apt-get update

RUN sudo apt-get install nodejs && \
 sudo apt-get install npm && \
 sudo apt-get clean

### Python 2.7 & Git
RUN sudo apt-get -qq update && \
 sudo apt-get -qq install -y --no-install-recommends git python && \
 sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
 sudo apt-get purge --auto-remove -y && \
 sudo apt-get autoremove -y && \
 sudo apt-get clean

# install cordova, bower and grunt
RUN sudo npm install -g cordova bower grunt-cli && \
 npm cache clean
