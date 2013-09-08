#import "MMAppViewController.h"

#import "MMGridViewController.h"
#import "MMTransitionsNavigation.h"

@interface MMAppViewController ()
@property(nonatomic, strong) MMGridViewController *gridViewController;
@property(nonatomic, strong) UINavigationController *navStackTransitionsNavigationController;
@property(nonatomic, strong) MMTransitionsNavigation *navigation;
@end

@implementation MMAppViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.gridViewController = [MMGridViewController new];
  self.navStackTransitionsNavigationController =
      [[UINavigationController alloc] initWithRootViewController:self.gridViewController];
  self.navigation = [MMTransitionsNavigation new];
  self.navStackTransitionsNavigationController.delegate = self.navigation;
  self.navStackTransitionsNavigationController.title = @"Nav";
  self.viewControllers = @[self.navStackTransitionsNavigationController];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

@end
