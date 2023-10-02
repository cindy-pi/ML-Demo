# Use an official Python runtime as a parent image
FROM python:3.9-slim
RUN pip install flask

RUN apt-get -y update
RUN apt-get install -y ca-certificates curl
RUN apt-get install -y apt-transport-https
RUN curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://dl.k8s.io/apt/doc/apt-key.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list
RUN apt-get -y update
RUN apt-get -y install kubectl
RUN apt-get -y install iputils-ping

RUN rm -rf /var/lib/apt/lists/*


# Set the working directory in docker
WORKDIR /usr/src/app

# Copy the content of the local src directory to the working directory
COPY . .


# Make port 80 available to the world outside this container
EXPOSE 5000

# Run app.py when the container launches
CMD [ "python3", "demo-server.py" ]
