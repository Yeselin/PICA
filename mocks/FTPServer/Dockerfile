FROM openjdk

WORKDIR /app/apache-ftpserver

COPY apache-ftpserver-1.1.1 .

CMD ["sh", "bin/ftpd.sh", "res/conf/ftpd-typical.xml"]