FROM golang

ENV TURBO_PARAKEET_EMAIL ${TURBO_PARAKEET_DEFAULT_NAME}
ENV TURBO_PARAKEET_DEFAULT_NAME ${TURBO_PARAKEET_DEFAULT_NAME}

RUN mkdir /tmp/$TURBO_PARAKEET_DEFAULT_NAME
COPY . /tmp/$TURBO_PARAKEET_DEFAULT_NAME
WORKDIR /tmp/$TURBO_PARAKEET_DEFAULT_NAME

RUN go get
RUN mkdir bin
RUN go build -v -o bin/$TURBO_PARAKEET_DEFAULT_NAME

RUN /bin/bash -c "source .env"

RUN mkdir /etc/$TURBO_PARAKEET_DEFAULT_NAME
RUN ssh-keygen -t rsa -b 4096 -N "" -C ${TURBO_PARAKEET_EMAIL} -f ./static/$TURBO_PARAKEET_DEFAULT_NAME
RUN cp ./static/configs.json /etc/$TURBO_PARAKEET_DEFAULT_NAME/
RUN mkdir /opt/$TURBO_PARAKEET_DEFAULT_NAME
RUN mkdir /opt/$TURBO_PARAKEET_DEFAULT_NAME/.key
RUN cp -r ./bin /opt/$TURBO_PARAKEET_DEFAULT_NAME
RUN cp ./static/$TURBO_PARAKEET_DEFAULT_NAME /opt/$TURBO_PARAKEET_DEFAULT_NAME/.key
RUN chown root:root /opt/$TURBO_PARAKEET_DEFAULT_NAME/.key/$TURBO_PARAKEET_DEFAULT_NAME
RUN touch /var/log/$TURBO_PARAKEET_DEFAULT_NAME
RUN chown root:root /var/log/$TURBO_PARAKEET_DEFAULT_NAME
RUN chmod 0755 /var/log/$TURBO_PARAKEET_DEFAULT_NAME
RUN ls /opt/${TURBO_PARAKEET_DEFAULT_NAME}

RUN rm -rf ./*

CMD /opt/${TURBO_PARAKEET_DEFAULT_NAME}/bin/${TURBO_PARAKEET_DEFAULT_NAME}
