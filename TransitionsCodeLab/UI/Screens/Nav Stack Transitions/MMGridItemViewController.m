#import "MMGridItemViewController.h"

#import "MMGridItemDetailViewController.h"

@interface MMGridItemViewController ()
@property(nonatomic, strong, readwrite) UIView *containerView;
@property(nonatomic, strong, readwrite) UIView *contentView;
@property(nonatomic, strong) UIColor *contentViewBackgroundColor;
@end

@implementation MMGridItemViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    self.title = @"Item";
    _contentViewBackgroundColor = [UIColor redColor];
  }
  return self;
}

- (void)loadView {
  self.view = [UIView new];
  self.view.backgroundColor = [UIColor lightGrayColor];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.containerView = [UIView new];
  [self.view addSubview:self.containerView];
  
  self.contentView = [UIView new];
  self.contentView.layer.borderWidth = 0.5f;
  self.contentView.backgroundColor = self.contentViewBackgroundColor;
  self.contentView.layer.borderColor = [UIColor blackColor].CGColor;
  [self.containerView addSubview:self.contentView];
  
  UITapGestureRecognizer *tapGestureRecognizer =
      [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTouch:)];
  [self.view addGestureRecognizer:tapGestureRecognizer];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
  
  if (self.contentView.superview == self.containerView) {
    self.containerView.frame = [self frameForContainerView];
    self.contentView.frame = self.containerView.bounds;
  }
}

- (CGRect)frameForContainerView {
  CGFloat width = self.view.bounds.size.width;
  return CGRectMake(0.0f, self.view.bounds.size.height/2.0f - width/2.0f, width, width);
}

- (void)updateContentViewColor:(UIColor *)color {
  self.contentViewBackgroundColor = color;
}

#pragma mark Navigation

- (void)pushNextViewController {
  if (self.navigationController) {
    MMGridItemDetailViewController *gridItemDetailViewController =
        [MMGridItemDetailViewController new];
    [self.navigationController pushViewController:gridItemDetailViewController animated:YES];
  }
}

#pragma mark Touch Handling

- (void)handleTouch:(UITapGestureRecognizer *)tapGestureRecognizer {
  [self pushNextViewController];
}

@end
