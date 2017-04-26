# From https://medium.com/@cnadeau_/docker-as-a-cordova-android-application-builder-9e292298c08e
# Creates an environement containing java 8, android SDKs 23/24, node 5.6.0, python 2.7, git, cordova and ionic.
FROM codenvy/ubuntu_android

### NodeJS
ENV NODEJS_VERSION=5.6.0 \
 PATH=$PATH:/opt/node/bin

RUN sudo apt-get update

RUN sudo apt-get install -y nodejs && \
 sudo apt-get install -y npm && \
 sudo apt-get install -y git && \
 sudo apt-get clean

# install cordova, bower and grunt
RUN sudo npm install -g cordova bower grunt-cli && \
 npm cache clean

RUN sudo chown -R user:user ~/tmp && \
  npm config set tmp /tmp
