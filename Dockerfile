# Stage 1: Build with Maven
FROM maven:3.8.4-openjdk-17 AS builder

WORKDIR /app

COPY ./src ./src
COPY ./pom.xml .

RUN mvn clean package

# Stage 2: Create the final image
FROM openjdk:17-jdk-alpine

VOLUME /tmp
COPY --from=builder /app/target/*.jar app.jar

ENTRYPOINT ["java","-jar","/app.jar"]