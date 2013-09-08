#import "MMTransitionsNavigation.h"

#import "MMGridViewController.h"
#import "MMGridItemViewController.h"
#import "MMGridToGridItemTransition.h"

#import "MMGridItemDetailViewController.h"
#import "MMGridItemToGridItemDetailTransition.h"

#import "MMCardFlipInteractiveTransition.h"

@interface MMTransitionsNavigation ()
@property(nonatomic, strong) NSMutableDictionary *interactors;
@end

@implementation MMTransitionsNavigation

- (id)init {
  self = [super init];
  if (self) {
    _interactors = [NSMutableDictionary dictionary];
  }
  return self;
}

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
  if ([viewController isKindOfClass:[MMGridItemViewController class]] ||
      [viewController isKindOfClass:[MMGridItemDetailViewController class]]) {
    
    self.interactors[NSStringFromClass([viewController class])] =
    [MMCardFlipInteractiveTransition transitionWithViewController:viewController
                                             panGestureRecognizer:[UIPanGestureRecognizer new]];
  }
}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC {
  if ([fromVC isKindOfClass:[MMGridViewController class]] &&
      [toVC isKindOfClass:[MMGridItemViewController class]]) {
    return [MMGridToGridItemTransition new];
  } else if ([fromVC isKindOfClass:[MMGridItemViewController class]] &&
             [toVC isKindOfClass:[MMGridViewController class]]) {
    return [MMGridToGridItemTransition new];
  } else if ([fromVC isKindOfClass:[MMGridItemViewController class]] &&
             [toVC isKindOfClass:[MMGridItemDetailViewController class]]) {
    return [MMGridItemToGridItemDetailTransition
            transitionWithInteractor:self.interactors[NSStringFromClass([MMGridItemViewController class])]];
  } else if ([fromVC isKindOfClass:[MMGridItemDetailViewController class]] &&
             [toVC isKindOfClass:[MMGridItemViewController class]]) {
    return [MMGridItemToGridItemDetailTransition
            transitionWithInteractor:self.interactors[NSStringFromClass([MMGridItemDetailViewController class])]];
  }
  
  return nil;
}

- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
  if ([animationController isKindOfClass:[MMGridItemToGridItemDetailTransition class]]) {
    MMCardFlipInteractiveTransition *transition =
    ((MMGridItemToGridItemDetailTransition *)animationController).interactor;
    if (transition.isInteractive) {
      return ((MMGridItemToGridItemDetailTransition *)animationController).interactor;
    }
  }
  
  return nil;
}

@end
