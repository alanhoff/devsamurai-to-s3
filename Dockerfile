FROM alpine:3.21
RUN apk --update --no-cache add aws-cli aria2 curl bash unzip jq envsubst
COPY ./backup.sh /bin/backup
RUN chmod a+x /bin/backup
CMD [ "/bin/backup" ]