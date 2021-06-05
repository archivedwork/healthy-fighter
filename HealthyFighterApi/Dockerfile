FROM openjdk:8-jdk-alpine
VOLUME /tmp
COPY ./build/libs/HealthyFighterApi-0.0.1-HEALTHYFIGHTERAPI-SNAPSHOT.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
