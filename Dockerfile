# From https://medium.com/@cnadeau_/docker-as-a-cordova-android-application-builder-9e292298c08e
# Creates an environement containing java 8, android SDKs 23/24, node 5.6.0, python 2.7, git, cordova and ionic.
FROM codenvy/ubuntu_android

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
 apt-get purge --auto-remove -y curl && \
 apt-get autoremove -y && \
 apt-get clean

### Python 2.7 & Git
RUN apt-get -qq update && \
 apt-get -qq install -y --no-install-recommends git python && \
 rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
 apt-get purge --auto-remove -y && \
 apt-get autoremove -y && \
 apt-get clean

# install cordova, bower and grunt
RUN npm install -g cordova && \
 npm install -g bower && \
 npm install -g grunt-cli && \
 npm cache clean
