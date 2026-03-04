plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.kbboutik_v04"
    compileSdk = 36

    defaultConfig {
        applicationId = "com.example.kbboutik_v04"
        minSdk = flutter.minSdkVersion // généralement 21+
        targetSdk = 36
        versionCode = 1
        versionName = "1.0"
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        isCoreLibraryDesugaringEnabled = true // pour certaines libs modernes
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

// 🔹 Repositories
repositories {
    google()
    mavenCentral()
}

// 🔹 Dépendances
dependencies {
    // Kotlin standard
    implementation("org.jetbrains.kotlin:kotlin-stdlib:1.9.10")

    // 🔹 Core library desugaring
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")

    // 🔹 Firebase BOM
    implementation(platform("com.google.firebase:firebase-bom:32.2.2"))

    // 🔹 Firebase KTX libs
    implementation("com.google.firebase:firebase-messaging-ktx")
    implementation("com.google.firebase:firebase-analytics-ktx")
}