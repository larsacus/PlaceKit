//
//  UIImageView+PlaceKit.m
//  PlaceKitDemo
//
//  Created by Lars Anderson on 5/5/13.
//  Copyright (c) 2013 theonlylars. All rights reserved.
//

#import "UIImageView+PlaceKit.h"

#import "PlaceKit.h"
#import "UIImageView+AFNetworking.h"

@implementation UIImageView (PlaceKit)

- (void)placeKittenImageWithSize:(CGSize)size{
    [self placeImageWithURLString:kPLKPlaceKittenURLString size:size];
}

- (void)placeBaconImageWithSize:(CGSize)size{
    [self placeImageWithURLString:kPLKPlaceBaconURLString size:size];
}

- (void)placeHolderImageWithSize:(CGSize)size{
    [self placeImageWithURLString:kPLKPlaceHolderURLString size:size];
}

- (void)placeRandomImageWithSize:(CGSize)size
                        category:(NSString *)category{
    NSString *urlString = [kPLKPlaceRandomURLString stringByAppendingPathComponent:category];
    [self placeImageWithURLString:urlString size:size];
}

- (void)placeRandomGreyscaleImageWithSize:(CGSize)size
                                 category:(NSString *)category{
    NSString *urlString = [kPLKPlaceRandomGreyscaleURLString stringByAppendingPathComponent:category];
    [self placeImageWithURLString:urlString size:size];
}

- (void)placeRandomImageWithSize:(CGSize)size{
    [self placeImageWithURLString:kPLKPlaceRandomURLString size:size];
}

- (void)placeRandomGreyscaleImageWithSize:(CGSize)size{
    [self placeImageWithURLString:kPLKPlaceRandomGreyscaleURLString size:size];
}

- (void)placeImageWithURLString:(NSString *)path size:(CGSize)size{
    CGFloat screenScale = [[UIScreen mainScreen] scale];
    NSString *urlString = [NSString stringWithFormat:path, size.width*screenScale, size.height*screenScale];
    NSURL *url = [NSURL URLWithString:urlString];
    [self setImageWithURL:url];
}

@end
