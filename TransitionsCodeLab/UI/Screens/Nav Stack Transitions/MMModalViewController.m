#import "MMModalViewController.h"

@interface MMModalViewController ()

@end

@implementation MMModalViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
  }
  return self;
}

- (void)loadView {
  self.view = [UIView new];
  self.view.backgroundColor = [UIColor orangeColor];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  UITapGestureRecognizer *tapGestureRecognizer =
      [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
  [self.view addGestureRecognizer:tapGestureRecognizer];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark Touch Handling

- (void)handleTap:(UITapGestureRecognizer *)tapGestureRecognizer {
  if (self.delegate &&
      [self.delegate conformsToProtocol:@protocol(MMModalViewControllerDelegate)]) {
    [self.delegate dismissModal];
  }
}

@end
