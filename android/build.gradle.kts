allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Firebase-specific dependencies and configuration
buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        // Add Firebase Gradle plugin classpath
        classpath("com.google.gms:google-services:4.4.0") // Use latest version
        classpath("com.google.firebase:firebase-crashlytics-gradle:2.9.9") // If using Crashlytics
        classpath("com.google.firebase:perf-plugin:1.4.2") // If using Performance Monitoring
    }
}

// Apply Firebase plugins to appropriate modules
subprojects {
    if (project.name == "app") {
        apply(plugin = "com.google.gms.google-services")
        apply(plugin = "com.google.firebase.crashlytics") // If using Crashlytics
        apply(plugin = "com.google.firebase.firebase-perf") // If using Performance Monitoring
    }
}

// Optional: Build directory customization (remove if causing issues with Firebase)
val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}