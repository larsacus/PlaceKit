//
//  PLKCollectionViewImageCell.m
//  PlaceKitDemo
//
//  Created by Lars Anderson on 5/5/13.
//  Copyright (c) 2013 theonlylars. All rights reserved.
//

#import "PLKCollectionViewImageCell.h"

@implementation PLKCollectionViewImageCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)prepareForReuse{
    [super prepareForReuse];
    self.imageView.image = nil;
}

@end
