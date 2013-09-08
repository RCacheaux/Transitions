#import "MMGridToGridItemTransition.h"

// From and to view controller classes.
#import "MMGridViewController.h"
#import "MMGridItemViewController.h"

@implementation MMGridToGridItemTransition

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
  return 1.0;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
  UIViewController *fromViewController =
      [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
  if ([fromViewController isKindOfClass:[MMGridViewController class]]) {
    [self animateForwardTransition:transitionContext];
  } else if ([fromViewController isKindOfClass:[MMGridItemViewController class]]) {
    [self animateBackwardTransition:transitionContext];
  }
}

- (void)animateForwardTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
  MMGridViewController *fromViewController = (MMGridViewController *)
      [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
  MMGridItemViewController *toViewController = (MMGridItemViewController *)
      [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
  
  UIView *transitionView = [transitionContext containerView];
  [transitionView addSubview:toViewController.view];
  toViewController.view.alpha = 0.0f;
  
  UIView *toViewControllerContentView = toViewController.contentView;
  [toViewControllerContentView removeFromSuperview];
  [transitionView addSubview:toViewControllerContentView];
  UIView *selectedCell = [fromViewController selectedCell];
  toViewControllerContentView.frame = [selectedCell.superview convertRect:selectedCell.frame toView:transitionView];
  
  
  [UIView animateWithDuration:0.2 animations:^{
    toViewController.view.alpha = 1.0f;
  }];
  
  void (^animationBlock)(void) = ^{
    toViewControllerContentView.frame =
        [toViewController.view convertRect:[toViewController frameForContainerView]
                                    toView:transitionView];
    
  };
  void (^completionBlock)(BOOL) = ^(BOOL finished) {
    [fromViewController.view removeFromSuperview];
    [toViewControllerContentView removeFromSuperview];
    [toViewController.containerView addSubview:toViewControllerContentView];
    
    [transitionContext completeTransition:YES];
  };
  [UIView animateWithDuration:[self transitionDuration:transitionContext]
                        delay:0.0
       usingSpringWithDamping:0.4
        initialSpringVelocity:15.0
                      options:0
                   animations:animationBlock
                   completion:completionBlock];
}

- (void)animateBackwardTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
  MMGridItemViewController *fromViewController = (MMGridItemViewController *)
      [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
  MMGridViewController *toViewController = (MMGridViewController *)
      [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
  
  UIView *transitionView = [transitionContext containerView];
  [transitionView addSubview:toViewController.view];
  toViewController.view.alpha = 0.0f;
  
  UIView *fromViewControllerContentView = fromViewController.contentView;
  [fromViewControllerContentView removeFromSuperview];
  [transitionView addSubview:fromViewControllerContentView];
  UIView *selectedCell = [toViewController selectedCell];
  selectedCell.alpha = 0.0f;
  fromViewControllerContentView.frame =
      [fromViewController.view convertRect:[fromViewController frameForContainerView]
                                    toView:transitionView];
  
  
  [UIView animateWithDuration:0.2 animations:^{
    toViewController.view.alpha = 1.0f;
    fromViewController.view.alpha = 0.0f;
  }];
  
  void (^animationBlock)(void) = ^{
    fromViewControllerContentView.frame = [selectedCell.superview convertRect:selectedCell.frame
                                                                       toView:transitionView];
  };
  void (^completionBlock)(BOOL) = ^(BOOL finished) {
    [fromViewController.view removeFromSuperview];
    [fromViewControllerContentView removeFromSuperview];
    [fromViewController.view addSubview:fromViewControllerContentView];
    selectedCell.alpha = 1.0f;
    
    [transitionContext completeTransition:YES];
  };
  [UIView animateWithDuration:[self transitionDuration:transitionContext]
                        delay:0.0
       usingSpringWithDamping:0.5
        initialSpringVelocity:10.0
                      options:0
                   animations:animationBlock
                   completion:completionBlock];
}

@end
