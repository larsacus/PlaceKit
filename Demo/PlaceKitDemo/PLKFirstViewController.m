//
//  PLKFirstViewController.m
//  PlaceKitDemo
//
//  Created by Lars Anderson on 5/5/13.
//  Copyright (c) 2013 theonlylars. All rights reserved.
//

#import "PLKFirstViewController.h"
#import "PLKCollectionViewImageCell.h"
#import "PlaceKit.h"
#import "UIImageView+PlaceKit.h"

@interface PLKFirstViewController ()

@end

@implementation PLKFirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Images", @"Images");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
    UINib *cellNib = [UINib nibWithNibName:@"PLKCollectionViewImageCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"placeholderCell"];
}

#pragma mark - CollectionView Data Source
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section{
    return 100;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PLKCollectionViewImageCell *cell = (PLKCollectionViewImageCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"placeholderCell"
                                                                           forIndexPath:indexPath];
    
    [self randomPlaceholderImageForCell:cell];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat maxDimension = 100.f;
    CGFloat minDimension = 25.f;
    CGFloat width = round(minDimension+arc4random_uniform(maxDimension-minDimension));
    CGFloat height = round(minDimension+arc4random_uniform(maxDimension-minDimension));
    CGSize size = CGSizeMake(width, height);
    
    return size;
}

- (void)randomPlaceholderImageForCell:(PLKCollectionViewImageCell *)cell{
    NSInteger random = arc4random_uniform(6);
    switch (random) {
        case 0:{
//            [PlaceKit placeKittenImageWithSize:cell.bounds.size
//                                    completion:^(UIImage *kittenImage) {
//                                        cell.imageView.image = kittenImage;
//                                    }];
            [cell.imageView placeKittenImage];
        }
            break;
        case 1:{
//            [PlaceKit placeHolderImageWithSize:cell.bounds.size
//                                    completion:^(UIImage *kittenImage) {
//                                        cell.imageView.image = kittenImage;
//                                    }];
            [cell.imageView placeHolderImage];
        }
            break;
        case 2:{
//            [PlaceKit placeBaconImageWithSize:cell.bounds.size
//                                    completion:^(UIImage *kittenImage) {
//                                        cell.imageView.image = kittenImage;
//                                    }];
            [cell.imageView placeBaconImage];
        }
            break;
        case 3:{
//            [PlaceKit placeRandomGreyscaleImageWithSize:cell.bounds.size
//                                             completion:^(UIImage *randomImage) {
//                                                 cell.imageView.image = randomImage;
//                                             }];
            [cell.imageView placeRandomGreyscaleImage];
        }
            break;
        case 4:{
//            [PlaceKit placeRandomImageWithSize:cell.bounds.size
//                                    completion:^(UIImage *randomImage) {
//                                        cell.imageView.image = randomImage;
//                                    }];
            [cell.imageView placeRandomImage];
        }
            break;
        case 5:
        default:{
//            [PlaceKit placeRandomGreyscaleImageWithSize:cell.bounds.size
//                                               category:@"sports"
//                                             completion:^(UIImage *randomImage) {
//                                                 cell.imageView.image = randomImage;
//                                             }];
            [cell.imageView placeRandomGreyscaleImageFromCategory:@"sports"];
        }
            break;
    }
}

@end
