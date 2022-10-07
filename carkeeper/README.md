# Car Keeper Setting
## android/app/src/main/AndroidMenifest.xml  
<details>
<summary> AndroidMenifest.xml </summary>
<div markdown="1">

<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.example.carkeeper">
    <!-- local notification -->
    <uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
    <uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
    <uses-permission android:name="android.permission.VIBRATE" />
    <uses-permission android:name="android.permission.WAKE_LOCK" />
    <uses-permission android:name="android.permission.USE_FULL_SCREEN_INTENT" />
    <uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <!-- android camera permission-->
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.CAMERA" />
    <uses-permission android:name="android.permission.RECORD_AUDIO" />
    <queries>
        <intent>
            <action android:name="android.media.action.IMAGE_CAPTURE" />
        </intent>
    </queries>
    <application
        android:label="carkeeper"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher">
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTop"
            android:theme="@style/LaunchTheme"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize"
            android:showWhenLocked="true"
            android:turnScreenOn="true">
            <!-- Specifies an Android theme to apply to this Activity as soon as
                 the Android process has started. This theme is visible to the user
                 while the Flutter UI initializes. After that, this theme continues
                 to determine the Window background behind the Flutter UI. -->
            <meta-data
              android:name="io.flutter.embedding.android.NormalTheme"
              android:resource="@style/NormalTheme"
              />
            <meta-data
                android:name="firebase_messaging_auto_init_enabled"
                android:value="false" />
            <meta-data
                android:name="firebase_analytics_collection_enabled"
                android:value="false" />
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
        <receiver android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationReceiver" />
        <receiver android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationBootReceiver">
            <intent-filter>
                <action android:name="FLUTTER_NOTIFICATION_CLICK" />
                <category android:name="android.intent.category.DEFAULT" />
                <action android:name="android.intent.action.BOOT_COMPLETED"/>
                <action android:name="android.intent.action.MY_PACKAGE_REPLACED"/>
                <action android:name="android.intent.action.QUICKBOOT_POWERON" />
                <action android:name="com.htc.intent.action.QUICKBOOT_POWERON"/>
            </intent-filter>
        </receiver>
        <!-- Don't delete the meta-data below.
             This is used by the Flutter tool to generate GeneratedPluginRegistrant.java -->
        <meta-data
            android:name="flutterEmbedding"
            android:value="2" />
    </application>
</manifest>

</div>
</details>  

## pubspec.yaml
 - camera:
 - path_provider:
 - path:
 - cupertino_icons: ^1.0.2
 - flutter_local_notifications: ^9.9.1
 - carousel_slider: ^4.1.1
 -  firebase_core: ^1.22.0
 -  firebase_messaging: ^13.0.2
 -  cloud_firestore: ^3.4.8
 -  web_socket_channel: ^2.2.0
 -  permission_handler: ^10.0.0
 -  app_settings: ^4.1.8
 -  image_picker: ^0.8.5+3
 -  firebase_auth: ^3.9.0
 - firebase_storage: ^10.3.8
 -  timer_builder: ^2.0.0
 -  date_format: ^2.0.7
 -  cached_network_image: ^3.2.1
 -  provider: ^6.0.3
 -  extended_image: ^6.2.1
 -  google_fonts: ^3.0.1


## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
