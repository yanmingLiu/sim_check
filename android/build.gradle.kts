group = "dev.fluttercommunity.flutter_sim_check"
version = "1.0-SNAPSHOT"

buildscript {
    val kotlinVersion = "2.1.0"

    repositories {
        google()
        mavenCentral()
    }

    dependencies {
        classpath("com.android.tools.build:gradle:8.12.1")
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlinVersion")
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

plugins {
    id("com.android.library")
}

// 动态检测 AGP 主版本以同时兼容 AGP 9+ 和旧版本
val agpMajor = try {
    com.android.Version.ANDROID_GRADLE_PLUGIN_VERSION.substringBefore('.').toInt()
} catch (_: Throwable) {
    8
}

if (agpMajor < 9) {
    apply(plugin = "org.jetbrains.kotlin.android")
}

project.extensions.configure(org.jetbrains.kotlin.gradle.dsl.KotlinAndroidProjectExtension::class.java) {
    compilerOptions {
        jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17)
    }
}

android {
    namespace = "dev.fluttercommunity.flutter_sim_check"
    compileSdk = 34

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        minSdk = 21
    }

    lint {
        disable.addAll(listOf("InvalidPackage", "MissingPermission"))
    }
}
