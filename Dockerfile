# Use Java 21 runtime environment
FROM eclipse-temurin:21-jre

# Set working directory inside container
WORKDIR /app

# Copy jar file
COPY target/*.jar app.jar

# Expose the internal application port
EXPOSE 9000

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]
