FROM openjdk:8-jdk-alpine

WORKDIR /app

COPY  build/libs/service-registry*.jar service-registry.jar

EXPOSE 8787

CMD ["java", "-jar", "service-registry.jar"]