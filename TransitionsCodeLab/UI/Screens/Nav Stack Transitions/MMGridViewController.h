#import <UIKit/UIKit.h>

@interface MMGridViewController : UIViewController

@property(nonatomic, strong, readonly) NSIndexPath *selectedItemIndexPath;

- (UIView *)selectedCell;

@end
