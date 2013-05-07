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
        self.title = NSLocalizedString(@"Second", @"Second");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [PlaceKit placeTextWithNumberOfParagraphs:3
                                     ofLength:PLKTextParagraphLengthVeryShort
                                      options:PLKTextOptionsAllCaps
                                   completion:^(NSString *placeText) {
                                       NSLog(@"placeholder text: %@", placeText);
                                   }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
