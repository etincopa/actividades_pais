# actividades_pais


## Getting Started


## Create Project
-- com.domainname.appname
flutter create --org com.pnpais.sig actividades_pais


## Flutter
Flutter 3.10.6

## UPDATE PUBSPECT
flutter pub outdated
flutter pub upgrade --major-versions


## BUILD APP IOS
flutter build ipa --release


## ERROR BUILD
ios > pod install

## ERRORES

Could not build the precompiled application for the device.
Error (Xcode): No profiles for 'com.pnpais.sig' were found: Xcode couldn't find any iOS App Development provisioning profiles matching 'com.pnpais.sig'. Automatic signing is disabled and unable to generate a profile. To enable automatic signing, pass -allowProvisioningUpdates to xcodebuild.
/Users/yo/Documents/Projects/PAIS/iOS/actividades_pais/ios/Runner.xcodeproj


It appears that there was a problem signing your application prior to installation on the device.

Verify that the Bundle Identifier in your project is your signing id in Xcode
  open ios/Runner.xcworkspace

Also try selecting 'Product > Build' to fix the problem.

Error launching application on Kirin.

