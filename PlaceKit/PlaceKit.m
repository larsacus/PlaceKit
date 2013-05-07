//
//  PlaceKit.m
//  PlaceKitDemo
//
//  Created by Lars Anderson on 5/5/13.
//  Copyright (c) 2013 theonlylars. All rights reserved.
//

#import "PlaceKit.h"

#import "AFNetworking.h"

NSString * const kPLKPlaceKittenImageURLString = @"http://placekitten.com/%1.0f/%1.0f";
NSString * const kPLKPlaceKittenGreyscaleImageURLString = @"http://placekitten.com/g/%1.0f/%1.0f";
NSString * const kPLKPlaceBaconImageURLString = @"http://baconmockup.com/%1.0f/%1.0f";
NSString * const kPLKPlaceHolderImageURLString = @"http://placehold.it/%1.0fx%1.0f";
NSString * const kPLKPlaceRandomImageURLString = @"http://lorempixel.com/%1.0f/%1.0f";
NSString * const kPLKPlaceRandomGreyscaleImageURLString = @"http://lorempixel.com/%1.0f/%1.0f";
NSString * const kPLKPlaceRandomPlainTextURLString = @"http://loripsum.net/api/plaintext";

@implementation PlaceKit

+ (AFHTTPClient *)httpClient{
    static AFHTTPClient *__httpClient;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^(void){
        NSURL *url = [NSURL URLWithString:@""];
        __httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
        [__httpClient registerHTTPOperationClass:[AFImageRequestOperation class]];
    });
    return __httpClient;
}

#pragma mark - Images
+ (void)placeKittenImageWithSize:(CGSize)size
                      completion:(void(^)(UIImage *kittenImage))completionBlock{
    [self requestImageWithPath:kPLKPlaceKittenImageURLString
                          size:size
                    completion:completionBlock];
}

+ (void)placeKittenGreyImageWithSize:(CGSize)size
                          completion:(void(^)(UIImage *greyKittenImage))completionBlock{
    [self requestImageWithPath:kPLKPlaceKittenGreyscaleImageURLString
                          size:size
                    completion:completionBlock];
}

+ (void)placeBaconImageWithSize:(CGSize)size
                     completion:(void(^)(UIImage *baconImage))completionBlock{
    [self requestImageWithPath:kPLKPlaceBaconImageURLString
                          size:size
                    completion:completionBlock];
}

+ (void)placeHolderImageWithSize:(CGSize)size
                      completion:(void(^)(UIImage *placeholderImage))completionBlock{
    [self requestImageWithPath:kPLKPlaceHolderImageURLString
                          size:size
                    completion:completionBlock];
}

//http://lorempixel.com/400/200 to get a random picture of 400 x 200 pixels
//http://lorempixel.com/g/400/200 to get a random gray picture of 400 x 200 pixels
//http://lorempixel.com/400/200/sports to get a random picture of the sports category
//http://lorempixel.com/400/200/sports/1 to get picture no. 1/10 from the sports category
//http://lorempixel.com/400/200/sports/Dummy-Text... with a custom text on the random Picture
//http://lorempixel.com/400/200/sports/1/Dummy-Text

+ (void)placeRandomImageWithSize:(CGSize)size
                        category:(NSString *)category
                      completion:(void(^)(UIImage *randomImage))completionBlock{
    [self requestImageWithPath:[kPLKPlaceRandomImageURLString stringByAppendingPathComponent:category]
                          size:size
                    completion:completionBlock];
}

+ (void)placeRandomGreyscaleImageWithSize:(CGSize)size
                                 category:(NSString *)category
                               completion:(void(^)(UIImage *randomImage))completionBlock{
    [self requestImageWithPath:[kPLKPlaceRandomGreyscaleImageURLString stringByAppendingPathComponent:category]
                          size:size
                    completion:completionBlock];
}

+ (void)placeRandomImageWithSize:(CGSize)size
                      completion:(void(^)(UIImage *randomImage))completionBlock{
    [self requestImageWithPath:kPLKPlaceRandomImageURLString
                          size:size
                    completion:completionBlock];
}

+ (void)placeRandomGreyscaleImageWithSize:(CGSize)size
                               completion:(void(^)(UIImage *randomImage))completionBlock{
    [self requestImageWithPath:kPLKPlaceRandomGreyscaleImageURLString
                          size:size
                    completion:completionBlock];
}

+ (void)requestImageWithPath:(NSString *)path size:(CGSize)size completion:(void(^)(UIImage *image))completionBlock{
    CGFloat screenScale = [[UIScreen mainScreen] scale];
    [[self httpClient]
     getPath:[NSString stringWithFormat:path, size.width*screenScale, size.height*screenScale]
     parameters:nil
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         UIImage *image = [UIImage imageWithData:responseObject scale:screenScale];
         completionBlock(image);
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         completionBlock(nil);
     }];
}

+ (void)placeTextWithNumberOfParagraphs:(NSInteger)numberOfParagraphs
                               ofLength:(PLKTextParagraphLength)paragraphLength
                                options:(PLKTextOptions)options
                             completion:(void(^)(NSString *placeText))completionBlock{
    NSAssert1(numberOfParagraphs > 0, @"Number of paragraphs is invalid (%i)", numberOfParagraphs);
    
    NSString *urlString = kPLKPlaceRandomPlainTextURLString;
    
    if (options & PLKTextOptionsAllCaps) {
        urlString = [urlString stringByAppendingPathComponent:@"allcaps"];
    }
    
    if (options & PLKTextOptionsPrude){
        urlString = [urlString stringByAppendingPathComponent:@"prude"];
    }
    
    NSString *paragraphLengthParameter = [self paragraphLengthParameterFromParagraphLength:paragraphLength];
    urlString = [urlString stringByAppendingPathComponent:paragraphLengthParameter];
    
    NSString *paragraphsArg = [NSString stringWithFormat:@"%i", numberOfParagraphs];
    
    urlString = [urlString stringByAppendingPathComponent:paragraphsArg];
    
    [[self httpClient] getPath:urlString
                    parameters:nil
                       success:^(AFHTTPRequestOperation *operation, id responseObject) {
                           NSData *data = [NSData dataWithData:responseObject];
                           
                           NSString *returnString = [NSString stringWithCString:[data bytes] encoding:NSUTF8StringEncoding];
                           completionBlock(returnString);
                       } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                           completionBlock(nil);
                       }];
}

+ (NSString *)paragraphLengthParameterFromParagraphLength:(PLKTextParagraphLength)paragraphLength
{
    NSString *paragraphLengthParameter;
    switch (paragraphLength) {
        case PLKTextParagraphLengthLong:
            paragraphLengthParameter = @"long";
            break;
        case PLKTextParagraphLengthMedium:
            paragraphLengthParameter = @"medium";
            break;
        case PLKTextParagraphLengthShort:
            paragraphLengthParameter = @"short";
            break;
        case PLKTextParagraphLengthVeryLong:
            paragraphLengthParameter = @"verylong";
            break;
        case PLKTextParagraphLengthVeryShort:
            paragraphLengthParameter = @"veryshort";
            break;
    }
    return paragraphLengthParameter;
}

+ (NSString *)placeRandomFirstName{
    NSArray *seedFirstNames = [[self maleFirstNames] arrayByAddingObjectsFromArray:[self femaleFirstNames]];
    return seedFirstNames[arc4random_uniform(seedFirstNames.count)];
}

+ (NSString *)placeRandomLastName{
    NSArray *seedLastNames = [self lastNames];
    return seedLastNames[arc4random_uniform(seedLastNames.count)];
}

+ (NSString *)placeRandomFullName{
    return [NSString stringWithFormat:@"%@ %@", [self placeRandomFirstName], [self placeRandomLastName]];
}

+ (NSString *)placeRandomBusinessNameWithNumberOfWords:(NSUInteger)words{
    
}

+ (NSString *)placeRandomPhoneNumber{
    return [NSString stringWithFormat:@"(%3.0i) %3.0i-%4.0i", arc4random_uniform(999), arc4random_uniform(999), arc4random_uniform(9999)];
}

+ (NSInteger)placeRandomIntegerLessThan:(NSInteger)lessThan{
    return arc4random_uniform(lessThan);
}

+ (CGFloat)placeRandomFloatLessThan:(NSInteger)lessThan{
    return ((CGFloat)arc4random_uniform(lessThan))+[self placeRandomPercentage];
}

+ (CGFloat)placeRandomFloatInRange:(NSRange)range{
    return range.location + arc4random_uniform(range.length);
}

+ (CGFloat)placeRandomPercentage{
    return arc4random_uniform(100)/100.f;
}

+ (CGSize)placeRandomSizeWithDimensionInRange:(NSRange)dimensionRange{
    return [self placeRandomSizeWithXRange:dimensionRange
                                    yRange:dimensionRange];
}

+ (CGSize)placeRandomSizeWithXRange:(NSRange)xDimensionRange
                             yRange:(NSRange)yDimensionRange{
    CGFloat width = round([self placeRandomFloatInRange:xDimensionRange]);
    CGFloat height = round([self placeRandomFloatInRange:yDimensionRange]);
    return CGSizeMake(width, height);
}

+ (CGRect)placeRandomRectWithinRect:(CGRect)rect{
    CGFloat minX = CGRectGetMinX(rect);
    CGFloat maxX = CGRectGetMaxX(rect);
    CGFloat minY = CGRectGetMinY(rect);
    CGFloat maxY = CGRectGetMaxY(rect);
    CGFloat maxWidth = CGRectGetWidth(rect);
    CGFloat maxHeight = CGRectGetHeight(rect);
    
    CGSize rectSize = [self placeRandomSizeWithXRange:NSMakeRange(0, maxWidth)
                                               yRange:NSMakeRange(0, maxHeight)];
    CGFloat xOrigin = [self placeRandomFloatInRange:NSMakeRange(minX, (maxX-rectSize.width))];
    CGFloat yOrigin = [self placeRandomFloatInRange:NSMakeRange(minY, (maxY-rectSize.height))];
    CGPoint origin = CGPointMake(xOrigin, yOrigin);
    
    return (CGRect){origin, rectSize};
}

+ (CGPoint)placeRandomPointWithinRect:(CGRect)rect{
    CGFloat minX = CGRectGetMinX(rect);
    CGFloat maxX = CGRectGetMaxX(rect);
    CGFloat minY = CGRectGetMinY(rect);
    CGFloat maxY = CGRectGetMaxY(rect);
    
    CGFloat xOrigin = [self placeRandomFloatInRange:NSMakeRange(minX, maxX)];
    CGFloat yOrigin = [self placeRandomFloatInRange:NSMakeRange(minY, maxY)];
    return CGPointMake(xOrigin, yOrigin);
}

+ (NSArray *)femaleFirstNames{
    return @[@"Malinda", @"Kaye", @"Audra", @"Trudie", @"Stacee", @"Esta", @"Albertina", @"Nakia", @"Bettye", @"Remona", @"Kimberli", @"Clarinda", @"Gussie", @"Carmina", @"Alia", @"Shaquita", @"Rosalee", @"Nicki", @"Tamica", @"Tressa", @"Yvette", @"Shantae", @"Trena", @"Abbie", @"Isabella", @"Fiona", @"Alejandrina", @"Hyo", @"Marvis", @"Alexandra", @"Torri", @"Gemma", @"Kirsten", @"Gabriella", @"Norene", @"Emmie", @"Omega", @"Tobi", @"Christiana", @"Mee", @"Indira", @"Lakia", @"Loria", @"Chere", @"Jin", @"Annis", @"Brigitte", @"Leonila", @"Clorinda", @"Lanie", @"Lorilee", @"Brynn", @"Roxane", @"Tricia", @"Raye", @"Christal", @"Lita", @"Gianna", @"Ceola", @"Lorita", @"Katelynn", @"Mei", @"Latosha", @"Thalia", @"Avelina", @"Mirta", @"Celina", @"Arleen", @"Erinn", @"Trudy", @"Tula", @"Tequila", @"Viola", @"Marilou", @"Jacquelyn", @"Jani", @"Mellisa", @"Elfriede", @"Rachael", @"Isabelle", @"Debby", @"Lelia", @"Linn", @"India", @"Mable", @"Charity", @"Khalilah", @"Tawnya", @"Sherrell", @"Reva", @"Janyce", @"Synthia", @"Brittaney", @"Adena", @"Frida", @"Emerald", @"Niki", @"Tonda", @"Alia", @"Rachele"];
}

+ (NSArray *)maleFirstNames{
    return @[@"Phillip", @"Gene", @"Trenton", @"Darwin", @"Darrin", @"Herman", @"Cody", @"Maximo", @"Gabriel", @"Noble", @"Adan", @"Dale", @"Ali", @"Laurence", @"Paris", @"Orval", @"Randy", @"Ed", @"Alonzo", @"Margarito", @"Leonard", @"Houston", @"Zackary", @"Darnell", @"Whitney", @"Samuel", @"Claud", @"Derick", @"Teddy", @"Rigoberto", @"Leonardo", @"Clay", @"Lyman", @"Solomon", @"Lloyd", @"Renaldo", @"Warner", @"Forest", @"Ty", @"Maynard", @"August", @"Charlie", @"Dewayne", @"Leopoldo", @"Wesley", @"Jerrod", @"Sylvester", @"Everette", @"Reginald", @"Omar", @"Winston", @"Quintin", @"Fredric", @"Rickey", @"Delmar", @"Raymon", @"Randy", @"Sherman", @"Lawerence", @"Lamont", @"Les", @"Nickolas", @"Guadalupe", @"Rodger", @"Armand", @"Edmundo", @"Booker", @"Van", @"Cristopher", @"Homer", @"Forest", @"Seymour", @"Frederic", @"Renaldo", @"Robt", @"Merlin", @"Leo", @"Garret", @"Fabian", @"Leon", @"Devon", @"Adam", @"Edward", @"Timmy", @"Rueben", @"Rafael", @"Felix", @"Tommy", @"Vince", @"Merle", @"Darrin", @"Bryan", @"Patrick", @"Waldo", @"Nathan", @"Coy", @"Luis", @"Reuben", @"Brendon", @"Lyman"];
}

+ (NSArray *)lastNames{
    return @[@"Mclawhorn", @"Lyvers", @"Deborde", @"Scarberry", @"Swearingen", @"Mccampbell", @"Strum", @"Banuelos", @"Parrish", @"Bueno", @"Wegener", @"Vieira", @"Plantz", @"Mcquaid", @"Bruckner", @"Orchard", @"Wall", @"Gerth", @"Schweiger", @"Minder", @"Correa", @"Cremer", @"Close", @"Zink", @"Victorian", @"Bickle", @"Vanorden", @"Lauro", @"Whitsitt", @"Dubose", @"Nowell", @"Holtzman", @"Harkleroad", @"Gardella", @"Shepard", @"Hudon", @"Bicknell", @"Flippin", @"Winzer", @"Meints", @"Merlino", @"Sikes", @"Segrest", @"Keefe", @"Botkin", @"Geissler", @"Revilla", @"Saenger", @"Steves", @"Mulherin", @"Angelos", @"Chica", @"Lapointe", @"Hutt", @"Kushner", @"Steiger", @"Gutowski", @"Mclain", @"Klutts", @"Vanfleet", @"Kirchoff", @"Stanfield", @"Mccomas", @"Saeger", @"Bashaw", @"Duncanson", @"Lussier", @"Glade", @"Mcmullin", @"Chmielewski", @"Vang", @"Klemme", @"Downs", @"Feagin", @"Alanis", @"Gartrell", @"Shippee", @"Fred", @"Lenhardt", @"Ferron", @"Hollaway", @"Felker", @"Irey", @"Gildersleeve", @"Arnwine", @"Stair", @"Wolski", @"Langan", @"Hirschman", @"Bisignano", @"Bull", @"Godbee", @"Outland", @"Choe", @"Bartsch", @"Bialek", @"Plumb", @"Rochell", @"Organ", @"Synder"];
}
@end
