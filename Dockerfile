FROM alpine:latest

ADD ./crontab /tasks/
ADD ./scripts/* /scripts/

RUN apk add py-pip && \
    pip install --upgrade pip && \
    pip install awscli && \
    mkdir /data && \
    /scripts/instance.sh && \
    /scripts/elb.sh && \
    /scripts/fqdn.sh && \
    /scripts/eni.sh

CMD sh -c 'crontab /tasks/crontab && crond -f -L -'
