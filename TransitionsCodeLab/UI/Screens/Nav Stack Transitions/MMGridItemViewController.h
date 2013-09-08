#import <UIKit/UIKit.h>

@interface MMGridItemViewController : UIViewController

@property(nonatomic, strong, readonly) UIView *containerView;
@property(nonatomic, strong, readonly) UIView *contentView;

- (CGRect)frameForContainerView;

- (void)updateContentViewColor:(UIColor *)color;

- (void)pushNextViewController;

@end
