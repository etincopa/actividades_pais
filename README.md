# actividades_pais

A new Flutter projects.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Create Project
flutter create --org com.pnpais.sifpnpais.app actividades_pais

## Git Ignore
Clear cache

git rm -r --cached .

## RECURSOS
```
> java -version
java version "1.8.0_333"
Java(TM) SE Runtime Environment (build 1.8.0_333-b02)
Java HotSpot(TM) 64-Bit Server VM (build 25.333-b02, mixed mode)

> flutter --version
Flutter 3.3.3 • channel stable • https://github.com/flutter/flutter.git
Framework • revision 18a827f393 (11 hours ago) • 2022-09-28 10:03:14 -0700
Engine • revision 5c984c26eb
Tools • Dart 2.18.2 • DevTools 2.15.0


> adb --version
Android Debug Bridge version 1.0.41
Version 33.0.3-8952118
Installed as //Users/egarciti/Library/Android/sdk/platform-tools/adb

> Gradle --version
Gradle 7.5.1
Build time:   2022-08-05 21:17:56 UTC
Revision:     d1daa0cbf1a0103000b71484e1dbfe096e095918
Kotlin:       1.6.21
Groovy:       3.0.10
Ant:          Apache Ant(TM) version 1.10.11 compiled on July 10 2021
JVM:          1.8.0_333 (Oracle Corporation 25.333-b02)
OS:           Mac OS X 12.4 x86_64


Android Studio Dolphin | 2021.3.1
Build #AI-213.7172.25.2113.9014738, built on August 31, 2022
Runtime version: 11.0.13+0-b1751.21-8125866 aarch64

```


## VARIABLES DE ENTORNO
```sh
    JAVA_HOME C:\Program Files\Java\jdk1.8.0_x
    JRE_HOME C:\Program Files\Java\jre1.8.0_x
    ANDROID_HOME C:\Users\egarciti\AppData\Local\Android\Sdk
    ANDROID_SDK_ROOT C:\Users\egarciti\AppData\Local\Android\Sdk
    GRADLE_HOME C:\Users\egarciti\Desktop\gradle\gradle-7.4.x

    PATH %JAVA_HOME%\bin
    PATH %JRE_HOME%\bin
    PATH %ANDROID_HOME%\tools
    PATH %ANDROID_HOME%\tools\bin
    PATH %ANDROID_HOME%\platform-tools
    PATH %ANDROID_HOME%\emulator
    PATH %ANDROID_SDK_ROOT%\tools
    PATH %ANDROID_SDK_ROOT%\tools\bin
    PATH %ANDROID_SDK_ROOT%\platform-tools
    PATH %ANDROID_SDK_ROOT%\cmdline-tools\latest\bin
    PATH %ANDROID_SDK_ROOT%\emulator
    PATH %GRADLE_HOME%\bin
```

## PASOS CREAR APP

1.- Si va a construir su proyecto a Android, debe ejecutar:

    flutter build apk --release

2.- Desplegar APK en dispositivo fisico / Emulador con ADB

    adb install -r build/app/outputs/flutter-apk/app-release.apk

3.- Desplegar APK en un emulador

    flutter run

## PASOS CREAR APP IOS
flutter clean && flutter build appbundle --release   ( Build Bundle App .aab )
flutter build apk --release
flutter build ipa --release

DOCS: 
 - https://www.youtube.com/watch?v=fU9w4IJ8XeM
 - https://stackoverflow.com/questions/5499125/how-to-create-ipa-file-using-xcode





flutter pub outdated  -> Verifica dependencias obsoletas
flutter pub upgrade --major-versions -> Actualiza dependencias a la ultima version estable


## Cambiar el NameSpace y Nombre del proyecto  (--org)
```sh
flutter pub global activate rename  (instalar)
flutter pub global run rename --bundleId com.pnpais.sifpnpais.app (Cambia la --org)
flutter pub global run rename --appname "SIFPNPAIS" (Cambia en nombre)
```



## DEPLOY PLAYSTORE
Generar una Keystore

Paso 1: ubicarse en la carpeta .../bin de java JDK
Requiere ejecutar el terminal como administrador (windows)
Paso 2: ingresar el siguiente comando

para activar los permisos en MacOs se antepone la clave:  sudo

```sh
1: .jks (recomendado)
sudo keytool -genkey -v -keystore key.jks -alias sifpnpais -storetype JKS -keyalg RSA -keysize 2048 -validity 10000

    Al ejecutar el comando solicitara completar algunos parametros:
    - keyPassword
    - datos de la organizacion
    - storePassword

2: .keystore
sudo keytool -genkey -v -keystore key.keystore -alias sifpnpais -keyalg RSA -keysize 2048 -validity 10000

```

clave: compnpaissifpnpais2023

    -keystore: Nombre de archivo [key]
    -alias: Alias del proyecto   [sifpnpais]
    -storetype: Tipo keystore
    -keysize: Tamaño de la keystore [2048]
    -validity: Tempo de duracion de la keystore en dias [10000]


### ERRORES Y POSIBLES SOLUCIONES


## ERROR 1
```sh
Parse Issue (Xcode): Module 'fluttertoast' not found
/Users/egarciti/Documents/Projects/App/Git/actividades_pais/ios/Runner/GeneratedPluginRegistrant.m:23:8


Could not build the application for the simulator.
Error launching application on iPhone 11.
```

## SOLUCION 1

iOS -> 
```sh
flutter clean
flutter pub get
pod repo update
pod install
```



## ERROR 2
```sh
Error: Cannot run with sound null safety, because the following dependencies
don't support null safety:

 - package:decorative_app_bar

For solutions, see https://dart.dev/go/unsound-null-safety
```

## SOLUCION 2.1
Usando la línea de comando "--no-sound-null-safety"
```sh
flutter run --no-sound-null-safety
flutter build apk --release --no-sound-null-safety
```

## SOLUCION 2.2
Agregue
```js
// @dart=2.9 
```
En el arcrhivo main.dart.



## ERROR 3
```sh
w: Runtime JAR files in the classpath should have the same version. These files were found in the classpath:
    /Users/egarciti/.gradle/caches/modules-2/files-2.1/org.jetbrains.kotlin/kotlin-stdlib-jdk8/1.5.30/5fd47535cc85f9e24996f939c2de6583991481b0/kotlin-stdlib-jdk8-1.5.30.jar (version 1.5)
    /Users/egarciti/.gradle/caches/modules-2/files-2.1/org.jetbrains.kotlin/kotlin-stdlib-jdk7/1.6.10/e1c380673654a089c4f0c9f83d0ddfdc1efdb498/kotlin-stdlib-jdk7-1.6.10.jar (version 1.6)
    /Users/egarciti/.gradle/caches/modules-2/files-2.1/org.jetbrains.kotlin/kotlin-stdlib/1.6.10/b8af3fe6f1ca88526914929add63cf5e7c5049af/kotlin-stdlib-1.6.10.jar (version 1.6)
    /Users/egarciti/.gradle/caches/modules-2/files-2.1/org.jetbrains.kotlin/kotlin-stdlib-common/1.6.10/c118700e3a33c8a0d9adc920e9dec0831171925/kotlin-stdlib-common-1.6.10.jar (version 1.6)
w: Some runtime JAR files in the classpath have an incompatible version. Consider removing them from the classpath
w: Runtime JAR files in the classpath should have the same version. These files were found in the classpath:
    /Users/egarciti/.gradle/caches/modules-2/files-2.1/org.jetbrains.kotlin/kotlin-stdlib-jdk8/1.5.30/5fd47535cc85f9e24996f939c2de6583991481b0/kotlin-stdlib-jdk8-1.5.30.jar (version 1.5)
    /Users/egarciti/.gradle/caches/modules-2/files-2.1/org.jetbrains.kotlin/kotlin-stdlib-jdk7/1.6.10/e1c380673654a089c4f0c9f83d0ddfdc1efdb498/kotlin-stdlib-jdk7-1.6.10.jar (version 1.6)
    /Users/egarciti/.gradle/caches/modules-2/files-2.1/org.jetbrains.kotlin/kotlin-stdlib/1.6.10/b8af3fe6f1ca88526914929add63cf5e7c5049af/kotlin-stdlib-1.6.10.jar (version 1.6)
    /Users/egarciti/.gradle/caches/modules-2/files-2.1/org.jetbrains.kotlin/kotlin-stdlib-common/1.6.10/c118700e3a33c8a0d9adc920e9dec0831171925/kotlin-stdlib-common-1.6.10.jar (version 1.6)
w: Some runtime JAR files in the classpath have an incompatible version. Consider removing them from the classpath
```

## SOLUCION 3
android ->
android/app/build.gradle

Remplazar: implementation "org.jetbrains.kotlin:kotlin-stdlib-jdk7:$kotlin_version"

Por: implementation "org.jetbrains.kotlin:kotlin-stdlib-jdk8:$kotlin_version"

Ejem:
```json
dependencies {
    //implementation "org.jetbrains.kotlin:kotlin-stdlib-jdk7:$kotlin_version"
    implementation "org.jetbrains.kotlin:kotlin-stdlib-jdk8:$kotlin_version"
}
```




# COLORES LOGO PAIS
```sh
#FBFBFB BACKGROUND
#BC0514 P
#8F9D9F A
#7987CC I
#65A33E S
```

# USUARIO DEMO

UPS
42315615
CIP_119811

47532262
47532262

45860931
45860931


"codigo": "CAP_010254",
"nombres": "Zulema Pecchi Barrientos",
"rol": "CRP",
"dni": "01325838",
"username": "01325838",
"password": "CAP_010254"


"codigo": "CIP_119910",
"nombres": "Gloria Nelly Rimarachin Carbajal",
"rol": "RESIDENTE",
"dni": "32909715",
"username": "32909715",
"password": "CIP_119910"

"codigo": "CIP_193094",
"nombres": "Wilber Quispe Vargas",s
"rol": "CRP",
"dni": "45860931",
"username": "45860931",
"password": "CIP_193094"