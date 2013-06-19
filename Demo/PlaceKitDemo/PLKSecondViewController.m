//
//  PLKSecondViewController.m
//  PlaceKitDemo
//
//  Created by Lars Anderson on 5/5/13.
//  Copyright (c) 2013 theonlylars. All rights reserved.
//

#import "PLKSecondViewController.h"
#import "PlaceKit.h"

@interface PLKSecondViewController ()

@end

@implementation PLKSecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Colors", @"Colors");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//    [PlaceKit placeTextWithNumberOfParagraphs:3
//                                     ofLength:PLKTextParagraphLengthVeryShort
//                                      options:PLKTextOptionsAllCaps
//                                   completion:^(NSString *placeText) {
//                                       NSLog(@"placeholder text: %@", placeText);
//                                   }];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    CGFloat randomHue = [PlaceKit placeRandomPercentage];
    UIColor *color = [PlaceKit placeRandomColorWithHue:randomHue];
    [UIView animateWithDuration:0.25f
                     animations:^{
                         self.view.backgroundColor = color;
                     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)newColorWithSameHue:(UIButton *)sender {
    UIColor *currentColor = self.view.backgroundColor;
    CGFloat hue;
    [currentColor getHue:&hue
              saturation:nil
              brightness:nil
                   alpha:nil];
    
    UIColor *color = [PlaceKit placeRandomColorWithHue:hue];
    [UIView animateWithDuration:0.25f
                     animations:^{
                         self.view.backgroundColor = color;
                     }];
    
}

- (IBAction)newRandomColor:(UIButton *)sender {
    UIColor *color = [PlaceKit placeRandomColor];
    [UIView animateWithDuration:0.25f
                     animations:^{
                         self.view.backgroundColor = color;
                     }];
}

- (IBAction)newRandomGreyscale:(UIButton *)sender {
    UIColor *color = [PlaceKit placeRandomGreyscaleColor];
    [UIView animateWithDuration:0.25f
                     animations:^{
                         self.view.backgroundColor = color;
                     }];
}
@end
