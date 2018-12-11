FROM docker:dind

ENV BOWTIE_BIN /bowtie/bin

RUN apk add --no-cache curl bash python2 nodejs yarn make
RUN curl -o- https://bootstrap.pypa.io/get-pip.py | python
RUN pip install awscli docker-compose

RUN mkdir -p $BOWTIE_BIN

RUN curl -L -o $BOWTIE_BIN/cc-test-reporter https://codeclimate.com/downloads/test-reporter/test-reporter-latest-linux-amd64 \
  && chmod +x $BOWTIE_BIN/cc-test-reporter

COPY bin/* $BOWTIE_BIN/

ENV PATH $BOWTIE_BIN:$PATH

COPY entrypoint.sh /

ENTRYPOINT [ "/entrypoint.sh" ]

CMD [ "bash" ]
