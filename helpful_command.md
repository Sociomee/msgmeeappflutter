flutter pub run change_app_package_name:main com.new.package.name

flutter pub run flutter_native_splash:create flutter pub run flutter_launcher_icons:main

flutter build apk --split-per-abi --obfuscate --split-debug-info=./private/data/

flutter build appbundle --obfuscate --split-debug-info=./private/data/

flutter build ipa --obfuscate --split-debug-info=./private/data/

keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android