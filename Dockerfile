FROM docker:dind

RUN apk add --no-cache curl bash python2
RUN curl -o- https://bootstrap.pypa.io/get-pip.py | python
RUN pip install awscli docker-compose

COPY entrypoint.sh /

ENTRYPOINT [ "/entrypoint.sh" ]

CMD [ "bash" ]
