FROM alpine:3.14

RUN apk add --no-cache bash netcat-openbsd supervisor

# openjdk7
RUN apk add --no-cache openjdk7
RUN ln -sf "/usr/lib/jvm/default-jvm/bin/"* "/usr/bin/"

# apache-ant
RUN wget https://archive.apache.org/dist/ant/binaries/apache-ant-1.6.5-bin.tar.gz -O /tmp/apache-ant-1.6.5-bin.tar.gz
RUN tar xvzf /tmp/apache-ant-1.6.5-bin.tar.gz -C /usr/lib/
RUN ln -sf /usr/lib/apache-ant-1.6.5/bin/ant /usr/bin/ant

# git
RUN apk add --no-cache git

# clone c5 repos
RUN git clone -b C5 https://git@bitbucket.org/l2jserver/l2j-server-game.git /tmp/l2j-server-game
RUN git clone -b C5 https://git@bitbucket.org/l2jserver/l2j-server-datapack.git /tmp/l2j-server-datapack

# build c5 projects
RUN ant -buildfile /tmp/l2j-server-game/L2J_Server/build.xml
RUN ant -buildfile /tmp/l2j-server-datapack/L2J_DataPack/build.xml

RUN mkdir /server

# move build files
RUN cp -rf /tmp/l2j-server-game/L2J_Server/build/dist/* /server/
RUN cp -rf /tmp/l2j-server-datapack/L2J_DataPack/build/dist/* /server/

RUN chmod +x /server/login/l2jserver.jar
RUN chmod +x /server/login/RegisterGameServer.sh

# install db
RUN apk add --no-cache expect mysql-client
COPY auto_installer.exp /server/tools/auto_installer.exp
RUN chmod +x /server/tools/database_installer.sh
RUN chmod +x /server/tools/auto_installer.exp

WORKDIR /server

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
