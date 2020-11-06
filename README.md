
# doordeck_flutter_plugin  
  
Flutter Plugin for the Doordeck's SDKs  (Android & iOS)
  
## Instructions
 Assuming that you have a running project already, please:

### iOS
1. Target your app at least to platform 10.3.
  To achieve this, modify your `Podfile`  and add:
  `platform :ios, '10.3'`
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
  

### Android
Target your app to `minSdkVersion 21`

#
Then be sure you follow the example.
Any issues, please raise an issue at the [Github's repo](https://github.com/doordeck/doordeck-sdk-flutter).
