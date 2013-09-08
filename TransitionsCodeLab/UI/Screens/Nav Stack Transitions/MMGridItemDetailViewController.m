#import "MMGridItemDetailViewController.h"

#import "MMModalViewController.h"
#import "MMModalTransitioningDelegate.h"

@interface MMGridItemDetailViewController ()<MMModalViewControllerDelegate>
@property(nonatomic, strong, readwrite) UIView *containerView;
@property(nonatomic, strong, readwrite) UIView *contentView;
@property(nonatomic, strong) id<UIViewControllerTransitioningDelegate> modalTransitioningDelegate;
@end

@implementation MMGridItemDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    self.title = @"Detail";
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
  self.contentView.backgroundColor = [UIColor darkGrayColor];
  self.contentView.layer.borderColor = [UIColor blackColor].CGColor;
  [self.containerView addSubview:self.contentView];
  
  UITapGestureRecognizer *tapGestureRecognizer =
      [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
  [self.view addGestureRecognizer:tapGestureRecognizer];
  
  self.modalTransitioningDelegate = [MMModalTransitioningDelegate new];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];

  self.containerView.frame = [self frameForContainerView];
  self.contentView.frame = self.containerView.bounds;
}

- (CGRect)frameForContainerView {
  CGFloat width = self.view.bounds.size.width;
  return CGRectMake(0.0f, self.view.bounds.size.height/2.0f - width/2.0f, width, width);
}

#pragma mark Touch Handlingpo 

- (void)handleTap:(UITapGestureRecognizer *)tapGestureRecognizer {
  MMModalViewController *modalViewController = [MMModalViewController new];
  modalViewController.delegate = self;
  modalViewController.transitioningDelegate = self.modalTransitioningDelegate;
  modalViewController.modalPresentationStyle = UIModalPresentationCustom;
  [self presentViewController:modalViewController animated:YES completion:nil];
}

#pragma mark Modal Delegate

- (void)dismissModal {
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end
