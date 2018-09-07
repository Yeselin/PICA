FROM openjdk

WORKDIR /app/soapui

COPY SoapUI-5.4.0 . 
COPY TuBoleta.xml .

CMD ["sh", "bin/mockservicerunner.sh", "TuBoleta.xml"]