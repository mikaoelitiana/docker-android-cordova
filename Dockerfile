# From https://medium.com/@cnadeau_/docker-as-a-cordova-android-application-builder-9e292298c08e
# Creates an environement containing java 8, android SDKs 23/24, node 5.6.0, python 2.7, git, cordova and ionic.
FROM codenvy/ubuntu_android

RUN sudo apt-get update

RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash - && \
 sudo apt-get install -y --no-install-recommends nodejs git && \
 sudo apt-get clean && \
 sudo rm -rf /var/lib/apt/lists/*
 sudo rm -fr /tmp/*

# install cordova, bower and grunt
RUN sudo npm install -g cordova bower grunt-cli && \
 npm cache clean

RUN sudo chown -R user:user ~/tmp && \
  npm config set tmp /tmp
