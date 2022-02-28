FROM processing
FROM node:12.14.1
MAINTAINER Francisco Ortiz

RUN npm i -g npm
RUN npm i
RUN npm install -g firebase-tools
EXPOSE 9005

COPY . .

# Install base package
RUN apt-get update

RUN wget -O /opt/processing.tgz http://download.processing.org/processing-2.2.1-linux64.tgz 
WORKDIR /
RUN tar xvf processing.tgz
RUN mv processing-2.2.1 processing

# Create symbolic link
RUN bash -c "ln -s /opt/processing/{processing,processing-java} /usr/local/bin/"

# Set start command
RUN bash -c 'echo "processing-java --run --sketch=Sketch --output=Sketch/output" >> /root/.zshrc'
