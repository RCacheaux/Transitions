#import <UIKit/UIKit.h>

@interface MMModalTransition : UIDynamicBehavior<UIViewControllerAnimatedTransitioning>
@property(nonatomic, assign) BOOL isPresenting;
@end
