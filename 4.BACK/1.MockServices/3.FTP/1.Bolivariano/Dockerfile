FROM openjdk

#ENV FTP_USERNAME=bolivariano
#ENV FTP_PASSWORD=touresbalon123
#ENV FTP_CLIENT_RATE=60000

WORKDIR /app

COPY  build/libs/bolivariano-*.jar bolivariano.jar

CMD ["java", "-jar", "bolivariano.jar"]