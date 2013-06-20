//
//  PlaceKit.m
//  PlaceKitDemo
//
//  Created by Lars Anderson on 5/5/13.
//  Copyright (c) 2013 theonlylars. All rights reserved.
//

#import "PlaceKit.h"

NSString * const kPLKPlaceKittenImageURLString = @"http://placekitten.com/%1.0f/%1.0f";
NSString * const kPLKPlaceKittenGreyscaleImageURLString = @"http://placekitten.com/g/%1.0f/%1.0f";
NSString * const kPLKPlaceBaconImageURLString = @"http://baconmockup.com/%1.0f/%1.0f";
NSString * const kPLKPlaceHolderImageURLString = @"http://placehold.it/%1.0fx%1.0f";
NSString * const kPLKPlaceRandomImageURLString = @"http://lorempixel.com/%1.0f/%1.0f";
NSString * const kPLKPlaceRandomGreyscaleImageURLString = @"http://lorempixel.com/%1.0f/%1.0f";
NSString * const kPLKPlaceRandomTextURLString = @"http://loripsum.net/api";

@implementation PlaceKit

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
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:path, size.width*screenScale, size.height*screenScale]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection
     sendAsynchronousRequest:request
     queue:[NSOperationQueue mainQueue]
     completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
         if (error == nil) {
             UIImage *image = [UIImage imageWithData:data scale:screenScale];
             completionBlock(image);
         }
         else{
             completionBlock(nil);
         }
     }];
}

#pragma mark - Text
+ (void)placeTextWithNumberOfParagraphs:(NSInteger)numberOfParagraphs
                               ofLength:(PLKTextParagraphLength)paragraphLength
                                options:(PLKTextOptions)options
                             completion:(void(^)(NSString *placeText))completionBlock{
    NSAssert1(numberOfParagraphs > 0, @"Number of paragraphs is invalid (%i)", numberOfParagraphs);
    
    NSString *urlString = kPLKPlaceRandomTextURLString;
    
    if (options & PLKTextOptionsAllCaps) {
        urlString = [urlString stringByAppendingPathComponent:@"allcaps"];
    }
    
    if (options & PLKTextOptionsPrude){
        urlString = [urlString stringByAppendingPathComponent:@"prude"];
    }
    
    NSString *paragraphLengthParameter = [self paragraphLengthParameterFromParagraphLength:paragraphLength];
    urlString = [urlString stringByAppendingPathComponent:@"plaintext"];
    urlString = [urlString stringByAppendingPathComponent:paragraphLengthParameter];
    
    NSString *paragraphsArg = [NSString stringWithFormat:@"%i", numberOfParagraphs];
    
    urlString = [urlString stringByAppendingPathComponent:paragraphsArg];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection
     sendAsynchronousRequest:request
     queue:[NSOperationQueue mainQueue]
     completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
         if (error == nil) {
             NSString *returnString = [NSString stringWithCString:[data bytes] encoding:[NSString defaultCStringEncoding]];
             completionBlock(returnString);
         }
         else{
             completionBlock(nil);
         }
     }];
}

+ (void)placeHipsterIpsumWithNumberOfParagraphs:(NSInteger)numberOfParagraphs
                                    shotOfLatin:(BOOL)shotOfLatin
                                     completion:(void(^)(NSString *hipsterIpsum))completionBlock{
    NSMutableString *hipsterPath = [@"http://hipsterjesus.com/api?" mutableCopy];
    [hipsterPath appendFormat:@"paras=%i",numberOfParagraphs];
    [hipsterPath appendString:@"&html=false"];
    
    if (shotOfLatin) {
        [hipsterPath appendFormat:@"&type=hipster-latin"];
    }
    else{
        [hipsterPath appendFormat:@"&type=hipster-centric"];
    }
    
    NSURL *url = [NSURL URLWithString:hipsterPath];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection
     sendAsynchronousRequest:request
     queue:[NSOperationQueue mainQueue]
     completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
         if (error == nil) {
             NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             
             NSString *returnString = dict[@"text"];
             if (completionBlock != nil) {
                 completionBlock(returnString);
             }
         }
         else{
             completionBlock(nil);
         }
     }];
}

+ (void)placeHTMLWithNumberOfParagraphs:(NSInteger)numberOfParagraphs
                               ofLength:(PLKTextParagraphLength)paragraphLength
                                options:(PLKHTMLOptions)options
                             completion:(void(^)(NSString *placeText))completionBlock{
    NSURL *htmlURL = [self placeURLForHTMLWithParagraphs:numberOfParagraphs
                                         paragraphLength:paragraphLength
                                                 options:options];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:htmlURL];
    [NSURLConnection
     sendAsynchronousRequest:request
     queue:[NSOperationQueue mainQueue]
     completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
         if (error == nil) {
             NSString *returnString = [NSString stringWithCString:[data bytes] encoding:[NSString defaultCStringEncoding]];
             if (completionBlock != nil) {
                 completionBlock(returnString);
             }
         }
         else{
             completionBlock(nil);
         }
     }];
}

+ (NSURL *)placeURLForHTMLWithParagraphs:(NSInteger)numberOfParagraphs
                         paragraphLength:(PLKTextParagraphLength)paragraphLength
                                 options:(PLKHTMLOptions)htmlOptions{
    NSString *htmlURLString = kPLKPlaceRandomTextURLString;
    NSString *optionsString = [self htmlOptionsStringFromOptions:htmlOptions];
    NSString *lengthString = [self paragraphLengthParameterFromParagraphLength:paragraphLength];
    
    htmlURLString = [htmlURLString stringByAppendingPathComponent:lengthString];
    htmlURLString = [htmlURLString stringByAppendingPathComponent:optionsString];
    
    NSURL *htmlURL = [NSURL URLWithString:htmlURLString];
    
    return htmlURL;
}

+ (NSString *)htmlOptionsStringFromOptions:(PLKHTMLOptions)options{
    NSString *optionsString = @"";
    
    if (options & PLKHTMLOptionsAnchorTags) {
        optionsString = [optionsString stringByAppendingPathComponent:@"link"];
    }
    if (options & PLKHTMLOptionsEmphasisTags) {
        optionsString = [optionsString stringByAppendingPathComponent:@"decorate"];
    }
    if (options & PLKHTMLOptionsUnorderedList) {
        optionsString = [optionsString stringByAppendingPathComponent:@"ul"];
    }
    if (options & PLKHTMLOptionsOrderedList) {
        optionsString = [optionsString stringByAppendingPathComponent:@"ol"];
    }
    if (options & PLKHTMLOptionsDescriptionList) {
        optionsString = [optionsString stringByAppendingPathComponent:@"dl"];
    }
    if (options & PLKHTMLOptionsBlockquotes) {
        optionsString = [optionsString stringByAppendingPathComponent:@"bq"];
    }
    if (options & PLKHTMLOptionsCodeSamples) {
        optionsString = [optionsString stringByAppendingPathComponent:@"code"];
    }
    if (options & PLKHTMLOptionsHeaders) {
        optionsString = [optionsString stringByAppendingPathComponent:@"headers"];
    }
    if (options & PLKHTMLOptionsAllCaps) {
        optionsString = [optionsString stringByAppendingPathComponent:@"allcaps"];
    }
    if (options & PLKHTMLOptionsPrude) {
        optionsString = [optionsString stringByAppendingPathComponent:@"prude"];
    }
    
    return optionsString;
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

#pragma mark - Fake Data
+ (NSString *)placeRandomFirstName{
    static NSArray *__seedFirstNames;
    if (__seedFirstNames == nil) {
        __seedFirstNames = [[self maleFirstNames] arrayByAddingObjectsFromArray:[self femaleFirstNames]];
    }
    return __seedFirstNames[arc4random_uniform(__seedFirstNames.count)];
}

+ (NSString *)placeRandomLastName{
    NSArray *seedLastNames = [self lastNames];
    return seedLastNames[arc4random_uniform(seedLastNames.count)];
}

+ (NSString *)placeRandomFullName{
    return [NSString stringWithFormat:@"%@ %@", [self placeRandomFirstName], [self placeRandomLastName]];
}

+ (NSString *)placeRandomBusinessNameWithNumberOfWords:(NSUInteger)words{
    NSAssert(words > 0, @"Business name must have a length!");
    
    NSMutableString *businessName = [NSMutableString string];
    
    switch (words) {
        case 1:{
            NSArray *prefixes = [self businessNameSingleWordPrefix];
            NSArray *suffixes = [self businessNameSingleWordSuffix];
            [businessName appendString:prefixes[[self placeRandomIntegerLessThan:prefixes.count]]];
            [businessName appendString:suffixes[[self placeRandomIntegerLessThan:suffixes.count]]];
             }
            break;
        case 2:{
            BOOL generalPrefix = (BOOL)roundf([self placeRandomPercentage]);
            NSString *generalPrefixString = nil;
            
            if (generalPrefix) {
                NSArray *prefixes = [self businessPreFixes];
                generalPrefixString = prefixes[[self placeRandomIntegerLessThan:prefixes.count]];
            }
            else{
                generalPrefixString = [self placeRandomBusinessNameWithNumberOfWords:1];
            }
            
            [businessName appendFormat:@"%@ ", generalPrefixString];
            
            NSArray *businessSuffixes = [self businessSuffixes];
            NSString *businessSuffix = businessSuffixes[[self placeRandomIntegerLessThan:businessSuffixes.count]];
            
            [businessName appendString:businessSuffix];
        }
            break;
        case 3:
            break;
        case 4:
            break;
        default:
            break;
    }
    
    return [businessName copy];
}

#pragma mark - Numbers
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
    return range.location + arc4random_uniform(range.length) + [self placeRandomPercentage];
}

+ (CGFloat)placeRandomPercentage{
    return arc4random_uniform(100)/100.f;
}

+ (CGFloat)placeRandomPercentageInRange:(NSRange)range{
    return (range.location+arc4random_uniform(range.length))/100.f;
}

#pragma mark - Geometry
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

#pragma mark - Colors
+ (UIColor *)placeRandomColorWithHue:(CGFloat)hue{
    NSParameterAssert((hue <= 1) && (hue >= 0));
    
    CGFloat s = [self placeRandomPercentageInRange:NSMakeRange(10, 90)];
    CGFloat b = [self placeRandomPercentageInRange:NSMakeRange(10, 90)];
    
    return [UIColor colorWithHue:hue
                      saturation:s
                      brightness:b
                           alpha:1.f];
}

+ (UIColor *)placeRandomColor{
    return [self placeRandomColorWithAlpha:1.f];
}

+ (UIColor *)placeRandomColorWithAlpha:(CGFloat)alpha{
    CGFloat r = [self placeRandomPercentage];
    CGFloat g = [self placeRandomPercentage];
    CGFloat b = [self placeRandomPercentage];
    
    return [UIColor colorWithRed:r
                           green:g
                            blue:b
                           alpha:1.f];
}

+ (UIColor *)placeRandomColorWithRandomAlpha{
    CGFloat alpha = MAX([self placeRandomPercentage], 0.1f);
    return [self placeRandomColorWithAlpha:alpha];
}

+ (UIColor *)placeRandomGreyscaleColor{
    return [self placeRandomGreyscaleColorWithAlpha:1.f];
}

+ (UIColor *)placeRandomGreyscaleColorWithAlpha:(CGFloat)alpha{
    CGFloat greyNess = MIN(MAX([self placeRandomPercentage],0.1f),0.95);
    return [UIColor colorWithWhite:greyNess
                             alpha:alpha];
}

+ (UIColor *)placeRandomGreyscaleColorWithRandomAlpha{
    CGFloat alpha = MAX([self placeRandomPercentage],0.1f);
    return [self placeRandomGreyscaleColorWithAlpha:alpha];
}

+ (UIColor *)placeRandomColorWithHueOfColor:(UIColor *)color{
    CGFloat hue;
    [color getHue:&hue
       saturation:nil
       brightness:nil
            alpha:nil];
    return [self placeRandomColorWithHue:hue];
}

#pragma mark - Names Storage
+ (NSArray *)femaleFirstNames{
    static NSArray *__femaleFirstNames;
    if (__femaleFirstNames == nil) {
        __femaleFirstNames = @[@"Malinda", @"Kaye", @"Audra", @"Trudie", @"Stacee", @"Esta", @"Albertina", @"Nakia", @"Bettye", @"Remona", @"Kimberli", @"Clarinda", @"Gussie", @"Carmina", @"Alia", @"Shaquita", @"Rosalee", @"Nicki", @"Tamica", @"Tressa", @"Yvette", @"Shantae", @"Trena", @"Abbie", @"Isabella", @"Fiona", @"Alejandrina", @"Hyo", @"Marvis", @"Alexandra", @"Torri", @"Gemma", @"Kirsten", @"Gabriella", @"Norene", @"Emmie", @"Omega", @"Tobi", @"Christiana", @"Mee", @"Indira", @"Lakia", @"Loria", @"Chere", @"Jin", @"Annis", @"Brigitte", @"Leonila", @"Clorinda", @"Lanie", @"Lorilee", @"Brynn", @"Roxane", @"Tricia", @"Raye", @"Christal", @"Lita", @"Gianna", @"Ceola", @"Lorita", @"Katelynn", @"Mei", @"Latosha", @"Thalia", @"Avelina", @"Mirta", @"Celina", @"Arleen", @"Erinn", @"Trudy", @"Tula", @"Tequila", @"Viola", @"Marilou", @"Jacquelyn", @"Jani", @"Mellisa", @"Elfriede", @"Rachael", @"Isabelle", @"Debby", @"Lelia", @"Linn", @"India", @"Mable", @"Charity", @"Khalilah", @"Tawnya", @"Sherrell", @"Reva", @"Janyce", @"Synthia", @"Brittaney", @"Adena", @"Frida", @"Emerald", @"Niki", @"Tonda", @"Alia", @"Rachele"];
    }
    return __femaleFirstNames;
}

+ (NSArray *)maleFirstNames{
    static NSArray *__maleFirstNames;
    if (__maleFirstNames == nil) {
        __maleFirstNames = @[@"Phillip", @"Gene", @"Trenton", @"Darwin", @"Darrin", @"Herman", @"Cody", @"Maximo", @"Gabriel", @"Noble", @"Adan", @"Dale", @"Ali", @"Laurence", @"Paris", @"Orval", @"Randy", @"Ed", @"Alonzo", @"Margarito", @"Leonard", @"Houston", @"Zackary", @"Darnell", @"Whitney", @"Samuel", @"Claud", @"Derick", @"Teddy", @"Rigoberto", @"Leonardo", @"Clay", @"Lyman", @"Solomon", @"Lloyd", @"Renaldo", @"Warner", @"Forest", @"Ty", @"Maynard", @"August", @"Charlie", @"Dewayne", @"Leopoldo", @"Wesley", @"Jerrod", @"Sylvester", @"Everette", @"Reginald", @"Omar", @"Winston", @"Quintin", @"Fredric", @"Rickey", @"Delmar", @"Raymon", @"Randy", @"Sherman", @"Lawerence", @"Lamont", @"Les", @"Nickolas", @"Guadalupe", @"Rodger", @"Armand", @"Edmundo", @"Booker", @"Van", @"Cristopher", @"Homer", @"Forest", @"Seymour", @"Frederic", @"Renaldo", @"Robt", @"Merlin", @"Leo", @"Garret", @"Fabian", @"Leon", @"Devon", @"Adam", @"Edward", @"Timmy", @"Rueben", @"Rafael", @"Felix", @"Tommy", @"Vince", @"Merle", @"Darrin", @"Bryan", @"Patrick", @"Waldo", @"Nathan", @"Coy", @"Luis", @"Reuben", @"Brendon", @"Lyman"];
    }
    return __maleFirstNames;
}

+ (NSArray *)lastNames{
    static NSArray *__lastNames;
    if (__lastNames == nil) {
        __lastNames = @[@"Mclawhorn", @"Lyvers", @"Deborde", @"Scarberry", @"Swearingen", @"Mccampbell", @"Strum", @"Banuelos", @"Parrish", @"Bueno", @"Wegener", @"Vieira", @"Plantz", @"Mcquaid", @"Bruckner", @"Orchard", @"Wall", @"Gerth", @"Schweiger", @"Minder", @"Correa", @"Cremer", @"Close", @"Zink", @"Victorian", @"Bickle", @"Vanorden", @"Lauro", @"Whitsitt", @"Dubose", @"Nowell", @"Holtzman", @"Harkleroad", @"Gardella", @"Shepard", @"Hudon", @"Bicknell", @"Flippin", @"Winzer", @"Meints", @"Merlino", @"Sikes", @"Segrest", @"Keefe", @"Botkin", @"Geissler", @"Revilla", @"Saenger", @"Steves", @"Mulherin", @"Angelos", @"Chica", @"Lapointe", @"Hutt", @"Kushner", @"Steiger", @"Gutowski", @"Mclain", @"Klutts", @"Vanfleet", @"Kirchoff", @"Stanfield", @"Mccomas", @"Saeger", @"Bashaw", @"Duncanson", @"Lussier", @"Glade", @"Mcmullin", @"Chmielewski", @"Vang", @"Klemme", @"Downs", @"Feagin", @"Alanis", @"Gartrell", @"Shippee", @"Fred", @"Lenhardt", @"Ferron", @"Hollaway", @"Felker", @"Irey", @"Gildersleeve", @"Arnwine", @"Stair", @"Wolski", @"Langan", @"Hirschman", @"Bisignano", @"Bull", @"Godbee", @"Outland", @"Choe", @"Bartsch", @"Bialek", @"Plumb", @"Rochell", @"Organ", @"Synder"];
    }
    return __lastNames;
}

+ (NSArray *)businessNameSingleWordPrefix{
    static NSArray *__businessNameSingleWordPrefix;
    if (__businessNameSingleWordPrefix == nil) {
        __businessNameSingleWordPrefix = @[@"Micro", @"Star", @"Wal", @"Du", @"Goo", @"Citi", @"Cono", @"Kro", @"Proc", @"Boe", @"Com", @"Sys", @"Super", @"Aet", @"All", @"Nation"];
    }
    return __businessNameSingleWordPrefix;
}

+ (NSArray *)businessNameSingleWordSuffix{
    static NSArray *__businessNameSingleWordSuffix;
    if (__businessNameSingleWordSuffix == nil) {
        __businessNameSingleWordSuffix = @[@"get", @"bucks", @"pont", @"gle", @"co", @"ger", @"ter", @"thon", @"soft", @"get", @"ing", @"cast", @"a", @"well", @"na", @"state"];
    }
    return __businessNameSingleWordSuffix;
}

+ (NSArray *)businessPreFixes{
    static NSArray *__businessPrefixes;
    if (__businessPrefixes == nil) {
        __businessPrefixes = @[@"News", @"Home", @"World", @"General", @"Giant", @"Big", @"Honey", @"Delta", @"Southwest", @"Dr.", @"Citi", @"Wells", @"Jamba", @"Cost", @"Green"];
    }
    return __businessPrefixes;
}

+ (NSArray *)businessMiddleParts{
    static NSArray *__businessMiddleParts;
    if (__businessMiddleParts == nil) {
        __businessMiddleParts = @[@"Depot", @"Juice", @"Bucks", @"Market", @"Air", @"Commercial", @"Fuel", @"Motor", @"Electric", @"Mae", @"Fruit", ];
    }
    return __businessMiddleParts;
}

+ (NSArray *)businessSuffixes{
    static NSArray *__businessNameSuffixes;
    if (__businessNameSuffixes == nil) {
        __businessNameSuffixes = @[@"Motors", @"Builders", @"Works", @"Technologies", @"Group", @"Institute", @"Labs", @"Communications", @"Electric", @"Co-Op", @"Holdings", @"Systems", @"International", @"Mobile"];
    }
    return __businessNameSuffixes;
}

+ (NSArray *)corporateMonikers{
    static NSArray *__corporateSuffixes;
    if (__corporateSuffixes == nil) {
        __corporateSuffixes = @[@", Inc", @"Incorporated", @", LLC", @".com"];
    }
    return __corporateSuffixes;
}
@end
