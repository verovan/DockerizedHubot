FROM debian:stretch
# Install packages
RUN apt-get update
RUN apt-get -y install expect redis-server curl build-essential libssl-dev libexpat1-dev curl
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y nodejs 
# Install HuBot
RUN npm install -g yo generator-hubot
RUN npm install --save hubot-hipchat moment mysql cli-table validator
# Create hubot user
RUN useradd -d /opt/hubot -m -s /bin/bash -U hubot
# Log in as hubot user and change directory
USER hubot
WORKDIR /opt/hubot
RUN mkdir /opt/hubot/scripts
# Install hubot
RUN yo hubot --owner="verovan" --name="verovanBot" --description="Hubot inside Docker" --defaults --adapter=hipchat
# Remove hubot-scripts.json - Deprecated
RUN rm /opt/hubot/hubot-scripts.json
# Add custom scripts
ADD hubot/scripts/*\.coffee /opt/hubot/scripts/
# Add scripts for specific tasks
ADD hubot/tasks/* /opt/hubot/tasks/
# Set env variables
ENV HUBOT_HIPCHAT_JID="XXXX_XXXX@chat.hipchat.com"
ENV HUBOT_HIPCHAT_ROOMS="XXXX_XXXXX@conf.hipchat.com,XXXXX_XXXXX@conf.hipchat.com"
ENV HUBOT_HIPCHAT_JOIN_ROOMS_ON_INVITE="true"
ENV HUBOT_LOG_LEVEL="debug"
ENV HUBOT_HIPCHAT_RECONNECT="true"
ENV HUBOT_HIPCHAT_JOIN_PUBLIC_ROOMS="false"
# Run hubot 
CMD ["/opt/hubot/bin/hubot", "--adapter", "hipchat"]
