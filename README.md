
# doordeck_flutter_plugin  
  
Flutter Plugin for the Doordeck's SDKs  (Android & iOS)
  
## Instructions
 Assuming that you have a running project already, please:

### iOS
1. Target your app at least to platform 12
  To achieve this, modify your `Podfile`  and add:
  `platform :ios, '12'`
2. Enable the NFC Tag Reading Capability.
  To achieve this, go to your *Certificates, Identifiers & Profiles* (Dev center) page to add manually the NFC capability.
  Also add the entitlement into the Xcode project:
  ```
    <key>com.apple.developer.nfc.readersession.formats</key>
    <array>
        <string>NDEF</string>
    </array>
   ```
3. Add the NFC usage description to your project. To achieve this, add a string for the key *Privacy — NFC Scan Usage Description* to your **Info.plist**
  
Important ⚠️:\
iOS's SDK implementation should comply with the instructions given in our [native SDK](https://github.com/doordeck/doordeck-sdk-swift)

### Android
Target your app to `minSdkVersion 21`

If you face an error similar to:
> Manifest merger failed : Attribute application@label value=([APP_NAME]) from (unknown)
is also present at [com.github.adorsys:secure-storage-android:0.0.2] AndroidManifest.xml:12:9-41 value=(@string/app_name).
Suggestion: add 'tools:replace="android:label"' to <application> element at AndroidManifest.xml:3:4-43:19 to override.

Please continue as the suggestion says. Be sure you have a string named @string/app_name as your app name, which is your label for your app as well and 
add the suggestion mentioned.

Important ⚠️:\
Android's SDK implementation should comply with the instructions given in our [native SDK](https://github.com/doordeck/doordeck-sdk-flutter)

#
Then be sure you follow the example.
Any issues, please raise an issue at the [Github's repo](https://github.com/doordeck/doordeck-sdk-flutter).
