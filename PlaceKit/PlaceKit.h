//
//  PlaceKit.h
//  PlaceKitDemo
//
//  Created by Lars Anderson on 5/5/13.
//  Copyright (c) 2013 theonlylars. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, PLKTextParagraphLength){
    PLKTextParagraphLengthVeryShort = 0,
    PLKTextParagraphLengthShort,
    PLKTextParagraphLengthMedium,
    PLKTextParagraphLengthLong,
    PLKTextParagraphLengthVeryLong,
};

/** See what these different options do at http://loripsum.net
 */
typedef NS_OPTIONS(NSInteger, PLKTextOptions){
    PLKTextOptionsNone = 0,
    PLKTextOptionsAllCaps = 1 << 0,
    PLKTextOptionsPrude = 1 << 1,
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
                               ofLength:(PLKTextParagraphLength)paragraphLength
                                options:(PLKTextOptions)options
                             completion:(void(^)(NSString *placeText))completionBlock;

/** Placeholder data
 */
/** Random names
 */
+ (NSString *)placeRandomFirstName;
+ (NSString *)placeRandomLastName;
+ (NSString *)placeRandomFullName;

/** Random business name
 */
+ (NSString *)placeRandomBusinessNameWithNumberOfWords:(NSUInteger)words;

/** Random numbers
 */
+ (NSString *)placeRandomPhoneNumber;
+ (NSInteger)placeRandomIntegerLessThan:(NSInteger)lessThan;
+ (CGFloat)placeRandomFloatLessThan:(NSInteger)lessThan;
+ (CGFloat)placeRandomFloatInRange:(NSRange)range;
+ (CGFloat)placeRandomPercentage;

/** Geometry
 */
+ (CGSize)placeRandomSizeWithDimensionInRange:(NSRange)dimensionRange;
+ (CGSize)placeRandomSizeWithXRange:(NSRange)xDimensionRange
                             yRange:(NSRange)yDimensionRange;
+ (CGRect)placeRandomRectWithinRect:(CGRect)rect;
+ (CGPoint)placeRandomPointWithinRect:(CGRect)rect;

@end
