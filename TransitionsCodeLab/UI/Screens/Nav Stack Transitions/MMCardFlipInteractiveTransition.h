#import <UIKit/UIKit.h>

#import "MMGridItemViewController.h"
#import "MMGridItemDetailViewController.h"

@interface MMCardFlipInteractiveTransition : UIPercentDrivenInteractiveTransition

@property(nonatomic, assign, readonly) BOOL isInteractive;

+ (instancetype)transitionWithViewController:(UIViewController *)viewController
                        panGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer;

@end
