#import "MMCardFlipInteractiveTransition.h"

@interface MMCardFlipInteractiveTransition()
@property(nonatomic, assign) BOOL isPushTransition;
@property(nonatomic, strong) MMGridItemViewController *gridItemViewController;
@property(nonatomic, strong) MMGridItemDetailViewController *gridItemDetailViewController;
@property(nonatomic, assign, readwrite) BOOL isInteractive;
@end

@implementation MMCardFlipInteractiveTransition


+ (instancetype)transitionWithViewController:(UIViewController *)viewController
                        panGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer {
  MMCardFlipInteractiveTransition *transition =
      [[self alloc] initWithViewController:viewController];

  [panGestureRecognizer addTarget:transition action:@selector(handlePan:)];
  [viewController.view addGestureRecognizer:panGestureRecognizer];
  
  return transition;
}

- (id)initWithViewController:(UIViewController *)viewController {
  self = [super init];
  if (self) {
    _isInteractive = NO;
    if ([viewController isKindOfClass:[MMGridItemViewController class]]) {
      _gridItemViewController = (MMGridItemViewController *)viewController;
      _isPushTransition = YES;
    } else if ([viewController isKindOfClass:[MMGridItemDetailViewController class]]) {
      _gridItemDetailViewController = (MMGridItemDetailViewController *)viewController;
      _isPushTransition = NO;
    }
  }
  return self;
}

- (void)handlePan:(UIPanGestureRecognizer *)panGestureRecognizer {
  CGPoint translation = [panGestureRecognizer translationInView:panGestureRecognizer.view];
  CGFloat percentage = fabsf(translation.x / panGestureRecognizer.view.bounds.size.width);
  switch (panGestureRecognizer.state) {
    case UIGestureRecognizerStateBegan:
      if (self.isPushTransition) {
        self.isInteractive = YES;
        [self.gridItemViewController pushNextViewController];
      } else {
        self.isInteractive = YES;
        [self.gridItemDetailViewController.navigationController popViewControllerAnimated:YES];
      }
      break;
      
    case UIGestureRecognizerStateChanged: {
      [self updateInteractiveTransition:percentage];
      break;
    }
      
    case UIGestureRecognizerStateEnded:
      [self finishInteractiveTransition];
      [panGestureRecognizer.view removeGestureRecognizer:panGestureRecognizer];
      break;
      
    case UIGestureRecognizerStateCancelled:
      [self cancelInteractiveTransition];
      
    default:
      break;
  }

}




@end
