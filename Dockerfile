FROM golang

ARG PROJECT_NAME
ARG PROJECT_EMAIL
ENV PROJECT_NAME ${PROJECT_NAME}

RUN mkdir /tmp/$PROJECT_NAME
COPY . /tmp/$PROJECT_NAME
WORKDIR /tmp/$PROJECT_NAME

RUN go get
RUN mkdir bin
RUN go build -v -o bin/$PROJECT_NAME

RUN /bin/bash -c "source .env"

RUN mkdir /etc/$PROJECT_NAME
RUN ssh-keygen -t rsa -b 4096 -N "" -C ${PROJECT_EMAIL} -f ./static/$PROJECT_NAME
RUN cp ./static/configs.json /etc/$PROJECT_NAME/
RUN mkdir /opt/$PROJECT_NAME
RUN mkdir /opt/$PROJECT_NAME/.key
RUN cp -r ./bin /opt/$PROJECT_NAME
RUN cp ./static/$PROJECT_NAME /opt/$PROJECT_NAME/.key
RUN chown root:root /opt/$PROJECT_NAME/.key/$PROJECT_NAME
RUN touch /var/log/$PROJECT_NAME
RUN chown root:root /var/log/$PROJECT_NAME
RUN chmod 0755 /var/log/$PROJECT_NAME
RUN ls /opt/${PROJECT_NAME}

RUN rm -rf ./*

CMD /opt/${PROJECT_NAME}/bin/${PROJECT_NAME}
