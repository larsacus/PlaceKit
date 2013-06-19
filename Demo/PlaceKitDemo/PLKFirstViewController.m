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
    
//    [PlaceKit placeHipsterIpsumWithNumberOfParagraphs:1 shotOfLatin:YES completion:^(NSString *hipsterIpsum) {
//        NSLog(@"%@", hipsterIpsum);
//    }];
//    [PlaceKit placeTextWithNumberOfParagraphs:3
//                                     ofLength:PLKTextParagraphLengthLong
//                                      options:PLKTextOptionsPrude
//                                   completion:^(NSString *placeText) {
//                                       NSLog(@"%@", placeText);
//                                   }];
//    [PlaceKit placeHTMLWithNumberOfParagraphs:1
//                                     ofLength:PLKTextParagraphLengthLong
//                                      options:PLKHTMLOptionsBlockquotes
//                                   completion:^(NSString *placeText) {
//                                       NSLog(@"%@", placeText);
//                                   }];
}

#pragma mark - CollectionView Data Source
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section{
    return [PlaceKit placeRandomFloatInRange:NSMakeRange(35, 300)];
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
    return [PlaceKit placeRandomSizeWithDimensionInRange:NSMakeRange(45, 130)];
}

- (void)randomPlaceholderImageForCell:(PLKCollectionViewImageCell *)cell{
    NSInteger random = arc4random_uniform(6);
    switch (random) {
        case 0:{
            [cell.imageView placeKittenImageWithSize:cell.bounds.size];
        }
            break;
        case 1:{
            [cell.imageView placeHolderImageWithSize:cell.bounds.size];
        }
            break;
        case 2:{
            [cell.imageView placeBaconImageWithSize:cell.bounds.size];
        }
            break;
        case 3:{
            [cell.imageView placeRandomGreyscaleImageWithSize:cell.bounds.size];
        }
            break;
        case 4:{
            [cell.imageView placeRandomImageWithSize:cell.bounds.size];
        }
            break;
        case 5:
        default:{
            [cell.imageView placeRandomGreyscaleImageWithSize:cell.bounds.size category:@"sports"];
        }
            break;
    }
}

@end
