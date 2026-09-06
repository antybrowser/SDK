# Publishing to Maven Central

## Prerequisites

1. **Sonatype OSSRH account**: https://issues.sonatype.org (create JIRA account)
2. **GPG key**: for signing artifacts
3. **Maven**: installed locally
4. **OSSRH staging profile**: must be approved by Sonatype

## Steps

### 1. Configure Maven settings (~/.m2/settings.xml)

```xml
<settings>
  <servers>
    <server>
      <id>ossrh</id>
      <username>YOUR_SONATYPE_USERNAME</username>
      <password>YOUR_SONATYPE_PASSWORD</password>
    </server>
  </servers>
</settings>
```

### 2. Build and deploy

```bash
cd sdk/java
mvn clean deploy -P release
```

This signs the JAR with GPG, uploads to OSSRH staging, and releases to Maven Central.

### 3. Users install with

**Maven:**
```xml
<dependency>
    <groupId>com.antybrowser</groupId>
    <artifactId>antybrowser-sdk</artifactId>
    <version>1.0.1</version>
</dependency>
```

**Gradle:**
```groovy
implementation 'com.antybrowser:antybrowser-sdk:1.0.1'
```

## Version Bumps

1. Edit `pom.xml` `<version>` tag
2. `mvn clean deploy -P release`

## Verify

https://search.maven.org/artifact/com.antybrowser/antybrowser-sdk/1.0.1/jar
