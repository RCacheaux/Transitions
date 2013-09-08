#import <Foundation/Foundation.h>

@interface MMGridItemToGridItemDetailTransition : NSObject<UIViewControllerAnimatedTransitioning>

@property(nonatomic, strong, readonly) id<UIViewControllerInteractiveTransitioning> interactor;

+ (instancetype)transitionWithInteractor:(id<UIViewControllerInteractiveTransitioning>)interactor;

@end
