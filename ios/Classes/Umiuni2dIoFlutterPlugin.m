#import "Umiuni2dIoFlutterPlugin.h"

@implementation Umiuni2dIoFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"umiuni2d_platform_path"
            binaryMessenger:[registrar messenger]];
  Umiuni2dIoFlutterPlugin* instance = [[Umiuni2dIoFlutterPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  }
  else if([@"getApplicationDirectory" isEqualToString:call.method]){
      NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSUserDomainMask, YES);
      NSString *dir = [paths objectAtIndex:0];
      result(dir);
  }
  else if([@"getCacheDirectory" isEqualToString:call.method]){
      NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
      NSString *dir = [paths objectAtIndex:0];
      result(dir);
  }
  else if([@"getDocumentDirectory" isEqualToString:call.method]){
      NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
      NSString *dir = [paths objectAtIndex:0];
      result(dir);

  }
  else {
    result(FlutterMethodNotImplemented);
  }
}

@end
