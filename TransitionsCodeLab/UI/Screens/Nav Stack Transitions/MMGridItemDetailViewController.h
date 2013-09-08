#import <UIKit/UIKit.h>

@interface MMGridItemDetailViewController : UIViewController

@property(nonatomic, strong, readonly) UIView *containerView;
@property(nonatomic, strong, readonly) UIView *contentView;

- (CGRect)frameForContainerView;

@end
