# =============================
#  STAGE 1: BUILD THE JAR
# =============================
FROM eclipse-temurin:21-jdk AS build
WORKDIR /app

# Copy Maven Wrapper (IntelliJ generates these automatically)
COPY mvnw .
COPY .mvn .mvn

# Copy project files
COPY pom.xml .
COPY src ./src

# Build Spring Boot JAR
RUN ./mvnw -q -DskipTests package


# =============================
#  STAGE 2: RUNTIME IMAGE
# =============================
FROM eclipse-temurin:21-jre
WORKDIR /app

# Copy JAR from build stage
COPY --from=build /app/target/*.jar app.jar

# Your Spring Boot port
EXPOSE 8081

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
