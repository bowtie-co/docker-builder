FROM docker:dind

ENV BOWTIE_BIN /bowtie/bin
ENV GLIBC_VER=2.31-r0

RUN apk add --no-cache \
    # Core Dependencies
    gcc git make musl-dev curl bash openssh libffi-dev libc-dev openssl-dev rust cargo binutils \
    # Python (2 + 3) NodeJS + Yarn
    python3 python3-dev py-pip nodejs npm yarn \
    # Install glibc compatibility for alpine + awscli (v2)
    && curl -sL https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub -o /etc/apk/keys/sgerrand.rsa.pub \
    && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-${GLIBC_VER}.apk \
    && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-bin-${GLIBC_VER}.apk \
    && apk add --no-cache \
        glibc-${GLIBC_VER}.apk \
        glibc-bin-${GLIBC_VER}.apk \
    && curl -sL https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip \
    && unzip awscliv2.zip \
    && aws/install \
    && rm -rf \
        awscliv2.zip \
        aws \
        /usr/local/aws-cli/v2/*/dist/aws_completer \
        /usr/local/aws-cli/v2/*/dist/awscli/data/ac.index \
        /usr/local/aws-cli/v2/*/dist/awscli/examples \
    && apk --no-cache del \
        binutils \
    && rm glibc-${GLIBC_VER}.apk \
    && rm glibc-bin-${GLIBC_VER}.apk \
    # Clear apk cache
    && rm -rf /var/cache/apk/* \
    # Ensure pip is latest version
    && pip install --upgrade pip \
    # Ensure npm is latest version
    && npm install --global npm \
    # Installl awscli and docker-compose using pip3
    && pip install docker-compose \
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
