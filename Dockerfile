FROM docker:dind

RUN apk add --no-cache curl bash python2 nodejs
RUN curl -o- https://bootstrap.pypa.io/get-pip.py | python
RUN pip install awscli docker-compose

ARG AWS_DEFAULT_REGION
ARG AWS_CONTAINER_CREDENTIALS_RELATIVE_URI

COPY entrypoint.sh /

ENTRYPOINT [ "/entrypoint.sh" ]

CMD [ "bash" ]
