FROM alpine:3.11

# variable "VERSION" must be passed as docker environment variables during the image build
# docker build --no-cache --build-arg VERSION=2.12.0 -t alpine/helm:2.12.0 .

ARG HELM_VERSION=3.7.2
#ARG KUBECTL_VERSION=1.17.4

# Install helm (latest release)
ENV BASE_URL="https://get.helm.sh"
ENV TAR_FILE="helm-v${HELM_VERSION}-linux-amd64.tar.gz"
RUN apk add --update ca-certificates && \
    apk add --update -t deps bash curl wget openssl && \
    curl -L ${BASE_URL}/${TAR_FILE} | tar xvz && \
    mv linux-amd64/helm /usr/bin/helm && \
    chmod +x /usr/bin/helm && \
    rm -rf linux-amd64 && \
    apk del --purge deps && \
    apk add --no-cache git && \
    rm -f /var/cache/apk/* && \
    rm -f ${TAR_FILE}

# Install kubectl
RUN apk add --update --no-cache curl && \
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    mv kubectl /usr/bin/kubectl && \
    chmod +x /usr/bin/kubectl

WORKDIR /apps
