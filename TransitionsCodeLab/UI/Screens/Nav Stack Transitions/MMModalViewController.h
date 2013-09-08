#import <UIKit/UIKit.h>

@protocol MMModalViewControllerDelegate <NSObject>
- (void)dismissModal;
@end

@interface MMModalViewController : UIViewController
@property(nonatomic, weak) id<MMModalViewControllerDelegate> delegate;
@end
