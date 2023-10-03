from debian
RUN apt-get update
RUN apt-get -y install python3
RUN apt-get -y install python3-pip
RUN apt-get -y install python3-venv
RUN apt-get -y install python3-rpi.gpio

RUN apt-get install -y ca-certificates curl
RUN apt-get install -y apt-transport-https
RUN curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://dl.k8s.io/apt/doc/apt-key.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list
RUN apt-get -y update
RUN apt-get -y install kubectl
RUN apt-get -y install iputils-ping

RUN rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/python/venv
WORKDIR /opt/python/
RUN python3 -m venv venv
ENV PATH="/opt/python/venv/bin:$PATH"
RUN pip3 install blinkt

WORKDIR /opt/python/venv

COPY setLights.py .
COPY init.sh .
COPY monitor.sh .
COPY reset.sh .

