#import "FzPlugin.h"
#import "UIView+Toast.h"

@implementation FzPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"fz_plugin"
            binaryMessenger:[registrar messenger]];
  FzPlugin* instance = [[FzPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  }
  else if([@"toast" isEqualToString:call.method]){
      NSString *msg = call.arguments[@"msg"];
      NSString *gravity = call.arguments[@"gravity"];
      NSString *length = call.arguments[@"length"];
      
      int time = 1;
      if([length isEqualToString:@"long"]){
          time =3;
      }
      if([gravity isEqualToString:@"bottom"]){
          [[UIApplication sharedApplication].delegate.window.rootViewController.view makeToast:msg duration:time position: CSToastPositionBottom];
      }else{
          //center
          [[UIApplication sharedApplication].delegate.window.rootViewController.view makeToast:msg duration:time position:CSToastPositionCenter];
          
      }
      
      result(@"success");
      
  }
  
  else {
    result(FlutterMethodNotImplemented);
  }
}


@end
