# Command line
Description project:<br>
- [*Spring Boot – Profile based properties and yaml example*](https://www.mkyong.com/spring-boot/spring-boot-profile-based-properties-and-yaml-example/)

<b>Note</b>:<br>
Spring Boot, the default profile is [*default*](), we can set the profile via [*spring.profiles.active*]() property.

## 1. Product

mvn spring-boot:run -Dspring.profiles.active=prod<br>
mvn install -DskipTests -P prod

## 2. Development (local)

mvn spring-boot:run -Dspring.profiles.active=dev<br>
mvn install -DskipTests -P dev