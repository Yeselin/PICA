FROM openjdk:8-jdk-alpine

WORKDIR /app

COPY  build/libs/products-service*.jar products-service.jar

EXPOSE 8787

CMD ["java", "-jar", "products-service.jar"]