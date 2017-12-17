# DockerizedHubot
Hubot bot inside Docker

You can run Hubot inside a Docker conatainer working with the Hipchat adapter. 

First you need set the ENV variables with the proper values in the Dockerfile for **HUBOT_HIPCHAT_JID** and **HUBOT_HIPCHAT_ROOMS**.

Second, move to the folder where the Dockerfile is and build the container:

```$ docker build -t hubot:latest .```

Launch the container with the following command:

```$ docker run --name hubot -it --env HUBOT_HIPCHAT_PASSWORD='hubot-password' hubot:latest ```
