plugins {
    kotlin("jvm") version "1.9.0"
    `maven-publish`
    signing
}

group = "com.antybrowser"
version = "1.0.2"

java {
    sourceCompatibility = JavaVersion.VERSION_11
    targetCompatibility = JavaVersion.VERSION_11
    withSourcesJar()
}

kotlin {
    jvmToolchain(11)
}

dependencies {
    implementation("com.google.code.gson:gson:2.10.1")
    implementation("org.apache.httpcomponents:httpclient:4.5.14")
    testImplementation(kotlin("test"))
}

tasks.test {
    useJUnitPlatform()
}

publishing {
    publications {
        create<MavenPublication>("maven") {
            from(components["java"])
            groupId = "com.antybrowser"
            artifactId = "antybrowser-sdk"
            version = "1.0.2"

            pom {
                name.set("Antybrowser SDK")
                description.set("Official Antybrowser SDK — Kotlin client for the Antybrowser Local API")
                url.set("https://antybrowser.com")
                licenses {
                    license {
                        name.set("MIT License")
                        url.set("https://opensource.org/licenses/MIT")
                    }
                }
                developers {
                    developer {
                        id.set("antybrowser")
                        name.set("Antybrowser.com")
                        email.set("support@antybrowser.com")
                    }
                }
                scm {
                    connection.set("scm:git:git://github.com/antybrowser/SDK.git")
                    developerConnection.set("scm:git:ssh://github.com/antybrowser/SDK.git")
                    url.set("https://github.com/antybrowser/SDK")
                }
            }
        }
    }
    repositories {
        maven {
            name = "sonatype"
            val releasesRepoUrl = uri("https://s01.oss.sonatype.org/service/local/staging/deploy/maven2/")
            val snapshotsRepoUrl = uri("https://s01.oss.sonatype.org/content/repositories/snapshots/")
            url = if (version.toString().endsWith("SNAPSHOT")) snapshotsRepoUrl else releasesRepoUrl
            credentials {
                username = findProperty("ossrhUsername") as String? ?: ""
                password = findProperty("ossrhPassword") as String? ?: ""
            }
        }
    }
}

signing {
    sign(publishing.publications["maven"])
}
