#import "DoordeckFlutterPlugin.h"
#if __has_include(<doordeck_flutter_plugin/doordeck_flutter_plugin-Swift.h>)
#import <doordeck_flutter_plugin/doordeck_flutter_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "doordeck_flutter_plugin-Swift.h"
#endif

@implementation DoordeckFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftDoordeckFlutterPlugin registerWithRegistrar:registrar];
}
@end
