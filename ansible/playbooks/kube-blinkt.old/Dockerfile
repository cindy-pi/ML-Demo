
from debian

RUN apt-get update \
 && apt-get install --assume-yes --no-install-recommends \
      python3 \
      python3-pip \
      python3-rpi.gpio \
 && rm -rf /var/lib/apt/lists/* \
 && pip3 install blinkt \
 && install -d -o root -g root -m 0755 /src

RUN apt-get update
RUN apt-get install -y ca-certificates curl
RUN apt-get install -y apt-transport-https
RUN curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list
RUN apt-get update
RUN apt-get install -y kubectl

COPY --chown=root:root main.py /src/

WORKDIR /src

VOLUME ["/src"]

ENTRYPOINT ["/usr/bin/python3"]

CMD ["main.py"]


