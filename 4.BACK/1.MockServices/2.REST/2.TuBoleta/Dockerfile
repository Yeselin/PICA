FROM openjdk

WORKDIR /app/soapui

COPY SoapUI-5.4.0 . 
COPY TuBoleta.xml .

EXPOSE 8080/tcp

CMD ["sh", "bin/mockservicerunner.sh", "TuBoleta.xml"]