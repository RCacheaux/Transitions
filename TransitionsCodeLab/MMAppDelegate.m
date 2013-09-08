#import "MMAppDelegate.h"

#import "MMAppViewController.h"

@implementation MMAppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  MMAppViewController *appViewController = [MMAppViewController new];
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  self.window.backgroundColor = [UIColor lightGrayColor];
  self.window.rootViewController = appViewController;
  [self.window makeKeyAndVisible];
  return YES;
}

@end
