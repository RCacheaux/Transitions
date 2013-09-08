#import "MMModalTransitioningDelegate.h"

#import "MMModalTransition.h"
#import "MMModalViewController.h"

@implementation MMModalTransitioningDelegate

- (id <UIViewControllerAnimatedTransitioning>)
    animationControllerForPresentedController:(UIViewController *)presented
                         presentingController:(UIViewController *)presenting
                             sourceController:(UIViewController *)source {
  MMModalTransition *transition = [MMModalTransition new];
  transition.isPresenting = YES;
  return transition;
}

- (id <UIViewControllerAnimatedTransitioning>)
    animationControllerForDismissedController:(UIViewController *)dismissed {
  if ([dismissed isKindOfClass:[MMModalViewController class]]) {
    MMModalTransition *transition = [MMModalTransition new];
    transition.isPresenting = NO;
    return transition;
  }
  return nil;
}

@end
