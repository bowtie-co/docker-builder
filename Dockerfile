FROM docker:dind

ENV BOWTIE_BIN /bowtie/bin

RUN apk add --no-cache curl bash python2 nodejs yarn make
RUN curl -o- https://bootstrap.pypa.io/get-pip.py | python
RUN pip install awscli docker-compose

RUN mkdir -p $BOWTIE_BIN

COPY bin/* $BOWTIE_BIN/

ENV PATH $BOWTIE_BIN:$PATH

COPY entrypoint.sh /

ENTRYPOINT [ "/entrypoint.sh" ]

CMD [ "bash" ]
