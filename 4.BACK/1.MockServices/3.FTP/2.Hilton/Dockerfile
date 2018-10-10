FROM openjdk

#ENV FTP_USERNAME=bolivariano
#ENV FTP_PASSWORD=touresbalon123
#ENV FTP_CLIENT_RATE=60000

WORKDIR /app

COPY  build/libs/hilton-*.jar hilton.jar

CMD ["java", "-jar", "hilton.jar"]
