//
//  UIImageView+PlaceKit.h
//  PlaceKitDemo
//
//  Created by Lars Anderson on 5/5/13.
//  Copyright (c) 2013 theonlylars. All rights reserved.
//

#import <UIKit/UIKit.h>

/** These category methods differ from their pure block-based counterparts in that they are using AFNetworking's UIImageView+AFNetworking category under the hood. This gives these category methods some small tidbits like image caching.
 
 Use the explicit size category methods when doing things in unlaid-out objects like before a collection view cell has been laid out. You may know the size of the image from the layout information, but the UIImageView that you will be using doesn't yet have a size.
 
 If you only need an image or don't want things the AFNetworking category provides, use the block-based image fetching methods in PlaceKit Core.
 */

@interface UIImageView (PlaceKit)
//------–------------------
/** @name Explicit Sizing */
//------–------------------

/** Place a kitten image with a given size from placekitten.com
 
 @param size The size in points of your kitten image
 */
- (void)placeKittenImageWithSize:(CGSize)size;

/** Place an image of bacon or other meat with a given size from baconmockup.com
 
 @warning *Warning:* May motivate designers at the expense of developer happiness.
 
 @param size The size in points of your meat-based image
 */
- (void)placeBaconImageWithSize:(CGSize)size;

/** Place a generic placeholder image with a given size from http://placehold.it
 
 @param size The size in points of your placeholder
 */
- (void)placeHolderImageWithSize:(CGSize)size;

/** Place a random image in a specific category with a given size from lorempixel.com
 
 @param size The size in points of your random image
 @param category The category that you would like your image to be chosen from. A full list of valid categories can be found at http://lorempixel.com
 */
- (void)placeRandomImageWithSize:(CGSize)size
                        category:(NSString *)category;

/** Place a random greyscale image in a specific category with a given size from lorempixel.com
 
 @param size The size in points of your random greyscale image
 @param category The category that you would like your image to be chosen from. A full list of valid categories can be found at http://lorempixel.com
 */
- (void)placeRandomGreyscaleImageWithSize:(CGSize)size
                                 category:(NSString *)category;

/** Place a random image with a given size from lorempixel.com
 
 @param size The size in points of your random image
 */
- (void)placeRandomImageWithSize:(CGSize)size;

/** Place a random greyscale image with a given size from lorempixel.com
 
 @param size The size in points of your random greyscale image
 */
- (void)placeRandomGreyscaleImageWithSize:(CGSize)size;

//------–------------------
/** @name Implicit Sizing */
//-------------------------

/** Place a kitten image with an inherited size from placekitten.com
 */
- (void)placeKittenImage;

/** Place an image of bacon or other meat with an inherited size from baconmockup.com
 
 @warning *Warning:* May motivate designers at the expense of developer happiness.
 */
- (void)placeBaconImage;

/** Place a generic placeholder image with an inherited size from http://placehold.it
 */
- (void)placeHolderImage;

/** Place a random image in a specific category with an inherited size from lorempixel.com
 
 @param category The category that you would like your image to be chosen from. A full list of valid categories can be found at http://lorempixel.com
 */
- (void)placeRandomImageFromCategory:(NSString *)category;

/** Place a random greyscale image in a specific category with an inherited size from lorempixel.com
 
 @param category The category that you would like your image to be chosen from. A full list of valid categories can be found at http://lorempixel.com
 */
- (void)placeRandomGreyscaleImageFromCategory:(NSString *)category;

/** Place a random image with an inherited size from lorempixel.com
 */
- (void)placeRandomImage;

/** Place a random greyscale image with an inherited size from lorempixel.com
 */
- (void)placeRandomGreyscaleImage;

@end
