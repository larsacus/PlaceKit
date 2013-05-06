//
//  UIImageView+PlaceKit.h
//  PlaceKitDemo
//
//  Created by Lars Anderson on 5/5/13.
//  Copyright (c) 2013 theonlylars. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (PlaceKit)

- (void)placeKittenImageWithSize:(CGSize)size;
- (void)placeBaconImageWithSize:(CGSize)size;
- (void)placeHolderImageWithSize:(CGSize)size;
- (void)placeRandomImageWithSize:(CGSize)size
                        category:(NSString *)category;
- (void)placeRandomGreyscaleImageWithSize:(CGSize)size
                                 category:(NSString *)category;
- (void)placeRandomImageWithSize:(CGSize)size;
- (void)placeRandomGreyscaleImageWithSize:(CGSize)size;

@end
