#!/bin/bash
mkdir -p builds
./node_modules/.bin/gulp build
ionic build ios --release --device
cd ./platforms/ios/build/device/
/usr/bin/xcrun -sdk iphoneos PackageApplication "$(pwd)/FlatTracker.app" -o "$(pwd)/FlatTracker.ipa"
cd -
mv ./platforms/ios/build/device/FlatTracker.ipa ./builds/FlatTracker.ipa
