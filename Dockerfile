FROM alpine:3.5

WORKDIR /app
COPY bin/netapp-api-exporter_linux_amd64 /app/netapp-api-exporter
COPY netapp_filers.yaml /app/config/netapp_filers.yaml
COPY entrypoint.sh /app/entrypoint.sh

#RUN echo -e "- name: default-netapp-api\n  host: localhost:8000\n  username: "$USERNAME"\n  password: "$PASSWORD > /app/netapp_filers.yaml

RUN chmod 777 /app/config -R

EXPOSE 9108
#ENTRYPOINT [ '/entrypoint.sh -u user -p pass -a localhost:8000' ]
#CMD [$PARAMETERS]