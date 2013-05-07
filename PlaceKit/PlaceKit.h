//
//  PlaceKit.h
//  PlaceKitDemo
//
//  Created by Lars Anderson on 5/5/13.
//  Copyright (c) 2013 theonlylars. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, PLKTextParagraphLength){
    PLKTextParagraphLengthShort = 0,
    PLKTextParagraphLengthMedium,
    PLKTextParagraphLengthLong,
    PLKTextParagraphLengthVeryLong,
};

/** See what these different options do at http://loripsum.net
 */
typedef NS_OPTIONS(NSInteger, PLKTextOptions){
    PLKTextOptionsNone = 0,
    PLKTextOptionsUnorderedList = 1 << 0,
    PLKTextOptionsOrderedList = 1 << 1,
    PLKTextOptionsBlockQuotes = 1 << 2,
    PLKTextOptionsCodeSamples = 1 << 3,
    PLKTextOptionsPrude = 1 << 4,
};

extern NSString * const kPLKPlaceKittenImageURLString;
extern NSString * const kPLKPlaceKittenGreyscaleImageURLString;
extern NSString * const kPLKPlaceBaconImageURLString;
extern NSString * const kPLKPlaceHolderImageURLString;
extern NSString * const kPLKPlaceRandomImageURLString;
extern NSString * const kPLKPlaceRandomGreyscaleImageURLString;

@interface PlaceKit : NSObject

/** Placeholder images
 */
//placekitten.com
//baconmockup.com
//placehold.it
//lorempixel.com
+ (void)placeKittenImageWithSize:(CGSize)size
                      completion:(void(^)(UIImage *kittenImage))completionBlock;
+ (void)placeBaconImageWithSize:(CGSize)size
                     completion:(void(^)(UIImage *baconImage))completionBlock;
+ (void)placeHolderImageWithSize:(CGSize)size
                      completion:(void(^)(UIImage *placeholderImage))completionBlock;
+ (void)placeRandomImageWithSize:(CGSize)size
                        category:(NSString *)category
                      completion:(void(^)(UIImage *randomImage))completionBlock;
+ (void)placeRandomGreyscaleImageWithSize:(CGSize)size
                                 category:(NSString *)category
                               completion:(void(^)(UIImage *randomImage))completionBlock;
+ (void)placeRandomImageWithSize:(CGSize)size
                      completion:(void(^)(UIImage *randomImage))completionBlock;
+ (void)placeRandomGreyscaleImageWithSize:(CGSize)size
                               completion:(void(^)(UIImage *randomImage))completionBlock;

/** Placeholder text
 */
//loripsum.net
+ (void)placeTextWithNumberOfParagraphs:(NSInteger)numberOfParagraphs
                                options:(PLKTextOptions)options
                             completion:(void(^)(NSString *placeText))completionBlock;

/** Placeholder data
 */
//Random person name
+ (NSString *)placeRandomFirstName;
+ (NSString *)placeRandomLastName;
+ (NSString *)placeRandomFullName;

//Random business name
+ (NSString *)placeRandomBusinessNameWithNumberOfWords:(NSUInteger)words;

//Random numbers
+ (NSString *)placeRandomPhoneNumber;
+ (NSInteger)placeRandomInteger;
+ (CGFloat)placeRandomFloat;
+ (CGFloat)placeRandomFloatInRange:(NSRange)range;
+ (CGFloat)placeRandomPercentage;

@end
