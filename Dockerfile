FROM amazoncorretto:8-alpine-jdk as builder
WORKDIR /opt/app
COPY .mvn/ .mvn
COPY mvnw pom.xml ./
RUN ./mvnw dependency:go-offline
COPY ./src ./src
RUN ./mvnw clean install

FROM amazoncorretto:8-alpine-jre
WORKDIR /opt/app
EXPOSE 8080
RUN apk --no-cache add curl
## Add the wait script to the image
# COPY --from=ghcr.io/ufoscout/docker-compose-wait:latest /wait /wait
COPY ./wait.sh /opt/app/wait.sh
COPY --from=builder /opt/app/target/*.jar /opt/app/app.jar
ENTRYPOINT ["/bin/sh", "-c","/opt/app/wait.sh && java -jar /opt/app/app.jar"]
# ENTRYPOINT ["java", "-jar", "/opt/app/app.jar"]