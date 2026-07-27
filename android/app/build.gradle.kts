import java.util.Properties

// Secrets hors depot : lus depuis la variable d'environnement, sinon depuis
// android/local.properties (ignore par git). Rien n'est versionne.
val localProperties = Properties().apply {
    val file = rootProject.file("local.properties")
    if (file.exists()) {
        file.inputStream().use(::load)
    }
}

fun resolveSecret(name: String): String =
    providers.environmentVariable(name).orNull ?: localProperties.getProperty(name, "")

// Keystore de publication. Hors depot lui aussi : android/key.properties et le
// .jks sont ignores par git. Voir Docs/PUBLICATION.md pour le generer.
val keystoreProperties = Properties().apply {
    val file = rootProject.file("key.properties")
    if (file.exists()) {
        file.inputStream().use(::load)
    }
}

val hasReleaseKeystore = keystoreProperties.getProperty("storeFile") != null

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    // Firebase / Google Services (FCM) — doit être appliqué après le plugin Android.
    id("com.google.gms.google-services")
}

android {
    namespace = "tech.sytium.mobile"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        // Requis par flutter_local_notifications (APIs java.time via desugaring).
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "tech.sytium.mobile"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        // Firebase Cloud Messaging exige un minSdk >= 23.
        minSdk = maxOf(23, flutter.minSdkVersion)
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        // Injecte dans AndroidManifest.xml (com.google.android.geo.API_KEY).
        // Sans cle, la carte affiche une tuile grise : c'est le symptome a
        // reconnaitre si SYTIUM_GOOGLE_MAPS_API_KEY n'est pas renseigne.
        manifestPlaceholders["googleMapsApiKey"] = resolveSecret("SYTIUM_GOOGLE_MAPS_API_KEY")
    }

    signingConfigs {
        if (hasReleaseKeystore) {
            create("release") {
                storeFile = rootProject.file(keystoreProperties.getProperty("storeFile"))
                storePassword = keystoreProperties.getProperty("storePassword")
                keyAlias = keystoreProperties.getProperty("keyAlias")
                keyPassword = keystoreProperties.getProperty("keyPassword")
            }
        }
    }

    buildTypes {
        release {
            // Sans key.properties on retombe sur la cle de debug pour que
            // `flutter run --release` reste possible sur une machine de dev.
            // Le garde-fou ci-dessous empeche qu'un tel binaire parte au Play
            // Store : c'est exactement le rejet « signed in debug mode ».
            signingConfig = if (hasReleaseKeystore) {
                signingConfigs.getByName("release")
            } else {
                signingConfigs.getByName("debug")
            }
        }
    }
}

// Un App Bundle ne sert qu'a la publication : le laisser se signer en debug
// serait un rejet garanti, decouvert seulement a l'upload. On echoue tot.
tasks.matching { it.name.startsWith("bundle") && it.name.endsWith("Release") }
    .configureEach {
        doFirst {
            check(hasReleaseKeystore) {
                "android/key.properties est absent : l'App Bundle serait signe avec la " +
                    "cle de debug et refuse par le Play Store. Voir Docs/PUBLICATION.md."
            }
        }
    }

flutter {
    source = "../.."
}

dependencies {
    // Desugaring des APIs Java 8+ (java.time) pour flutter_local_notifications.
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}
