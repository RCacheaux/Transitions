#import "MMGridViewController.h"

#import "PlaceKit.h"

#import "MMGridItemViewController.h"

@interface MMGridViewController ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate>
@property(nonatomic, strong, readonly) UICollectionView *collectionView;
@property(nonatomic, strong, readwrite) NSIndexPath *selectedItemIndexPath;
@end

@implementation MMGridViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    self.title = @"Grid";
    _selectedItemIndexPath = nil;
  }
  return self;
}

- (void)loadView {
  UICollectionViewFlowLayout *flowLayout = [self newCollectionViewLayout];
  self.view = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
  self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.collectionView.dataSource = self;
  self.collectionView.delegate = self;
  [self.collectionView registerClass:[UICollectionViewCell class]
          forCellWithReuseIdentifier:[self cellReuseID]];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  self.selectedItemIndexPath = nil;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (UIView *)selectedCell {
  if (self.selectedItemIndexPath) {
    return [self.collectionView cellForItemAtIndexPath:self.selectedItemIndexPath];
  }
  return nil;
}

#pragma mark Collection View Datasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return 102;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  UICollectionViewCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:[self cellReuseID]
                                                forIndexPath:indexPath];
  cell.backgroundColor = [PlaceKit placeRandomColorWithHueOfColor:[UIColor redColor]];
  cell.layer.borderWidth = 0.5f;
  cell.layer.borderColor = [UIColor blackColor].CGColor;
  
  return cell;
}

#pragma mark Collection View Delegate

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout*)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section {
  return UIEdgeInsetsMake(0.0f, 5.0f, 0.0f, 5.0f);
}

- (void)collectionView:(UICollectionView *)collectionView
    didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  if (self.navigationController) {
    self.selectedItemIndexPath = indexPath;
    MMGridItemViewController *gridItemViewController = [MMGridItemViewController new];
    UIView *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
    [gridItemViewController updateContentViewColor:cell.backgroundColor];
    [self.navigationController pushViewController:gridItemViewController animated:YES];
  }
}

#pragma mark Factories

- (UICollectionViewFlowLayout *)newCollectionViewLayout {
  UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
  flowLayout.itemSize = CGSizeMake(96.0f, 96.0f);
  return flowLayout;
}

#pragma mark Property Accessors

- (UICollectionView *)collectionView {
  return (UICollectionView *)self.view;
}

#pragma mark Strings

- (NSString *)cellReuseID {
  return @"gridCell";
}

@end
