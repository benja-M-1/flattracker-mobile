# FlatTracker - mobile application

## Installation

To install you will need access to the following projects:

 * https://github.com/theodo/flattracker-backend
 * https://github.com/theodo/flattracker-mobile
 
To install backend, follow instructions in README of `@TODO` project.

Front development requires these following packages:

 * `npm`
 * `ionic`
 * `cordova`
 * `ant`
 * `cordova-deploy` with Bam patch to handle upload with HockeyApp

Assuming `npm` is installed, run this to install requirements :

``` bash
sudo npm install -g ionic
sudo npm install -g cordova
sudo npm install -g bamlab/cordova-deploy
sudo apt-get install ant android-tools-adb
```

And run :

``` bash
# Install npm + bower dependencies and then build
npm install

# Edit config.json file
cp tools/build/config/config.json.dist tools/build/config/config.json

# Launch the watcher + livereload
npm start
# http://localhost:8000
```

## Git workflow

Branches description
--------------------

The **master** branch corresponds to the **production** environment where the final project is.
The **dev** branch corresponds to the **dev** environment where tests are done.
Other branches are **development** branches. Each development branch should match a **feature**, and match the following
pattern: **feature/XXX/name-of-the-feature**.

How to use Git on the project
-----------------------------

- Create a new branch **feature/XXX/name-of-the-feature** from **master**
- Commit your modifications on it
- Merge your custom branch on **dev**
- Deploy and build on the **dev** environment
- Upon validation, merge **feature/XXX/name-of-the-feature** onto **master**
- Deploy and build on the **prod** environment

**NOTE**: Do not merge **dev** on **master** otherwise you will merge not validated features and deploy them on
the **prod** environment!

## Developement

To test your iOS and Android platforms side-by-site, just run :

``` bash
ionic serve --lab
```

## Build and deploy

**WARNING** : don't forget to increment version in `config.xml`, `bower.json` and `package.json` file after each release.

Android
-------

The first time, run :

``` bash
cordova platform add android
```

Then install Android SDK :

```
cd && wget "https://dl.google.com/android/android-sdk_r24.1.2-linux.tgz" && tar xvf android-sdk_r24.1.2-linux.tgz
```
Add path `~/android-sdk_r24.1.2-linux/tools` in your `.bashrc` or `.zshrc`

Then install JDK from here : http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html or on Debian with `sudo apt-get install openjdk-7-jdk`

Run the Android SDK Manager (`android &` on Debian), and choose : `Android SDK Build-Tools`, `Android SDK Tools`, `Android SDK Platform-tools`, `SDK Platform` of the target device, and the drivers corresponding to your OS.

# Add Android platform and set minSdkVersion to 15 in AndroidManifest.xml (this `sed` syntax works only on Linux)

``` bash
cordova platform add android

# Linux only
sed -iE 's@(android:minSdkVersion)="[^"]*"@\1="15"@g' platforms/android/AndroidManifest.xml

# Mac
brew install gnu-sed --default-names
/usr/local/bin/sed  -iE 's@(android:minSdkVersion)="[^"]*"@\1="15"@g' platforms/android/AndroidManifest.xml
```

To use Facebook authentication, you need to generate an Android development key hash, and supply it to Facebook.

``` bash
keytool -exportcert -alias androiddebugkey -keystore ~/.android/debug.keystore | openssl sha1 -binary | openssl base64
```

Choose a password, and copy the generate hash in the `Key Hashes` field of the Android section here : https://developers.facebook.com/apps/156492668043546/settings/

To build on Android devices, run:

``` bash
# Debug
ionic run android --device -l

# Release (prod)
ionic run android --release
```

To build and deploy to HockeyApp, run:

``` bash
cordova-deploy --build --android -N
```

iOS (only on Mac)
-----------------

The first time, assuming you have the last version of `Xcode` and a valid Apple Account Developper:
 * Go here https://developer.apple.com/account/ios/certificate/certificateList.action and click on `+`
 * Choose `ìOS App Development`, and follow instructions to generate a CSR file, and upload it.
 * Download iOS Certificates and import it in your KeyChain (just open it)
 * In project root directory, run `ionic platform add ios`
 * Open Xcode, open `Xcode` menu > `Preferences...`, `Accounts` tab, and add your Apple ID.
 * Click on Theodo team, then `View details` and download `iOS Team Provisioning Profile: *`
 * Open with Xcode `platforms/ios/FlatTracker.xcodeproj`, and double click on `FlatTracker` in the left tree
  * In `General` tab, set `Team` to `Theodo`
  * In `Build Settings` tab `Architectures` section, set valid architectures to `arm64 armv7` and set `Build Active Architecture Only` to Yes
  * In `Build Settings` tab `Code Signing` section, set `Code Signing Identity` (and all children) to : `iPhone Developer: <certificate name> (<certifiate ID>)`
 * Edit `platforms/ios/cordova/build-release.xcconfig` and set `CODE_SIGN_IDENTITY` and `CODE_SIGN_IDENTITY[sdk=iphoneos*]` to `iPhone Developer: <certificate name> (<certifiate ID>)` (you have shown the exact value previously in XCode)

To build, run :
```
bash build-ios.sh
```
It will generate `builds/FlatTracker.ipa`

To build and deploy to HockeyApp, run:

``` bash
cordova-deploy --build --ios -N
```
