#import "AirwallexPlugin.h"
#if __has_include(<airwallex/airwallex-Swift.h>)
#import <airwallex/airwallex-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "airwallex-Swift.h"
#endif

@implementation AirwallexPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAirwallexPlugin registerWithRegistrar:registrar];
}
@end
