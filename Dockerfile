# =============================
#  BUILD STAGE
# =============================
FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app

# Copy project files
COPY pom.xml .
COPY src ./src

# Build JAR using Maven inside Docker
RUN mvn -q -DskipTests package


# =============================
#  RUNTIME STAGE
# =============================
FROM eclipse-temurin:21-jre
WORKDIR /app

# Copy only the final JAR
COPY --from=build /app/target/*.jar app.jar

# Expose your Spring Boot port
EXPOSE 8081

ENTRYPOINT ["java", "-jar", "app.jar"]
