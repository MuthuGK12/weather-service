# =============================
#  STAGE 1: BUILD THE JAR
# =============================
FROM eclipse-temurin:21-jdk AS build
WORKDIR /app

# Copy Maven wrapper
COPY mvnw .
# REMOVE: COPY .mvn .mvn    (because your project doesn’t have it)

# Copy project files
COPY pom.xml .
COPY src ./src

# Build jar
RUN ./mvnw -q -DskipTests package


# =============================
#  STAGE 2: RUNTIME CONTAINER
# =============================
FROM eclipse-temurin:21-jre
WORKDIR /app

# Copy jar from build stage
COPY --from=build /app/target/*.jar app.jar

EXPOSE 8081

ENTRYPOINT ["java", "-jar", "app.jar"]
