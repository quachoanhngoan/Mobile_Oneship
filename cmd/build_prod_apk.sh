#!/bin/bash


flutter build apk lib/main.dart --flavor prod --release 

now=$(date +"%Y%m%d")
versionName=$(awk '/prod {/,/}/{if(/versionName/) print $2}' android/app/build.gradle | tr -d '"' )
versionCode=$(awk '/prod {/,/}/{if(/versionCode/) print $2}' android/app/build.gradle  | tr -d '"' )
    
mv build/app/outputs/flutter-apk/app-prod-release.apk build/app/outputs/flutter-apk/driver-prod-$now-$versionName.apk

# Tìm tệp APK mới nhất được tạo ra
open build/app/outputs/flutter-apk
