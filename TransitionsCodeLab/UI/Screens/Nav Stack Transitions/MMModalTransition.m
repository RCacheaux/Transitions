#import "MMModalTransition.h"

#import "MMGridItemDetailViewController.h"

@interface MMModalTransition ()
@property(nonatomic, assign) NSTimeInterval duration;
@property(nonatomic,assign) NSTimeInterval finishTime;
@property(nonatomic, strong) UIDynamicItemBehavior *bodyBehavior;
@property(nonatomic, strong) UIGravityBehavior *gravityBehavior;
@property(nonatomic, strong) UIDynamicAnimator *modalDynamicAnimator;
@property(nonatomic, strong) UIAttachmentBehavior *attachmentBehaviorLeft;
@property(nonatomic, strong) UIAttachmentBehavior *attachmentBehaviorRight;
@end

@implementation MMModalTransition

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
  if (self.isPresenting) {
    return 2.8;
  } else {
    return 1.0f;
  }
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
  if (self.isPresenting) {
    [self animatePresentationTransition:transitionContext];
  } else {
    [self animateDismissalTransition:transitionContext];
  }
}

- (void)animatePresentationTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
  UIViewController *fromViewController =
      [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
  UIViewController *toViewController =
      [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
  UIView *transitionView = [transitionContext containerView];
  toViewController.view.bounds = CGRectMake(0.0f, 0.0f, 300.0f, 400.0f);
  toViewController.view.center = CGPointMake(CGRectGetMidX(transitionView.bounds),
                                             CGRectGetMidY(transitionView.bounds));
  toViewController.view.frame = CGRectOffset(toViewController.view.frame, 0.0f, -800.0f);
  
  [transitionView addSubview:toViewController.view];
  
  NSTimeInterval duration = [self transitionDuration:transitionContext];
  UIView *dynamicView = toViewController.view;
  [transitionView addSubview:dynamicView];
  
  self.modalDynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:transitionView];
  
  self.bodyBehavior = [[UIDynamicItemBehavior alloc] init];
  self.bodyBehavior.allowsRotation = NO;
  [self.bodyBehavior addItem:dynamicView];
  
  NSArray *gravityItems = @[dynamicView];
  self.gravityBehavior = [[UIGravityBehavior alloc] initWithItems:gravityItems];
  self.gravityBehavior.magnitude = 5.0f;
  
  self.attachmentBehaviorLeft = [[UIAttachmentBehavior alloc] initWithItem:dynamicView
                                                      attachedToAnchor:CGPointZero];
  self.attachmentBehaviorLeft.length = 240.0f;
  self.attachmentBehaviorLeft.damping = 0.3f;
  self.attachmentBehaviorLeft.frequency = 1.15f;
  
  self.attachmentBehaviorRight =
      [[UIAttachmentBehavior alloc] initWithItem:dynamicView
                                attachedToAnchor:CGPointMake(CGRectGetMaxX(transitionView.bounds), 0.0f)];
  self.attachmentBehaviorRight.length = 240.0f;
  self.attachmentBehaviorRight.damping = 0.3f;
  self.attachmentBehaviorRight.frequency = 1.15f;
  
  
  self.finishTime = [self.dynamicAnimator elapsedTime] + duration;
  MMModalTransition __weak *weakSelf = self;
  self.action = ^{
    NSLog(@"%f", [weakSelf.dynamicAnimator elapsedTime]);
    if ([weakSelf.dynamicAnimator elapsedTime] >= weakSelf.finishTime) {
      [weakSelf.dynamicAnimator removeBehavior:weakSelf];
      [transitionContext completeTransition:YES];
    }
  };

  [self addChildBehavior:self.bodyBehavior];
  [self addChildBehavior:self.gravityBehavior];
  [self addChildBehavior:self.attachmentBehaviorLeft];
  [self addChildBehavior:self.attachmentBehaviorRight];
  [self.modalDynamicAnimator addBehavior:self];
  
  [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
    [fromViewController.view setTintAdjustmentMode:UIViewTintAdjustmentModeDimmed];
  }];
}

- (void)animateDismissalTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
  UIViewController *fromViewController =
      [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
  UIViewController *toViewController =
      [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
  UIView *transitionView = [transitionContext containerView];

  NSTimeInterval duration = [self transitionDuration:transitionContext];
  UIView *dynamicView = fromViewController.view;
  
  self.modalDynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:transitionView];
  
  NSArray *gravityItems = @[dynamicView];
  self.gravityBehavior = [[UIGravityBehavior alloc] initWithItems:gravityItems];
  self.gravityBehavior.magnitude = 5.0f;
  
  self.finishTime = [self.dynamicAnimator elapsedTime] + duration;
  MMModalTransition __weak *weakSelf = self;
  self.action = ^{
    NSLog(@"%f", [weakSelf.dynamicAnimator elapsedTime]);
    if ([weakSelf.dynamicAnimator elapsedTime] >= weakSelf.finishTime) {
      [weakSelf.dynamicAnimator removeBehavior:weakSelf];
      [fromViewController.view removeFromSuperview];
      [transitionContext completeTransition:YES];
    }
  };

  [self addChildBehavior:self.gravityBehavior];
  [self.modalDynamicAnimator addBehavior:self];
  
  [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
    [toViewController.view setTintAdjustmentMode:UIViewTintAdjustmentModeNormal];
  }];
}

@end
