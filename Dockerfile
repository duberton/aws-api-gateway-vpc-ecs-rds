FROM maven:3.8.3-amazoncorretto-17

WORKDIR /app

ADD https://dtdg.co/latest-java-tracer dd-java-agent.jar

COPY pom.xml .
COPY src ./src

RUN mvn -B package --file pom.xml

EXPOSE 8080:8080

ENTRYPOINT ["java", "-javaagent:/app/dd-java-agent.jar", "-jar", "target/app.jar"]