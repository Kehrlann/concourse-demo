FROM registry:5000/openjdk:8-jre-alpine

VOLUME /tmp
COPY target/*.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
