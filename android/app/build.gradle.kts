plugins {
    id("com.android.application")
    // id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
     
    id("org.jetbrains.kotlin.android")
     
}

android {
    namespace = "com.exmaple.SCRIPTS"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
    applicationId = "com.example.SCRIPTS"
    minSdk = flutter.minSdkVersion
    targetSdk = 34
    versionCode = 1
    versionName = "1.0"
    manifestPlaceholders["appAuthRedirectScheme"] = "com.example.SCRIPTS"
    }
    signingConfigs {
     create("release") {            // ← نستخدم الموجود بدلاً من create
        storeFile = file("upload-keystore.jks")
        storePassword = "12345678"
        keyAlias = "upload"
        keyPassword = "12345678"
    }
}

    buildTypes {
        debug {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
