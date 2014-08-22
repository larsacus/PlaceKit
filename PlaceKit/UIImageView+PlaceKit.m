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

#pragma mark - Explicit Size
- (void)placeKittenImageWithSize:(CGSize)size{
    [self placeImageWithURLString:kPLKPlaceKittenImageURLString size:size];
}

- (void)placeBaconImageWithSize:(CGSize)size{
    [self placeImageWithURLString:kPLKPlaceBaconImageURLString size:size];
}

- (void)placeHolderImageWithSize:(CGSize)size{
    [self placeImageWithURLString:kPLKPlaceHolderImageURLString size:size];
}

- (void)placeRandomImageWithSize:(CGSize)size
                        category:(NSString *)category{
    NSString *urlString = [kPLKPlaceRandomImageURLString stringByAppendingPathComponent:category];
    [self placeImageWithURLString:urlString size:size];
}

- (void)placeRandomGreyscaleImageWithSize:(CGSize)size
                                 category:(NSString *)category{
    NSString *urlString = [kPLKPlaceRandomGreyscaleImageURLString stringByAppendingPathComponent:category];
    [self placeImageWithURLString:urlString size:size];
}

- (void)placeRandomImageWithSize:(CGSize)size{
    [self placeImageWithURLString:kPLKPlaceRandomImageURLString size:size];
}

- (void)placeRandomGreyscaleImageWithSize:(CGSize)size{
    [self placeImageWithURLString:kPLKPlaceRandomGreyscaleImageURLString size:size];
}

- (void)placeDowneyImageWithSize:(CGSize)size {
    [self placeImageWithURLString:kPLKPlaceRandomDowneyImageURLString size:size];
}

#pragma mark - Inherits UIImageView Bounds
- (void)placeKittenImage{
    [self placeImageWithURLString:kPLKPlaceKittenImageURLString size:self.bounds.size];
}

- (void)placeBaconImage{
    [self placeImageWithURLString:kPLKPlaceBaconImageURLString size:self.bounds.size];
}

- (void)placeHolderImage{
    [self placeImageWithURLString:kPLKPlaceHolderImageURLString size:self.bounds.size];
}

- (void)placeDowneyImage {
    [self placeImageWithURLString:kPLKPlaceRandomDowneyImageURLString size:self.bounds.size];
}

- (void)placeRandomImageFromCategory:(NSString *)category{
    NSString *urlString = [kPLKPlaceRandomImageURLString stringByAppendingPathComponent:category];
    [self placeImageWithURLString:urlString size:self.bounds.size];
}

- (void)placeRandomGreyscaleImageFromCategory:(NSString *)category{
    NSString *urlString = [kPLKPlaceRandomGreyscaleImageURLString stringByAppendingPathComponent:category];
    [self placeImageWithURLString:urlString size:self.bounds.size];
}

- (void)placeRandomImage{
    [self placeImageWithURLString:kPLKPlaceRandomImageURLString size:self.bounds.size];
}

- (void)placeRandomGreyscaleImage{
    [self placeImageWithURLString:kPLKPlaceRandomGreyscaleImageURLString size:self.bounds.size];
}

#pragma mark - Common
- (void)placeImageWithURLString:(NSString *)path size:(CGSize)size{
    CGFloat screenScale = [[UIScreen mainScreen] scale];
    CGFloat w = size.width*screenScale;
    CGFloat h = size.height*screenScale;
    NSString *service = @"lorempixel.com";
    if ([path rangeOfString:service].length > 0) {
        CGFloat max = 1920.0f;
        if (w > max || h > max) {
          w = MIN(w,max);
          h = MIN(h,max);
          NSLog(@"%s: Warn: clamping image size to %@ max size. using %.0fx%.0f", __PRETTY_FUNCTION__, service, w, h);
        }
    }
    NSString *urlString = [NSString stringWithFormat:path, w, h];
    NSURL *url = [NSURL URLWithString:urlString];
    [self setImageWithURL:url];
}

@end
