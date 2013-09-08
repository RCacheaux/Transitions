#import "MMGridItemToGridItemDetailTransition.h"

// From and to view controller classes.
#import "MMGridItemViewController.h"
#import "MMGridItemDetailViewController.h"

@interface MMGridItemToGridItemDetailTransition ()
@property(nonatomic, strong, readwrite) id<UIViewControllerInteractiveTransitioning> interactor;
@end

@implementation MMGridItemToGridItemDetailTransition

+ (instancetype)transitionWithInteractor:(id<UIViewControllerInteractiveTransitioning>)interactor {
  MMGridItemToGridItemDetailTransition *transition = [self new];
  transition.interactor = interactor;
  return transition;
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
  return 1.0;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
  UIViewController *fromViewController =
      [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
  if ([fromViewController isKindOfClass:[MMGridItemViewController class]]) {
    [self animateForwardTransition:transitionContext];
  } else if ([fromViewController isKindOfClass:[MMGridItemDetailViewController class]]) {
    [self animateBackwardTransition:transitionContext];
  }
}

- (void)animateForwardTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
  MMGridItemViewController *fromViewController = (MMGridItemViewController *)
      [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
  MMGridItemDetailViewController *toViewController = (MMGridItemDetailViewController *)
      [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
  
  UIView *transitionView = [transitionContext containerView];
  [transitionView addSubview:toViewController.view];
  toViewController.view.alpha = 0.0f;
  
  UIView *transitionContainerView = fromViewController.containerView;
  [transitionContainerView removeFromSuperview];
  transitionContainerView.frame =
      [fromViewController.view convertRect:[fromViewController frameForContainerView]
                                    toView:transitionView];
  [transitionView addSubview:transitionContainerView];

  
  UIView *fromViewControllerContentView = fromViewController.contentView;
  
  UIView *toViewControllerContentView = toViewController.contentView;
  [toViewControllerContentView removeFromSuperview];
  toViewControllerContentView.frame = transitionContainerView.bounds;
  
  void (^completionBlock)(BOOL) = ^(BOOL finished) {
    toViewController.view.alpha = 1.0f;
    
    [transitionContainerView removeFromSuperview];
    [fromViewController.view addSubview:transitionContainerView];
    [fromViewController.view removeFromSuperview];
    
    [toViewControllerContentView removeFromSuperview];
    [toViewController.containerView addSubview:toViewControllerContentView];
    toViewControllerContentView.frame = CGRectMake(0.0f, 0.0f,
                                                   [toViewController frameForContainerView].size.width,
                                                   [toViewController frameForContainerView].size.width);
    [toViewController.view layoutSubviews];
    
    [transitionContext completeTransition:YES];
  };
  
  [UIView transitionFromView:fromViewControllerContentView
                      toView:toViewControllerContentView
                    duration:[self transitionDuration:transitionContext]
                     options:UIViewAnimationOptionTransitionFlipFromLeft
                  completion:completionBlock];
}

- (void)animateBackwardTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
  MMGridItemDetailViewController *fromViewController = (MMGridItemDetailViewController *)
      [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
  MMGridItemViewController *toViewController = (MMGridItemViewController *)
      [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
  
  UIView *transitionView = [transitionContext containerView];
  [transitionView addSubview:toViewController.view];
  toViewController.view.alpha = 0.0f;
  
  UIView *transitionContainerView = fromViewController.containerView;
  [transitionContainerView removeFromSuperview];
  transitionContainerView.frame =
      [fromViewController.view convertRect:[fromViewController frameForContainerView]
                                    toView:transitionView];
  [transitionView addSubview:transitionContainerView];
  
  UIView *fromViewControllerContentView = fromViewController.contentView;
  
  UIView *toViewControllerContentView = toViewController.contentView;
  [toViewControllerContentView removeFromSuperview];
  toViewControllerContentView.frame = transitionContainerView.bounds;
  
  void (^completionBlock)(BOOL) = ^(BOOL finished) {
    toViewController.view.alpha = 1.0f;
    
    [transitionContainerView removeFromSuperview];
    [fromViewController.view addSubview:transitionContainerView];
    [fromViewController.view removeFromSuperview];
    
    [toViewControllerContentView removeFromSuperview];
    [toViewController.containerView addSubview:toViewControllerContentView];
    toViewControllerContentView.tag = 7777;
    toViewControllerContentView.frame = CGRectMake(0.0f, 0.0f,
                                                   [toViewController frameForContainerView].size.width,
                                                   [toViewController frameForContainerView].size.width);
    
    
    [transitionContext completeTransition:YES];
  };
  
  [UIView transitionFromView:fromViewControllerContentView
                      toView:toViewControllerContentView
                    duration:[self transitionDuration:transitionContext]
                     options:UIViewAnimationOptionTransitionFlipFromRight
                  completion:completionBlock];
}

@end
