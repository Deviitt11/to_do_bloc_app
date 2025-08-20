plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.to_do_bloc_app"
    compileSdk = flutter.compileSdkVersion

    // --- Usa el NDK que requieren isar_flutter_libs y path_provider_android ---
    ndkVersion = "27.0.12077973" // <- CLAVE

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }
    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.to_do_bloc_app"
        minSdk = maxOf(21, flutter.minSdkVersion) // Comentario (ES): asegura minSdk 21 o mayor
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        ndk {
            // Comentario (ES): incluye ABI del emulador x86_64 y dispositivos ARM
            abiFilters += listOf("arm64-v8a", "armeabi-v7a", "x86_64")
        }
    }

    packaging {
        jniLibs {
            // Comentario (ES): packaging “legacy” evita líos con .so en debug
            useLegacyPackaging = true
        }
        // resources { pickFirsts += listOf("lib/**/libisar.so") } // <- solo si hubiese colisiones
    }

    buildTypes {
        debug {
            isMinifyEnabled = false
            isShrinkResources = false
        }
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
