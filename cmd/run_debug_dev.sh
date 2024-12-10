#!/bin/bash

# Thiết lập các biến cho các thông tin cần thiết
flutterPath="/Users/bie/development/flutter"
appPath="/Users/bie/VILL/villship-driver-flutter/"

# Di chuyển đến thư mục ứng dụng và build ứng dụng Flutter
cd "$appPath"
"$flutterPath/bin/flutter" run lib/main_dev.dart --flavor dev --verbose   



# Tìm tệp APK mới nhất được tạo ra

