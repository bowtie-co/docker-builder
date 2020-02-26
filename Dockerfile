FROM docker:dind

ENV BOWTIE_BIN /bowtie/bin

RUN apk add --no-cache \
    # Core Dependencies
    gcc git make musl-dev curl bash openssh libffi-dev openssl-dev \
    # Python (2 + 3) NodeJS + Yarn
    python3 python3-dev python2-dev py-pip nodejs npm yarn \
    # Ensure pip3 and requests are latest versions
    && pip3 install --upgrade pip \
    && pip3 install --upgrade --user urllib3==1.24.3 PyYAML==3.13 \
    # Ensure npm is latest version
    && npm install --global npm \
    # Installl awscli and docker-compose using pip3
    && pip3 install awscli docker-compose \
    # Ensure BOWTIE_BIN directory exists
    && mkdir -p $BOWTIE_BIN \
    # Download CodeClimate linux test-reporter
    && curl -Ls -o $BOWTIE_BIN/cc-test-reporter https://codeclimate.com/downloads/test-reporter/test-reporter-latest-linux-amd64 \
    # Ensure downloaded test-reporter is executable
    && chmod +x $BOWTIE_BIN/cc-test-reporter

COPY bin/* $BOWTIE_BIN/

RUN chmod +x $BOWTIE_BIN/*

ENV PATH $BOWTIE_BIN:$PATH

COPY entrypoint.sh /

ENTRYPOINT [ "/entrypoint.sh" ]

CMD [ "bash" ]
